#!/usr/bin/env python3
"""SRI das dependencias de CDN — gera e confere o `integrity` do import map.

O PROBLEMA. O QualiLab carrega sete bibliotecas de CDN (pdf.js, tesseract, xlsx, mammoth,
sql.js, supabase-js, transformers.js) e nenhuma delas passa por uma tag <script src>: todas
entram por `import()` dinamico, via o helper `importRetry`. `integrity=` e atributo de
ELEMENTO — nao existe tag onde pendura-lo. Sem nada no lugar, uma resposta adulterada de CDN
executa com acesso ao corpus do pesquisador, a sessao Supabase e a chave BYOK no localStorage.

O MECANISMO. Import map com o campo `integrity`, que casa URL RESOLVIDA -> hash e vale para
qualquer requisicao daquele modulo, inclusive `import()` dinamico de URL completa. O bloco
vive no <head>, antes do <script type="module"> do app, e e gerado por este script.

O QUE ISSO **NAO** COBRE — leia antes de escrever no README que "as dependencias estao
verificadas", porque a frase seria falsa:
  1. GRAFO TRANSITIVO. O hash cobre o modulo de topo. Se ele importa outros arquivos (o esm.sh
     serve um shim que reexporta de um segundo salto), esses vem SEM verificacao. O `--update`
     mede e reporta isso por dependencia, em vez de deixar voce supor.
  2. WORKER E WASM. `pdf.worker.min.mjs` e buscado como Worker pelo pdf.js e o `sql-wasm.wasm`
     pelo `locateFile` do sql.js. Nenhum dos dois e "module script": o import map nao os
     alcanca. Ficam declarados em NAO_COBERTO, com o motivo.
  3. NAVEGADOR ANTIGO. Onde o campo `integrity` do import map nao e suportado, ele e IGNORADO
     em silencio — sem protecao e sem quebra. E defesa em profundidade, nao garantia.

MODOS
  --check            (CI, offline) toda URL de CDN do index.html esta pinada ou declarada
                     como nao-cobrivel? Pega a dependencia nova que entrou sem hash.
  --check --online   alem disso, rebaixa cada URL e confere o hash pinado contra o que o CDN
                     serve AGORA. Vermelho aqui = o pino saiu do lugar ou o CDN mudou.
  --update           rebaixa, calcula sha384 e (re)escreve o bloco. Nunca grava parcial: se
                     qualquer download falhar, sai sem tocar no arquivo — hash errado nao
                     degrada a seguranca, DERRUBA o app.

Uso:
    py -3 scripts/sri.py --update
    py -3 scripts/sri.py --check --online
"""
import argparse
import base64
import hashlib
import json
import re
import sys
import urllib.request
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
INDEX = RAIZ / "index.html"
# O index.html e gerado; a FONTE deste bloco e o fragmento abaixo (ver src/manifesto.txt).
BLOCO_FONTE = RAIZ / "src" / "pagina" / "importmap.html"

INICIO = "<!-- SRI:BEGIN — gerado por scripts/sri.py --update. NAO EDITE A MAO. -->"
FIM = "<!-- SRI:END -->"
ABRE_MODULO = '<script type="module">'

# Hosts cujos modulos o app importa. Qualquer URL destes hosts no index.html tem de estar
# pinada ou declarada abaixo — e assim que uma dependencia nova nao entra em silencio.
HOSTS = ("cdn.jsdelivr.net", "esm.sh")

# URLs que o import map comprovadamente NAO alcanca, com o motivo. Estar aqui e uma decisao
# consciente e auditavel, nao um esquecimento: o --check exige que toda URL esteja pinada OU
# aqui. Reduzir esta lista e trabalho de verdade (servir o worker/wasm do proprio arquivo).
NAO_COBERTO = {
    "https://cdn.jsdelivr.net/npm/pdfjs-dist@4.7.76/build/pdf.worker.min.mjs":
        "buscado como Worker pelo pdf.js, nao como module script — import map nao alcanca",
    "https://cdn.jsdelivr.net/npm/sql.js@1.14.0/dist/${f}":
        "URL montada em runtime pelo locateFile do sql.js (wasm) — nao e module script",
}

TIMEOUT = 60


def modulo_do_index(texto):
    """So o <script type=module> do app: evita casar URL que esteja em comentario do <head>."""
    i = texto.find(ABRE_MODULO)
    if i < 0:
        raise SystemExit("sri.py: nao achei o <script type=\"module\"> no index.html")
    return texto[i:]


def urls_usadas(texto):
    """Toda URL de CDN citada no modulo, na ordem em que aparece, sem repetir."""
    mod = modulo_do_index(texto)
    achadas = []
    padrao = re.compile(r"https://(?:" + "|".join(re.escape(h) for h in HOSTS) + r")/[^\"'`\s)]+")
    for m in padrao.finditer(mod):
        u = m.group(0).rstrip(",;")
        if u not in achadas:
            achadas.append(u)
    return achadas


def ler_bloco(texto):
    """Devolve (mapa_integridade, inicio, fim) — mapa vazio se o bloco ainda nao existe."""
    i = texto.find(INICIO)
    if i < 0:
        return {}, -1, -1
    j = texto.find(FIM, i)
    if j < 0:
        raise SystemExit("sri.py: achei o SRI:BEGIN mas nao o SRI:END — bloco truncado.")
    j += len(FIM)
    m = re.search(r'<script type="importmap">\s*(\{.*?\})\s*</script>', texto[i:j], re.S)
    if not m:
        raise SystemExit("sri.py: bloco SRI presente mas sem importmap legivel dentro.")
    return json.loads(m.group(1)).get("integrity", {}), i, j


def baixar(url):
    req = urllib.request.Request(url, headers={"User-Agent": "qualilab-sri/1.0"})
    with urllib.request.urlopen(req, timeout=TIMEOUT) as r:
        return r.read()


def sha384(bruto):
    return "sha384-" + base64.b64encode(hashlib.sha384(bruto).digest()).decode("ascii")


def imports_internos(bruto):
    """Quantas OUTRAS URLs o modulo baixado importa — o que o hash de topo NAO cobre."""
    try:
        txt = bruto.decode("utf-8", "replace")
    except Exception:
        return 0
    alvos = set()
    for m in re.finditer(r"""(?:from|import)\s*\(?\s*["']([^"']+)["']""", txt):
        alvo = m.group(1)
        if alvo.startswith((".", "/", "http")):
            alvos.add(alvo)
    return len(alvos)


def montar_bloco(mapa):
    corpo = json.dumps({"integrity": mapa}, indent=2, ensure_ascii=False)
    return (
        INICIO + "\n"
        + "<script type=\"importmap\">\n" + corpo + "\n</script>\n"
        + FIM
    )


def cmd_update(caminho, texto, saida_bloco=None):
    urls = [u for u in urls_usadas(texto) if u not in NAO_COBERTO]
    mapa, i, j = {}, *ler_bloco(texto)[1:]
    novo, falhas, relatorio = {}, [], []
    for u in urls:
        try:
            bruto = baixar(u)
        except Exception as e:
            falhas.append(f"{u} -> {e}")
            continue
        novo[u] = sha384(bruto)
        relatorio.append((u, len(bruto), imports_internos(bruto)))

    if falhas:
        print("FALHOU — nenhum download pode falhar (hash errado DERRUBA o app):", file=sys.stderr)
        for f in falhas:
            print("  - " + f, file=sys.stderr)
        print("\nNada foi escrito.", file=sys.stderr)
        return 1

    bloco = montar_bloco(novo)
    # DESTINO: o index.html e GERADO (src/manifesto.txt + scripts/build_index.py), entao
    # escrever nele seria trabalho perdido no build seguinte. Por isso a leitura e a
    # ESCRITA se separaram: as URLs sao descobertas no arquivo MONTADO (elas moram nos
    # loaders, espalhadas pelo modulo) e o bloco vai para o fragmento de FONTE, cujo
    # conteudo inteiro e justamente este bloco. Sem --saida, o comportamento e o de antes.
    if saida_bloco:
        alvo = Path(saida_bloco)
        antigo = alvo.read_bytes() if alvo.exists() else b""
        fim_linha = "\r\n" if b"\r\n" in antigo else "\n"
        conteudo = (bloco + "\n").replace("\r\n", "\n").replace("\n", fim_linha)
        with alvo.open("w", encoding="utf-8", newline="") as fh:
            fh.write(conteudo)
        caminho = alvo
    else:
        if i >= 0:
            saida = texto[:i] + bloco + texto[j:]
        else:
            k = texto.find(ABRE_MODULO)
            saida = texto[:k] + bloco + "\n" + texto[k:]
        # newline='' e obrigatorio: o arquivo pode vir com CRLF (autocrlf no Windows) e a traducao
        # do write_text viraria cada \r\n em \r\r\n. Mesma armadilha do check_index.py.
        with Path(caminho).open("w", encoding="utf-8", newline="") as fh:
            fh.write(saida)

    print(f"ok — {len(novo)} dependencia(s) pinada(s) em {Path(caminho).name}\n")
    print("COBERTURA REAL (o hash cobre so o modulo de topo):")
    for u, tam, n in relatorio:
        nota = "modulo unico — coberto" if n == 0 else f"importa {n} URL(s) NAO cobertas pelo hash"
        print(f"  {tam:>9,}b  {nota}\n             {u}")
    if NAO_COBERTO:
        print("\nFORA DO ALCANCE DO IMPORT MAP (declarado em NAO_COBERTO):")
        for u, motivo in NAO_COBERTO.items():
            print(f"  - {u}\n      {motivo}")
    return 0


def cmd_check(texto, online):
    mapa, i, _ = ler_bloco(texto)
    urls = urls_usadas(texto)
    erros = []

    if i < 0:
        return 1, ["nao ha bloco SRI no index.html — rode `py -3 scripts/sri.py --update`."]

    for u in urls:
        if u in NAO_COBERTO or u in mapa:
            continue
        erros.append(
            f"dependencia de CDN sem hash: {u}\n"
            f"      rode `py -3 scripts/sri.py --update`, ou declare em NAO_COBERTO com o motivo."
        )

    orfaos = [u for u in mapa if u not in urls]
    for u in orfaos:
        erros.append(f"hash pinado para URL que o index.html nao usa mais: {u}")

    if online:
        for u, esperado in mapa.items():
            try:
                obtido = sha384(baixar(u))
            except Exception as e:
                erros.append(f"nao consegui rebaixar {u}: {e}")
                continue
            if obtido != esperado:
                erros.append(
                    f"HASH DIVERGENTE — o CDN serve bytes diferentes do pinado:\n"
                    f"      {u}\n      pinado : {esperado}\n      servido: {obtido}"
                )

    if erros:
        return 1, erros
    escopo = "conteudo conferido no CDN" if online else "estrutural (offline)"
    print(f"ok — {len(mapa)} pinada(s), {len(NAO_COBERTO)} declarada(s) fora do alcance; {escopo}.")
    return 0, []


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--index", default=str(INDEX),
                    help="arquivo MONTADO onde as URLs sao descobertas")
    ap.add_argument("--saida", default=str(BLOCO_FONTE),
                    help="fragmento de FONTE que recebe o bloco (todo o conteudo "
                         "dele e o bloco). Passe vazio para escrever no --index, "
                         "como era antes de a fonte virar modular.")
    ap.add_argument("--update", action="store_true", help="rebaixa, calcula e (re)escreve o bloco")
    ap.add_argument("--check", action="store_true", help="confere (padrao)")
    ap.add_argument("--online", action="store_true", help="no --check, rebaixa e compara os hashes")
    args = ap.parse_args()

    caminho = Path(args.index)
    texto = caminho.read_bytes().decode("utf-8")

    if args.update:
        return cmd_update(caminho, texto, args.saida or None)

    codigo, erros = cmd_check(texto, args.online)
    if erros:
        print(f"\nFALHOU — {len(erros)} problema(s) de SRI em {caminho.name}:", file=sys.stderr)
        for e in erros:
            print("  - " + e, file=sys.stderr)
    return codigo


if __name__ == "__main__":
    sys.exit(main())
