# Changelog

Mudanças relevantes para quem **usa** o QualiLab. O histórico completo (incluindo refatorações
e decisões internas) está nos commits e no `CLAUDE.md`.

A versão aparece no canto direito do cabeçalho e no rodapé da tela de entrada. **Cite esse
número ao relatar um problema**: sem ele não há como saber qual build o seu navegador carregou.

> **Este arquivo é próprio deste repositório desde ago/2026** e descreve só o aplicativo
> publicado aqui. O QualiLab dentro do assistente (extensão do Claude Desktop, plugin) tem
> numeração e changelog próprios, no repositório `QualiLab-plugin` — as ferramentas de
> leitura por agente não fazem parte deste app.
>
> Ao publicar uma versão: suba o `QUALILAB_VERSION`, acrescente a seção aqui **antes** de
> gerar (o `gen-estavel.sh` recusa publicar uma versão sem seção) e regenere.

## 1.4.13 (05/08/2026)

### Trecho codificado por várias pessoas deixa de ir repetido para a IA

Em pesquisa coletiva, é normal que o mesmo trecho seja marcado com o mesmo código por dois ou três
codificadores — e mais uma vez pelo gabarito, quando a equipe reconcilia. Isso são várias
codificações, mas **um pedaço de texto só**.

Na tela **Sugerir Codificação**, a lista de "trechos já codificados" que ia no prompt repetia a
mesma citação uma vez por codificador. Num projeto de três pessoas, essa parte do material saía
com o triplo do tamanho, sem acrescentar nada: você pagava por texto repetido e gastava com ele a
capacidade do modelo.

Agora cada pedaço de texto aparece **uma vez**. Dois códigos diferentes no mesmo trecho continuam
sendo duas entradas (são duas decisões de análise), e dois trechos com o mesmo texto em posições
diferentes continuam separados (são duas ocorrências).

A tela **Analisar com IA** e a amostra do **Organizar Códigos** já faziam isso; o que muda é que
agora as três telas — e a lista de trechos da **Leitura** — usam exatamente a mesma regra.

## 1.4.12 (05/08/2026)

### As telas de IA aceitam muito mais material

Até agora, cada documento entrava na análise por no máximo **dez páginas**, e o total de tudo que
você selecionasse não passava de **trinta e três**. O que excedia era cortado, com aviso na tela —
mas cortado.

Dois problemas nisso. O primeiro é o tamanho: um acórdão de sessenta páginas entrava pela sexta
parte. O segundo é pior, e era invisível: **o corte pega o começo do documento**, e num acórdão o
começo é o relatório, quem pediu o quê. A parte que decide fica no fim. Ou seja, o corte jogava
fora justamente o pedaço que responde à maior parte das perguntas, e errava sempre para o mesmo
lado.

Agora cada documento pode entrar com até **cerca de 130 páginas**, e o total chega a **200**. Um
documento longo cabe inteiro; uma seleção de vários cabe sem picotar.

Vale nas quatro telas de IA: Analisar com IA, Sugerir Codificação, Sugerir Categorização e
Organizar Códigos.

### O que isso custa

Material maior custa mais, e quem paga é você (a chave é sua). A estimativa continua aparecendo
**antes** de enviar, no ⚙ Configurar Prompt — vale olhar antes de mandar duzentas páginas. Os
avisos de corte continuam lá para quando o novo limite for atingido.

Um aviso honesto: cada modelo tem uma capacidade máxima própria, menor nos modelos locais
(Ollama) e nos mais antigos. Se você mandar material demais para um modelo pequeno, o erro virá
do provedor, não do QualiLab. Em caso de dúvida, selecione menos documentos.

## 1.4.11 (04/08/2026)

### Colunas da planilha podem virar o memo do documento

Planilha de pesquisa quase sempre tem uma coluna que não é dado nem atributo: "Observações",
"Parecer", "Resumo do caso" — o que **você** anotou sobre aquela linha. Até agora ela só podia
virar categoria, e texto longo em campo de categoria fica ilegível.

No modal de mapeamento há um papel novo: **Memo do documento**. Marque **uma ou várias** colunas.
Com várias, o memo é **costurado**: um bloco por coluna, na ordem em que elas aparecem na
planilha, separados por linha em branco — do mesmo jeito que a importação do Zotero monta o memo
com a referência, o resumo e as notas.

Cada bloco é identificado pelo **título da coluna** (numa planilha, o cabeçalho é a única coisa
que diz o que aquele texto é). Dá para desligar isso numa caixa de seleção, e o modal mostra uma
**prévia** do memo que vai sair, montada com a primeira linha preenchida — a costura fica visível
antes de importar, não depois.

Célula vazia não vira bloco vazio nem título órfão, e linha sem nenhuma das colunas preenchida
simplesmente não ganha memo. O resumo do import diz quantos memos entraram.

O memo cai na aba **Memos**, em **Documentos**, e é editável como qualquer outro.

## 1.4.10 (04/08/2026)

### Importar uma coleção do Zotero

Quem organiza a bibliografia no Zotero levava o corpus para o QualiLab um PDF de cada vez, e
redigitava autor, ano e periódico como categoria. Agora a coleção inteira entra de uma vez.

No Zotero: clique com o botão direito na coleção → **Exportar coleção…** → formato **Zotero RDF**,
com **Exportar arquivos** marcado. Ele cria uma pasta. No QualiLab, em **importar ▾ → pasta do
Zotero**, escolha essa pasta.

Cada referência com PDF anexado vira um **documento**, com o texto extraído do PDF do mesmo jeito
que no `＋ enviar`: "ver original", o número da página nos trechos e o OCR de páginas escaneadas
funcionam normalmente.

Você escolhe quais metadados viram **categorias** (autor, ano, periódico, idioma, tipo). A
**referência completa, o resumo e as notas** que você escreveu no Zotero vão para o **memo do
documento**, não para uma categoria: são texto seu *sobre* a fonte, e resumo em campo de categoria
fica ilegível.

O **ano** vira uma categoria de **Data**, então a aba **Tempo** dos Gráficos passa a funcionar.
Quando a data da referência é ambígua (`11/13/2014` pode ser 13 de novembro ou 11 de dezembro), o
QualiLab guarda **só o ano** em vez de chutar o dia.

O que fica de fora é dito pelo nome, antes e depois de importar: referência sem PDF, snapshot de
página web e notas avulsas sem referência. **Não vêm códigos nem trechos codificados** — uma
biblioteca de referências não tem isso, e as marcações feitas no leitor de PDF do Zotero não saem
na exportação dele.

## 1.4.9 (03/08/2026)

### Melhorias internas de produção do código do app

Nada muda na tela. Esta versão marca uma mudança na forma como o QualiLab é produzido: o
aplicativo publicado aqui passou a ser gerado e numerado de forma independente das ferramentas
que rodam dentro de assistentes de IA. Na prática, o que você usa fica mais previsível — cada
versão publicada aqui traz só o que diz respeito a este aplicativo.

## 1.4.8 (03/08/2026)

### O nome do documento não escorre mais por cima dos botões

Na tela **Codificação**, com a janela estreita (ou o painel da direita bem largo), o nome de um
documento longo passava por cima do "＋ enviar" e do "pesquisar": as letras ficavam sobrepostas
aos botões e a barra virava um borrão. Agora o nome é cortado com "…" quando não cabe, e os
botões continuam legíveis e clicáveis. O nome completo segue no tooltip e na lista que abre ao
clicar nele.

## 1.4.7 (01/08/2026)

### A nuvem cair não faz mais você perder trabalho

Antes, se o servidor não respondesse na hora de salvar, o QualiLab mostrava um aviso vermelho e a
alteração simplesmente não acontecia: cabia a você perceber, lembrar o que estava fazendo e refazer.
Numa conversa longa da tela **Analisar com IA**, isso custava a análise inteira.

Agora, quando a nuvem falha por um motivo passageiro (conexão caiu, servidor fora do ar, tempo
esgotado), a alteração **fica guardada neste navegador e continua aparecendo na tela**. Ela sobe
sozinha assim que a nuvem responder, e o cabeçalho mostra quantas estão aguardando — clique ali
para tentar na hora. Você pode continuar trabalhando normalmente enquanto isso, e **fechar a aba
não perde a fila**: ela volta quando você reabrir o projeto.

Vale para o trabalho do dia a dia: codificações, respostas de categoria, notas (memos), conversas
salvas da IA e o diário de memórias. Mudanças estruturais — criar ou excluir documento, mexer no
esquema de códigos, gestão do projeto e importações — continuam avisando na hora se falharem: numa
pesquisa coletiva, reaplicar esse tipo de mudança minutos depois produziria um estado que ninguém
pediu.

Se a nuvem **recusar** uma alteração de vez (por exemplo, o seu papel no projeto mudou, ou outra
pessoa excluiu o que você estava anotando), ela não some calada: aparece um aviso dizendo o que foi
recusado, com atalho para baixar um `.qualilab` antes de refazer.

Por consequência, o indicador `offline` do cabeçalho parou de dizer "alterações não estão sendo
salvas" — não é mais verdade.

## 1.4.6 (01/08/2026)

### A aba "Visualização" agora se chama "Leitura"

"Visualização" é o nome que a área costuma dar a gráfico, e gráfico é o que a aba ao lado faz. Com
o modo Documentos (abaixo), esta virou de fato a tela de **reler o que já foi codificado** — no
material ou no esquema. Nada mudou de lugar além do nome.

### Navegador de documentos

Até aqui, a única porta para o corpus era a lista suspensa no alto do leitor: todos os documentos,
na ordem em que foram importados, sem busca. Num `.qdpx` essa ordem é a das entradas dentro do
pacote — na prática, aleatória. Com 200 documentos, achar um era rolar a lista até dar sorte.

No lugar dela, um **navegador de documentos**, que aparece em dois lugares.

**No leitor (aba Codificação)**, o nome do documento virou um botão que abre a lista com:

- **filtro por nome**, ignorando acento e maiúscula;
- **ordenação** por nome (agora o padrão) ou pela ordem de importação;
- **agrupamento** por uma categoria — o efeito de "pastas", usando o metadado que você já
  preencheu, sem inventar estrutura nova;
- o **⚠︎** dos documentos com extração provavelmente ruim, com o motivo no repouso do mouse;
- teclado: **↑ ↓** percorrem, **Enter** abre, **Esc** fecha.

A escolha de ordenar e agrupar fica guardada no navegador e vale para os próximos projetos.

### A Visualização agora tem dois modos de leitura

A tela ganhou sub-abas, como os Gráficos: **▤ Documentos** e **✎ Trechos**.

**Trechos** é a Visualização de sempre: escolha um código e leia os trechos dele em todo o projeto.

**Documentos** é nova, e é o que faltava: o **documento inteiro**, com os grifos no contexto em que
foram feitos — a mesma leitura que o Relatório Interativo entrega ao avaliador, agora disponível
enquanto você trabalha. Passando o mouse num grifo você vê o código e quem o aplicou; clicando,
abre uma faixa com o caminho do código, a camada e a nota analítica, e um atalho para o trecho na
Codificação. A caixa **grifos** desliga todos de uma vez, quando você quer ler o texto limpo.

À esquerda, no mesmo lugar em que as outras telas põem a navegação, fica a lista do corpus, com o
mesmo filtrar/ordenar/agrupar do leitor mais o **número de trechos** de cada documento — o que a
torna também um mapa do que ainda não foi codificado. Agrupada por uma categoria, ela é o primeiro
esboço de **pastas**.

### Corrigido: a contagem de trechos não batia com o que a tela mostrava

Em pesquisa coletiva, um trecho consolidado costuma ter três marcas: a de cada codificador e a do
gabarito. O cabeçalho dizia **"6 trechos"** onde a tela mostrava **2 cards** — e o subtotal ao lado
de cada documento dizia 1 e 1, ou seja, o total não era nem a soma dos próprios subtotais.

Agora a pílula conta **pedaços de texto** (o que você vê) e, quando há mais de uma marca sobre o
mesmo pedaço, a outra conta aparece ao lado: **"2 trechos · 6 codificações"**. As duas respondem a
perguntas diferentes e as duas são úteis — a segunda é a que a árvore de códigos à esquerda e os
Gráficos usam, e o repouso do mouse explica isso em cada lugar.

O filtro **Ver:** (de quem são os grifos) fica na barra das sub-abas e vale para os dois modos, e a
seção **Categorias** do painel da esquerda passou a vir recolhida, para a árvore de códigos aparecer
sem rolagem.

A tela abre em **Documentos**, e o documento que aparece ali é o mesmo que você tem aberto na
Codificação, para ir e voltar sem perder o lugar. Clicar numa barra dos Gráficos continua levando
direto para os **Trechos** daquele código.

## 1.4.5 (29/07/2026)

### Corrigido: a IA cortava material sem avisar

Quando o que você seleciona passa do tamanho que a IA lê de uma vez, o QualiLab corta o excedente.
São dois cortes, e os dois eram silenciosos em algum lugar do app. O único registro ia dentro do
texto enviado, ou seja, quem ficava sabendo era a IA, não você: material saía da análise sem que
nada na tela indicasse, e o resultado parecia completo.

**Corte da seleção inteira** (o limite é ~33 páginas somando tudo). A tela **Analisar com IA** já
avisava; as três telas de IA do **Codificar Automaticamente** cortavam caladas. Agora as três
avisam, dizendo o que ficou de fora:

- **Sugerir Codificação** e **Sugerir Categorização**: quantos documentos do fim da lista não
  entram (e por isso não vão receber sugestão nenhuma);
- **Organizar Códigos**: que a amostra de trechos foi cortada, ou que ela ficou toda de fora
  porque a lista de códigos sozinha já ocupa o limite. A lista de códigos vai sempre inteira.

**Corte de cada documento** (o limite é ~10 páginas por documento). Este era silencioso nas
**quatro** telas de IA, Analisar inclusive: um documento de 60 páginas entrava pela sexta parte e
nada dizia. Agora as quatro avisam quantos documentos da sua seleção entraram só pelo começo. Se
precisa da análise de um documento longo inteiro, o caminho é dividi-lo em documentos menores.

Junto com isso, o texto enviado à IA passou a marcar onde o documento foi cortado. Sem a marca, o
documento simplesmente terminava no meio de uma frase, e a IA podia ler isso como lacuna do seu
corpus (chegando a criticar uma ausência que era corte nosso).

O comportamento do corte não mudou: o que mudou é você ficar sabendo.

## 1.4.4 (29/07/2026)

### Corrigido: a nota de trecho vazava na codificação cega (leia se você usa esse modo)

Em projeto com **codificação cega**, o QualiLab escondia de você as codificações dos outros
pesquisadores, como prometido, mas **entregava as notas analíticas delas**. Na aba **Memos**, a
seção "Trechos anotados" listava essas notas com o rótulo "(trecho removido)" e mostrava o começo
do texto como prévia; clicando, a nota inteira abria. Ou seja: você não via o grifo do colega, mas
podia ler o raciocínio dele, que é justamente o que a codificação cega existe para impedir.

Agora a nota de trecho segue **exatamente** a visibilidade do trecho: se você não pode ver o
grifo, não vê nem lê a nota dele, e o servidor recusa gravá-la. Vale para o **gabarito** também,
que já ficava fora da vista no modo cego.

**Isso é uma correção no servidor**, então vale para todo mundo assim que a página é recarregada,
sem depender da versão que o navegador tem em cache. Se você usou codificação cega até aqui,
considere que as notas de trecho podem ter sido vistas por quem não devia.

### Anotar o trecho de outro pesquisador, direto no leitor

Em pesquisa coletiva, "Anotar trecho" no menu do botão direito só aparecia nos grifos **seus**.
Mas a nota de trecho é **compartilhada** e sempre foi editável por qualquer membro pela aba
**Memos**: o menu escondia o caminho, não protegia a nota. Agora ela aparece para qualquer grifo
que você possa ver, com o nome de quem grifou (ou "gabarito"), que é onde a observação costuma
nascer: lendo. Remover o grifo de outra pessoa continua sendo do autor ou de um administrador.

## 1.4.3 (29/07/2026)

### Reorganizar o esquema não descobre mais trecho censurado

Marcar uma família como censura já valia para os subcódigos criados depois dela. Faltava o
caminho da **reorganização**: mover ou agrupar um código para dentro de uma família de censura
deixava esse código **descoberto**, e ainda por cima **pintado de preto** (a cor que a censura
usa). Ele parecia censurado sem estar, e os trechos dele continuavam indo para a IA e saindo
inteiros no Relatório e nos exports de transparência.

Agora, ao mover códigos para dentro de uma família de censura:

- eles (e os subcódigos deles) **passam a ser censura junto**, como já acontecia na criação;
- o QualiLab avisa **antes**, dizendo quantos códigos e quantos trechos passam a ser mascarados;
- em pesquisa coletiva, isso é **alteração de censura**, então só administradores fazem. Quem
  não é administrador recebe uma explicação, não um erro.

Na direção oposta, tirar um código de censura de dentro da família **não desmarca** a censura
(desmarcar continua sendo um ato explícito, na caixa do código) e ele **não perde mais a cor
preta** ao adotar a cor do novo pai.

### A mesclagem avisa quando muda o alcance da censura

Mesclar um código de censura em um código normal move os trechos dele para fora da censura: eles
voltam a ir para a IA e a aparecer inteiros nos relatórios. Isso acontecia em silêncio. Agora o
QualiLab avisa quantos trechos deixam de ser mascarados e pede confirmação. No sentido inverso
(mesclar em um código de censura), avisa quantos passam a ser mascarados.

## 1.4.2 (29/07/2026)

### O QDPX agora leva uma citação por trecho, não uma por código

Quando você aplica **dois códigos ao mesmo trecho**, o arquivo QDPX chegava ao ATLAS.ti (ou ao
MAXQDA, ou ao NVivo) como **duas citações idênticas sobrepostas** — o mesmo texto duplicado na
lista, atrapalhando a leitura e a contagem. Agora vai **uma citação com os dois códigos**, que é
como essas ferramentas representam isso.

O agrupamento é **deliberadamente conservador**, em dois casos:

- Quando o mesmo trecho foi codificado por **pessoas diferentes**, as citações continuam separadas,
  uma por codificador. O QualCoder lê o nome do codificador da citação, não de cada código dentro
  dela; juntar as duas faria o trabalho de um aparecer como sendo do outro, sem aviso.
- Quando **dois códigos do mesmo trecho têm nota analítica própria**, também ficam separados. O
  formato só reserva um espaço de comentário por citação — e o MAXQDA ainda corta esse comentário
  em 511 caracteres ao importar.

Em ambos, preferimos a citação repetida a uma autoria trocada ou a uma nota cortada.

### A nota analítica do trecho volta quando você reimporta um QDPX

A nota que você escreve num grifo ("Anotar trecho") já era gravada no QDPX, mas **era descartada na
importação**: exportar e reimportar perdia todas elas em silêncio. Agora voltam inteiras, cada uma
presa ao trecho certo.

### Correção: projeto sem categorias gerava um QDPX que alguns programas recusam

Um projeto que nunca definiu categorias exportava um arquivo com uma seção de atributos vazia, o
que torna o QDPX inválido perante o padrão REFI-QDA — importadores mais rigorosos podiam recusar o
arquivo inteiro. A seção vazia deixou de ser escrita. Vale também para projetos sem códigos e sem
documentos.

## 1.4.1 (28/07/2026)

### "Limpar conteúdo" não apaga mais a configuração do seu estudo

No **rascunho** e no **modo arquivo**, limpar o conteúdo do projeto levava junto coisas que não
são material: as suas instruções à IA, a postura de análise, o "Memo para a IA", a biblioteca de
prompts salvos e a lista de palavras ignoradas da nuvem. Quem só queria trocar o corpus perdia
decisões de método, sem aviso. **Na nuvem isso já funcionava certo** — agora os três modos se
comportam igual.

O que "Limpar conteúdo" apaga continua sendo o material: documentos, códigos, codificações,
categorias e as notas presas a eles (nota de documento, definição de código, nota de trecho —
o alvo delas deixa de existir). Sobrevivem: o memo do projeto, toda a configuração de IA, os
prompts salvos, a lista de palavras ignoradas e o histórico de IA (conversas e memórias).

## 1.4.0 (28/07/2026)

### Você escolhe quais palavras ficam de fora da nuvem

A nuvem de palavras (aba **Gráficos ▸ Nuvem**) já descartava as palavras funcionais do português
(*que*, *para*, *com*...), mas isso não resolvia o problema real de quem trabalha com entrevistas:
a nuvem enchia de **"entrevistado", "pesquisador", "moderador"** e dos nomes dos falantes, e não
havia saída.

Agora há uma lista de **palavras ignoradas**, no painel à esquerda:

- **Clique numa palavra da nuvem para tirá-la dali.** É o caminho mais rápido, e desfaz-se com um
  clique no ✕ da palavra na lista.
- **Termine com `*` para pegar as variações**: `entrevistad*` cobre *entrevistado*, *entrevistada*
  e *entrevistados* de uma vez (a nuvem não faz lematização; o português flexiona demais para uma
  lista literal dar conta).
- **A lista pertence ao projeto**: viaja no `.qualilab`, e numa pesquisa coletiva vale para a
  equipe toda, como o restante das decisões de método.
- **Dá para desligar a lista padrão do português** ("Usar a lista padrão"), para corpus em outro
  idioma ou para quando você quer justamente ver as palavras funcionais.

Nada disso altera as suas codificações: a lista muda só o que a nuvem conta e desenha.

## 1.3.0 (28/07/2026)

### A sua chave de IA agora fala direto com o provedor

Quando você usa a **sua própria chave** (o caso normal), o navegador passou a chamar o provedor
de IA **diretamente**. O material da análise **não passa mais por nenhum servidor do QualiLab**.

Isso muda uma frase importante do manual: nos modos **arquivo** e **rascunho**, o conteúdo não
passa pelo servidor de outra pessoa — e agora isso vale **também quando você usa a IA**. O que
continua igual é a outra ponta: o **provedor que você escolher** vê o material enviado, e é
nele que mora a decisão de confiança.

Dois efeitos práticos:

- **Análises longas deixam de estourar tempo.** O caminho antigo tinha um limite de ~150 segundos
  por chamada (era o "Erro 546" em material grande com modelo lento). Esse teto não existe mais.
- **O card de IA em Minha conta diz por onde a sua chamada vai** — direto ao provedor, à sua
  máquina (Ollama) ou, no caso abaixo, pela função do servidor.

**Duas exceções, e a segunda é a única em que algo passa pelo servidor deste projeto.** O
**Ollama local** continua indo direto para a sua máquina, sem internet. E um endpoint
*Personalizado*/*Azure* que **não libere chamadas de navegador** (uma regra de quem serve a API,
chamada CORS) faz a chamada ser refeita pela função no servidor, como antes — o card em Minha
conta avisa quando esse é o seu caso. Nos demais provedores isso nunca acontece: se a chamada
direta falhar, você vê o erro, e não um desvio silencioso.

**Trocar de provedor não carrega mais a chave antiga.** Chave, modelo e URL base pertencem a um
provedor; ao trocar, os campos vêm limpos. **Voltar ao provedor que está salvo repõe a
configuração dele**, então dar uma olhada nos outros e voltar não perde nada. E se você colar uma
chave com cara de outro provedor, o card avisa na hora (só avisa: nada fica bloqueado).

Antes, a chave ficava no campo ao trocar de provedor e era fácil salvá-la sob o provedor errado —
o erro só aparecia depois, como uma recusa do provedor na hora de usar a IA.

Detalhe menor: com o Gemini, as telas que pedem uma resposta em formato estrito agora usam o
modo de saída estruturada nativo do provedor, o que reduz respostas fora de formato.

## 1.2.1 (27/07/2026)

- A dica do painel de Códigos ainda descrevia o modelo antigo ("família no topo... o código novo
  entra como filho do código selecionado"). Agora explica a regra em vigor: código com subcódigos
  vira família, ela não recebe trechos e o número dela soma os filhos.
- **Capturas do manual regeradas** — as telas mudaram bastante na 1.2.0 e as imagens ainda
  mostravam a versão anterior.

## 1.2.0 (27/07/2026)

### Uma regra nova para códigos: ou agrupa, ou recebe trechos

Um código que tem subcódigos passa a ser uma **família**: ele organiza e **não recebe trechos**.
Quem não tem subcódigos recebe trechos, esteja no topo (Hierarquia 0) ou dentro de uma família.

Antes era possível ter as duas coisas no mesmo código, e isso tornava toda contagem ambígua —
quando a família mostrava um número, não dava para saber se eram os trechos dela, os dos filhos,
ou a soma. É a mesma separação que o ATLAS.ti e o QualCoder fazem, por argumento metodológico.
A explicação completa está no manual, em **Conceitos ▸ Código e família**.

**Você não precisa decidir nada na frente.** Crie códigos à vontade; a família aparece quando
você decide subdividir. No instante em que um código ganha o primeiro subcódigo:

- se ele **não tinha trechos**, nada acontece além de virar família;
- se **tinha**, o QualiLab pergunta ali mesmo para onde eles vão. Você marca trecho a trecho, ou
  manda todos para um subcódigo de pendência (`«Nome» (geral)`) e resolve depois. Nada é movido
  sem você ver, e a nota de cada trecho é preservada.

**Seus projetos existentes não mudam de comportamento** ao abrir esta versão. Um código que já
tinha subcódigos e trechos ao mesmo tempo continua com tudo no lugar; ele só aparece como família
(quadradinho vazado) e deixa de aceitar trechos novos até você resolver a divisão.

### Novo: dividir um código em subcódigos

Em **Esquema ▸ Códigos**, selecione um código com trechos e clique em **⑃ Dividir em subcódigos**.
Abre uma tela com os subcódigos novos e uma tabela de trecho por linha: marque para onde vai cada
um. Um trecho pode ir para mais de um subcódigo. As **teclas 1 a 9** marcam a coluna na linha em
foco e as setas percorrem as linhas, o que torna viável distribuir dezenas de trechos. Há a opção
**mutuamente exclusivo**, para quem calcula concordância entre codificadores. É ação de
administrador, porque move codificação de todos.

### Aplicar código ficou mais rápido

O menu do botão direito no leitor ganhou:

- **campo de busca** com foco automático, que filtra pelo caminho inteiro ("riscos" acha
  "Riscos ▸ Confidencialidade do cliente") e **ignora acento** (digite "alucinacao");
- **teclado**: as setas movem e **Enter aplica**;
- **Recentes**: os três últimos códigos usados na sessão, no topo — codificação é repetitiva;
- um **✓** nos códigos que já estão naquele trecho, para não duplicar sem perceber.

### Contagem da família

O número ao lado de uma família passa a incluir os subcódigos (o tooltip avisa). Sem isso ela
mostraria sempre zero, já que família não tem trechos próprios.

### Corrigido
- No **Mapa**, o código criado pelo menu do botão direito nasce **onde você clicou**. Antes ia
  para uma vaga fixa da grade, que num projeto com muitos códigos caía fora da área visível — e
  parecia que o código não tinha sido criado.
- Um botão azul dentro de menu suspenso **sumia ao passar o mouse** (texto branco sobre fundo
  claro).
- Mesclar códigos preserva o **id** de cada codificação. Na prática: a nota do trecho sobrevive
  sempre, e a data em que o trecho foi codificado deixa de ser trocada pela data da mesclagem.

## 1.1.1 (26/07/2026)

### Corrigido (leia se você usa código de censura)
- **Subcódigo criado dentro de uma família de censura agora nasce censurado.** Antes ele nascia
  **fora** da censura, e ainda por cima já **pintado de preto**, herdado da família: parecia
  protegido e não estava, então aquele trecho ia em claro para a IA e para o Relatório
  Interativo e a Web Annotation. A caixa "Código de censura" só alcançava os subcódigos que
  **já existiam** no momento em que você a marcou. Se você criou subcódigos assim antes desta
  versão, o remédio é desmarcar e marcar de novo a caixa da família: a marcação desce para
  todos os subcódigos. A herança vale só para **proteger**: mover um código para fora nunca
  desmarca a censura sozinho, isso continua sendo uma decisão explícita de quem administra.
- Falta ainda o caso vizinho: **agrupar** um código que já existe sob uma família de censura
  também não o marca. Enquanto isso, marque a censura depois de agrupar.

## 1.1.0 (26/07/2026)

### Mudou (leia se você exporta QDPX)
- **A exportação QDPX voltou a sair completa, com os trechos censurados em claro.** Na versão
  anterior ela mascarava a censura, e isso estava errado por dois motivos. O QDPX é o formato
  pelo qual você leva o **seu próprio** material para o ATLAS.ti, o MAXQDA ou o NVivo e traz de
  volta: mascarar ali apagava o texto original de forma **irreversível** naquele caminho. Pior,
  a exportação **descartava as codificações de censura**, então quem migrava chegava na outra
  ferramenta com o código de censura vazio, justamente onde precisava continuar protegendo o
  material. A regra agora é clara: os formatos de **trabalho e migração** (`.qualilab`, QDPX,
  QDC, CSV, JSON) saem **completos**; as saídas de **transparência** (Relatório Interativo e
  Web Annotation) e o que vai para a **IA** continuam mascarando. O menu **exportar** passou a
  dizer isso na hora, com um aviso em destaque quando o projeto usa código de censura.

### Adicionado
- **Repetir Codificação: uma aba nova que não usa IA.** Ela pega os trechos que um código **já
  tem** e mostra as outras ocorrências **idênticas** deles no projeto inteiro, com o texto em
  volta, para você aprovar uma a uma. Serve a qualquer código, e resolve um problema concreto da
  censura: marcar um nome num parágrafo não protege as outras cinco menções, e nada na tela
  mostrava isso. Não precisa de chave de IA, não manda nada para fora e funciona offline. Ela
  encontra texto **idêntico**, não variante: "Banca Exemplo" não acha "a banca", e para essas o
  caminho continua sendo **pesquisar +**, onde o julgamento é seu.
- Por causa dessa aba, a tela **Codificar com IA** passou a se chamar **Codificar
  Automaticamente**: das quatro abas, três usam IA e uma não. Em uma instalação com a IA
  desligada, a tela continua existindo, só com a aba que funciona sem ela.
- **Manual: como publicar sem vazar o que a censura não alcança** (seção 12.4). A censura protege
  o que você marcou **dentro do texto**, e não toca em **título do documento**, **valores de
  categoria** e **memos**, que viajam em toda saída. O manual agora explica o fluxo recomendado:
  trabalhe no projeto de laboratório e publique de uma **cópia limpa**. Inclui o conselho mais
  barato de todos, que é nomear os documentos sem identificação (`ENT-01`) desde o começo.

### Corrigido
- **Depois de aplicar codificações sugeridas, o leitor mostrava os grifos antigos.** A mensagem
  dizia "confira no leitor" e o leitor exibia o estado anterior até você trocar de documento ou
  recarregar a página, o que fazia parecer que nada havia sido gravado (estava, sim). Valia para
  as sugestões de IA, para a mesclagem de códigos no Esquema e para o preenchimento de
  categorias.
- Nos resultados da nova aba, o texto em volta do trecho não é mais cortado no meio de uma
  palavra.

## 1.0.1 (26/07/2026)

### Corrigido
- **Importar um projeto grande na nuvem enchia a tela de erros de conexão.** Ao importar um
  pacote com milhares de trechos codificados, a sincronização ao vivo tentava recarregar o
  projeto **a cada linha gravada**: centenas de recargas ao mesmo tempo, até o navegador
  recusar novas conexões. A tela se enchia de "Falha de conexão" e o import parecia ter
  quebrado (embora os dados estivessem entrando). Agora as atualizações são agrupadas: uma
  recarga de cada vez, e nenhuma enquanto uma importação está em andamento. Quem importa
  sozinho não vê diferença; quem trabalha em equipe continua recebendo as alterações dos
  colegas, com um pequeno atraso de segundos.
- **Aviso de falha de conexão dizia que "a alteração NÃO foi salva" mesmo quando não havia
  alteração nenhuma** (por exemplo ao entrar na conta ou ao abrir uma tela). A frase agora
  diz apenas que a ação não foi concluída.

## 1.0.0 (26/07/2026)

Primeira versão marcada. O app já era usado antes disto; a numeração começa agora para que
pesquisador e autor consigam falar da mesma versão.

### Adicionado
- **Recuperação de senha.** "Esqueci minha senha" no acesso pela nuvem: link por e-mail, tela
  para criar a senha nova, tratamento de link vencido. Antes, quem esquecesse a senha ficava
  **sem acesso ao próprio projeto**, sem saída.
- **Aviso de tela pequena.** Em telas estreitas o app diz com franqueza que dá para ler e
  consultar, mas não para codificar (aplicar código depende do menu de botão direito, que não
  existe no toque).
- **Versão visível** no cabeçalho e na tela de entrada.
- **Pré-visualização de link** (`description`/Open Graph): compartilhar o endereço no WhatsApp
  ou por e-mail agora mostra um cartão com nome e descrição, em vez de vir vazio.

### Melhorado
- Mensagens de erro de conta mais claras: sessão inválida/expirada agora explica o que fazer
  ("peça um novo link"), em vez de mostrar o erro técnico de JWT; senha repetida e excesso de
  tentativas também ganharam texto próprio.
- Título da página corrigido.

### Interno (não muda o uso)
- **CI nos dois repositórios**: a cada mudança, verificação automática das invariantes do
  arquivo (aspas curvas em atributo, `</script>` literal, BOM), da sintaxe do JavaScript, dos
  testes de funções puras e do boot real num navegador. O app é um arquivo único sem etapa de
  compilação. Antes disto, nada impedia que um erro de digitação virasse tela branca para
  todos os usuários do site publicado.

### Polimento de texto e de superfície (26/07/2026)
- **Travessões fora do texto que você lê.** Toda a interface, o README e o manual foram reescritos
  sem travessão (em-dash), frase por frase.
- **Painéis laterais padronizados.** Eram sete larguras diferentes e só uma tela permitia
  redimensionar. Agora são três medidas (navegação, painel de trabalho, configuração de IA) e
  **todas as divisas podem ser arrastadas**, com duplo clique para voltar ao padrão e setas do
  teclado. A largura que você escolher vale em todas as telas do mesmo tipo e sobrevive ao
  recarregamento.
- **Botões consistentes.** Ações de diálogo e de confirmação agora começam com maiúscula
  (`Salvar`, `Cancelar`, `Excluir projeto`); o cabeçalho e os controles inline seguem discretos, em
  minúscula. As faixas de aviso passaram a ser dispensadas pelo `✕`, como as demais.
- **Vocabulário uniforme para ações destrutivas:** *Remover* tira algo de onde está (um código de um
  trecho, uma pessoa do projeto), *Excluir* faz o item deixar de existir, *Limpar* esvazia sem
  destruir. "Apagar" e "deletar" saíram dos botões.
