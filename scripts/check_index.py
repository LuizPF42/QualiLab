#!/usr/bin/env python3
"""Invariantes do index.html que, se quebradas, deixam TELA BRANCA pra todo mundo.

O QualiLab e um arquivo unico sem build: nao existe compilador pra reclamar antes de
publicar. Estas checagens sao as que pegam os acidentes ja documentados no CLAUDE.md
(regras de ouro), todas em cima do texto do arquivo — nenhuma precisa de navegador.

Uso:
    py -3 scripts/check_index.py                       # so checa
    py -3 scripts/check_index.py --emit-module out.mjs  # + extrai o modulo pro `node --check`

Saida: 0 = tudo certo; 1 = alguma invariante quebrada (imprime o que e onde).
"""
import argparse
import re
import sys
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
INDEX = RAIZ / "index.html"

CURVAS = "“”‘’"          # " " ' '
ABRE_MODULO = '<script type="module">'
FECHA = "</script>"


def linha_de(texto: str, pos: int) -> int:
    return texto.count("\n", 0, pos) + 1


def checar(texto: str, bruto: bytes):
    """Devolve (lista de erros, fonte do modulo). Cada erro e uma string legivel."""
    erros = []

    # 1. BOM. Gravar com BOM ja aconteceu (PowerShell -Encoding utf8) e o byte extra
    #    entra ANTES do <!doctype>, o que atrapalha o parse e a comparacao de bytes.
    if bruto.startswith(b"\xef\xbb\xbf"):
        erros.append("index.html comeca com BOM UTF-8 — grave sem BOM (UTF8Encoding($false)).")

    # 2. Aspas curvas EM ATRIBUTO. A gotcha #1: class="card" com aspa curva nao aplica a
    #    classe, o elemento perde estilo e o sintoma nao aponta pra causa. Em texto corrido
    #    aspa curva e legitima (o app e em portugues), por isso a checagem e so em atributo.
    for m in re.finditer(r'([A-Za-z-]+)=([' + CURVAS + r'])', texto):
        erros.append(
            f"linha {linha_de(texto, m.start())}: atributo {m.group(1)}= com aspa curva "
            f"({m.group(2)!r}) — use aspas retas."
        )

    # 3. O bloco do modulo tem de existir, ser UNICO e ser o ultimo a fechar.
    if texto.count(ABRE_MODULO) != 1:
        erros.append(
            f"esperava exatamente 1 {ABRE_MODULO}, achei {texto.count(ABRE_MODULO)} — "
            f"o app inteiro vive num bloco so."
        )
        return erros, None
    ini = texto.find(ABRE_MODULO)
    corpo_ini = ini + len(ABRE_MODULO)
    fim = texto.rfind(FECHA)
    if fim <= corpo_ini:
        erros.append(f"{FECHA} final aparece antes do inicio do modulo — arquivo truncado?")
        return erros, None
    modulo = texto[corpo_ini:fim]

    # 4. </script> literal DENTRO do modulo. O gerador do leitor de transparencia embute uma
    #    pagina HTML inteira num template literal e PRECISA escrever <\/script>: um </script>
    #    literal ali encerra o <script type="module"> do app no parser do navegador (que nao
    #    entende string JS) e derruba tudo.
    #    A checagem CONTA DENTRO DO MODULO, nao no arquivo inteiro. Ela ja foi "esperava
    #    exatamente 2 (head + modulo)", o que era um proxy valido enquanto so existiam esses
    #    dois blocos; o vendor-core.py passou a embutir preact/hooks/htm em <script> classico
    #    antes do modulo e a contagem total virou 5. Trocar 2 por 5 amarraria o guarda a
    #    QUANTAS bibliotecas estao embutidas — numero sem significado, que quebraria de novo na
    #    proxima. Contar dentro do modulo mede o que o guarda de fato protege, e nao e mais
    #    frouxo: e exatamente ali que o template literal mora.
    dentro = [m.start() for m in re.finditer(re.escape(FECHA), modulo)]
    if dentro:
        onde = ", ".join(str(linha_de(texto, corpo_ini + p)) for p in dentro)
        erros.append(
            f"achei {len(dentro)} {FECHA} literal DENTRO do modulo, nas linhas {onde} — "
            f"dentro de template literal escreva <\\/script>."
        )

    return erros, modulo


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--emit-module", metavar="ARQUIVO",
                    help="grava o JS do <script type=module> pra checagem de sintaxe (node --check)")
    ap.add_argument("--index", default=str(INDEX), help="caminho do index.html")
    args = ap.parse_args()

    caminho = Path(args.index)
    bruto = caminho.read_bytes()
    texto = bruto.decode("utf-8")

    erros, modulo = checar(texto, bruto)

    if args.emit_module and modulo is not None:
        saida = Path(args.emit_module)
        saida.parent.mkdir(parents=True, exist_ok=True)
        # preserva o numero de linha do index.html: assim o erro que o node aponta
        # (linha N) e a MESMA linha do index.html, sem conta de cabeca.
        prefixo = "\n" * texto.count("\n", 0, texto.find(ABRE_MODULO) + len(ABRE_MODULO))
        # newline="" e OBRIGATORIO: o arquivo vem com CRLF (autocrlf do git no Windows) e a
        # traducao automatica do write_text viraria cada \r\n em \r\r\n — o que DOBRA a
        # contagem de linhas e destroi justamente o alinhamento que o prefixo garante.
        with saida.open("w", encoding="utf-8", newline="") as fh:
            fh.write(prefixo + modulo)
        print(f"modulo extraido para {saida} ({len(modulo)} chars)")

    if erros:
        print(f"\nFALHOU — {len(erros)} problema(s) em {caminho.name}:", file=sys.stderr)
        for e in erros:
            print(f"  - {e}", file=sys.stderr)
        return 1

    print(f"ok — {caminho.name}: sem BOM, sem aspa curva em atributo, {FECHA} balanceado.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
