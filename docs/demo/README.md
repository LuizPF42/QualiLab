# Demonstração: um `index.html` é um editor de arquivos

Uma prova de conceito de **um único arquivo HTML** que abre, exibe, edita e grava **`.docx` de verdade** — sem instalação, sem servidor, sem biblioteca externa e **sem nenhuma requisição de rede**, com um monitor embutido que registra qualquer byte que tente sair.

O ponto que ela demonstra: **"roda no navegador" não significa "está na nuvem"**. O navegador é só o ambiente de execução; um arquivo HTML aberto do disco é um programa local. O QualiLab, no modo Arquivo, é exatamente essa arquitetura — trocando o `.docx` desta demonstração pelo `.qualilab` (ver [Onde os seus dados ficam](../../README.md#onde-os-seus-dados-ficam) no README principal).

## Como usar

1. **Hospedada:** `https://luizpf42.github.io/QualiLab/demo/` — ou **baixe o [`index.html`](index.html)** e dê dois cliques nele (prova completa: nem a página veio da rede).
2. Arraste um `.docx` para a folha, ou clique em **Criar documento de exemplo** (a página monta um `.docx` do zero).
3. Edite o texto, **Ctrl+S** grava — em Chrome/Edge, direto no mesmo arquivo; nos demais, baixa a cópia.
4. Confira o **monitor**: zero requisições de rede — e o **razão das operações de arquivo**: cada leitura e cada escrita no disco aparece no registro com nome, tamanho e via (escolhido no seletor, arrastado, gravado direto no arquivo, entregue ao Downloads), incluindo as imagens lidas de dentro do próprio `.docx`. Duvida do monitor? Ele mesmo sugere os auditores externos: **F12 → aba Rede**, ou desligar o Wi-Fi e seguir trabalhando. O botão **⚡** manda a página *tentar* acessar a internet, para você ver o navegador barrar.

## Como funciona (e por que isso é o argumento)

- Um `.docx` é um ZIP com XML dentro. A página lê e escreve o ZIP com aritmética de bytes (CRC32, diretório central) e usa o (des)compressor do próprio navegador (`DecompressionStream`/`CompressionStream`). O texto vive em `word/document.xml`; cada `<w:r>` (trecho formatado) vira um `<span>` editável, e ao salvar o texto volta para os mesmos nós do XML. **Todo o resto do pacote — estilos, imagens, propriedades — é copiado byte a byte.** Abrir e gravar arquivo é operação de *editor*, não de *plataforma*.
- A privacidade não é prometida, é **imposta**: a meta tag de `Content-Security-Policy` declara `default-src 'none'` — o navegador bloqueia `fetch`/XHR/WebSocket/beacon *antes de qualquer pacote sair* (nem DNS resolve). O monitor registra em três camadas: recursos efetivamente carregados (`PerformanceObserver`), violações de CSP relatadas pelo navegador, e as próprias APIs de rede embrulhadas para acusar até a tentativa. O mesmo registro serve de **livro-razão de E/S**: toda a movimentação da página se resume a *leu o seu arquivo, gravou o seu arquivo* — e é isso que ele mostra.

## Limites assumidos (é uma demonstração, não um produto)

- Edita, apaga e acrescenta **texto** nos parágrafos existentes; Enter insere quebra de linha (`<w:br/>`), não parágrafo novo.
- Num parágrafo com estrutura alterada (trechos apagados/inseridos), um run dentro de `<w:hyperlink>` perde o invólucro do link.
- Marcadores de lista aparecem genéricos (sem resolver `numbering.xml`); imagens EMF/WMF e objetos OLE viram etiqueta preservada; ZIP64 e `.docx` cifrado não são suportados.
- Trabalhe sobre uma **cópia** do seu documento.

## Validação

Testado de ponta a ponta em Chromium headless (Playwright), aberto via `file://`: criar exemplo → editar → salvar → reabrir o salvo na própria página; `fetch` provocado e bloqueado com o contador externo em zero — confirmado também pelo Playwright (nenhuma requisição http/https observada). O `.docx` salvo foi verificado por um consumidor independente (`python-docx`): parágrafos, negrito/itálico, estilo de título e tabela íntegros. Na direção inversa, um `.docx` gerado pelo `python-docx` (17 entradas no pacote) foi aberto, editado e salvo pela página com **todas** as entradas preservadas — apenas o `word/document.xml` reescrito.
