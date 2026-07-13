<p align="center">
  <a href="https://luizpf42.github.io/QualiLab"><img src="images/logo.png" alt="QualiLab" width="160"></a>
</p>

# Manual do QualiLab

**Guia completo de uso, do primeiro acesso à publicação dos resultados.**

Este manual ensina a *usar* o QualiLab passo a passo. Para a lista de recursos e a parte técnica (instalação, Supabase, formatos), veja o [README](README.md). Para contribuir com o código, veja o [CLAUDE.md](CLAUDE.md).

> O QualiLab roda inteiro no navegador, num único arquivo. Não há instalação, login obrigatório nem servidor próprio. Você pode começar agora mesmo em **[luizpf42.github.io/QualiLab](https://luizpf42.github.io/QualiLab)**. Quer experimentar antes de ler? Os **[Primeiros 5 minutos](#primeiros-5-minutos)** colocam você a codificar já.

---

## Índice

> ⚡ **Com pressa?** Vá direto aos [**Primeiros 5 minutos**](#primeiros-5-minutos) e volte depois para aprofundar.

0. [A ideia do QualiLab](#0-a-ideia-do-qualilab): para que serve, que problemas ataca, como planejar o uso
1. [Conceitos fundamentais](#1-conceitos-fundamentais): o modelo mental antes de tudo
2. [Começando](#2-começando): acessar, escolher onde salvar, criar projeto
3. [A interface](#3-a-interface): cabeçalho e as telas principais
4. [Documentos](#4-documentos): enviar, colar, renomear, editar o texto
5. [Codificação de trechos](#5-codificação-de-trechos): o coração da ferramenta
6. [Categorias (atributos do documento)](#6-categorias-atributos-do-documento)
7. [Esquema](#7-esquema): organizar códigos e categorias em lote
8. [Reconciliação](#8-reconciliação): consolidar o gabarito (projeto coletivo)
9. [Visualização](#9-visualização): ler os trechos por código
10. [Gráficos](#10-gráficos)
11. [Memos](#11-memos): notas analíticas
12. [Relatório](#12-relatório): o hub de publicação e transparência
13. [Colaboração](#13-colaboração): equipe, papéis, convites
14. [Minha conta](#14-minha-conta)
15. [Importar e exportar](#15-importar-e-exportar)
16. [Salvamento, backup e modos de armazenamento](#16-salvamento-backup-e-modos-de-armazenamento)
17. [Codificar e Analisar com IA](#17-codificar-e-analisar-com-ia): IA opcional (BYOK), opt-in e transparente
18. [Solução de problemas](#18-solução-de-problemas)
19. [Atalhos de teclado](#19-atalhos-de-teclado)
20. [Glossário](#20-glossário)

---

## 0. A ideia do QualiLab

*Se você caiu de paraquedas aqui, comece por esta seção: ela explica para que serve o QualiLab, que problemas ele ataca e como tirar bom proveito dele, para você planejar o uso antes de sair clicando.*

### Em uma frase

QualiLab é o seu **laboratório de pesquisa qualitativa em um único arquivo**: você abre um documento, seleciona um trecho e já codifica, e tem onde **experimentar** com o material (ler, visualizar, cruzar, testar ideias) e **transformar** o resultado em algo que outras pessoas possam ler e aproveitar.

### O espírito: um laboratório, não um arquivo morto

O nome não é enfeite. Laboratório é onde se **experimenta**: você levanta uma hipótese, mistura materiais, testa uma ideia, descarta o que não se sustenta e transforma o que sobra em algo útil. O QualiLab é feito para esse vaivém, não para "guardar" a análise, mas para **mexer** nela.

Por isso **Visualização**, **Gráficos** e o **Relatório Interativo (ATI)** não são acessórios pregados no fim do processo: são as bancadas do laboratório. Em **Visualização** você junta todos os trechos de um código e relê o conjunto; em **Gráficos** você levanta e derruba hipóteses olhando frequências, cobertura e co-ocorrências; no **Relatório** você **transforma a exploração em produto**: um relatório pronto, uma página interativa, um conjunto de anotações. Exploração de um lado, produto do outro, e o caminho entre os dois curto o bastante para você ir e voltar quantas vezes precisar.

### Os problemas que ele ataca

A análise qualitativa de dados (QDA) costuma cobrar caro em três moedas. O QualiLab foi desenhado contra as três:

1. **Custo e barreira de entrada.** As ferramentas de referência (ATLAS.ti, MAXQDA, NVivo) são caras, fechadas e têm uma curva de aprendizado que consome horas *antes* de a primeira análise começar. O QualiLab é **gratuito, de código aberto (MIT) e abre direto**: sem instalação, sem servidor próprio, sem assinatura. Carregou um documento, selecionou, codificou.

2. **A planilha paralela.** Codificação temática numa ferramenta; atributos estruturados (ano, fonte, tribunal, perfil do entrevistado) numa planilha à parte. O QualiLab **integra os dois**: códigos de **trecho** (o que o texto diz) e **categorias** do documento (o que o documento é) convivem no mesmo ambiente, sem alternar de ferramenta.

3. **A evidência que fica para trás.** Um argumento qualitativo forte fica ainda mais forte quando quem lê pode **ver o material que o sustenta**, mas mostrar esse caminho sempre foi trabalhoso: preso em ferramentas caras ou espalhado por arquivos soltos. O QualiLab encurta esse caminho: codificação, categorias, memos e reconciliação ficam **explícitos e exportáveis**, e dá para publicá-los em padrões abertos (ATI / W3C Web Annotation), **na medida e no formato que você escolher**, sem depender de nenhum fornecedor.

### Para o que serve

Qualquer corpus de **texto** que você queira interpretar de forma sistemática: entrevistas e transcrições, decisões e peças judiciais, documentos de política pública, notícias, respostas abertas de survey, atas, relatórios, literatura. Funciona sozinho ou em equipe, online ou totalmente offline.

### O que uma boa pesquisa com o QualiLab quer alcançar

Pense nestes como **objetivos** que orientam o uso, não recursos, mas o que você está construindo:

- **Afirmações com lastro.** Cada ponto apoiado em trechos concretos, que você pode mostrar quando quiser dar peso ao argumento.
- **Profundidade interpretativa _e_ comparabilidade estruturada.** Memos e codificação rica capturam o sentido; categorias permitem contar, cruzar e comparar. Os dois lados da pesquisa qualitativa, no mesmo lugar.
- **Autoria explícita e acordo entre codificadores.** Em equipe, cada um codifica na sua camada e o grupo consolida um gabarito na Reconciliação: o **desacordo vira dado**, não ruído varrido para baixo do tapete.
- **Controle sobre os seus dados.** Você escolhe onde eles ficam, e sabe o que cada opção implica (veja *Dados sensíveis e responsabilidade*, abaixo).

### Transparência a serviço do seu argumento

Uma palavra sobre transparência, porque o termo é carregado. Aqui ela **não** significa prestação de contas, nem a promessa de "replicar" uma análise interpretativa: isso seria medir a pesquisa qualitativa por uma régua que não é a dela. A ideia é mais simples e mais a seu favor: **mostrar a evidência ao lado da leitura que você faz dela fortalece o que você defende.** Quando quem lê pode percorrer os trechos que sustentam um achado, o seu argumento ganha credibilidade, sem que você abra mão de uma vírgula da sua interpretação.

E sempre com as cautelas que a pesquisa qualitativa exige: o sentido é situado e construído, nem tudo pode ou deve ser exposto, e o sigilo das fontes vem antes de qualquer coisa. Por isso, no QualiLab, a transparência é **opcional, gradual e sua**: você decide o que mostrar, para quem e quando, e os trechos marcados como **censura** saem mascarados por padrão. A ferramenta oferece os meios; o juízo é seu.

### Dados sensíveis e responsabilidade

Antes de carregar qualquer material, decida **o quanto da ferramenta você pode usar**, porque isso depende da **sensibilidade do dado**, e não é uma escolha lateral neutra. A regra de ouro: **o material só sai do seu dispositivo se você deixar**, ao trabalhar em **nuvem** (sincroniza via Supabase), ao usar **IA remota** (vai ao provedor que você escolher) ou ao **publicar** um relatório. Nos modos **arquivo** e **rascunho**, e com a **IA local**, nada sai do seu computador.

> **Regra prática (safe-by-default):** na dúvida, trate o material como mais sensível. Dado **público ou sintético** libera tudo; dado **sensível** pede o modo arquivo e, se usar IA, a **sua própria** chave (de preferência paga/institucional) com a censura conferida; dado **vedado** (comitê de ética que proíbe saída, saúde identificável, segredo de justiça) fica **offline**, sem nuvem e sem IA remota. E lembre: a **censura mascara só o que você marcou à mão** (não é anonimização automática) e **anonimizar** nas exportações apenas omite a autoria. A **matriz de decisão completa** e o que a censura **não** faz estão na [seção 16](#16-salvamento-backup-e-modos-de-armazenamento). Leia antes de escolher onde salvar.

> **Aviso legal.** O QualiLab é um projeto **pessoal**, distribuído sob licença **MIT, sem qualquer garantia**. Não representa posição nem implica responsabilidade de qualquer instituição (incluindo a FGV). O autor não se responsabiliza por perda de dados, vazamento ou uso indevido. Use por sua conta e risco, com as cautelas éticas e legais que a sua pesquisa exige.

### Como planejar o uso (um roteiro mínimo)

1. **Declare o objetivo** da pesquisa num **memo de projeto** ([seção 11](#11-memos)). Ele orienta a codificação, e também orienta a IA.
2. **Escolha onde os dados ficam** ([seção 16](#16-salvamento-backup-e-modos-de-armazenamento)) conforme a sensibilidade do material e se há equipe (releia *Dados sensíveis e responsabilidade*, acima).
3. **Escolha o tipo de projeto**, individual ou coletivo ([seção 2](#2-começando)).
4. **Traga os documentos** e preencha as **categorias** que vai querer comparar depois ([seções 4](#4-documentos) e [6](#6-categorias-atributos-do-documento)).
5. **Codifique**, deixe os códigos emergirem (indutivo) ou siga um esquema prévio; registre decisões em memos ([seção 5](#5-codificação-de-trechos)).
6. **Reconcilie** (em equipe) ou revise (sozinho) ([seção 8](#8-reconciliação)).
7. **Experimente e publique**, explore em Visualização e Gráficos e transforme em produto pelo Relatório ([seções 9](#9-visualização)–[12](#12-relatório)).

### Como o QualiLab foi feito (e o que esperar)

Vale ser honesto sobre a origem da ferramenta. O QualiLab foi escrito, **em sua maior parte, com o [Claude Code](https://claude.com/claude-code)** (a IA de programação da Anthropic), **guiado pelo autor** a partir de problemas reais encontrados na própria prática de pesquisa e no diálogo com a comunidade e a literatura de métodos qualitativos. Em parte, o projeto é ele mesmo um experimento sobre uma pergunta: **até onde dá para transformar uma IA guiada numa ferramenta de pesquisa?**

Disso decorrem duas consequências honestas: **bugs são esperados** (é software jovem, em desenvolvimento ativo) e **as melhorias são constantes**. Salve o seu trabalho com frequência ([seção 16](#16-salvamento-backup-e-modos-de-armazenamento)) e, se encontrar um problema ou tiver uma ideia, relate em [github.com/LuizPF42/QualiLab](https://github.com/LuizPF42/QualiLab/issues). Esse retorno é parte de como a ferramenta evolui.

### Uma palavra sobre a IA dentro do QualiLab

Coerente com o que foi dito acima, o QualiLab incorpora IA como **assistente, nunca como substituta do julgamento do pesquisador**, sob três regras inegociáveis. **Opt-in:** a IA fica desligada por padrão; nada é enviado a um modelo sem você pedir, análise a análise. **Transparência:** você pode ver o prompt exato, a IA devolve **propostas** que você aprova ou recusa uma a uma, e ela é obrigada a **citar a fonte** (trecho e documento) de cada observação. **Controle:** trechos marcados como censura são mascarados antes de qualquer envio, e você usa a chave/modelo do projeto ou a **sua própria**. A IA acelera leitura e organização; a interpretação e a decisão continuam suas. Detalhes na [seção 17](#17-codificar-e-analisar-com-ia).

---

## 1. Conceitos fundamentais

Antes de clicar em qualquer botão, vale entender cinco ideias. Elas se repetem em todas as telas.

### Documento
Um texto a ser analisado: uma entrevista, uma decisão judicial, um artigo, uma transcrição. Você importa (`.txt`, `.md`, `.docx`, `.pdf`) ou cola o texto direto. Cada linha de uma planilha (`.csv`/`.xlsx`) também pode virar um documento.

### Código
Um rótulo que você aplica a **trechos** do texto ("este parágrafo fala de *acesso à justiça*"). Códigos são **hierárquicos**: uma família (Hierarquia 0) pode ter subcódigos, e estes podem ter os seus. A **cor** vem da família (o matiz) e a **tonalidade** indica a profundidade. É a codificação temática clássica de QDA.

### Categoria (atributo do documento)
Diferente do código: a categoria descreve o **documento inteiro**, não um trecho. "Ano", "Tribunal", "Tipo de fonte", "Gênero do entrevistado". É o que normalmente vira coluna numa planilha paralela; aqui fica integrado. Há cinco tipos (Texto Fechado, Texto Aberto, Data, Múltipla Escolha, Caixa de Seleção).

> **Código × Categoria, em uma frase:** *código* marca um **pedaço** do texto; *categoria* responde uma pergunta sobre o **documento todo**.

### Camadas e autoria
Toda codificação e toda resposta de categoria registra **quem** fez. Há duas camadas:

- **Individual**: o trabalho de cada pesquisador, separado.
- **Final (gabarito)**: a versão consolidada da equipe.

Em **projeto individual**, tudo já vai direto para o gabarito. Em **projeto coletivo**, cada um trabalha na sua camada individual e a equipe consolida o gabarito na tela de **Reconciliação**.

### Papéis (projeto coletivo)
- **Admin**: define o esquema de categorias, edita o gabarito, gerencia membros, define as cores de família e a **censura**, edita o **texto** dos documentos, **importa** material e faz as operações **estruturais e destrutivas** — **excluir** documentos ou códigos e **mesclar** códigos (que afetam o trabalho de toda a equipe).
- **Membro**: codifica na sua camada, preenche as próprias respostas de categoria, **cria e renomeia** códigos, e escreve memos.

> Essas restrições são impostas pelo **servidor**, não apenas escondidas na interface: um membro não consegue — nem por chamada direta à API — escrever no gabarito, excluir documentos/códigos, editar o texto compartilhado, remover a censura de um código ou importar. Essas ações exigem o papel de admin.

> Onde os dados ficam (nuvem, navegador ou arquivo no disco) é uma escolha **separada** do tipo de projeto. Veja a [seção 16](#16-salvamento-backup-e-modos-de-armazenamento).

---

## Primeiros 5 minutos

*Quer sentir a ferramenta na mão antes de mergulhar no método? Este é o caminho mais curto até o seu primeiro código, sem criar conta nem instalar nada.*

1. Abra **[luizpf42.github.io/QualiLab](https://luizpf42.github.io/QualiLab)** e clique em **Só testar (rascunho)**: um projeto abre na hora, só neste navegador.
2. Na aba **Codificação**, clique em **colar texto** e cole um trecho: uma fala de entrevista, um parágrafo de decisão, uma notícia (ou use **＋ enviar** para um `.txt`, `.pdf` ou `.docx`).
3. **Selecione** com o mouse uma frase que lhe chame atenção, clique com o **botão direito** e escolha **+ Criar novo código**. Dê um nome ao tema (ex.: *acesso à justiça*) e clique em **Criar e aplicar**. Pronto, seu primeiro trecho codificado.
4. Codifique mais alguns trechos: **repita o mesmo código** onde o tema volta, **crie outros** onde surgem temas novos.
5. Abra a aba **Visualização** e clique no seu código: todos os trechos que você marcou aparecem juntos, lado a lado. É a sua análise começando a tomar forma.

> Gostou? Antes de ir longe, decida **onde salvar** o trabalho (o rascunho é efêmero, [seção 16](#16-salvamento-backup-e-modos-de-armazenamento)) e leia a **[seção 0](#0-a-ideia-do-qualilab)** para tirar o máximo da ferramenta. O resto do manual aprofunda cada um destes passos.

---

## 2. Começando

### 2.1. Como acessar

| Forma | Como | Quando usar |
|---|---|---|
| **Online** | Abra [luizpf42.github.io/QualiLab](https://luizpf42.github.io/QualiLab) | O caminho normal |
| **Offline** | [Baixe o `index.html`](https://github.com/LuizPF42/QualiLab/releases) e dê duplo clique | Sem internet, dados sensíveis |

Ao baixar, o arquivo abre direto no navegador (`file://`) sem precisar de servidor. Ele só busca as bibliotecas externas pela internet **na primeira vez**. (Se a sua política de navegador bloquear, sirva com `python -m http.server 8000` na pasta do arquivo.)

> **Chrome ou Edge** são recomendados: só neles funciona o **modo Arquivo local** (salvar um `.qualilab` visível no disco) e o **backup automático em pasta**. Firefox e Safari funcionam, mas caem para o modo rascunho (`localStorage`).

### 2.2. A tela de entrada

![A tela de entrada do QualiLab: os três caminhos (Novo em arquivo, Entrar na nuvem e Só testar), com "Abrir arquivo existente" e "Conectar ao meu Supabase" logo abaixo.](manual-img/01-welcome.png)

A primeira tela oferece três caminhos (com o logo no topo):

1. **Novo em arquivo**: cria um projeto salvo como arquivo `.qualilab` no seu disco (Chrome/Edge): portátil, offline, sem nuvem. Ideal para dados sensíveis.
2. **Entrar na nuvem**: leva ao **login** (e-mail e senha; ou **Criar conta** na mesma tela, informe um **nome de exibição**, e-mail e senha de no mínimo 6 caracteres), para trabalho colaborativo e sincronizado entre dispositivos. **← Voltar** retorna à tela de entrada.
3. **Só testar (rascunho)**: abre na hora um projeto de **rascunho** neste navegador, sem configurar nada. É efêmero (some se você limpar os dados do site), bom para experimentar; migre para arquivo ou nuvem quando quiser (um clique no hub do projeto).

Um botão violeta **"Conectar ao meu Supabase"** (na tela de entrada e no login) aponta o app para o **seu próprio servidor Supabase** antes de logar: é onde ficam os seus projetos coletivos.

> Um arquivo ou sessão já aberto **reabre sozinho** na próxima vez. Se o app não tiver nuvem configurada, "Entrar na nuvem" não aparece e você começa direto em arquivo/rascunho.

### 2.3. Escolher / criar um projeto

Depois do login (ou direto, sem nuvem) aparece **"Meus projetos"**:

- **Abrir um projeto existente**: clique nele na lista, ou em **abrir**.
- **Criar projeto**:
  1. Confirme o **seu nome de exibição**.
  2. Digite o **nome do projeto**.
  3. Escolha o tipo: **Projeto Individual** (uso solo, tudo vai direto pro gabarito, sem reconciliação) ou **Projeto Coletivo** (vários pesquisadores, com reconciliação).
  4. Clique em **Criar**.
- **Entrar com código**: para participar de um projeto coletivo de outra pessoa, cole o **código de acesso** (ex.: `9F2A1C`) e clique em **Entrar**.
- **Arquivo local** (Chrome/Edge): **Novo arquivo…** cria um `.qualilab` no disco; **Abrir arquivo…** reabre um existente. Ideal para dados sensíveis (sem nuvem, sem rede).

> O tipo do projeto pode ser mudado depois (admin). Converter **Coletivo → Individual é irreversível**: colapsa todas as codificações num único autor e mantém só o gabarito das categorias.

---

## 3. A interface

![A tela de Codificação com um projeto aberto: à esquerda o leitor com os trechos grifados na cor de cada código; à direita, os painéis de Categorias e Códigos. No topo, o cabeçalho em duas linhas, com as abas e a pílula do projeto.](manual-img/02-codificacao.png)

Depois de abrir um projeto, o **cabeçalho** tem duas linhas:

**Primeira linha**
- **QualiLab** (volta ao GitHub) e o botão de tema escuro/claro da *interface* (**☀︎/⏾**, não confundir com o tema do *leitor*, que fica na barra do documento).
- As abas principais (`.seg`):

| Aba | Para quê |
|---|---|
| **Codificação** | Ler o documento e aplicar códigos/categorias |
| **Reconciliação** | *(só projeto coletivo)* consolidar o gabarito |
| **Visualização** | Ver todos os trechos de um código |
| **Gráficos** | Frequências, nuvem, co-ocorrência etc. |
| **Memos** | Notas analíticas |
| **Esquema** | Organizar códigos e categorias em lote |
| **Codificar com IA** | *(opcional, BYOK)* IA propõe codificação/categorização/organização, você aprova |
| **Analisar com IA** | *(opcional, BYOK)* conversa analítica sobre o material selecionado |
| **Relatório** | Exportar relatórios e pacotes de transparência |

> As duas telas de **IA** são **opt-in**. Detalhes na [seção 17](#17-codificar-e-analisar-com-ia).

**Segunda linha**
- A **pílula do projeto**, ex.: `rascunho · Meu Projeto · individual ▾`. O prefixo mostra o modo de armazenamento (`arquivo`/`nuvem`/`nuvem pessoal`/`rascunho`) e a **cor** reforça onde os dados estão: neutra = rascunho (neste navegador), verde = arquivo no seu disco, azul = nuvem (servidor padrão), violeta = nuvem no seu próprio Supabase, âmbar = nuvem sem conexão. Passe o mouse para a explicação (em modo rascunho, inclui o % usado do armazenamento do navegador); clicar abre o **hub de gestão do projeto**.
- Seu **nome**, **clicável em todos os modos** (nuvem, rascunho e arquivo) → Minha conta. Em modo offline, é também a porta de entrada para configurar a sua chave/modelo de IA, inclusive o Ollama local (veja a [seção 17](#17-codificar-e-analisar-com-ia)).
- **trocar projeto** / **sair** (modo nuvem).
- **exportar ▾** e **importar ▾** (aparecem quando há documentos).
- Indicadores `offline` / `sincronizando…` (modo nuvem).

Logo abaixo do cabeçalho podem aparecer **faixas de aviso**: erro (vermelho), importação em andamento (com barra de progresso) e o aviso de falha de salvamento (veja a [seção 16](#16-salvamento-backup-e-modos-de-armazenamento)).

---

## 4. Documentos

### Enviar arquivos
Na aba **Codificação**, no topo do leitor, clique em **＋ enviar** e escolha um ou mais arquivos `.txt`, `.md`, `.docx` ou `.pdf`. O texto é extraído e exibido para leitura.

- **PDF**: o texto é reagrupado em parágrafos (junta linhas quebradas, trata hifenização). Tabelas **não** são reconstruídas. PDFs muito visuais podem sair com a leitura imperfeita.
- **DOCX**: convertido para texto. A formatação rica não é preservada (o foco é o conteúdo a codificar).

### Colar texto
Use o botão de **colar** (ao lado de ＋ enviar) para criar um documento a partir de texto copiado, sem arquivo.

### Trocar de documento, renomear e editar o texto
- O **seletor** no topo do leitor alterna entre os documentos do projeto.
- O botão **🗑 deletar** (ao lado) remove o documento aberto e todas as suas codificações. Não há desfazer, então confirme com cuidado.
- O botão **✏ editar** (ao lado do seletor) abre o modo de edição do documento aberto: nele você corrige o **título** e o **texto extraído**, útil quando um PDF vem com sujeira (um trecho grudado, um rodapé que sobrou, uma linha quebrada). **Salvar** grava as duas coisas; **Cancelar** descarta.
- Ao salvar uma edição do texto, **os grifos já feitos são reancorados automaticamente** às novas posições. Se alguma codificação cair exatamente sobre o trecho que você mexeu, o app avisa antes de salvar (esses grifos podem precisar de conferência).
- Editar serve para **limpeza local**; corrupção do documento inteiro (por exemplo, um PDF antigo que sai inteiro sem espaços) é caso de OCR, não de correção à mão.
- Em projeto **coletivo na nuvem**, editar o texto é restrito ao **administrador** (o texto é compartilhado, então a edição desloca os grifos de todos os codificadores).

### Importar muitos documentos de uma vez
Uma planilha (`.csv`/`.xlsx`) vira **um documento por linha**. Veja [Importar e exportar](#15-importar-e-exportar).

---

## 5. Codificação de trechos

Esta é a tela **Codificação**: leitor à esquerda, painéis de **Categorias** e **Códigos** à direita.

### 5.1. Criar códigos
No painel **Códigos** (direita) você cria e organiza os rótulos. Um código novo nasce como família (Hierarquia 0). Você pode criar subcódigos, renomear e excluir. Também dá para criar um código **na hora de aplicar** (veja abaixo).

> **Dica de pesquisa.** Deixe os códigos *emergirem* do material (a abordagem **indutiva**, em que os temas nascem da leitura) ou aplique um esquema teórico prévio (a abordagem **dedutiva**). As duas são válidas; o que importa é ter consciência de qual você está usando. Evite criar um código para cada frase: se um rótulo aparece uma única vez, pergunte se é mesmo um tema ou só um detalhe. E, ao criar um código, anote num **[memo](#11-memos)** o que ele *inclui e exclui*: esse é, na prática, o seu **livro de códigos** (*codebook*), o que mantém a codificação consistente ao longo do tempo e entre pessoas.

### 5.2. Aplicar um código a um trecho

![Com um trecho selecionado, o clique com o botão direito abre o menu de códigos: clique num código para aplicá-lo, ou em "+ Criar novo código". A faixa azul no topo confirma o trecho selecionado.](manual-img/03-codificacao-menu.png)

1. **Selecione** o trecho no texto com o mouse.
2. **Clique com o botão direito** sobre a seleção.
3. No menu de contexto, clique no código desejado; ele é aplicado na hora.
   - Ou clique em **+ Criar novo código**: digite o nome, escolha se é uma **nova família (nível 0)** ou um **subcódigo de "…"**, e clique em **Criar e aplicar**.

> Ao aplicar, o grifo aparece no texto com a cor do código. **A linha embaixo do grifo só aparece quando há mais de um código sobrepondo o mesmo trecho**. É o sinal de sobreposição. Trecho com um código só fica apenas tintado, sem linha, para não poluir.

### 5.3. Remover um código de um trecho
Você **não precisa selecionar de novo**:
1. Clique com o **botão direito sobre o grifo** existente.
2. No menu, em **Remover código** (admins em projeto coletivo veem "Rejeitar / remover código"), clique no código que quer tirar.

> Em projeto coletivo na nuvem, você só remove codificações **suas**. Não dá para apagar o grifo de outro pesquisador. (Em projeto individual, tudo é seu.)

### 5.4. Desfazer (Ctrl+Z)
**Ctrl+Z** desfaz a **última codificação aplicada** na sessão atual (até as últimas 50). Funciona só na aba Codificação e fora de campos de texto. Não há desfazer para outras ações (excluir documento, categoria, código etc.). Essas são definitivas.

### 5.5. Censura (mascarar trechos sensíveis)
Um código pode ser marcado como **censura** (no [Esquema](#7-esquema), por um admin). Trechos com esse código aparecem como uma caixa preta e, nas saídas de transparência ([Relatório](#12-relatório)), saem mascarados como `[trecho censurado]` por padrão, útil para publicar mantendo nomes/dados sensíveis ocultos.

### 5.6. Controles de leitura
A barra no topo do leitor ajusta **só a leitura** (preferência salva no navegador):
- **A-** / **A+**: diminui/aumenta a fonte.
- **⬍ / ⬌**: alterna a largura da coluna (padrão ↔ coluna estreita de leitura).
- **◔ / ◗ / ◕**: tema do leitor: claro / sépia / escuro (independente do tema da interface).

### 5.7. Buscar no documento
Clique em **🔍︎ pesquisar** (a lupa). Digite o termo: as ocorrências são destacadas por cima dos grifos, com navegação **‹ anterior / próxima ›** (e **Enter** / **Shift+Enter**), com volta ao início ao chegar no fim.

### 5.8. Filtro "Ver:" (de quem é o que aparece)
O seletor **Ver:** controla **de quem** são os grifos e as respostas de categoria exibidos. Aparece em projeto coletivo e também quando há mais de um codificador (ex.: dados importados com vários autores). Em projeto coletivo, as opções são:
- **Individuais (todos)**: sobrepõe os grifos de todos + o gabarito ao mesmo tempo (só leitura).
- **Minhas**: só o seu trabalho (editável).
- **(nome de cada pesquisador)**: o trabalho de um colega específico (só leitura).
- **Final / gabarito**: a camada consolidada (só leitura aqui; edita-se na Reconciliação).

Em projeto individual com mais de um autor importado, o seletor mostra **Todos os codificadores** e o nome de cada autor.

> **Por que algumas visualizações são só leitura?** Editar enquanto vê o trabalho de *outra* pessoa gravaria sob a *sua* identidade. Por isso só **Minhas** (ou projeto individual) permite editar a resposta de categoria ali. O gabarito se edita na Reconciliação.

---

## 6. Categorias (atributos do documento)

No painel **Categorias** (direita, na aba Codificação) você responde os atributos do **documento aberto**.

### Os cinco tipos
| Tipo | Como preenche |
|---|---|
| **Texto Fechado** | Lista suspensa, escolhe **um** |
| **Texto Aberto** | Campo livre |
| **Data** | DD / MM / AAAA, com partes opcionais (pode pôr só o ano) |
| **Múltipla Escolha** | Botões, escolhe **um** |
| **Caixa de Seleção** | Botões, escolhe **vários** |

Cada categoria pode ter uma **descrição/instrução** e habilitar duas opções especiais: **"Não informado"** e **"Outros"** (com valor livre).

> **Dica de pesquisa.** Crie uma categoria só se você for **comparar ou contar** por ela depois (ano, tribunal, perfil do entrevistado). É isso que alimenta os filtros e os [Gráficos](#10-gráficos). Categoria que nunca entra numa comparação vira peso morto. Pense nelas como as **colunas** que você quereria numa planilha para cruzar com os temas (que são os códigos).

### Quem define e quem preenche
- **Definir o esquema** (criar categorias, tipos, opções): admin, no item **"Gerenciar esquema de categorias"** (dentro do painel Categorias) ou na aba **Esquema → Categorias**.
- **Preencher**: qualquer membro responde a **sua** versão; o admin define o **gabarito**.
- A resposta exibida segue o filtro **Ver:** (ver a de outro pesquisador é só leitura).

---

## 7. Esquema

![A aba Esquema (sub-aba Códigos): a árvore de códigos com a hierarquia (a família "Adoção e motivação" aparece expandida em subcódigos), reordenável arrastando pelo punho ⠿. Marcar duas ou mais caixas libera as ações "Agrupar" e "Mesclar".](manual-img/04-esquema.png)

A aba **Esquema** é uma tela cheia (sem documento aberto) para organizar tudo de uma vez. Tem duas sub-abas.

### 7.1. Categorias
Mesma edição do painel de Categorias, mas focada em montar o esquema: criar, editar tipos e opções, e **reordenar arrastando** pelo punho **⠿** (o item arrastado fica translúcido; uma linha azul mostra onde vai cair).

### 7.2. Códigos (reorganização em lote)
Pensado para quem terminou uma codificação aberta com **centenas de códigos soltos** e quer organizá-los. É uma árvore com **caixas de seleção**; o painel da direita muda conforme a seleção:

- **Clique simples em um código** (na linha, não na caixa) → editar nome/cor + **Promover a Hierarquia 0** (se for subcódigo).
- **Marque 2 ou mais** (caixas) → aparecem duas ações:
  - **Agrupar**: os marcados viram **filhos** de um código (existente, escolhido na lista, ou novo). Continuam separados, só ganham um pai. Adotam a cor do pai.
  - **Mesclar**: escolhe um **sobrevivente** (sugestão = o mais frequente); as codificações dos demais são **reatribuídas** a ele e os outros são excluídos. **Irreversível**: confirma antes. Os filhos dos mesclados são preservados (passam para o sobrevivente).
- **Reordenar entre irmãos**: arraste pelo punho **⠿** (só reordena dentro do mesmo pai; para mudar de pai, use **Agrupar**).

### 7.3. Ver os códigos como Mapa (quadro branco espacial)

![O Mapa dos códigos (Esquema → Códigos → ⊞ Mapa): cada código é uma bolha (o tamanho reflete quantas vezes foi usado; a cor é a da família), ligada aos filhos por linhas. Arraste para organizar; o layout fica salvo com o projeto.](manual-img/13-mapa.png)

No alto do painel de códigos, o seletor **⛼ Árvore / ⊞ Mapa** troca a lista hierárquica por um **quadro branco espacial**: cada código vira uma **bolha** (o tamanho reflete o número de trechos; a cor é a da família) e linhas ligam pai e filho. É outra forma de enxergar e reorganizar o mesmo esquema, útil quando há muitos códigos.

- **Arraste** as bolhas para posicioná-las como quiser — o layout **fica salvo** com o projeto. **⤢ ajustar** enquadra tudo na tela; **↻ reembaralhar** recalcula as posições (sobrescreve o layout); **☑ linhas** mostra/esconde as ligações de hierarquia.
- **Selecionar**: clique numa bolha; **Ctrl+clique** ou o **laço** (ferramenta **▚**, arrastando no vazio) marcam várias. A ferramenta **✜** move a tela; a **roda do mouse** dá zoom.
- **Botão direito** sobre uma bolha abre um menu cujo alvo é o **destino**: criar subcódigo, **mover** a seleção para dentro dele, **mesclar** a seleção ali (o alvo sobrevive), **promover** ao topo, **agrupar** sob um novo pai, ou **excluir**. São as mesmas operações da Árvore, com as mesmas proteções.

### 7.4. Cores e censura (admin)
Ao editar um código, o admin pode:
- Escolher a **cor da família** por um controle de **matiz** (0–359), ou **cinza** / **preto**, propagada aos subcódigos.
- Marcar o código como **censura** (força a cor preta). Veja [5.5](#55-censura-mascarar-trechos-sensíveis).

> **Importante:** o painel de Códigos da aba **Codificação** continua existindo e é independente. A reorganização em lote é só aqui no Esquema, de propósito (menos mudança de hábito na tela de codificar).

---

## 8. Reconciliação

![Reconciliação, aba Códigos, documento ENT-01: cada grupo reúne as codificações que se sobrepõem num mesmo código (o caminho do código, quem codificou e o trecho). Aqui já estão todas "na camada final", com a opção de removê-las; quando ainda não estão, aparece "Consolidar no final".](manual-img/14-reconciliacao.png)

*Só em projeto coletivo.* É onde a equipe consolida o **gabarito** a partir do trabalho individual de cada pesquisador. A coluna da esquerda escolhe entre **Categorias** e **Códigos**, e navega por documento — incluindo a opção **(Todos os documentos)**, que reconcilia o projeto inteiro de uma vez.

**Categorias.** Para cada documento e categoria, você vê o **Gabarito** (que o admin define) e, abaixo, a resposta de cada pesquisador com **✓** (igual ao gabarito) ou **✗** (diferente). No modo (Todos os documentos), escolhe-se uma categoria e ela é consolidada documento a documento.

**Códigos.** Cada **grupo** reúne as codificações que se **sobrepõem** no mesmo código, com o trecho e quem codificou. O selo **"N de M · consenso"** mostra quantos codificadores marcaram aquele trecho — quando todos concordam, o card ganha destaque. Você **consolida** cada grupo na camada final (**Consolidar no final →**) ou, se já estiver lá, pode **remover do final**.

- **Consolidar em massa**: havendo grupos pendentes, aparecem **Consolidar tudo feito por mim (N)** e **Consolidar tudo (N)** — do documento aberto ou, em (Todos os documentos), do projeto inteiro (respeitando o filtro de código). É irreversível; o app confirma antes.
- **Atalho pelo leitor**: na aba Codificação, o admin pode aceitar um grifo direto no gabarito pelo **botão direito → "Aceitar no gabarito"**, sem passar por esta tela.

O resultado vira a camada **Final**, usada nos relatórios e gráficos quando você escolhe "gabarito".

---

## 9. Visualização

![Visualização: à esquerda, os filtros por categoria e a árvore de códigos; à direita, todos os trechos do código selecionado, agrupados por documento e com a autoria e a camada de cada codificação.](manual-img/05-visualizacao.png)

Tela mestre-detalhe para **ler todos os trechos de um código**:

- **Esquerda**: escolha a camada (Ver:) e navegue pela árvore de códigos (e pelas categorias colapsáveis).
- **Direita**: todos os trechos do código selecionado, em tipografia de leitura, **agrupados por documento**.

Recursos:
- **Trechos idênticos, um card só**: quando **mais de um pesquisador** marca o **mesmo trecho com o mesmo código**, ele aparece **uma vez**, com um **balão de nome por pesquisador** embaixo — em vez de cards repetidos. Cada balão traz um **×** para remover aquela marcação específica.
- **Nota analítica (●)**: um balão com **●** avisa que aquele trecho tem uma nota analítica; clique no **●** para **ler a nota ali mesmo**. (A nota se escreve pelo menu de contexto do leitor, em "Anotar trecho".)
- **Abrir no leitor**: clique no **texto do trecho** para pular até ele na aba Codificação, **no lugar exato do grifo** — ele pisca por um instante para você achar.
- **Filtro por categoria**: restringe aos documentos que atendem certos atributos.
- **Co-ocorrência**: mostra trechos onde dois códigos aparecem juntos.
- **Aceitar no gabarito** *(admin, projeto coletivo)*: consolida um trecho individual direto na camada final, sem ir à Reconciliação.

---

## 10. Gráficos

![A aba Gráficos, no gráfico de Frequência: quantas vezes cada código foi usado. À esquerda, os filtros por categoria e "Ignorar censura"; no topo, as demais abas (Nuvem, Co-ocorrência, Cobertura, etc.) e a exportação em SVG/PNG.](manual-img/06-graficos.png)

A aba **Gráficos** é um explorador: filtros à esquerda, um gráfico por vez à direita (escolhido nas abas). Todos os gráficos são desenhados em SVG (sem bibliotecas) e podem ser **exportados em SVG ou PNG**.

### Abas disponíveis
| Aba | O que mostra |
|---|---|
| **Frequência** | Quantas vezes cada código foi usado |
| **Nuvem** | Nuvem de palavras dos trechos codificados (cor do código predominante) |
| **Co-ocorrência** | Matriz de pares de códigos que se sobrepõem |
| **Cobertura** | % do corpus coberto por cada código |
| **Código × atributo** | Cruzamento de um código com uma categoria (heatmap) |
| **Tempo** | *(se houver categoria de data)* distribuição ao longo do tempo |
| **Codificadores** | *(só coletivo)* produção e concordância entre pesquisadores |

### Filtros (coluna esquerda)
- **Por categoria**: restringe **todos** os gráficos aos documentos que passam ("X de Y documentos no filtro").
- **Ignorar censura**: **ligado por padrão**; remove dos gráficos os trechos de códigos de censura.
- **Nuvem**: uma árvore com caixas seleciona de quais códigos vem o vocabulário (marcar um código marca a subárvore).
- **Co-ocorrência**: dois seletores escolhem os eixos **X** (colunas) e **Y** (linhas); vazio = os 12 mais frequentes.
- **Ver:** e **Top:** (10/25/50/Todos) refinam o recorte.

> **Do gráfico para os trechos.** Clique numa **barra** (Frequência, Cobertura, Concordância) ou numa **célula** (Co-ocorrência, Código × atributo) para abrir a **Visualização** já naquele código — o filtro de categorias e o recorte "Ver:" viajam junto, então os trechos exibidos batem com o número do gráfico.

---

## 11. Memos

![A aba Memos: à esquerda, os alvos das notas (memo do projeto, documentos, códigos, trechos anotados e as seções de IA); à direita, o memo do projeto em edição, com salvamento automático.](manual-img/07-memos.png)

A aba **Memos** guarda **notas analíticas**, texto livre que você anexa a um alvo do projeto, compartilhado entre os membros e com salvamento automático. Se a codificação **organiza** o material, o memo é onde a **interpretação acontece**: é aqui que você registra o que um código quer dizer, uma hipótese que surgiu, uma dúvida a resolver. Memoar cedo e com frequência é um dos hábitos que mais distinguem uma boa análise qualitativa. A coluna da esquerda navega por alvo:

- **Memo do projeto**: uma nota geral do projeto (rascunho livre; veja o aviso sobre a IA abaixo).
- **Documentos**: uma nota por documento.
- **Códigos**: uma nota por código (sua definição, regra de aplicação etc.).
- **Trechos anotados**: a nota ancorada num **grifo** específico (a seção aparece quando há alguma). Escreve-se pelo **botão direito sobre o grifo → "Anotar trecho (nota analítica)"**, ou aqui nos Memos. *(Por enquanto o grifo anotado não ganha marca no leitor de codificação; você reencontra a nota nesta seção ou no [Relatório Interativo](#121-relatório-interativo-ati).)*

No [Relatório Interativo (ATI)](#121-relatório-interativo-ati), a **nota de trecho** é o que aparece ao clicar num grifo, e a **nota de código** aparece na legenda (em árvore) — é assim que as duas alimentam a transparência ativa.

**Seções de IA** (aparecem com a IA ligada, abaixo das anteriores):

- **Memo para a IA**: o contexto do projeto escrito **para a IA**, injetado nos prompts por padrão. É **diferente** do *Memo do projeto* comum, que **deixou de ser enviado automaticamente** à IA (virou rascunho livre): se você quer que a IA leve o objetivo da pesquisa em conta, escreva-o aqui.
- **Prompts salvos**: a sua **biblioteca de prompts** (os que você salva na tela [Analisar com IA](#173-analisar-com-ia-leitura-assistida-do-material)): abra, renomeie ou apague cada um.
- **Conversas salvas**: cada conversa do [Analisar com IA](#173-analisar-com-ia-leitura-assistida-do-material) que você guardou, aberta por inteiro ao clicar.
- **Memória do projeto**: o **diário de insights da IA**: memórias curtas (fatos/decisões) que entram no contexto entre sessões; você adiciona à mão ou aprova as que a IA sugere, e liga/desliga quais usar.

---

## 12. Relatório

![A aba Relatório: na coluna esquerda, as três saídas (Relatório Interativo/ATI, Relatório Padrão e Web Annotation/W3C) e a opção de ocultar autoria; à direita, a prévia ao vivo do relatório interativo.](manual-img/08-relatorio.png)

A aba **Relatório** é o **hub de publicação**. Na coluna esquerda você escolhe entre três saídas. Em projeto coletivo, todas respeitam a **camada** escolhida (gabarito final ou individuais); em todas, trechos de **censura** saem mascarados. As saídas de transparência (ATI e W3C) ainda oferecem **anonimizar autoria**, que omite os nomes de quem codificou, útil para publicar sem expor a equipe. *Atenção: isso não anonimiza o conteúdo dos documentos. Veja [Dados sensíveis e responsabilidade](#0-a-ideia-do-qualilab).*

### 12.1. Relatório Interativo (ATI)
Uma **página HTML auto-contida** (sem servidor): cada documento aparece com os trechos grifados clicáveis. Clicar num **grifo** abre, num painel lateral, a **nota daquele trecho** (a *nota analítica por trecho* da [seção 11](#11-memos)); um trecho sem nota própria mostra "sem nota", e a definição do código fica na legenda. Os **títulos de documento** e os **códigos da legenda** abrem, no mesmo painel, o memo do documento e o memo do código. A **legenda de códigos vem em árvore** (mesma hierarquia do [Esquema](#7-esquema)), recolhível e com filtro, para escalar a projetos grandes; documentos vêm colapsados. É o equivalente ao *overlay* da **Annotation for Transparent Inquiry (ATI)** do QDR, mas hospedável por você (ex.: GitHub Pages, Dataverse como anexo).

### 12.2. Relatório Padrão
Um **montador**: marque as seções na coluna esquerda e o texto se monta ao vivo. Seções: resumo, lista de documentos, contagens e listas do esquema, frequência de códigos, distribuição por categoria, trechos por código, códigos não utilizados. Depois:
- **Copiar texto**: texto simples pronto para colar em Word/Google Docs.
- **Imprimir / PDF**: abre a impressão do navegador (força tinta escura sobre branco, mesmo se o app estiver em tema escuro).
- Opção de **creditar o QualiLab** no resumo.

### 12.3. Web Annotation (W3C)
Exporta as anotações no padrão aberto **[W3C Web Annotation Data Model](https://www.w3.org/TR/annotation-model/)** (JSON-LD): cada trecho vira uma anotação com seletor de posição/citação + nota analítica. É a "língua de dados" comum ao ATI, ao [hypothes.is](https://web.hypothes.is/), ao Anno-REP e ao Dataverse, interoperável sem casar com nenhuma ferramenta.

---

## 13. Colaboração

*(Projeto coletivo, modo nuvem.)*

### Convidar pessoas
Abra a **pílula do projeto** (cabeçalho) → ali está o **código de acesso**. Compartilhe-o; quem recebe entra por **"Meus projetos" → Entrar com código**. No modo nuvem, o código também aparece na própria pílula (`nuvem · Projeto · CÓDIGO · coletivo ▾`).

### Gerenciar membros e o projeto
Ainda na pílula do projeto, o admin pode: ver a **lista de membros** e mudar papéis (**admin/membro**), **renomear**, **limpar conteúdo**, **excluir** o projeto, mudar o **tipo** e ajustar a **conexão** (credenciais Supabase).

### Enviar para a nuvem
Se o projeto ativo for **rascunho** ou **arquivo**, a pílula mostra **"Enviar para a nuvem"**: cria um projeto novo na nuvem e copia tudo (documentos, categorias, códigos, codificações, memos) de uma vez, sem exportar/importar `.qualilab` na mão.

### Tempo real (e seus limites)
**Codificações** e **respostas de categoria** sincronizam ao vivo entre colaboradores. Já mudanças no **esquema de categorias** ou na **árvore de códigos** só aparecem para os outros ao **recarregar a página**.

---

## 14. Minha conta

![Minha conta: o nome de exibição e o card "IA — sua chave e modelo" (BYOK), com a escolha de provedor, o campo da chave de API e o modelo.](manual-img/11-conta.png)

Clique no **seu nome** no cabeçalho para abrir **Minha conta** (funciona **em todos os modos**: nuvem, rascunho e arquivo):
- Trocar o **nome de exibição** (usado nas codificações).
- Alterar a **senha** (só contas com e-mail; some nos modos rascunho/arquivo).
- Ver **todos os seus projetos** num lugar só, com ações diretas: abrir, renomear (admin), sair ou excluir (admin).
- Configurar a sua **chave/modelo de IA** (BYOK), incluindo o **Ollama local** (ver [seção 17](#17-codificar-e-analisar-com-ia)).
- **Sair da conta** (só no modo nuvem).

> É por Minha conta que você chega à configuração de IA em **qualquer modo**, inclusive offline, para apontar o **Ollama local**.

> Não há "esqueci minha senha": a troca de senha exige estar logado.

---

## 15. Importar e exportar

Os menus **exportar ▾** e **importar ▾** ficam no cabeçalho (aparecem quando há documentos).

### Exportar (menu "exportar ▾")
| Item | O que é |
|---|---|
| **.qualilab (projeto completo, nativo)** | Tudo (documentos, categorias, valores, códigos, codificações, memos) para reabrir no QualiLab. É o backup completo do projeto |
| **JSON (projeto)** | Projeto completo com camadas e autores |
| **CSV (trechos codificados)** | Um trecho por linha (documento, código, camada, autor) |
| **CSV (atributos por documento)** | Um documento por linha, com os valores de categoria |
| **QDPX (ATLAS.ti / MAXQDA / NVivo)** | Padrão REFI-QDA; prefere a camada final quando consolidada |
| **QDC (codebook REFI-QDA)** | Só o livro de códigos |

> As saídas de **transparência** (Relatório Interativo / W3C) ficam na aba **Relatório**, não neste menu.

### Importar (menu "importar ▾")
| Item | O que traz |
|---|---|
| **.qualilab** | Mescla um projeto exportado. Em destino **coletivo**, preserva a resposta de cada pesquisador de origem; o gabarito vira gabarito |
| **QDPX** | Projeto REFI-QDA de outras ferramentas. Tipos de categoria são **inferidos** (revise no esquema). Inclui importação reforçada de `.qdpx` do **ATLAS.ti** com PDFs |
| **.sqlite3 (Taguette)** | Projeto nativo do Taguette: documentos, tags (hierarquia por `/` ou `.`) e trechos. Sem atributos nem autor por trecho |
| **.qdc (codebook REFI-QDA)** | Só o livro de códigos |
| **planilha (.csv / .xlsx)** | **Cada linha vira um documento**, veja abaixo |

> Em projeto **coletivo na nuvem**, **importar é uma ação de administrador** (o import cria dados compartilhados e pode escrever o gabarito). Em rascunho, arquivo ou projeto individual, qualquer usuário importa.

#### Importar uma planilha (passo a passo)
1. **importar ▾ → planilha (.csv / .xlsx)** e escolha o arquivo.
2. No **modal de mapeamento**, para cada coluna escolha o papel: *Ignorar*, **Texto (conteúdo)**, **Nome do documento**, ou **Categoria · <tipo>**.
3. É obrigatório marcar **exatamente uma** coluna como **Texto**.
4. Para categorias fechadas, as opções são deduzidas dos valores observados. Confirme em **Importar**.
- Linhas sem texto na coluna de conteúdo são ignoradas (o resumo informa quantas). O `.csv` detecta o separador (`,`/`;`/tab); o Excel importa a **primeira aba**.

> Depois de importar de outra ferramenta, vale revisar o esquema de categorias (os tipos podem ter sido inferidos).

---

## 16. Salvamento, backup e modos de armazenamento

![O hub do projeto, aberto pela pílula do cabeçalho: o tipo (individual/coletivo), a gestão (renomear, limpar, excluir) e as opções de armazenamento — backup automático em pasta, salvar como arquivo .qualilab e enviar para a nuvem.](manual-img/12-projeto.png)

O QualiLab **salva sozinho** a cada ação. *Onde* ele salva depende do modo:

| Modo | Onde fica | Indicador | Quando usar |
|---|---|---|---|
| **Arquivo local** | Um `.qualilab` no disco | `arquivo ·` | Dados sensíveis, offline, sem rede |
| **Rascunho** | `localStorage` do navegador | `rascunho ·` | Só testar rápido (efêmero) |
| **Nuvem** | Supabase | `nuvem ·` | Equipes, vários dispositivos |

### Sensibilidade dos dados: o que é seguro habilitar
Antes de escolher o modo, decida **o quanto da ferramenta você pode usar** conforme a **sensibilidade do material**. Não é uma escolha neutra. Primeiro, para onde o material vai em cada caminho:

- **Arquivo / Rascunho:** ficam **no seu dispositivo** e **não saem dele**.
- **Nuvem:** vão a um **servidor de terceiros** (Supabase) para sincronizar entre pessoas e aparelhos. Saem do seu controle direto e ficam sujeitos aos termos do provedor.
- **IA de nuvem:** os trechos que você analisar vão ao **provedor de IA** que você usar, exceto o que estiver marcado como **censura**, mascarado antes do envio ([seção 17](#17-codificar-e-analisar-com-ia)).
- **Publicação:** o que você divulgar (relatório ATI / anotações W3C) fica **público**. A censura é mascarada por padrão, mas confira antes.

Use a matriz para decidir (regra **safe-by-default**: na dúvida, trate como mais sensível):

| Nível | Exemplo | Nuvem (Supabase) | IA remota (provedor) | IA local | Publicar (ATI/W3C) |
|---|---|---|---|---|---|
| **Público / sintético** | Decisões públicas, dados já abertos, exemplo sintético | OK | OK (qualquer provedor) | OK | OK |
| **Sensível trafegável** | Entrevistas sem vedação formal; dado que você prefere proteger | OK, com ciência | Preferir a **sua própria** chave (paga/institucional) e conferir o que sai e a censura | Preferível | Caso a caso, com a censura conferida |
| **Vedado** | Comitê de ética que proíbe saída, saúde identificável, segredo de justiça | **Não** | **Não**, desligue a IA para essa análise | Só se for **local de verdade** (offline + modelo na máquina) | **Não** |

> Há um limite honesto: **privacidade total e o conjunto completo de recursos não coexistem** numa ferramenta que roda no navegador. Dado vedado empurra você para o canto **offline/arquivo**, e é nesse mesmo canto que mora a **IA local** (Ollama na sua máquina). É uma restrição real, não um detalhe.

**O que a censura e a anonimização _não_ fazem.** O QualiLab **não identifica nem mascara dados pessoais no conteúdo** dos documentos (nomes, CPF, dados de saúde). Duas coisas parecem "anonimização" mas **não são**: a **censura** mascara só os trechos que **você** marcou (não varre o texto atrás do que é sensível); a opção **anonimizar** das exportações de transparência apenas **omite a autoria**. Ou seja, confiar na censura é confiar que **você** marcou, à mão, cada detalhe identificável **antes de cada envio**, e disciplina perfeita não é um controle de segurança. Anonimizar, obter consentimento e escolher o modo adequado é **responsabilidade sua**.

### Modo arquivo (Chrome/Edge)
O projeto é um arquivo `.qualilab` **visível no sistema de arquivos** (qualquer pasta, HD externo, volume criptografado). Zero rede, zero `localStorage`, 100% offline. Comece em **"Meus projetos" → Novo arquivo… / Abrir arquivo…**. O app reabre o último arquivo na sessão seguinte (com permissão do navegador).

### Modo nuvem (Supabase): o que é, e como os dados ficam protegidos (ou não)
A **nuvem** guarda o seu projeto num banco de dados online para que ele **sincronize** entre pessoas e aparelhos. Esse banco roda no **Supabase**, um serviço de infraestrutura de terceiros (banco de dados + login) muito usado por aplicativos. O QualiLab não tem servidor próprio; ele apenas conversa com um projeto Supabase.

A pergunta que mais importa é **de quem é esse Supabase**:

- **Servidor padrão do QualiLab** (o que você usa ao clicar "Entrar na nuvem" sem configurar nada): os dados vão para o **Supabase do autor**. Ele mantém o serviço no ar e, por ser dono do banco, **tecnicamente consegue** acessar o conteúdo. É prático, mas significa confiar os dados a um projeto pessoal, sem garantia institucional (releia o *Aviso legal* na [seção 0](#0-a-ideia-do-qualilab)). O autor **não quer** estar nessa posição com dado sensível, daí a recomendação no fim desta seção.
- **Seu próprio Supabase** (a pílula do projeto fica **violeta**, "nuvem pessoal"): você aponta o app para um projeto Supabase **seu** (criar um é gratuito). O banco passa a ser seu; só você e quem você autorizar têm as chaves. Continua hospedado pela empresa Supabase, mas o dono dos dados é você. Configure no hub do projeto, em **Conexão (Supabase)** ("Conectar ao meu Supabase").

**O que protege os seus dados na nuvem:**
- **Login** (e-mail e senha, via Supabase Auth): só quem tem conta entra.
- **Isolamento entre usuários** (a chamada *Row Level Security*): as regras do banco garantem que cada pessoa só enxerga os **projetos de que é membro**. Um colega não vê os seus outros projetos, e quem não foi convidado não vê nada.
- **Trânsito criptografado** (HTTPS) e **criptografia em repouso** no disco do Supabase, o padrão de qualquer serviço de nuvem sério.

**O que a nuvem NÃO faz:**
- **Não é criptografia ponta a ponta.** Os dados ficam **legíveis** para quem administra o banco: no servidor padrão, isso inclui o **autor**; no seu Supabase, inclui **você**; e, nos dois casos, a empresa **Supabase** como hospedeira. O isolamento acima protege você dos *outros usuários*, não do *dono do banco*.
- **Não há recuperação de senha** por e-mail (a troca exige estar logado).

Vale, então, a mesma lógica de confiança da [seção 17.5](#175-para-onde-vão-os-seus-dados-provedores-e-configuração): a nuvem é ótima para colaborar e sincronizar, mas usá-la é **confiar o conteúdo a quem administra o banco**. Para dado **sensível**, prefira o **seu próprio Supabase**, o **modo arquivo** ou o **rascunho local**, onde o conteúdo não passa pelo servidor de outra pessoa.

### Backup automático em pasta (modo rascunho, Chrome/Edge)
Mantém um `backup-automatico.qualilab` sempre atualizado numa pasta sua, como espelho do `localStorage`. Ative em **pílula do projeto → Backup automático em pasta → Escolher pasta…**.

### Salvar/baixar manualmente
**exportar ▾ → .qualilab (projeto completo, nativo)** baixa o projeto inteiro a qualquer momento, em qualquer modo. Bom para versões e backups manuais. (O mesmo arquivo é oferecido pelo atalho da faixa de erro, quando o salvamento automático falha.)

### Quando o salvamento falha
Se o navegador não conseguir gravar (`localStorage` cheio, permissão de pasta revogada, disco removido), aparece uma **faixa vermelha persistente** avisando que as últimas alterações **não** foram salvas, com um atalho para **baixar .qualilab** na hora. Ela só some quando um salvamento volta a funcionar. **Não ignore esse aviso**: baixe o backup antes de continuar.

### Modo nuvem offline
O cabeçalho mostra `offline` (âmbar) quando a conexão cai. Escritas (codificar, preencher categoria) exigem rede; sem ela, a ação em andamento falha (mas os dados já salvos não são corrompidos). Por isso, **não conte com o modo nuvem sem conexão**: enquanto aparecer `offline`, evite codificar e volte a trabalhar ao reconectar, ou baixe um `.qualilab` como segurança.

---

## 17. Codificar e Analisar com IA

> As telas de IA são **opt-in** e ficam no cabeçalho (numa build sem IA, `AI_ENABLED=false`, elas são ocultadas). Os princípios da [seção 0](#0-a-ideia-do-qualilab) valem aqui como **regras**: opt-in, transparência, e a IA nunca decide por você.

A IA do QualiLab não "codifica sozinha" nem escreve no seu projeto sem permissão. Ela aparece em duas telas: *Codificar com IA* (assistentes que **propõem** mudanças ao seu projeto, você revisa item a item) e *Analisar com IA* (leitura e interpretação do material). Em todas, o resultado é uma **proposta** ou um **texto** que você revisa. Aplicar qualquer mudança é sempre um ato seu.

### 17.1 Como a IA funciona aqui

- **Onde a chamada vai.** Para os provedores na nuvem (Gemini/OpenAI/Anthropic/Azure/Personalizado), as telas de IA conversam com o **provedor de modelo** (LLM) através de uma função no servidor (Supabase Edge Function `ai-ask`); o navegador não fala direto com o provedor. **Exceção: o Ollama local**, em que o **navegador chama o modelo na sua máquina direto**, sem passar pelo servidor. Para onde **cada provedor** manda o dado, e o que isso implica para material sensível, veja [17.5](#175-para-onde-vão-os-seus-dados-provedores-e-configuração).
- **De quem é a chave (BYOK).** O padrão é **você trazer a sua própria chave** e modelo, configurados em **Minha conta** (veja 17.4). Eles viajam só na requisição até a função do servidor, **não ficam guardados lá**, só neste navegador. (Uma instância que hospede a própria pode, opcionalmente, configurar uma chave de servidor; a versão pública não tem.)
- **Ver e configurar o prompt (⚙).** Toda tela de IA tem, no topo, o botão **⚙ Configurar Prompt**. Ele abre a **prévia exata** do que será enviado, seção por seção (papel, memo, memória, material, regras, tarefa), com o modelo ativo, as contagens, a **estimativa de tokens** e um botão **copiar prompt**. No mesmo painel você ajusta o que a IA recebe: nas telas de *Codificar*, as **instruções próprias à IA**, os **memos injetados** e a **memória do projeto**; em *Analisar*, isso **e** a **postura** metodológica (veja [17.3](#173-analisar-com-ia-leitura-assistida-do-material)). **Nada sai do navegador sem passar por aqui**. É a face concreta da regra de transparência.
- **Provedores suportados** (com chave própria): **Gemini**, **OpenAI**, **Anthropic**, **Azure OpenAI**, **Personalizado** (qualquer API compatível com o formato OpenAI `/chat/completions`: DeepSeek, Mistral, Qwen hospedado, ou um servidor próprio Ollama/vLLM exposto numa URL pública) e **Ollama local** (modelo na sua própria máquina, chamado **direto pelo navegador**, sem passar pelo servidor, veja [17.5](#175-para-onde-vão-os-seus-dados-provedores-e-configuração)).
- **Censura sempre antes do envio.** Trechos de códigos marcados como **censura** ([5.5](#55-censura-mascarar-trechos-sensíveis)) são substituídos por `[trecho censurado]` **antes** de o material sair do navegador. Em *Analisar com IA*, você pode optar por incluir um código de censura específico naquela análise (opt-in explícito, por código).
- **Ajuste das respostas.** A IA vem calibrada para respostas focadas e consistentes (não "criativas"), adequadas à análise. Você não precisa configurar nada.
- **Limites de tamanho.** Há um teto por envio: cerca de **30.000 caracteres (~10 páginas) por documento** e **100.000 no total (~33 páginas)** — cabe uma seleção generosa (algumas entrevistas, ou os trechos de um código inteiro), mas não o corpus todo de uma vez. Seleções maiores são **cortadas para caber** (a lista de códigos fica sempre inteira; a amostra de trechos é reduzida primeiro); a prévia do **⚙ Configurar Prompt** mostra o tamanho em páginas e avisa quando vai truncar. Para uma análise completa, selecione menos material de cada vez.
- **Estimativa de custo.** Com a **sua própria** chave paga, cada resposta no *Analisar com IA* traz um **custo estimado** (em R$, com o total acumulado da conversa), e o **⚙ Configurar Prompt** mostra a estimativa de tokens do envio. É uma **estimativa de teto** (não desconta cache); o câmbio e, para provedores sem tabela de preços, a sua tarifa se ajustam em **Minha conta**. Com o **Ollama local** o custo é zero.

> ⚠️ **A IA pode errar e inventar.** Trate toda saída como hipótese a conferir contra o trecho citado. É exatamente por isso que a regra é "a IA propõe, você decide".

### 17.2 Codificar com IA: três assistentes em abas

![Codificar com IA: os três assistentes em abas (Sugerir Codificação, Sugerir Categorização, Organizar Códigos). À esquerda, a seleção de documentos e códigos; no topo, o botão "Configurar Prompt" com a estimativa de tokens.](manual-img/09-ia-codificar.png)

A tela **Codificar com IA** reúne **três assistentes** em abas, no topo: **Sugerir Codificação** (que abre por padrão), **Sugerir Categorização** e **Organizar Códigos**. Os três seguem o mesmo padrão: a IA **propõe**, você **aprova ou recusa item a item**, e **nada é gravado sem a sua confirmação**. O **Memo para a IA** e a memória do projeto entram como contexto ([seção 11](#11-memos)), a censura é mascarada, e o botão **⚙ Configurar Prompt** mostra o prompt inteiro e deixa ajustar as *instruções próprias à IA*, os *memos injetados* e a *memória do projeto* (veja [17.1](#171-como-a-ia-funciona-aqui)). Se a resposta for muito longa e vier cortada, o QualiLab aproveita os itens completos e descarta só o último (incompleto).

O botão **⚙ Configurar Prompt** (no topo de cada assistente) abre a janela abaixo. Em cima ficam os **controles**: **Instruções próprias à IA** (guias que entram em todo prompt, compartilhadas com o Analisar com IA), **Memos injetados** (por padrão o *Memo para a IA*; dá para incluir outros) e a **Memória do projeto** (liga/desliga quais insights entram no contexto). Embaixo, a **prévia exata do que será enviado** — o modelo ativo, a contagem de material (em **páginas**), **quantos códigos de censura foram mascarados**, a **estimativa de tokens** (avisando quando o material será truncado) e o prompt **seção por seção** (papel e princípios, memos, memória do projeto, material). Um botão **copiar prompt** leva tudo para a área de transferência. **Nada sai do navegador sem passar por aqui** — é a face concreta da regra de transparência.

![Configurar Prompt, aberto na tela Codificar com IA: em cima, os controles (instruções próprias à IA, memos injetados e a memória do projeto, agora dentro do modal); embaixo, a prévia do que será enviado — modelo, material em páginas, censura mascarada e estimativa de tokens — e o prompt seção por seção, com "Papel e princípios" mostrando as regras invioláveis da IA (a IA propõe, não inventa, cita a fonte).](manual-img/15-ia-configurar-prompt.png)

#### 17.2.1 Sugerir Codificação: a segunda codificadora

*(A aba que abre por padrão.)* A IA atua como uma **segunda codificadora**: lê os documentos e aponta **trechos que se encaixam em códigos existentes mas escaparam** da sua primeira leitura. Ela **não cria códigos novos**. Selecione os **documentos** e os **códigos** que ela pode usar.

Para cada trecho proposto, a IA **copia o trecho do texto**, e o QualiLab o **localiza no documento** (vira um grifo de verdade). Cada item mostra o trecho, o código e um selo **"novo"** (ou **"≈ localização aproximada"** quando o casamento não é exato). Trechos que já estão codificados com aquele código **não** são repropostos (a IA vê a codificação existente); trechos que não puderam ser localizados no texto são descartados e contados. Censura nunca é codificada. Ao aprovar e aplicar, cada trecho vira uma **codificação** na sua camada. Confira no leitor da aba Codificação.

#### 17.2.2 Sugerir Categorização: preencher categorias já existentes

A IA **não cria categorias**: ela ajuda a **preencher o valor** das categorias que você já definiu (no Esquema), documento por documento. Selecione à esquerda quais **documentos** e quais **categorias** entram; a IA lê o texto e, para tipos de opção fechada, sugere **exatamente uma das opções** válidas.

O detalhe importante: a IA recebe o que **já está preenchido** e só devolve **diferenças** ou **campos vazios**: se concorda com o valor atual, não propõe nada. Cada sugestão mostra um selo: **"já aplicada"** (com o valor atual → o sugerido) ou **"vazia"** (preenchimento novo). Aprove as que quiser e aplique: os valores entram na sua camada de respostas (ou no gabarito, em projeto individual), como se você os tivesse digitado na aba Codificação.

#### 17.2.3 Organizar Códigos: arrumar o livro de códigos

Ajuda quem terminou uma codificação aberta com **dezenas ou centenas de códigos soltos** a arrumar o esquema, no espírito da *grounded theory* (a teoria que se constrói a partir dos próprios dados). A IA lê a **lista completa de códigos** (com hierarquia e contagem de trechos) e, opcionalmente, uma **amostra de até 3 trechos por código**, e propõe **operações**, cada uma com sua justificativa:

| Operação | O que faz |
|---|---|
| **Mesclar** | Funde códigos redundantes num só |
| **Agrupar** | Reúne códigos sob uma família (existente ou nova) |
| **Mover** (reparent) | Muda um código de pai |
| **Renomear** | Sugere um nome melhor |
| **Promover** | Eleva um subcódigo a Hierarquia 0 |

As operações aparecem **dentro da resposta da IA** (no chat), cada uma com aprovar/recusar; aplique as aprovadas para mudar o esquema. Refine pedindo ajustes num follow-up. Códigos de **censura** ficam de fora desta reorganização (não são categoria analítica).

### 17.3 Analisar com IA: leitura assistida do material

![Analisar com IA: no topo, o seletor de Material e o botão "Configurar Prompt"; à esquerda, a seleção do material; à direita, a Tarefa (texto livre, com a biblioteca de prompts) e a conversa.](manual-img/10-ia-analisar.png)

Ajuda a **interpretar** o material, sempre **citando as fontes**, numa **conversa** iterativa. Você escolhe o **escopo** (que material entra) e descreve uma **tarefa** (a pergunta ou o pedido de análise). As conversas úteis podem ser **salvas**: passam a aparecer na aba **Memos**, em "Conversas salvas".

A tela é um **chat**. Na **barra do topo** ficam o botão **⚙ Configurar Prompt** (à esquerda, veja abaixo) e o seletor de **Material** (o escopo). À **esquerda** você seleciona o material (documentos em lista, ou uma **árvore de códigos** com cores e contagem) e marca/desmarca a censura. À **direita** ficam a **Tarefa** (no cabeçalho, recolhível), a **conversa** e a **caixa de mensagem fixa embaixo**. As respostas saem formatadas (títulos, listas) e, enquanto a IA pensa, aparece um indicador animado. *(Na primeira vez, um aviso convida a abrir o "Configurar Prompt" antes de analisar.)*

**A Tarefa (o que você quer que a IA faça).** O campo da tarefa é **texto livre**, e é aqui que mora o essencial: **os melhores resultados vêm da tarefa que _você_ escreve**, com as suas palavras e a sua pergunta de pesquisa. Não há uma tarefa "certa" pré-pronta — a análise é sua, e a IA responde ao que você pedir.

Para não partir do zero (ou para se inspirar), o botão **biblioteca de prompts ▾** oferece duas coisas: **prompts de exemplo** do QualiLab e os **prompts que você mesmo salvou**. Qualquer item se **insere** no campo como um **ponto de partida editável** — ajuste-o antes de enviar. Quando montar um pedido que funcione bem, clique em **✦ salvar** para guardá-lo (ele passa a aparecer aqui e na aba **Memos → "Prompts salvos"**, onde dá para renomear ou apagar): assim você vai construindo a **sua própria biblioteca**, que é o objetivo. Os **prompts de exemplo** (só um ponto de partida, não um menu fechado) variam conforme o escopo:

- **Documentos** (texto integral dos documentos escolhidos): *Temas emergentes* · *Síntese analítica* · *O inesperado* · *Diferenças entre casos*.
- **Trechos + Código** (os trechos de cada código, tratado como categoria analítica): *O que há no código* · *Coerência & saturação* · *Código vs. definição* · *Diferenças entre casos*.
- **Documentos + Trechos + Código** (a codificação lida em contexto, uma "segunda leitura"): *O que escapou* · *Validação em contexto* · *Trecho em contexto* · *Síntese contextualizada*.

**Configurar o prompt (⚙).** O botão **⚙ Configurar Prompt** (no topo) abre o painel onde você ajusta a **voz** da IA e confere **exatamente** o que será enviado:

![Configurar Prompt na tela Analisar com IA: no alto, a Postura (Papel e princípios) com os botões Padrão, Indutivo, Dedutivo, Abdutivo e Personalizado; abaixo, as instruções próprias à IA, os memos injetados, a memória do projeto e o toggle de categorias, e a prévia seção por seção do que será enviado.](manual-img/16-ia-analisar-prompt.png)

- **Postura** (Papel e princípios): a **lente metodológica** da análise, num único clique. *Padrão* (sem privilegiar uma abordagem), *Indutivo* (constrói categorias a partir do próprio material), *Dedutivo* (avalia o material à luz do esquema de códigos já existente), *Abdutivo* (busca a explicação que melhor dê conta dos dados, inclusive do inesperado) ou *Personalizado* (abre um campo para você descrever a postura com as suas palavras). O texto de cada postura aparece logo abaixo dos botões, e entra no prompt como parte do papel da IA.
- **Instruções próprias à IA**: guias que entram em **todo** prompt (ex.: "priorize a linguagem dos entrevistados"). *(Compartilhadas com o Codificar com IA.)*
- **Memos injetados**: quais memos a IA recebe: por padrão, o **Memo para a IA** ([seção 11](#11-memos)); você pode incluir outros (de projeto, documento, código ou trecho).
- **Memória do projeto**: liga/desliga quais entradas do **diário de insights** ([seção 11](#11-memos)) entram no contexto desta análise.
- **Categorias como metadados**: opcionalmente, anexa a cada documento as suas categorias preenchidas (atributos do caso), para a IA situar cada fala. Desligado por padrão.
- **Prévia e proveniência**: abaixo dos controles, o prompt aparece **seção por seção**, com o **modelo** ativo, as contagens (material em **páginas**) e a **estimativa de tokens** (com aviso se o material for truncado), e um botão **copiar prompt**.

**Passo a passo:**
1. Abra a aba **Analisar com IA**.
2. No topo, escolha o **escopo** e, à esquerda, **selecione o material** (há um filtro por categoria, colapsável, para marcar vários documentos de uma vez; os códigos aparecem em árvore).
3. Escreva a **Tarefa** (à direita), do zero, ou partindo de uma sugestão da **biblioteca de prompts**. Se quiser, abra o **⚙ Configurar Prompt** para definir a postura e conferir a prévia.
4. Clique em **Iniciar Análise**; depois **refine por follow-up** quantas vezes quiser, pela caixa de mensagem embaixo. "Analisar de novo" recomeça com a seleção atual; "Limpar conversa" zera.
5. **Salve** as conversas que valerem (botão *Salvar Conversa (Memos)*). Elas passam a aparecer na aba **Memos → Conversas salvas**, onde abrem por inteiro.

A IA recebe, junto, o **memo de cada código** e — se você ligar o toggle *Categorias como metadados* no Configurar Prompt — as **categorias preenchidas** de cada documento, para ancorar cada observação na sua **fonte** (documento, autor, camada), coerente com a ideia, lá da [seção 0](#0-a-ideia-do-qualilab), de manter a evidência ao lado da interpretação.

> **Botão "Sugerir memórias".** Ao fim de uma conversa, ele pede à IA que proponha entradas curtas para a **Memória do projeto** ([seção 11](#11-memos)): fatos ou decisões que valem lembrar entre sessões. Você aprova, edita ou recusa cada uma antes de gravar.

### 17.4 Configurar a sua chave (opcional)

Em **Minha conta → IA (sua chave e modelo)**:
1. Escolha o **provedor**.
2. Para *Azure*, *Personalizado* ou *Ollama local*, informe a **URL base** (no Ollama ela já vem preenchida com `http://localhost:11434/v1`).
3. Cole a **sua chave de API** (obrigatória, o app usa a **sua** chave; o Ollama local normalmente dispensa chave).
4. Escolha o **modelo** (ou o nome do *deployment*, no Azure; no Ollama, digite o nome do modelo baixado, ex.: `qwen2.5:14b`). Em geral, modelos maiores são mais capazes, porém mais lentos e caros.
5. **salvar**, ou **limpar** para remover a sua chave.

O mesmo card traz ainda o **câmbio US$→R$** e, para provedores sem tabela de preços (*Personalizado*/*Azure*), a **sua tarifa** por milhão de tokens — usados na estimativa de custo ([17.1](#171-como-a-ia-funciona-aqui)).

> A sua chave fica **só neste navegador** (não é gravada no servidor); ela só acompanha cada requisição até a função que chama o provedor.

### 17.5 Para onde vão os seus dados: provedores e configuração

Toda chamada de IA na nuvem passa por uma função no servidor (Supabase `ai-ask`) e de lá segue ao **provedor que você escolheu** (Gemini, OpenAI, Anthropic, Azure ou Personalizado), **inclusive quando você traz a sua própria chave** (a chave só acompanha a requisição; não fica guardada no servidor). Todos seguem a **mesma lógica**: o QualiLab envia o material, o provedor processa e devolve. A única exceção é o **Ollama local**, em que o navegador fala **direto** com o modelo na sua máquina e **nada** vai ao servidor nem à internet.

**Retenção e treino: confie no provedor, não na cláusula.** Você não tem como auditar o que um provedor faz com o seu material; depende de acreditar na política dele, que muda com o tempo e vive de tecnicalidades ("não treinamos, mas retemos por segurança"). Por isso a regra mais honesta não é decorar quem treina:

> **Regra de bolso:** *se você não submeteria este dado num chat com o ChatGPT / Gemini / Claude, mesmo com o "usar meus dados" desligado, não o submeta pela API.* Mandar pela API muda os detalhes da política, não o fato de que o dado sai para um terceiro em quem você precisa **confiar**.

Quando a resposta for "não confio", não troque por outra promessa. Troque por algo que **não dependa de confiança**: **retenção zero contratual** (institucional, com recurso legal de verdade) ou **local** (Ollama, em que o dado não sai da máquina).

Para constar, o que as políticas *dizem* hoje (e pode mudar): camadas **gratuitas e de consumidor** (inclusive a **chave grátis do Google AI Studio**) costumam **treinar** com o seu conteúdo, e o próprio Google avisa "não envie informações sensíveis"; as **APIs da OpenAI e da Anthropic** dizem **não** treinar por padrão, mas **retêm** por dias. Serve para escolher entre opções de baixo risco, não para confiar dado sensível a uma promessa.

**Ollama local, na prática.** Como o navegador chama o `localhost` direto (sem passar pelo servidor), duas regras de segurança do navegador entram em jogo: é preciso **autorizar a origem do app** ao iniciar o Ollama (com `OLLAMA_ORIGINS`) e, se o app estiver em **HTTPS**, alguns navegadores bloqueiam a chamada a `http://localhost`. O caminho mais confiável é **rodar o app localmente** (o `index.html` baixado, ou `python -m http.server 8000`). Aí não há conflito. Os detalhes técnicos estão no [README](README.md).

> **Para dado vedado**, a única combinação que mantém tudo na sua máquina é o **Ollama local com o app rodando localmente**, offline. Modelos locais pequenos são menos precisos, mas nas tarefas que exigem um formato estrito o QualiLab já ativa um modo que força a saída correta.

---

## 18. Solução de problemas

**O app não carrega / tela em branco ao abrir o arquivo baixado.**
Ele precisa de internet na **primeira vez** (para baixar as bibliotecas). Se a política do navegador bloquear o `file://`, sirva por um servidor local: `python -m http.server 8000` na pasta do `index.html`.

**Não vejo "Novo arquivo…" nem o backup em pasta.**
Esses recursos usam a File System Access API, que só existe em **Chrome/Edge**. No Firefox/Safari, use o modo nuvem ou rascunho.

**Faixa vermelha "as últimas alterações NÃO foram salvas".**
O armazenamento encheu ou ficou indisponível. Clique em **baixar .qualilab** imediatamente; depois libere espaço (modo rascunho tem limite de ~5–10 MB) ou migre para o modo **arquivo**/**nuvem**.

**Um colega não vê meus códigos / categorias novas.**
Esquema de categorias e árvore de códigos não sincronizam ao vivo, peça para **recarregar a página**. (Codificações e respostas de categoria, sim, sincronizam.)

**Importei um `.qdpx` e as categorias vieram com o tipo errado.**
Os tipos são inferidos quando o arquivo vem de outra ferramenta. Ajuste em **Esquema → Categorias** (ou "Gerenciar esquema").

**Importei um `.qdpx` e as respostas de categoria estão todas no meu nome.**
Limitação do formato REFI-QDA, que não guarda autoria de atributos (só de trechos). Para preservar autoria por pesquisador, use o `.qualilab` nativo.

**Apaguei um código/categoria/documento sem querer.**
Não há desfazer para isso (Ctrl+Z só cobre a última *codificação de trecho*). Recupere de um backup `.qualilab`, se tiver.

**Esqueci minha senha.**
Não há recuperação por e-mail. Sem acesso, será preciso criar outra conta.

**O PDF importou com o texto bagunçado.**
PDFs muito visuais (colunas, tabelas, digitalizações) podem extrair mal. Tabelas não são reconstruídas. Quando possível, prefira `.docx`/`.txt`, ou cole o texto limpo.

---

## 19. Atalhos de teclado

| Atalho | Onde | Ação |
|---|---|---|
| **Botão direito** sobre uma seleção | Codificação | Menu para aplicar/criar código |
| **Botão direito** sobre um grifo | Codificação | Remover código / Anotar trecho |
| **Ctrl+Z** | Codificação | Desfazer a última codificação aplicada |
| **Enter** / **Shift+Enter** | Busca (🔎) | Próxima / anterior ocorrência |
| **Enter** / **Esc** | Renomear documento | Confirmar / cancelar |

---

## 20. Glossário

- **Código**: rótulo aplicado a um trecho; hierárquico (família → subcódigos).
- **Categoria / atributo**: propriedade do documento inteiro (cinco tipos de campo).
- **Codificação**: uma aplicação de um código a um trecho específico (com autor e camada).
- **Camada**: *individual* (de cada pesquisador) ou *final* (gabarito consolidado).
- **Gabarito**: a camada final consolidada da equipe.
- **Reconciliação**: tela onde a equipe consolida o gabarito (projeto coletivo).
- **Memo**: nota analítica por projeto/documento/código/trecho.
- **Censura**: código que mascara trechos sensíveis nas exportações.
- **Co-ocorrência**: dois códigos aplicados ao mesmo trecho (ou sobrepostos).
- **Modo (armazenamento)**: onde os dados ficam: arquivo, rascunho ou nuvem.
- **Tipo de projeto**: individual (sem reconciliação) ou coletivo.
- **Papel**: admin (define esquema/gabarito/membros) ou membro.
- **REFI-QDA / QDPX / QDC**: padrão aberto de intercâmbio entre ferramentas de QDA.
- **ATI**: *Annotation for Transparent Inquiry*, método de transparência do QDR.
- **W3C Web Annotation**: padrão aberto de dados de anotação (base do ATI, hypothes.is etc.).
- **Opt-in**: recurso desligado por padrão que só age quando você o aciona (a regra da IA no QualiLab).
- **BYO-key** (*bring your own key*): usar a sua própria chave de API de um provedor de IA (o padrão no QualiLab; guardada só no seu navegador).
- **Provedor / LLM**: o serviço de modelo de linguagem que a IA chama (Gemini, OpenAI, Anthropic, Azure, um compatível com OpenAI, ou o **Ollama local** na sua própria máquina).
- **Ollama local**: modelo de linguagem rodando na sua máquina (via [Ollama](https://ollama.com/)), chamado **direto pelo navegador**, sem passar pelo servidor, a opção em que o material **não sai do seu computador**.

---

<p align="center"><sub>QualiLab, o seu laboratório de pesquisa qualitativa. Desenvolvido por Luiz Pimenta Filho (LabDados / FGV Direito SP). Licença MIT.</sub></p>
