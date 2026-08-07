#!/usr/bin/env python3
"""Autoteste do scripts/sri.py — roda OFFLINE, com um CDN falso.

Por que existe: o sri.py so faz o seu trabalho quando o CDN esta acessivel, e um script de
seguranca que nunca foi exercitado e uma promessa, nao um controle. Aqui o download e
substituido por um dicionario em memoria, entao toda a logica (achar as URLs no index.html,
escrever o bloco, ser idempotente, recusar gravacao parcial, detectar bytes trocados no CDN e
dependencia nova sem hash) roda sem rede e sem depender de o jsdelivr estar de pe.

    py -3 scripts/sri_selftest.py      # 0 = tudo certo
"""
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import sri  # noqa: E402

A = "https://esm.sh/xlsx@0.18.5"
B = "https://cdn.jsdelivr.net/npm/jszip@3.10.1/+esm"
WORKER = "https://cdn.jsdelivr.net/npm/pdfjs-dist@4.7.76/build/pdf.worker.min.mjs"

INDEX = """<!doctype html>
<html><head><title>falso</title></head>
<body>
<script type="module">
async function getXLSX(){ return await importRetry('%s'); }
async function getJSZip(){ return await importRetry(['%s']); }
_pdfjs.GlobalWorkerOptions.workerSrc='%s';
</script>
</body></html>
""" % (A, B, WORKER)

# B imita o que o esm.sh de fato serve: um shim que reexporta de um SEGUNDO salto. E esse
# segundo salto que o hash de topo nao cobre — o relatorio de cobertura tem de dizer isso.
CDN = {
    A: b"export const x = 1;  // bundle unico, sem outro salto",
    B: b"export * from '/v135/jszip@3.10.1/es2022/jszip.mjs';",
}

falhas = []


def checa(nome, cond, detalhe=""):
    print(("  ok   " if cond else "  FALHA") + "  " + nome + ("" if cond else "\n         " + detalhe))
    if not cond:
        falhas.append(nome)


def escrever(texto):
    f = Path(tempfile.mkdtemp()) / "index.html"
    f.write_text(texto, encoding="utf-8", newline="")
    return f


def rodar_update(caminho):
    texto = caminho.read_bytes().decode("utf-8")
    return sri.cmd_update(caminho, texto)


def rodar_check(caminho, online=False):
    texto = caminho.read_bytes().decode("utf-8")
    return sri.cmd_check(texto, online)


print("autoteste do sri.py (CDN falso, sem rede)\n")
sri.baixar = lambda url: CDN[url]

# 1. o worker NAO entra no mapa (esta em NAO_COBERTO) e as duas outras entram
f = escrever(INDEX)
checa("--update grava sem erro", rodar_update(f) == 0)
mapa, i, _ = sri.ler_bloco(f.read_bytes().decode("utf-8"))
checa("as duas dependencias de modulo foram pinadas", set(mapa) == {A, B}, f"mapa={list(mapa)}")
checa("o worker do pdf.js NAO foi pinado (fora do alcance do import map)", WORKER not in mapa)
checa("o bloco entrou ANTES do <script type=module>", 0 <= i < f.read_text(encoding="utf-8").find(sri.ABRE_MODULO))
checa("o hash e sha384 em base64", mapa[A].startswith("sha384-") and len(mapa[A]) > 60, mapa.get(A, ""))

# 2. o --check offline passa logo depois do update
checa("--check (offline) passa apos o update", rodar_check(f)[0] == 0, str(rodar_check(f)[1]))

# 3. idempotencia: rodar de novo nao duplica bloco nem muda o resultado
antes = f.read_text(encoding="utf-8")
rodar_update(f)
depois = f.read_text(encoding="utf-8")
checa("--update e idempotente (mesmo byte a byte)", antes == depois)
checa("o bloco nao foi duplicado", depois.count(sri.INICIO) == 1)

# 4. --check --online passa com o CDN intacto e FALHA com bytes trocados
checa("--check --online passa com o CDN intacto", rodar_check(f, online=True)[0] == 0)
original = CDN[A]
CDN[A] = b"conteudo ADULTERADO"
codigo, erros = rodar_check(f, online=True)
checa("--check --online PEGA bytes trocados no CDN", codigo == 1 and any("DIVERGENTE" in e for e in erros),
      str(erros))
CDN[A] = original

# 5. dependencia NOVA sem hash tem de reprovar (o guarda que mais importa no dia a dia)
NOVA = "https://esm.sh/nova-lib@1.0.0"
CDN[NOVA] = b"lib nova"
com_nova = f.read_text(encoding="utf-8").replace(
    "</script>\n</body>", "await importRetry('%s');\n</script>\n</body>" % NOVA)
g = escrever(com_nova)
codigo, erros = rodar_check(g)
checa("--check REPROVA dependencia nova sem hash", codigo == 1 and any(NOVA in e for e in erros), str(erros))

# 6. hash orfao (URL saiu do index.html) tambem reprova
sem_jszip = f.read_text(encoding="utf-8").replace("async function getJSZip(){ return await importRetry(['%s']); }" % B, "")
codigo, erros = rodar_check(escrever(sem_jszip))
checa("--check REPROVA hash orfao", codigo == 1 and any(B in e for e in erros), str(erros))

# 7. download que falha NAO pode gravar nada (hash errado derruba o app)
h = escrever(INDEX)
antes_h = h.read_text(encoding="utf-8")
def quebrado(url):
    if url == B:
        raise OSError("CDN fora do ar")
    return CDN[url]
sri.baixar = quebrado
codigo = rodar_update(h)
checa("--update com download falho sai != 0", codigo != 0)
checa("--update com download falho NAO tocou no arquivo", h.read_text(encoding="utf-8") == antes_h)
sri.baixar = lambda url: CDN[url]

# 8. o relatorio de cobertura distingue modulo unico de modulo com imports transitivos
checa("detecta import transitivo (o que o hash NAO cobre)",
      sri.imports_internos(CDN[B]) == 1 and sri.imports_internos(CDN[A]) == 0,
      f"A={sri.imports_internos(CDN[A])} B={sri.imports_internos(CDN[B])}")

print()
if falhas:
    print("FALHOU — %d verificacao(oes): %s" % (len(falhas), ", ".join(falhas)), file=sys.stderr)
    sys.exit(1)
print("ok — sri.py passa em todas as verificacoes do autoteste.")
