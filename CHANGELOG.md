# Changelog

Mudanças relevantes para quem **usa** o QualiLab. O histórico completo (incluindo refatorações
e decisões internas) está nos commits e no `CLAUDE.md`.

A versão aparece no canto direito do cabeçalho e no rodapé da tela de entrada. **Cite esse
número ao relatar um problema**: sem ele não há como saber qual build o seu navegador carregou.

> **Este arquivo é próprio deste repositório desde ago/2026** e descreve só o aplicativo
> publicado aqui. O QualiLab dentro do assistente (extensão do Claude Desktop, plugin) tem
> numeração e changelog próprios, no repositório `QualiLab-plugin` — ele leva as mesmas
> ferramentas de leitura para dentro do seu assistente, e é outro produto.
>
> Ao publicar uma versão: suba o `QUALILAB_VERSION`, acrescente a seção aqui **antes** de
> gerar (o `gen-estavel.sh` recusa publicar uma versão sem seção) e regenere.

## 1.4.55 (03/09/2026)

### O que cada papel pode fazer, decidido item a item na criação do projeto

Até aqui o QualiLab só distinguia **somente leitura** de **membro** por uma regra tudo-ou-nada, e o
resto do controle eram interruptores do projeto inteiro. E o projeto coletivo nascia **aberto**: as
decisões de acesso ficavam num card do hub que a coordenação abria depois, quando quem entrou pelo
convite já tinha visto o trabalho dos outros. O que alguém já viu não se desvê.

Agora, ao criar um projeto coletivo (e ao "Enviar para a nuvem"), o formulário pergunta o **tipo de
estudo** (equipe aberta, confiabilidade entre codificadores, dividir o corpus, painel de juízes) e
mostra uma **matriz** em duas partes. **Papéis**: para somente leitura e para membro, caixas de
marcar para comentar, codificar e responder categorias, adicionar documentos, criar e editar
códigos, editar o verbete dos códigos e usar os painéis de IA. **Desenho do estudo**: codificação
cega, distribuição restritiva e categorias como metadado do desenho, com o nome que têm na
literatura. O tipo de estudo só preenche a matriz; ela continua editável. O que é da administração
por construção fica recolhido embaixo. É o **servidor** que
aplica cada linha, não a tela. A mesma matriz fica no hub (**Distribuir documentos → O que cada papel
pode fazer**), e cada mudança entra no histórico do projeto. Sem mexer em nada, tudo continua como
antes: membro faz tudo, somente leitura lê e comenta.

**Os convites já vão com isso**: o e-mail do convite lista o que o papel convidado vai poder fazer
neste projeto, gerado da matriz; e, logo depois de criar um projeto coletivo, o hub abre com os
convites, para a pessoa não precisar procurar.

Exige a migração de banco desta versão, já aplicada no projeto público em 03/09/2026 (o bloco está no `supabase/schema.sql`).

## 1.4.54 (03/09/2026)

### Importar um `.qualilab` de equipe num projeto individual preservava só um codificador por trecho

Ao importar num rascunho ou projeto individual um arquivo exportado de projeto coletivo, o
QualiLab fundia numa linha só as codificações de **pessoas diferentes** no **mesmo trecho** com o
**mesmo código**, e juntava as notas analíticas delas num memo só, separadas por `---`, sem dizer
de quem era cada frase. O resumo ainda anunciava o número de codificações do arquivo, não o
gravado. Medido num projeto real de validação com três avaliadores: o arquivo trazia 3.211
codificações, o banner dizia 3.211 e o projeto ficava com 2.116. Nenhum erro, nenhum aviso.

Era justamente a observação de consenso ("os três marcaram o mesmo trecho") sendo apagada. Agora,
em projeto individual, **cada codificador da camada individual continua sendo uma codificação
própria**, com a sua nota; o gabarito só entra nos trechos que não têm codificação individual
(era o que a regra antiga existia para garantir, e continua garantido). O resumo passou a contar
o que **foi gravado** e a dizer quantas codificações do arquivo se fundiram, e por quê.

Projeto coletivo na nuvem não era afetado: lá cada codificação já entrava inteira.

### O gabarito das categorias sob codificação cega, por escolha do projeto

Sob codificação cega, o membro não via **nenhuma** categoria respondida no gabarito, porque a
regra que esconde o gabarito das codificações escondia também o das categorias. Está certo quando
a categoria é um veredito; está errado quando ela é fato do desenho do estudo (plataforma, perfil
sorteado, tema), e aí o codificador cego abria o documento sem saber de que material se tratava.

Nova opção em **Distribuir documentos → Como este projeto controla o acesso**, logo abaixo do
cego: **As categorias são metadado do desenho**. Ligada, o gabarito das categorias fica visível
aos membros mesmo sob cego. **Só as categorias**: o gabarito das codificações de trecho e a nota
de quem codificou continuam ocultos, sempre, e isso não é configurável. É o servidor que aplica.
A mudança entra no histórico do projeto, e o Relatório ganha um bloco **"Desenho do estudo"**
declarando a escolha nas três saídas, sem caixa para desligar.

Exige a migração de banco desta versão, já aplicada no projeto público em 03/09/2026 (o bloco está no `supabase/schema.sql`).

## 1.4.53 (03/09/2026)

### O verbete do código aparece na Codificação, ao lado da árvore

A definição de um código — o que conta, o que não conta, onde fica a fronteira — é escrita no
memo dele, e já podia ser lida na aba **▤ Memos** do painel direito. Só que ali ela nasce
recolhida, e abrir aquela aba tira a **árvore de códigos** da vista, que é exatamente o gesto de
quem está codificando: ler a delimitação e clicar no código.

Agora, ao selecionar um código na aba **✎ Codificar**, o verbete aparece logo abaixo dele, em
leitura, com as quebras de linha preservadas. Para **escrever**, a aba Memos continua sendo o
lugar — uma casa para editar, duas para consultar.

Com um trecho já selecionado no texto, clicar num código o **aplica** (é o que sempre fez), então
o verbete se consulta antes de selecionar o trecho.

### Categoria respondida só no gabarito não aparece mais como "sem valor"

Num projeto coletivo, o campo de cada categoria é sempre **a sua** resposta — e continua sendo.
Mas quando você ainda não respondeu e existe um valor no **gabarito**, a tela dizia "(sem valor)"
no seletor e "—" na linha recolhida, sobre uma categoria cujo valor ela conhecia e exibia logo
abaixo. Acontece em estudos cujas categorias são fato do desenho (a fonte do material, o perfil,
o tema sorteado) e vivem só no gabarito.

Agora a linha recolhida mostra esse valor em itálico, dizendo de onde ele veio; e o valor do
gabarito passou a aparecer também em **Ver: Minhas**, não só em "Individuais (todos)". O campo
continua vazio de propósito: preenchê-lo o deixaria com cara de respondido, e a primeira tecla
criaria em silêncio uma resposta sua diferente do gabarito.

### Agrupar documentos por categoria na tela de Codificação

O seletor de documento da Codificação oferecia ordenar, mas não **agrupar por categoria** — a
opção existia só nas telas que já carregam o projeto inteiro. Agora ela existe aqui também: ao
abrir o seletor, o QualiLab busca os valores das categorias (só eles) e monta as seções. Quem
nunca agrupa não paga nada por isso, porque a busca só acontece quando o seletor é aberto.

### Travar o verbete dos códigos (projetos coletivos na nuvem)

Nova opção em **Distribuir documentos ▸ Como este projeto controla o acesso**: enquanto ligada,
só a administração edita a definição dos códigos. **Ler continua livre para todo mundo.**

Ela existe para estudos de calibração e validação, em que o verbete é o instrumento: reescrito no
meio de uma rodada, as codificações feitas antes e as feitas depois deixam de ser comparáveis — e
nada na tela denuncia, porque as duas metades continuam parecendo a mesma tarefa. Quem aplica a
regra é o servidor, não a interface. Ligar e desligar fica registrado no histórico do projeto.
Quem hospeda o próprio Supabase precisa aplicar o `supabase/schema.sql` atualizado.

### Correções

- **O campo de memo abria vazio** quando o memo já existia e a lista chegava do servidor logo
  depois de a tela montar. O cabeçalho já mostrava "última edição: fulano" — sinal de que o texto
  tinha sido encontrado — e o campo ficava no espaço reservado. Pegava principalmente o **memo do
  projeto** na primeira abertura, que costuma ser onde mora o protocolo do estudo. Quem está
  digitando não é interrompido: o texto que chega nunca escreve por cima do que está sendo escrito.

## 1.4.52 (03/09/2026)

### Espelhos do projeto: um ponto de restauração antes do irreversível

Um **espelho** guarda o projeto inteiro num instante (documentos, categorias, códigos,
codificações, memos, conversas e memórias de IA), para **restaurar** depois. Fica em
**pílula do projeto ▸ Espelhos do projeto**.

- **Espelhar agora**, com um rótulo opcional, cria um espelho manual. Manuais ficam até você excluir.
- **Antes de limpar o conteúdo, excluir documento, código ou categoria, mesclar ou dividir código
  (no Esquema ou pela IA), editar o texto de um documento e antes de restaurar**, o QualiLab espelha
  sozinho, no máximo um automático a cada 10 minutos; ficam os 5 automáticos mais recentes.
- **O automático tem interruptor**, ligado por padrão, no mesmo cartão: cada espelho é uma cópia do
  texto e da análise, e com os 5 automáticos o projeto pode ocupar cerca de 1,5× o tamanho (no modo
  arquivo é o próprio `.qualilab` que cresce). Desligar é decisão do projeto e fica no histórico.
- **Restaurar** volta o projeto inteiro ao estado daquele instante. O estado atual é espelhado
  antes (dá para desfazer a própria restauração), e o histórico do projeto registra a
  restauração em vez de voltar atrás: **o histórico nunca é restaurado**.
- **O que o espelho não guarda**: os PDFs originais (o PDF de um documento excluído não volta;
  o texto e a análise voltam) e o histórico. A declaração sobre uso de IA, a equipe e a
  distribuição de documentos também não mudam ao restaurar.
- Onde mora: no rascunho, no armazenamento do navegador (fora do limite de 5 MB do rascunho);
  no modo arquivo, **dentro do próprio `.qualilab`** (o arquivo cresce com cada espelho); na nuvem,
  numa tabela e num bucket próprios, onde só administradores criam, restauram e excluem. Quem
  hospeda o próprio Supabase precisa aplicar o `supabase/schema.sql` atualizado.
- Um espelho não é backup externo: mora no mesmo lugar do projeto. Continue exportando o
  `.qualilab` para guardar uma cópia fora.

## 1.4.51 (02/09/2026)

### Histórico do projeto: a trilha de auditoria do processo

O QualiLab passa a **registrar as operações que alteram o projeto** e a mostrá-las numa lista,
em **Memos ▸ Histórico do projeto**. Cada linha é uma frase com data e autor: "Importou QDPX
(REFI-QDA): 16 documento(s), 90 código(s), 2332 codificação(ões)", "Mesclou "Prazo" em Demora:
41 codificação(ões) movida(s)", "Excluiu o documento X: 12 codificação(ões) apagada(s) junto",
"Aplicou em lote pela tela Sugerir Codificação: 8 item(ns)", "Consolidou 3 codificação(ões) na
camada final", "Exportou QDPX (REFI-QDA)". Entram: importações e mesclagens de arquivo, mesclagens
e divisões de código, exclusões (documento, código, categoria, limpar conteúdo), edição de texto
com reancoragem dos grifos, aplicações em lote (Repetir Codificação e as três telas de IA),
consolidações da Reconciliação, mudanças de tipo e configuração do projeto, entradas e saídas de
membros e mudanças de papel (na nuvem) e exportações.

- **O que ele NÃO é**, escrito no alto da própria tela: não desfaz nada, não guarda o conteúdo do
  que foi apagado (só nomes e contagens: nenhum trecho do corpus viaja nele) e não registra
  leitura nem navegação. A codificação aplicada uma a uma também não entra: ela já fica registrada
  na própria codificação, com autor e data.
- **Filtro por operação e busca por texto**: digite o nome de um código para ver o que já
  aconteceu com ele (as mesclagens, divisões e exclusões que o citam).
- **Exportar CSV** baixa a lista inteira, com a frase legível e o detalhe em JSON.
- **Viaja no `.qualilab`** e **sobrevive ao "Limpar conteúdo"**; reimportar o mesmo arquivo não
  duplica o histórico. O QDPX não tem onde guardá-lo, e o menu exportar ▾ avisa.
- **Na nuvem é só-acréscimo**: nem o administrador edita ou apaga uma linha pela API. Sob
  codificação cega, cada pesquisador vê os próprios eventos e os de equipe, e o administrador vê
  tudo. Entradas, saídas e mudanças de papel são gravadas pelo próprio servidor. Quem hospeda o
  próprio Supabase precisa aplicar o `supabase/schema.sql` atualizado.
- **No Relatório**, a caixa **"Incluir o histórico do processo"** (ligada por padrão) acrescenta
  às três saídas um resumo do que o histórico registra: quantas importações, mesclagens,
  exclusões, aplicações em lote, consolidações e exportações, e desde quando. Ele relata, não
  promete.
- O histórico começa no primeiro evento depois desta versão. O que aconteceu antes não foi
  gravado, e a primeira linha diz isso.

## 1.4.50 (01/09/2026)

### Convite com papel já definido

Até agora, quem entrava no projeto pelo código de acesso sempre nascia **pesquisador** — outro
papel exigia um segundo passo do administrador, depois que a pessoa já tinha entrado. Agora dá
para fixar o papel **antes**.

- Em **Projeto ▸ Convite com papel fixo**, o administrador escolhe o papel (administrador,
  pesquisador ou somente leitura) e gera um código próprio. Quem entrar com ele já recebe aquele
  papel, sem ajuste depois.
- **Opcionalmente, trave o convite a um e-mail**: só quem se cadastrar ou entrar com aquele
  e-mail consegue usar o código — os demais recebem a mesma mensagem de "código inválido" de
  sempre, para não revelar a quem o convite se destina.
- **O QualiLab não manda e-mail nenhum sozinho.** A entrega do código é sempre sua: copie e
  cole onde quiser, ou use "abrir e-mail", que só monta a mensagem e abre a **sua própria** caixa
  de saída — nada passa pelo servidor do QualiLab.
- Convites podem ser de uso único (o padrão) ou reutilizáveis, e ficam listados para revogar a
  qualquer momento.

O código de acesso do projeto continua funcionando exatamente como antes (entra como
pesquisador); o convite com papel é um caminho a mais, não uma troca.

## 1.4.49 (31/08/2026)

### Um papel de somente leitura, para quem lê e comenta

Um projeto na nuvem agora tem **três papéis**, e não dois. Além de administrador e pesquisador,
existe o **somente leitura** — pensado para o orientador, o parecerista, o membro do comitê de
ética, o colega a quem você pede uma segunda opinião.

- **Ele lê o projeto inteiro**: os documentos, o livro de códigos, as codificações da equipe, as
  categorias, os gráficos, a Reconciliação e o Relatório. As mesmas restrições que já existiam
  continuam valendo para ele: sob **codificação cega** ele vê só o que um pesquisador cego veria,
  e sob **distribuição** só os documentos atribuídos a ele.
- **Ele não muda material nenhum**: não codifica, não cria nem renomeia código, não responde
  categoria, não envia nem edita documento, não consolida gabarito, não importa.
- **Mas ele COMENTA**, e é isso que faz o papel valer: pode escrever **memos** — a nota de um
  trecho, a de um documento, a de um código e a memória do projeto. É por aí que a leitura dele
  volta para a equipe, dentro do projeto, em vez de num e-mail à parte.
- **As telas de IA somem para ele**, do mesmo jeito que somem para quem desativou a IA no
  projeto: elas existem para propor mudanças que ele não pode aplicar.
- **A configuração do estudo fica com quem coordena.** As instruções que a IA recebe, a postura
  de análise, os prompts salvos e as palavras ignoradas na nuvem são guardados como memos, mas
  não são comentário — são decisão de método, e o papel de leitura não mexe neles.

**Como atribuir:** em **Projeto ▸ Membros**, o administrador clica em "tornar somente leitura" na
linha da pessoa (e "devolver a codificação" para desfazer). Ela entra no projeto normalmente,
com o mesmo código de acesso. Um projeto nunca fica sem administrador: o botão recusa rebaixar o
último que existe.

Quem já usa o QualiLab **não é afetado**: ninguém muda de papel sozinho, e os projetos que já
existiam continuam com os mesmos administradores e pesquisadores de antes. As restrições são
impostas pelo **servidor**, não apenas escondidas na interface.

## 1.4.48 (31/08/2026)

### O QualiLab agora fala inglês

A interface inteira passou a existir em **português e inglês**. Não é uma tradução parcial:
todas as telas, as sub-abas, os menus, as mensagens de erro, as confirmações, os resumos de
importação, os avisos, os textos de ajuda e os modais estão nos dois idiomas.

- **O idioma vem do seu navegador, e você não precisa configurar nada**: navegador em português
  abre em português; qualquer outro idioma abre em inglês.
- **Para escolher o contrário, vá em "Minha conta"** — o seletor de idioma fica lá. Trocar
  recarrega a página. A escolha é sua e fica no seu navegador: ela **não viaja no projeto**, e
  dois pesquisadores da mesma equipe podem ler o MESMO projeto em idiomas diferentes.
- **Números e datas acompanham o idioma.** Em inglês, `1.234` deixa de aparecer como `1.234`
  (que ali significaria "um vírgula dois") e passa a `1,234`; as datas saem no formato local.
- **Os seus dados não mudam de idioma, e isso é de propósito.** O que você escreveu — nomes de
  documentos, de códigos e de categorias, os valores que preencheu, os seus memos — é material
  de pesquisa e sai exatamente como você o escreveu. As respostas "Sim/Não", "Não informado" e
  "Outros" agora têm rótulo traduzido na tela **sem mudar o que está gravado**, para que uma
  resposta preenchida em português e outra em inglês continuem sendo a MESMA resposta na
  comparação entre codificadores.
- **O apêndice de transparência (leitor ATI) acompanha a interface**: quem trabalha em inglês
  entrega um apêndice em inglês, com a declaração de uso de IA junto. A marca de trecho
  censurado (`[trecho censurado]`) **continua em português nos arquivos exportados**, para que
  o mesmo arquivo não mude de conteúdo conforme o navegador de quem o gerou.
- **Os pedidos que o QualiLab faz à IA continuam em português**, e portanto as respostas dela
  também. Traduzi-los muda o comportamento do modelo, e isso é uma decisão que precisa ser
  medida antes de tomada — não entrou nesta versão.

### Correções que vieram junto

- Na Leitura, a lista de documentos está à **esquerda** desde uma versão anterior, mas o texto
  do estado vazio ainda mandava procurá-la à direita.
- Em projetos importados de outras ferramentas, um trecho sem autor aparecia como "sem autor"
  numa tela e como "anônimo" nas outras — agora é uma grafia só, em todas.
## 1.4.47 (30/08/2026)

### Um convite visível para instalar o QualiLab como aplicativo

- A tela de entrada passou a mostrar uma faixa **"Instalar o QualiLab"**, com um botão que abre
  a janela de instalação do navegador. Até agora esse convite só existia num **ícone pequeno na
  barra de endereço**, que quase ninguém encontra — instalado, o QualiLab ganha janela própria,
  **abre sem internet** e o duplo clique num `.qualilab` passa a abrir nele.
- **No Windows, quem estiver no Chrome recebe "Instalar pelo Edge" em destaque** — e o link abre
  o Edge no mesmo endereço, mesmo você estando no Chrome. Instalar ali mesmo continua a um
  clique, em "Instalar aqui": funciona igual, só deixa o ícone dos arquivos `.qualilab` quebrado
  no Explorer (é limitação do Chrome, não do QualiLab). A escolha continua sua — o ícone pode não
  lhe importar.
- A faixa **só aparece quando instalar é possível de verdade**: some no Firefox e no Safari, que
  não instalam, e some assim que você instala. Ela não muda nada de onde os seus dados ficam.

## 1.4.46 (26/08/2026)

### O destaque do trecho agora acontece em duas fases: a frase, depois o trecho

- Ao pular para um trecho (da Leitura, da busca global, dos Gráficos), primeiro a **frase ou
  parágrafo inteira** pulsa uma vez, suave — é o que leva o olho à região certa da página —
  e então o **trecho exato** pisca duas vezes, mais forte, com o segundo pisco de propósito
  mais tardio, quando o olhar já assentou.
- O destaque continua neutro (escurece em fundo claro, clareia em fundo escuro) e some sozinho
  sem deixar rastro; quem usa "reduzir movimento" recebe só o véu parado sobre o trecho.

## 1.4.45 (26/08/2026)

### O app instalado passou a abrir offline desde a primeira visita

- **O que acontecia.** Instalar o QualiLab como aplicativo e abri-lo **sem rede** (ou com o
  endereço fora do ar) podia dar a página de erro do navegador — "não consigo chegar a esta
  página" — mesmo com o app prometendo funcionar offline. O truque: a cópia offline só era
  guardada quando a página era **recarregada** ao menos uma vez depois de instalada; quem
  instalava e usava direto, sem F5, ficava sem cópia nenhuma.
- **O que mudou.** A cópia do aplicativo é guardada **no momento da instalação**. O
  comportamento com rede não muda em nada: continua vindo sempre a versão mais nova.

## 1.4.44 (26/08/2026)

### O "pisca" que mostra o trecho ao chegar na Codificação ficou visível de verdade

- **O que acontecia.** Ao clicar num trecho (na Leitura, na busca global, nos Gráficos), o
  leitor rolava até ele e o destacava com um pisca — que quase ninguém via. Dois motivos: o
  pisca inteiro durava 0,6 segundo e acontecia **enquanto os olhos ainda estavam se achando**
  depois do salto da rolagem; e, no tema claro, o clarão branco deixava o trecho **igual à
  página** — um destaque que funciona sumindo.
- **O que mudou.** São **três piscos em 1,6 segundo**, com o último de propósito mais tarde
  (quando o olhar já assentou); e a cor do pisca **segue o fundo**: escurece no tema claro e
  no sepia, clareia no escuro. Continua neutro — cor com matiz se leria como cor de código.
- Quem usa "reduzir movimento" no sistema segue recebendo o destaque parado, sem piscar.

## 1.4.43 (26/08/2026)

### O banner falso "ResizeObserver loop..." parou de aparecer

- **O que acontecia.** De vez em quando (visto no app instalado como PWA, ao abrir ou
  redimensionar a janela) surgia a faixa vermelha *"Algo falhou de forma inesperada:
  ResizeObserver loop completed with undelivered notifications"* — sem que nada tivesse
  falhado de verdade.
- **De onde vinha.** Essa frase é um **aviso do navegador**, não um erro do QualiLab: ela
  aparece quando um componente que reage a mudança de tamanho (os Gráficos, por exemplo)
  ajusta o layout no mesmo instante em que é medido. O navegador a entrega pelo mesmo canal
  dos erros reais, e o QualiLab a exibia como se fosse um.
- **O que mudou.** O aviso passa a ser ignorado pelo detector de erros. Erros de verdade
  continuam virando banner, exatamente como antes.

## 1.4.42 (26/08/2026)

### PWA: trocar de tela deixou de abrir janelas do navegador

- **O que acontecia.** Com o QualiLab **instalado como aplicativo** (Edge recente), clicar nas
  abas do cabeçalho — Leitura, Memos, Gráficos… — abria uma **janela nova do navegador**, como
  se cada aba fosse um link para outro site. O app em aba normal do navegador nunca teve isso.
- **De onde vinha.** Não era do QualiLab: o Edge ganhou em 2026 um recurso que decide sozinho
  se uma navegação ligada a um aplicativo instalado fica no app ou vai para o navegador — e,
  sem instrução em contrário no manifesto do app, ele resolvia a dúvida abrindo janela nova.
- **O que mudou.** O manifesto do aplicativo agora declara essa instrução
  (`launch_handler: navigate-existing`): navegação do QualiLab fica **na janela que já está
  aberta**.
- **Se ainda acontecer com você.** O navegador só relê o manifesto de um app instalado de tempos
  em tempos. Para valer na hora: desinstale e reinstale o aplicativo. Alternativa sem reinstalar:
  `edge://apps` → QualiLab → Detalhes → desligue o **tratamento de links**.

## 1.4.41 (24/08/2026)

### Minha conta: o card de IA parou de ser uma parede de texto

- **O que acontecia.** O card **IA: sua chave e modelo** tinha mais explicação do que controle:
  cinco blocos de texto de ajuda empurravam o Provedor, a chave, o Modelo e o botão **Salvar**
  para baixo. Num modal isso quer dizer rolar para achar aquilo que você foi ali fazer.
- **O que mudou.** As explicações passaram a vir **recolhidas**, cada uma atrás de uma seta:
  *como isso funciona*, *como preencher*, *como escolher*, *Custo estimado (calculadora)* e
  *ajustes do modelo*. **Nada foi removido** — é um clique para abrir, e o texto é o mesmo.
- **O que continua à vista, de propósito.** Além dos controles, a frase que diz **para onde o seu
  material vai** — e ela muda conforme a sua configuração: com o Ollama local, que nada sai da sua
  máquina; com a sua chave, que a chamada não passa por servidor nenhum do QualiLab; sem chave,
  que ela passa por uma função no servidor deste projeto. Essa frase não fica atrás de clique.

## 1.4.40 (24/08/2026)

### Clicar num trecho na Leitura abre o documento, ali mesmo

- **O que acontecia.** Na **Leitura ▸ Trechos**, clicar num trecho levava você para a tela de
  **Codificação**. Ler um trecho no contexto em que ele foi feito é leitura, não codificação — e
  a troca de tela ainda arrastava junto o documento que estava aberto na Codificação.
- **O que mudou.** O clique passa a abrir o documento na sub-aba **Documentos**, na mesma tela,
  rolando até o trecho e destacando ele. A Codificação fica exatamente onde estava.
- **Como ir para a Codificação.** Continua existindo: clique num grifo do leitor e use o botão
  **abrir na Codificação →**.
- **O que ainda não funciona.** Com a caixa **grifos** desmarcada não há grifo para destacar,
  então o documento abre no topo, sem rolar até o trecho.

### O destaque do trecho ficou visível

- **O que acontecia.** Ao saltar para um trecho (daqui ou da **busca global**), o destaque era um
  anel azul que aparecia e desvanecia uma vez. Ele chegava no mesmo instante em que a página
  acabava de rolar, então quando o olho pousava no lugar já tinha passado.
- **O que mudou.** Agora ele **pisca duas vezes**, em branco translúcido sobre o trecho. Branco
  porque uma cor se confunde com a cor do próprio código; e como um véu por cima, o texto
  continua legível e a cor do código volta intacta quando o destaque acaba.
- Quem configurou o sistema para **menos movimento** recebe o destaque parado, sem piscar.

### Arquivos `.qualilab` no Windows: o tipo agora tem nome

- Com o app **instalado**, o Explorer passa a mostrar **Projeto QualiLab** como tipo do arquivo,
  em vez do genérico "Arquivo QUALILAB".
- **O ícone do arquivo ainda não.** Declaramos um ícone próprio para o tipo, como o padrão da web
  prevê, mas o Chrome no Windows não repassa esse ícone ao sistema hoje — o arquivo continua com
  a folha em branco. A declaração fica: no dia em que ele passar a repassar, o ícone aparece sem
  precisar de nova versão.

## 1.4.39 (24/08/2026)

### Categorias que se recolhem, na tela de Codificação

- Cada categoria do painel direito ganhou uma seta ao lado do nome: clicar no rótulo recolhe.
- **Por que isso ajuda.** A descrição de uma categoria é a *instrução de codificação* — quando
  ela é um verbete completo (definição, o que conta como cada valor, fronteiras, o que ignorar),
  duas ou três categorias seguidas empurram as demais para fora da vista, e achar a que falta
  responder vira rolagem.
- **Recolhida, a linha continua respondendo**: mostra o valor atual à direita, ou um traço quando
  ainda não há resposta. O texto inteiro aparece ao passar o mouse.
- **Todas começam abertas**, como sempre — recolher é escolha sua, e nada muda se você não mexer.
  O estado vale enquanto você está na tela; trocar de tela reabre tudo.

### Reconciliação: quem não é dono do projeto agora tem o que fazer na aba Categorias

- **O que acontecia.** Na aba **Códigos**, qualquer pesquisador podia agir — *Concordo com este
  código* registra uma codificação sua no trecho. Na aba **Categorias**, só o dono do projeto
  tinha ação (preencher o gabarito): os demais abriam a tela, viam a comparação de respostas e
  não tinham gesto nenhum.
- **O que mudou.** Cada categoria ganhou **Sua resposta**: você registra ou muda a sua ali mesmo,
  com as respostas da equipe lado a lado. É exatamente a resposta que você preencheria na tela de
  Codificação — **não mexe no gabarito**, que continua sendo consolidado pelo dono do projeto.
- Vale nos dois modos da aba: um documento por vez e **(Todos os documentos)**.
- **Uma ressalva honesta.** Ali você responde *vendo* a resposta dos outros, o que influencia. É o
  esperado numa tela de reconciliação, cujo objetivo é justamente convergir — e o botão *Concordo
  com este código* já funcionava assim. Quem precisa medir concordância sem essa influência usa a
  **codificação cega**, que esconde esta tela para os pesquisadores.
- **O que ainda não existe.** Um botão *Discordo* na aba Códigos. Hoje o app sabe registrar
  concordância (uma codificação sua no trecho) e não tem onde guardar uma discordância — então
  quem revisou e discordou fica indistinguível de quem ainda não olhou. Está desenhado para uma
  próxima versão.

## 1.4.38 (24/08/2026)

### Codificar ficou visível: a barra flutuante de seleção

Selecionou um trecho no leitor? Agora aparece uma **barra flutuante** colada à seleção, com os
seus códigos **recentes** em um clique e o botão **"aplicar código"** (o mesmo menu completo do
botão direito). O botão direito continua funcionando exatamente como antes — a barra é a porta
de entrada para quem chega, e o caminho para quem usa trackpad ou tablet. Junto:

- **Teclas 1 a 9**: com um trecho selecionado, aplicam um dos códigos recentes. A lista numerada
  aparece no painel Codificar, ao lado da árvore.
- **Minimapa do documento**: uma coluna fina na borda direita do leitor mostra ONDE estão os
  grifos (na cor de cada código) e as ocorrências da busca. Clique para ir. Em documento de
  dezenas de páginas, é navegação de verdade.
- **Toque (tablet)**: a seleção por toque agora também abre a barra flutuante.

### O app agora é instalável (PWA) e abre sem internet

- **Instalar como aplicativo**: o QualiLab ganhou manifesto e ícone próprios. No Chrome/Edge,
  use "Instalar QualiLab" na barra de endereço: ele vira uma janela própria, com ícone no menu
  iniciar/dock.
- **Abre offline**: depois da primeira visita, digitar o endereço sem internet abre o app
  normalmente (antes dava a página de erro do navegador). As bibliotecas de PDF/OCR/planilha
  também ficam guardadas depois do primeiro uso. Quando uma versão nova estiver disponível, a
  barra de status avisa e um clique atualiza.
- **Instalado, o duplo clique num `.qualilab` abre no QualiLab** (Chrome/Edge, com o app
  instalado), como um .docx abre no Word.
- **Os dados do rascunho ficaram mais seguros**: o app agora pede ao navegador armazenamento
  **persistente** para projetos locais com conteúdo (sem isso, o navegador pode limpar os dados
  sob pressão de disco, sem avisar).

### Paleta de comandos, atalhos com mapa e uma barra de status

- **Ctrl+K** abre a paleta de comandos: digite parte do nome de um documento, de uma tela ou de
  uma ação (baixar .qualilab, pesquisar em tudo) e vá direto. Num corpus de 100+ documentos, é
  mais rápido que qualquer menu.
- **?** mostra o mapa de atalhos de teclado — eles existiam (Ctrl+Z, Delete, setas nas árvores)
  e não havia onde descobri-los.
- **Barra de status** no rodapé: o "✓ salvo", a fila de envio da nuvem, o uso do armazenamento
  do rascunho e a versão saíram do cabeçalho para um rodapé fino, sempre no mesmo lugar. O
  cabeçalho ficou só com o que é navegação e identidade.
- Apagar um grifo agora mostra um aviso discreto com **desfazer** (8 segundos), em vez de exigir
  atenção a mais um diálogo.

### Cabeçalho reorganizado e dois nomes melhores

- As telas do cabeçalho estão **agrupadas por assunto** (codificar · ler e organizar · analisar ·
  publicar), com divisórias finas; a aba ativa é marcada por um sublinhado, não mais por um
  bloco cheio.
- **"Codificar Automaticamente" agora se chama "Auto-codificação"**, e **"MCP/RAG" agora se
  chama "Explorar com IA"**. As telas são as mesmas; só os nomes mudaram (o antigo era o rótulo
  mais comprido da barra, e MCP/RAG é sigla de infraestrutura que não dizia nada a quem chega).
- O **tema ganhou o modo "automático"** (segue o claro/escuro do sistema) e é o padrão para quem
  nunca escolheu; o botão alterna automático → claro → escuro.
- Clicar no logotipo não abre mais o GitHub numa aba nova (o link segue no rodapé da tela de
  entrada).

### Primeiros passos mais fáceis

- **Corpus de exemplo em um clique**: num projeto sem documentos, o botão "experimentar com um
  corpus de exemplo" carrega um projeto sintético pequeno para você ver grifos, gráficos e
  relatório funcionando antes de trazer o seu material.
- Um card discreto de **primeiros passos** (enviar documento → criar código → grifar) risca os
  itens conforme você avança e some quando termina (ou no ✕, para sempre).
- As telas vazias passaram a dizer **o que fazer** para deixarem de estar vazias, e as telas que
  cruzam o projeto inteiro mostram um "carregando" de verdade em vez de parecerem vazias
  enquanto a nuvem responde.
- A pílula do projeto ganhou, no hub, um card **"Onde ficam os dados deste projeto"**, com a
  resposta honesta por modo (arquivo, nuvem, rascunho).

### Leitura e aparência

- **Largura de leitura** virou o padrão do leitor (coluna de ~65 caracteres, a regra tipográfica
  clássica); o botão de largura devolve a coluna cheia, e a sua preferência salva continua
  valendo.
- Hifenização automática em português no leitor; a troca de tema do leitor ficou suave.
- **Gráficos**: opção "**texturas nas barras**" (hachuras) para distinguir cores parecidas —
  útil para daltonismo, e sai junto no SVG/PNG exportado. Contagens grandes agora usam ponto de
  milhar (2.332). A **nuvem de palavras** passou a usar a serifada do leitor.
- Impressão do Relatório com margens de página e um rodapé com projeto, versão e data.
- Ícones do cromo (tema, busca, ações do documento) viraram desenhos de traço únicos, iguais em
  qualquer sistema — antes eram caracteres de texto, que cada sistema desenha de um jeito.
- Tamanhos de letra, cantos e sombras foram postos numa escala única; os textos da interface
  respeitam o tamanho de fonte configurado no navegador; e os menores textos subiram para um
  piso legível.

## 1.4.37 (23/08/2026)

### Lista de documentos embaralhada em projeto da nuvem que veio de importação

- **O que acontecia.** Num projeto da **nuvem** criado por importação em lote (abrir um
  `.qualilab`, "enviar para a nuvem", importar `.qdpx`, planilha ou Taguette), a lista de
  documentos saía numa ordem que não era nem a de importação nem a alfabética. Aparecia com
  mais força na **Reconciliação ▸ Categorias ▸ "(Todos os documentos)"**, que percorre o corpus
  inteiro: com 80 documentos a lista podia começar no meio, e achar um exigia rolar tudo. Não
  havia erro na tela, e o problema não aparecia em projeto montado documento a documento — só
  nos importados.
- **Por quê.** Ao importar, o servidor grava os documentos em blocos, e todos os do mesmo bloco
  ficam com exatamente o mesmo horário de criação. Como a lista era ordenada por esse horário,
  os empatados saíam em ordem imprevisível — e ela podia até mudar de uma abertura para outra.
- **O que mudou.** Os dois modos "(Todos os documentos)" da Reconciliação (Categorias e Códigos)
  passaram a listar em **ordem alfabética**, com números lidos como número (`turno 2` antes de
  `turno 10`) — a mesma regra que a lista de documentos da tela de Leitura já usava. A ordem que
  vem do servidor também ficou estável, então a mesma tela não muda de ordem sozinha.
- **O que ainda não mudou.** Na nuvem, a opção **"ordem de importação"** do seletor da lista de
  documentos continua sem conseguir reproduzir a ordem original do arquivo importado, pelo mesmo
  motivo acima. Ordenar por nome funciona normalmente.

### Grifo sobreposto podia mudar de cor sozinho (nuvem)

- **O que acontecia.** Quando dois códigos marcam o mesmo trecho, o leitor pinta o trecho com a
  cor de um deles. Na nuvem, a lista de trechos de um documento chegava sem ordem definida, e a
  cor escolhida dependia dessa ordem — então o mesmo trecho podia aparecer com uma cor hoje e
  com a outra ao reabrir o documento, sem nada ter mudado no projeto. (Trecho censurado nunca foi
  afetado: ele tem prioridade sobre os demais.)
- **O que mudou.** Os trechos passam a chegar sempre na mesma ordem, então a cor de um trecho
  sobreposto fica estável. A lista de trechos que aparece ao transformar um código em família
  também deixou de mudar de ordem a cada vez que o diálogo é aberto.

### Não dava para responder as categorias vendo o trabalho de todos

- **O que acontecia.** Na Codificação de um projeto coletivo, o filtro **"Ver:"** começa em
  **"Individuais (todos)"**. Nesse estado os códigos funcionam normalmente — você vê os grifos de
  toda a equipe e continua marcando os seus. As **categorias**, na mesma tela e no mesmo filtro,
  ficavam bloqueadas: os botões de valor apareciam e não respondiam ao clique. Como esse é o
  filtro em que a tela abre, na prática era impossível preencher atributo nenhum sem descobrir
  sozinho que era preciso trocar o filtro para "Minhas". O aviso que explicava isso ficava no
  alto do painel e saía de vista assim que você rolava até uma categoria com descrição longa.
- **O que mudou.** Em "Individuais (todos)" o campo passou a ser **seu**: mostra e edita a sua
  resposta, como em "Minhas". Logo abaixo dele aparecem, **apenas para leitura**, as respostas
  dos outros pesquisadores e o gabarito, quando existirem — assim o filtro que promete mostrar
  o trabalho de todos passa a mostrá-lo também nas categorias, e não só nos grifos.
- **O que continua igual, de propósito.** Ver **"Final / gabarito"** ou a resposta de **outro
  pesquisador** segue somente leitura. O motivo é que o app grava sempre no seu nome: editar ali
  mudaria a **sua** resposta enquanto a tela mostra a de outra pessoa. O gabarito continua sendo
  consolidado na Reconciliação.

### A nota do trecho aparece ao passar o mouse, e a busca volta a destacar onde você está

- **Nota ao passar o mouse.** A nota analítica de um trecho só era alcançável por clique (pelo
  menu do botão direito, ou pelo ● na Leitura ▸ Trechos), então quem estava lendo não tinha como
  saber que ela existia. Agora ela aparece na etiqueta que surge ao passar o mouse sobre o
  trecho, abaixo do código e do autor a que pertence. Notas longas são encurtadas.
- **A etiqueta ficou legível.** Ela juntava todas as codificações do trecho numa linha só, o que
  com três códigos de nome longo já saia ilegível. Agora é uma linha por codificação. Quando a
  codificação não tem autor registrado, aparece "sem autor" em vez de um campo vazio.
- **Busca do leitor.** A ocorrência em que você está voltou a ficar destacada. A busca achava e
  navegava normalmente, mas todas as ocorrências ficavam com a mesma aparência, então não dava
  para ver em qual delas você estava.

### Clicar num gráfico abria a Leitura na aba errada

- **O que acontecia.** Nos **Gráficos**, clicar numa barra ou numa célula (Frequência, Cobertura,
  Co-ocorrência e Código × atributo) leva à Leitura para mostrar os trechos daquele código. Ela
  abria na sub-aba **Documentos**, que mostra o documento inteiro — e o código em que você clicou
  simplesmente não aparecia. Era preciso trocar de sub-aba à mão, sem nada indicar isso.
- **O que mudou.** O clique passa a abrir direto na sub-aba **Trechos**, com o código (e, na
  co-ocorrência, o par) já selecionados, e o filtro de categorias do gráfico continua viajando
  junto.

### Clicar num trecho da Leitura abria o documento errado

- **O que acontecia.** Na **Leitura ▸ Trechos**, clicar num trecho deveria abrir a Codificação
  naquele documento, rolando até o trecho. Em vez disso abria o documento que **já estava
  aberto**, e o trecho nunca era alcançado. O mesmo valia para o botão **"codificar →"** da
  Leitura ▸ Documentos e para o salto da **busca global**: sempre que a navegação precisava
  trocar de tela **e** de documento ao mesmo tempo, o documento não trocava.
- **Por quê.** O endereço da página (o que aparece depois do `#`) guarda a tela e o documento.
  Ao trocar de tela, o app gravava nesse endereço o documento **anterior**, e em seguida lia o
  próprio endereço de volta — desfazendo a troca que o clique tinha acabado de fazer.
- **O que mudou.** A troca de tela e de documento passou a ser gravada de uma vez só, e o app
  deixou de tratar como ordem sua a mudança de endereço que ele mesmo acabou de fazer. Continuam
  funcionando normalmente o botão **voltar** do navegador e abrir um link colado.

## 1.4.36 (22/08/2026)

### Reconciliação de categorias: a mesma resposta deixou de aparecer como divergência

- **O que acontecia.** Numa categoria do tipo **Caixa de Seleção**, o app guarda os valores
  marcados num campo só, na ordem em que você clicou. A Reconciliação comparava esse campo como
  texto puro, então `T1 | T3` e `T3 | T1` — a **mesma** resposta — apareciam como respostas
  diferentes. Ninguém via erro nenhum: parecia divergência legítima entre codificadores,
  justamente na categoria de múltipla marcação, que é onde comparar equipe mais importa.
- **O que mudou.** A comparação passou a ser por conjunto de valores marcados: a ordem não conta
  mais. Isso vale também para o que já estava gravado — arquivos antigos e projetos vindos de
  outra ferramenta. E as respostas novas passam a ser gravadas sempre na ordem da lista de
  opções, para a tela mostrar sempre a mesma coisa.

### A Reconciliação passou a dizer se os codificadores concordam ENTRE SI

- **O que acontecia.** A única pergunta que a tela sabia fazer era "esta resposta é igual ao
  gabarito?". Num projeto recém-importado, em que ninguém consolidou gabarito ainda, isso pintava
  **todo mundo de ✗ vermelho** — a tela acusava desacordo onde não havia nada com o que comparar.
- **O que mudou.** Enquanto não há gabarito, cada categoria (e cada documento, no modo "todos os
  documentos") diz se os codificadores **concordam** ou **divergem** entre si, e com quantos
  valores distintos. O marcador de cada resposta fica neutro (·) em vez de vermelho. Resposta em
  branco não conta como divergência: não responder não é discordar.

### Quem só responde categorias agora aparece no "Ver:"

- A lista de codificadores saía apenas das codificações de trecho, então um pesquisador que
  preenche atributos do documento sem grifar nada simplesmente não existia para o app: não
  aparecia no seletor "Ver:" nem era nomeado na Reconciliação.

## 1.4.35 (22/08/2026)

### Correção de segurança: abrir um `.qualilab` de terceiro não expõe mais a sua sessão

- **O que acontecia.** Cada trecho codificado tem um identificador interno. Ao montar o
  **Relatório ▸ Interativo ATI**, o app colava esse identificador dentro da página que ele gera
  sem tratá-lo como texto. Num arquivo preparado de má-fé, esse campo podia trazer instruções em
  vez de um identificador — e elas passavam a rodar dentro da prévia, com os mesmos poderes da aba
  do QualiLab: alcance à **sua chave de IA** guardada no navegador e à **sua sessão da nuvem**. A
  mesma página é a que o botão "Exportar HTML" entrega, então o arquivo hostil também fabricava um
  relatório hostil para quem o recebesse.

- **A quem isso alcançava.** Só a quem abrisse um `.qualilab` recebido de outra pessoa **e**
  entrasse na aba Relatório. Arquivo produzido pelo próprio QualiLab nunca teve esse conteúdo, e
  nada no seu projeto foi alterado por esta correção.

- **O que mudou, e são duas barreiras independentes.** O identificador passou a ser tratado como
  texto, então a instrução nunca chega a existir na página — e é essa metade que protege também o
  **HTML exportado**, que roda fora do QualiLab e onde não há mais nada a socorrer. Além dela, a
  prévia do relatório passou a rodar **isolada** da página do app: o clique no grifo e o filtro da
  legenda continuam funcionando, mas sem alcance ao que está fora dela.

- **Se você abriu arquivos de origem desconhecida**, vale trocar a chave de IA em *Minha Conta* —
  era a informação sensível ao alcance. A recomendação é de prudência: não há indício de que isso
  tenha ocorrido.

- Achado numa inspeção de segurança do código, e preso por um teste que reproduz o ataque e
  confirma que ele falha.

## 1.4.34 (19/08/2026)

### Na Reconciliação, agora dá para dizer "concordo", e não só "aceito no gabarito"

- **Concordo com este código.** Cada grupo da aba Códigos ganhou um botão que registra que **você**
  também aplicaria aquele código àquele trecho. Ele cria uma codificação sua na sua camada
  individual e **não** encosta no gabarito. Até agora a tela só oferecia consolidar no gabarito, que
  é ato de **administrador**: para quem apenas codifica, a Reconciliação era uma tela de leitura com
  um botão que o servidor recusava. O placar do grupo sobe na hora ("2 de 3" vira "3 de 3 ·
  consenso"), e um **desfazer** ao lado remove a concordância.

- **Concordar não se confunde com codificar.** A codificação criada pelo botão fica marcada como
  concordância, porque concordar aqui é decidir **vendo a resposta dos outros** — útil para fechar a
  reconciliação, mas não é a mesma evidência que duas pessoas chegando ao mesmo trecho de forma
  independente. É essa distinção que faz o **desfazer** apagar só a concordância e nunca o trabalho
  que você fez lendo o documento: se o trecho já tem uma codificação sua, o card diz "codificação
  sua" e não oferece o botão.

- **Codificação sugerida por IA passou a ficar registrada como tal.** Quando você aprova uma
  sugestão em "Sugerir Codificação", a linha guardada agora diz que nasceu de uma sugestão de
  modelo. Antes ela ficava idêntica a uma codificação feita à mão, e a informação existia só na
  conversa salva. Nada muda no que você vê ou faz; muda o que o seu projeto consegue dizer sobre si
  mesmo depois. A aba "Repetir Codificação" **não** entra nessa conta, porque não passa por modelo
  nenhum: ela procura ocorrências idênticas de um texto.

- Essa marca **viaja no `.qualilab`** (exportar e reimportar preserva) e, na nuvem, **não pode ser
  reescrita** depois que a linha é criada.

### Codificar trechos direto de uma planilha

Quem organiza o material numa planilha — uma linha por documento (uma lei, um acórdão, uma
entrevista) e uma coluna por tema, com o excerto copiado na célula — agora traz isso para dentro do
QualiLab de uma vez, em **importar ▾ → planilha (.csv / .xlsx → codificar trechos)**. É o terceiro
caminho de planilha, e o único que **codifica**: o primeiro cria documentos, o segundo preenche
categorias, este marca trechos.

Cada linha aponta um documento que **já existe** (casado pelo nome, como o de categorias), e cada
coluna que você marcar com um código vira um trecho **localizado dentro do texto daquele documento**
e codificado ali. Não é preciso reformatar a planilha para "uma linha por trecho".

- **O trecho é procurado no texto e ancorado no lugar certo** — não entra como citação solta. É o
  mesmo mecanismo de localização que já traz os trechos de um `.qdpx` e o que a IA sugere, com a
  mesma tolerância a hifenização e a OCR imperfeito.
- **Trecho que não bate com o texto fica de fora e é listado**, com a linha e a coluna: um resumo
  escrito por você em vez da citação literal, ou um erro de digitação, não é chutado para um lugar
  aproximado. O resto da planilha entra normalmente.
- **A tela mostra o que vai acontecer antes de gravar**: quantas linhas casaram um documento,
  quantos trechos serão codificados, quais códigos serão criados e quais linhas não encontraram
  documento nenhum.
- **Coluna sem código correspondente pode criar um código novo**, usando o título da coluna como
  nome.
- **Reimportar a mesma planilha não duplica.** Um trecho que já está codificado com aquele código
  naquele lugar é reconhecido e pulado — então dá para acrescentar linhas e importar de novo.
- Em projeto **coletivo**, você escolhe se está gravando no **gabarito da equipe** (administrador)
  ou na **sua camada**.

O passo a passo está no [manual](https://luizpf42.github.io/QualiLab/manual.html).

> **Precisa fazer alguma coisa?** Se você usa a nuvem do QualiLab (o modo padrão), **não**: a
> atualização do banco já foi aplicada. Se você aponta o app para um **Supabase próprio**, rode o
> `supabase/schema.sql` deste repositório novamente no SQL Editor do seu projeto — ele é
> idempotente, rodar de novo não causa efeito colateral. Em rascunho e em arquivo `.qualilab` não há
> banco nenhum, e nada muda.

## 1.4.33 (17/08/2026)

**Os atributos dos seus documentos deixaram de sumir na importação de `.qdpx`.**

- **Atributo gravado no próprio documento agora é lido.** O formato REFI-QDA aceita que o valor de
  um atributo (tipo, ano, tribunal, situação) fique em **dois lugares** do arquivo: colado no
  documento, ou dentro de um "caso" que aponta para ele. O QualiLab só lia o segundo — e é o
  primeiro que o **QualCoder** usa. Quem importava de lá via os nomes dos seus atributos
  aparecerem na tela de categorias e **todos os campos em branco**, sem nenhum aviso de que os
  valores estavam no arquivo. Agora as duas formas entram, inclusive em documentos PDF.

- **Categoria que chega vazia é dita no resumo da importação, pelo nome.** Se o arquivo declara um
  atributo e nenhum documento recebe valor, a mensagem ao fim da importação nomeia a categoria e
  sugere conferir na ferramenta de origem. Pode ser normal — você pode ter criado o atributo e
  nunca o preenchido —, mas antes esse caso era **silencioso**, e era assim que uma perda de dados
  passava por importação bem-sucedida.

- **Quando os dois lugares discordam, vale o que está no documento.** O valor colado no documento
  fala dele; o do "caso" fala de um agrupamento que pode reunir vários documentos. Antes vencia,
  sem critério nenhum, o que o arquivo listasse por último.

## 1.4.32 (16/08/2026)

### Você decide se o seu projeto usa IA, e isso passa a ser dito no relatório

**Todo projeto novo pergunta, e nasce sem IA.** Ao criar um projeto — na nuvem, em arquivo ou como
rascunho — o QualiLab pergunta se os recursos de IA devem ficar disponíveis. Nenhuma opção vem
marcada, e a resposta padrão é não ativar. Dá para mudar quando quiser, em **Projeto → Recursos de
IA**, ou clicando no selo que fica no cabeçalho, entre a pílula do projeto e o seu nome.

São três escolhas, e a do meio existe para pesquisa coletiva: **Ativados** (todo mundo), **Só para
administradores** (os pesquisadores não têm as telas de IA; a coordenação continua com elas) e
**Desativados** (ninguém, você inclusive).

Com a IA desativada, as telas de IA somem, junto com a configuração que só serve a elas (o Memo
para a IA e os Prompts salvos). O que **fica** é o registro do que já houve: as conversas salvas e
a memória do projeto continuam onde estavam. Conversa de IA também não entra num projeto que a
desativou, nem por importação — o resumo diz quantas ficaram de fora, e por quê.

**A decisão acompanha o projeto.** Ela vai dentro do `.qualilab`: salvar como arquivo, reabrir
depois ou enviar para a nuvem preserva o que você escolheu. Importar material de um projeto sem IA
para dentro de um projeto com IA ativa **não** muda a sua configuração, mas o resumo avisa que
aquele material vinha de um projeto assim.

**Nova declaração no Relatório**, ligada por padrão, na caixa *"incluir informações sobre uso de
IA"* (ao lado da de revisão cega). Ela sai nas três saídas — Relatório Padrão, Relatório Interativo
e Web Annotation — e diz **o que o projeto registra**, nunca uma promessa: se os recursos
estiveram disponíveis, e quantas conversas e memórias existem. Um projeto que ativou a IA e nunca
a usou não é descrito como tendo usado; um que nunca ativou diz exatamente isso, sem data.

> **O que isto não é, e está escrito na tela também:** não é um bloqueio técnico. Qualquer pessoa
> pode copiar um trecho para outra ferramenta, e o QualiLab não tem como impedir. O que muda é que
> o trabalho **em massa** deixa de caber dentro do aplicativo — e é o volume que desloca a
> concordância entre codificadores, não uma consulta avulsa. Quem desativa a IA não deve ler
> "100% manual" como prova de coisa alguma.

### Nova tela: MCP/RAG, em que a IA busca o material sozinha (experimental)

Nas outras telas de IA **você monta o recorte** antes de perguntar: escolhe documentos, códigos,
escopo, e a IA recebe aquilo pronto. Nesta é o contrário — você pergunta, e a IA **procura o
material**, pedindo o que precisa por meio de ferramentas de leitura (ler um documento, buscar um
termo, listar os trechos de um código, ver os memos). **Cada pedido aparece na tela**, com a
ferramenta, os argumentos e um resumo do que voltou.

Isso muda o tipo de pergunta que cabe: dá para perguntar sobre o corpus inteiro sem saber de
antemão onde está a resposta. *"Que documentos falam de prazo, e como o tema aparece em cada um?"*

Todas as ferramentas são de **leitura**: nenhuma cria, altera ou apaga nada. A censura vale como
em todo lugar, e a tela mostra o que de fato foi pedido — se a resposta afirmar algo que nenhuma
leitura sustenta, a lista de chamadas denuncia. Precisa da sua chave, e consome mais que as outras
telas, porque cada pergunta vira várias idas ao provedor.

> **Ela é experimental, e o app diz isso nela.** Funciona e não altera nada, mas é a superfície
> mais nova do QualiLab: o formato das respostas e o conjunto de ferramentas ainda podem mudar
> entre versões. Não a use como o único registro de uma análise — o que quiser guardar, guarde em
> memo ou no relatório. Está documentada na seção 17.6 do manual.

## 1.4.31 (16/08/2026)

### O editor de categorias agora tem um "Salvar" — e não grava mais sozinho

**Leia esta seção antes de editar uma categoria.** O cartão onde você define uma categoria (nome,
tipo, descrição, valores) não tinha nenhum botão: o **nome** e a **descrição** eram gravados a
cada tecla digitada. Não havia como saber se tinha salvado, e um esbarrão no campo já mudava o
esquema do projeto — sendo que a descrição é a instrução de codificação que a sua equipe segue e
que entra no prompt das telas de IA.

Esses dois campos passaram a ser um **rascunho**: só vão para o projeto quando você clicar em
**Salvar**, no canto inferior do cartão. Enquanto houver algo por salvar, o botão fica em
destaque e aparece um **descartar** ao lado, que devolve os campos ao que está gravado; sem nada
pendente, ele mostra **"Salvo ✓"**.

O que você escreveu não se perde ao trocar de tela e voltar. E quando o painel "Gerenciar esquema
de categorias" está recolhido, um aviso no título dele diz que há alteração não salva. O resto do
cartão — o tipo, os valores, as caixas "Não informado" e "Outros" — continua valendo na hora,
porque são cliques que você desfaz clicando de novo.

### O cartão de categoria ficou legível no painel lateral

Na aba **Codificação**, dentro de "Gerenciar esquema de categorias", o campo do **nome** dividia a
linha com o seletor de tipo e sobrava para ele menos de um terço da largura: cabiam poucas letras
e o nome da categoria ficava cortado. Agora, quando o painel é estreito, o nome ocupa a linha
inteira e o tipo desce para a linha seguinte. Na tela larga nada muda.

### Os botões de salvar ganharam cor

Em vários lugares o botão que **grava** o que você acabou de escrever tinha a mesma aparência dos
botões comuns ao lado. Ganharam destaque: **Salvar** o nome de um código (no painel de cores),
**Salvar** o nome de exibição e o nome de um projeto em *Minha conta*, e **Renomear** o projeto no
painel do projeto.

### Saiu a opção de cor "cinza" dos códigos

A cor de uma família de código podia ser **cinza**, e quase ninguém usava — além de disputar a
leitura com o **preto**, que marca censura. O botão saiu; continuam o anel de matiz, a saturação,
o preto e a "cor automática". **Códigos que já estavam em cinza continuam cinza**: para trocar,
use "cor automática" e depois escolha a cor que quiser.

## 1.4.30 (16/08/2026)

Esta versão corrige três defeitos da importação de `.qdpx` do **ATLAS.ti**. Como na 1.4.28, os
três eram silenciosos: o material entrava, nada dava erro, e o resultado parecia uma propriedade
da sua pesquisa.

### Trechos do ATLAS.ti chegavam cortados no meio da palavra

Parte dos trechos entrava com o texto interrompido depois de 70 caracteres, muitas vezes no meio
de uma palavra. Eles não pareciam defeituosos: a citação estava lá, só que pela metade — e, ao
contrário de um trecho que o QualiLab não conseguiu localizar, esses não recebiam marca nenhuma.

O texto completo estava dentro do arquivo o tempo todo. O ATLAS.ti guarda a citação de duas
formas, e o QualiLab estava lendo o **rótulo de prévia**, que é curto por natureza, em vez da
citação. Num projeto real de 119 documentos, os trechos afetados ganharam em média **474
caracteres** a mais.

Quando o arquivo de origem realmente não traz a citação inteira — o que acontece com marcações
feitas por retângulo sobre a página —, o trecho continua entrando pelo rótulo curto, mas o resumo
da importação passa a **avisar**, dizendo quantos são e em quantos caracteres o programa de
origem cortou. Antes eles passavam calados.

### As notas do ATLAS.ti agora ficam no código que elas explicam

O ATLAS.ti registra quais notas explicam quais códigos. Essa ligação era ignorada, e todas as
notas chegavam empilhadas num **único memo do projeto** — num caso real, 24 notas somando 28 mil
caracteres num texto só, que ninguém lê. Agora cada uma vai para o memo do código a que o arquivo
a amarra, que é onde você procura quando a dúvida aparece. Notas sem dono continuam no memo do
projeto.

Quando a mesma nota explica mais de um código, ela é **copiada** em todos eles, com uma linha
dizendo com quais outros ela é compartilhada.

### O resumo da importação contava memos que o projeto não recebia

A mensagem ao fim da importação anunciava mais memos do que de fato entravam — num caso real, 159
anunciados contra 94 no projeto —, porque contava antes de descartar as repetições. Agora o número
é o que você encontra no projeto.

E quando um trecho não pode ser localizado no texto, a **nota analítica** dele cai junto. Isso
sempre aconteceu, mas em silêncio; o resumo agora diz quantas notas foram nesse mesmo saco.

**Se você importou um `.qdpx` do ATLAS.ti antes desta versão, refaça a importação — inclusive se
já refez por causa da 1.4.28.** As citações completas e as notas nos códigos só chegam numa
importação nova. E, como importar **acrescenta** ao que já existe, não repita a importação por
cima do projeto atual: crie um projeto novo, ou use "Limpar conteúdo" no painel do projeto antes.
O seu `.qdpx` está intacto — o problema sempre foi a leitura, nunca o arquivo.

## 1.4.29 (16/08/2026)

### As fontes do QualiLab nunca carregaram — agora carregam, e sem chamar ninguém

A folha de estilo pedia três fontes ao Google (Newsreader para a leitura, Inter para a interface,
JetBrains Mono para os números), e essa linha estava numa posição em que o navegador simplesmente
a ignora. Resultado: desde a primeira versão o app rodava com as fontes de reserva do seu sistema,
sem nada avisar. Se a sua tela parecia certa, é porque o seu computador já tinha alguma delas
instalada.

Agora as três **viajam dentro do arquivo**. Duas consequências, e a segunda é a que importa:

- o texto passa a ser exibido na tipografia que a ferramenta escolheu, em qualquer computador —
  o leitor, em especial, deixa de cair no Georgia;
- o QualiLab **não pede nada ao Google**, nem a nenhum outro servidor, para se desenhar. Pôr a
  linha "no lugar certo" teria custado três requisições a cada abertura, entregando o seu IP —
  inclusive no modo arquivo, onde a promessa é que nada saia da sua máquina. Ele continua abrindo
  sem falar com ninguém.

O arquivo ficou cerca de 190 KB maior por causa disso. Os ícones da interface continuam vindo do
sistema, como antes.

### O custo estimado da IA em "Definir Categoria" era muito menor que o real

O número de tokens e o custo mostrados no ⚙ Configurar Prompt contavam **só a última chamada** da
rodada. Antes dela, a tela dispara uma chamada por caso de treino, e cada uma leva o **documento
inteiro** — que é justamente o que domina o gasto. Com doze casos e documentos de 20 mil
caracteres, o valor anunciado era cerca de 85 vezes menor que o cobrado; com acórdãos longos, mais
de 300.

O que mudou:

- a estimativa agora soma **todas** as chamadas da rodada, e a nota ao lado diz quantas são e por
  que a localização é a parte cara. A barra continua medindo a maior chamada — é ela que decide se
  o material vai ser cortado —, e isso passou a estar escrito;
- o **teste nos documentos guardados**, que é outro clique e outra rodada de chamadas, ganhou
  estimativa própria: até aqui ele não aparecia em número nenhum;
- a mesma correção conserta a **avaliação cega** da aba Sugerir Categorização, cuja estimativa
  parava de crescer depois de certo tamanho de corpus.

Nenhuma tela ficou mais cara: o que mudou é o que se anuncia antes de gastar.

### Reimportar o mesmo projeto não empilha mais as conversas e as memórias de IA

Trocar o corpus de um projeto ("Limpar conteúdo" e importar de novo) duplicava as conversas salvas
e o diário de insights a cada vez — três importações, três cópias de cada. Documentos, códigos e
trechos nunca tiveram esse problema; essas duas coleções são as únicas que sobrevivem de propósito
ao "Limpar conteúdo", para que o conhecimento do estudo não morra junto com o corpus antigo.

Agora o que já está no projeto não entra de novo, e o resumo da importação diz quantas conversas e
memórias foram reconhecidas como repetidas — em vez de anunciar como gravado o que veio no
arquivo.

## 1.4.28 (14/08/2026)

Esta versão corrige quatro defeitos de importação e devolve o PDF original. Os quatro tinham a
mesma característica: **nenhum deles dava erro**. O material entrava, a tela mostrava números, e
o resultado parecia uma propriedade da sua pesquisa. Se você importou de alguma dessas
ferramentas, vale ler a seção correspondente até o fim — algumas pedem uma reimportação.

### Importação do ATLAS.ti: cada trecho entrava duas vezes, e uma das cópias vinha cortada

Quem importava um `.qdpx` do ATLAS.ti com documentos em PDF recebia o projeto **dobrado**. Cada
trecho codificado aparecia duas vezes: uma com a citação inteira e outra com o texto cortado no
meio de uma palavra. Na tela isso aparecia como um par quase idêntico, e a *Reconciliação* pedia
para escolher entre duas versões do mesmo trecho, como se dois codificadores tivessem discordado.

A causa está no arquivo, não no seu trabalho: o ATLAS.ti descreve cada citação de PDF duas vezes,
uma pela posição na página e outra pela posição no texto, e o QualiLab estava importando as duas
como se fossem trechos diferentes. A cópia extra saía cortada porque o rótulo curto que o
ATLAS.ti guarda ali tem no máximo 70 caracteres, e era dele que o texto estava sendo tirado.

Num projeto real de 119 documentos, o mesmo arquivo produzia **9.563 trechos; agora produz
4.971** — quase o dobro do que havia. Como a codificação é o que alimenta os *Gráficos*,
frequência, cobertura, nuvem de palavras e a matriz de co-ocorrência estavam todas medindo esse
excesso.

Agora cada citação entra uma vez, com o texto inteiro, e o fim da importação diz quantas vinham
descritas duas vezes no arquivo.

**Se você importou um `.qdpx` do ATLAS.ti antes desta versão, refaça a importação — mas não por
cima do projeto atual.** Importar **acrescenta** ao que já existe, então repetir a importação no
mesmo projeto somaria uma terceira cópia em vez de consertar. Crie um projeto novo e importe
nele, ou use "Limpar conteúdo" no painel do projeto antes de importar de novo. O seu `.qdpx`
está intacto: nada se perdeu nele, o problema era só a leitura.

### Importação do Taguette: o texto vinha com marcação e os grifos caíam no lugar errado

Quem importava um projeto do Taguette (`.sqlite3`) recebia duas coisas quebradas, e nenhuma delas
avisava nada.

O documento chegava com o código HTML à mostra — o leitor exibia `<p><b>CÂMARA DOS
DEPUTADOS</b></p>` no lugar do texto. E **todos os trechos codificados ficavam ancorados fora do
lugar**: o Taguette conta a posição dos grifos de um jeito diferente do QualiLab, e essa
diferença não era traduzida. O desvio não era de um caractere: ele cresce ao longo do documento,
então o trecho aparecia grifado a parágrafos de distância de onde deveria. Num projeto real de 45
documentos, nenhum dos 278 trechos estava no lugar certo.

Agora o texto entra limpo e cada trecho ancora onde você o marcou no Taguette. A mensagem do fim
da importação também passou a dizer o que não coube: grifos que estavam sem nenhuma tag (no
QualiLab todo trecho precisa de um código) e trechos cujo texto não confere com o documento.

Se importou antes desta versão, **reimporte** (num projeto novo, ou depois de "Limpar
conteúdo"): a codificação antiga está deslocada, e hoje não existe uma migração que a reancore no
lugar certo.

### Importação do Zotero: referências duplicadas trocavam de PDF

Se a sua biblioteca do Zotero tinha duas entradas para a mesma referência — algo comum, e por
isso o próprio Zotero tem a ferramenta "Itens duplicados" —, uma delas era importada com **o
texto do outro artigo**, embaixo do título, da referência e do memo corretos. Nada avisava.

Agora cada referência entra com o PDF dela. Se você importou do Zotero antes desta versão e a sua
coleção tinha duplicatas, vale conferir esses documentos: o texto pode não ser o da referência
que está no memo.

### Trechos do ATLAS.ti que iam parar em outra página

Quando o mesmo texto aparece mais de uma vez num documento — comum em projeto de lei, com o texto
da ementa repetido no corpo do artigo —, o QualiLab colocava o trecho na **primeira** ocorrência,
mesmo que o ATLAS.ti dissesse que ele estava em outra página.

O trecho continuava com o texto certo, o código certo e a nota certa: só ficava no lugar errado do
documento. É o tipo de erro que não se percebe lendo o trecho, e que só aparece ao voltar ao
documento para ver o contexto — que é justamente o que se faz ao escrever.

Num projeto real de 2.658 citações, **17 estavam em outra página**, espalhadas por 15 dos 119
documentos. Em um deles, a expressão "terrorismo ambiental" foi para a página 1 enquanto o
ATLAS.ti a marca na página 2 — e ela aparece seis vezes naquele documento.

O ATLAS.ti sempre disse em que página cada trecho está; o QualiLab é que não usava essa
informação. Agora usa: a busca começa pela página indicada e só depois olha o resto do documento.

O fim da importação também passou a contar as **citações que estavam sem nenhum código**. No
ATLAS.ti é legítimo marcar um trecho e classificá-lo depois; aqui todo trecho precisa de um
código, então essas não entram — e antes sumiam sem aparecer em lugar nenhum. No projeto real
eram 213, 8% das marcações.

### O PDF original agora fica ao importar um `.qdpx`

Um `.qdpx` traz os PDFs dentro dele, e o QualiLab estava jogando fora todos. O texto entrava e o
documento original desaparecia — em um projeto real, nos 119 documentos.

Com isso, três coisas simplesmente não funcionavam em nada que tivesse vindo de um `.qdpx`:

- **🗎 ver original**, para conferir o trecho na página como ela é
- **o número da página** ("p. 12") nos trechos da *Leitura*, no *Relatório*, na coluna do CSV e
  na exportação de anotações
- **⋯ → ler com OCR**, justamente onde mais falta: PDF escaneado entra sem texto, e o OCR é o que
  resolve — mas ele precisa do original, que tinha sido descartado

Agora o original é guardado, junto com o índice de páginas que o QualiLab já havia calculado
durante a importação. Isso também conserta a ida e volta do próprio QualiLab: exportar um projeto
com PDFs em `.qdpx` e reimportá-lo perdia todos eles.

**Na nuvem o QualiLab pergunta antes**, uma vez por projeto, porque ali o arquivo original passa
a ser acessível ao operador do servidor e aos outros membros — é a mesma pergunta que já aparece
ao enviar um PDF pelo "＋ enviar". Em rascunho ou arquivo, o PDF não sai da sua máquina. O fim da
importação diz quantos originais foram guardados.

Quem já importou antes desta versão e quer os originais precisa reimportar, com o mesmo cuidado
das seções acima: projeto novo, ou "Limpar conteúdo" antes.

### Reconciliação: em projeto importado ela dizia que havia um codificador só

A tela de *Reconciliação* existe para comparar o trabalho de pesquisadores diferentes. Em
qualquer projeto que tenha vindo de uma importação (`.qdpx`, `.qualilab` de outra pessoa,
Taguette, `.qdc`), ela mostrava **"1 de 1" em todos os grupos**, com um nome só ao lado de cada
trecho — mesmo com cinco pesquisadores no arquivo, e a borda de consenso nunca acendia.

A informação de quem codificou o quê nunca se perdeu: ela estava gravada e aparece corretamente
em outras telas, como o filtro "Ver:". Era a *Reconciliação* que estava olhando para o campo
errado.

Agora ela conta as pessoas certas, mostra o nome de cada uma nos trechos e volta a marcar
consenso quando todos concordam. **Nenhum dado precisa ser reimportado por causa disto**: é só
abrir a tela de novo.

O botão "Consolidar tudo feito por mim" continua contando só o que foi codificado nesta conta, e
por isso segue mostrando "(0)" num projeto que veio inteiro de uma importação. Isso é de
propósito: codificação importada não é sua, ainda que traga o seu nome. Para consolidar o que
veio no arquivo, use "Consolidar tudo", que diz no aviso que vai consolidar o trabalho de todos
os codificadores.

## 1.4.27 (14/08/2026)

### O código de confirmação do cadastro é aceito com o tamanho que tiver

Ao criar uma conta, o QualiLab pede o código que chega por e-mail. Esse código é gerado pelo
servidor, e o **número de dígitos dele é uma configuração do servidor**, não do aplicativo: pode
ser seis, pode ser mais. A tela supunha que eram sempre seis, e o estrago disso era silencioso.

Com um código mais longo, o campo **descartava os números que passassem do sexto, sem avisar**.
Como o botão "Confirmar e entrar" acendia assim que o sexto número entrava, parecia que faltava
só clicar — e a mensagem de erro que vinha depois ainda mandava conferir "os 6 dígitos", ou
seja, culpava você por um código que tinha digitado certo. Quem esbarrava nisso não tinha como
terminar o cadastro. Colar o código também podia falhar: se ele viesse com espaços no meio
(`294 709 20`), o campo cortava junto com os espaços e sobravam cinco números, com o botão
desabilitado e nenhuma explicação.

Agora a tela aceita o código do e-mail **com o tamanho que ele tiver**, ignora espaços colados
junto e só habilita o botão quando o que você digitou puder ser um código. Vale nos dois lugares
que pedem o código: a tela de cadastro e o passo de confirmação dentro de *Enviar para a nuvem*.

Se você tinha um cadastro parado nesse ponto, peça um código novo e digite todos os números
dele. Nada precisa ser refeito: as contas que ficaram pendentes continuam válidas.

## 1.4.26 (14/08/2026)

### A aba "Organizar Códigos" voltou a abrir

Desde a 1.4.22, abrir *Codificar Automaticamente ▸ Organizar Códigos* num projeto que já tem
trechos codificados derrubava a tela: no lugar do painel aparecia a faixa vermelha "Algo falhou
de forma inesperada". Não havia contorno, porque a falha acontecia ao montar a aba, antes de
qualquer botão. Nada se perdeu — a aba simplesmente não abria — e as outras quatro abas de
Codificar Automaticamente nunca foram afetadas.

A causa entrou junto com a correção de censura da 1.4.22, que passou a conferir cada citação
contra o texto do documento antes de mascará-la. Nesta aba o texto do documento não chegava à
conferência. A conferência continua valendo, e a amostra de trechos que a aba envia à IA sai
como sempre: mascarada onde há censura, inteira onde não há.

## 1.4.25 (13/08/2026)

### O QDPX passou a dizer três coisas que o padrão manda dizer

Uma leitura da especificação REFI-QDA (a mesma que define o `.qdpx` e o `.qdc`) encontrou três
pontos em que o arquivo exportado estava certo, válido, e mesmo assim calado. Nenhum deles
quebrava nada aqui: o efeito aparecia **na outra ferramenta**, ou na volta.

- **Família vira pasta de verdade.** No QualiLab, código com subcódigos agrupa e não recebe
  trechos. O padrão tem exatamente esse conceito, e ele viaja num atributo que o QualiLab
  escrevia sempre igual, então todas as famílias chegavam ao ATLAS.ti, ao MAXQDA e ao QualCoder
  como códigos comuns, prontas para receber trecho. Agora saem marcadas como pasta. (Se uma
  família tiver trecho próprio, coisa que só acontece com projeto vindo de fora, ela continua
  saindo como código: marcá-la como pasta produziria um arquivo internamente contraditório, que
  algumas ferramentas recusam inteiro.)

- **A marca de censura vai e volta.** Até agora o `.qdpx` levava os trechos censurados (ele é
  formato de trabalho e sai completo, isso não mudou), mas perdia a informação de *quais códigos
  são de censura*: reimportando o arquivo aqui, o trabalho de marcação tinha que ser refeito à
  mão. A marca agora viaja num conjunto de códigos, que é o mecanismo que o padrão oferece para
  isso, e a importação a restaura e diz quantos códigos voltaram marcados. Ferramenta que não
  preserva conjunto de códigos perde a marca, nunca o trecho.

- **O memo do projeto deixa de ficar solto.** Ele já saía no pacote, mas sem nada declarando a
  quem pertencia. Agora vai ancorado no projeto.

### O aviso de perda aparece na hora de exportar

O padrão pede que o software avise no momento da exportação quando o formato não carrega tudo,
"com o máximo de detalhe possível". O aviso que existia no menu era sobre privacidade (a censura
sai em claro), não sobre perda. Agora, ao exportar um `.qdpx`, o QualiLab lista o que fica para
trás **naquele projeto**: as codificações individuais quando já existe gabarito, as respostas de
categoria preenchidas por mais de uma pessoa, e as categorias de caixa de seleção (que viram
texto único, porque o formato não tem múltipla escolha). Projeto que não tem nenhuma dessas
situações não vê aviso nenhum. O `.qualilab` continua preservando os três casos.

### Também

O README passou a declarar, como o padrão pede, a que partes dele o QualiLab reivindica
conformidade: as duas, projeto (`.qdpx`) e livro de códigos (`.qdc`).

## 1.4.24 (11/08/2026)

### Definir Categoria: "Não informado" deixa de ser tratado como resposta suspeita

No **Definir Categoria**, antes de escrever o verbete a IA faz uma passada que procura, em cada
caso de treino, o trecho do documento que sustenta a resposta que você deu. Para um documento
respondido **"Não informado"** essa pergunta não tem resposta possível: a evidência ali é
justamente a *ausência* de trecho. A IA dizia isso corretamente, e o app então listava o caso em
**"Casos sem nada no texto que sustente a resposta"**, cuja explicação sugere engano de
preenchimento, resposta vinda de fora do documento ou extração ruim do texto. Nenhuma das três
era o caso, e você aparecia errado onde tinha acertado.

Agora esses documentos não vão para a passada de localização (o que também poupa uma chamada
paga por caso) e o cartão volta a listar só o que promete: resposta afirmativa sem respaldo no
texto. Eles **continuam** no material da indução, e com um papel próprio: são os casos negativos,
os que ensinam a regra a dizer *quando* marcar "Não informado" — a fronteira entre "o documento
não traz a informação" e "eu não encontrei". Antes eles chegavam à indução rotulados como
suspeitos, e era exatamente esse critério que o verbete tendia a não escrever.

Resposta de múltipla escolha que combina "Não informado" com algum outro valor segue indo para a
localização normalmente: ali ainda há o que procurar.

## 1.4.23 (11/08/2026)

### A tela de entrada diz que a nuvem padrão é lida por quem a mantém

Sob o cartão **Entrar na nuvem** agora aparece **"Dados visíveis para o desenvolvedor"**, com link
para o repositório do projeto. Quem sobe material para a nuvem padrão do QualiLab está confiando
esse material a quem administra aquele servidor, e isso precisava estar na tela onde a escolha é
feita, não só no manual. O aviso **não** aparece quando você conectou o seu próprio Supabase: ali
a frase seria falsa.

### Erro de servidor sem mensagem deixa de virar um símbolo sem sentido

Quando o servidor recusava uma operação sem dizer por quê, a tela mostrava `{}`. Aconteceu de
verdade no cadastro: duas falhas completamente diferentes do envio de e-mail chegaram como esse
mesmo símbolo, sem indicar se o problema era da sua conta ou do servidor. Agora aparece uma frase
que diz o que se sabe, que a ação não foi concluída e a quem recorrer.

## 1.4.22 (09/08/2026)

### A censura passa a falhar fechada quando perde a âncora

Uma revisão adversarial da 1.4.21 encontrou dois caminhos em que a censura podia deixar escapar
parte do conteúdo marcado, e os dois foram fechados:

- **Censura cuja posição gravada não corresponde mais ao texto** (por exemplo, o documento mudou
  por baixo da marcação sem o remapeamento acontecer): antes a máscara era aplicada na posição
  antiga e podia deixar visível parte do trecho sensível. Agora, quando o QualiLab detecta que
  uma censura não bate mais com o texto, ele **mascara o documento inteiro** nas superfícies que
  mascaram (prompt da IA, leitor de transparência, JSON W3C) e diz por quê — é barulhento de propósito: reaplique a censura naquele documento
  para voltar ao normal. O trabalho no leitor não é afetado.
- **Citação sem âncora válida**: um trecho codificado que perdeu a posição no texto podia sair
  com a citação gravada **crua** no JSON W3C, mesmo cobrindo conteúdo censurado. Agora a
  citação sem âncora sai como rótulo de censura.

### A avaliação às cegas fica cega de verdade

O prompt do modo cego (Sugerir Categorização e o teste da definição no Definir Categoria) não
leva mais a **memória do projeto** nem os **memos injetados**: são campos livres que podem
conter respostas humanas — inclusive memórias propostas pela própria IA numa rodada que viu os
valores preenchidos. O ⚙ Configurar Prompt mostra as duas seções como omitidas, com o motivo.

### Rodada de indução malsucedida não devolve documentos ao sorteio

No Definir Categoria, os documentos de treino passam a ser registrados como "já vistos" no
momento em que são **enviados**, e não só quando a indução termina bem. Antes, uma rodada em
que o modelo recusava a ferramenta de saída (ou uma falha no fim) deixava aqueles documentos
voltarem como **guardados** da rodada seguinte — e o placar media a definição em casos que já
tinham entrado num prompt dela.

## 1.4.21 (09/08/2026)

### A definição da categoria virou um verbete, e agora cabe escrevê-lo

O campo de descrição de uma categoria era de **uma linha só**, e a quebra de linha sumia na
exibição. Agora ele é um campo que cresce, e o texto aparece como você escreveu — no painel de
atributos, no Esquema e na Reconciliação.

Não é detalhe de conforto: esse campo é a **instrução de codificação**. É o mesmo texto que o
codificador humano lê e que a IA recebe no prompt. Uma definição só governando os dois.

### Avaliação às cegas: saber se a sua definição funciona

Na aba **Sugerir Categorização** há uma caixa nova, *Avaliação às cegas*.

No modo de sempre, a IA vê as respostas que você já preencheu e devolve só as diferenças. É
ótimo para completar corpus — e não serve para medir, porque o avaliador está vendo o seu
gabarito antes de responder.

Marcando a caixa, ela recebe **só o documento**, responde todas as categorias marcadas, e a
comparação é feita depois, aqui. Você recebe um **placar de concordância** com o seu gabarito,
separado por categoria. As divergências continuam disponíveis para aprovar uma a uma, só que
agora vindas de uma segunda opinião que não estava ancorada na sua.

O placar conta apenas os pares em que **os dois** responderam: onde a IA não respondeu não vira
erro, e onde você ainda não tinha respondido não entra na conta (vira sugestão de preenchimento).
Cada documento vira uma conversa separada, para que todos sejam avaliados nas mesmas condições —
por isso este modo custa mais que o normal, e a estimativa aparece no botão *Configurar Prompt*.

### Definir Categoria: escrever a instrução a partir do que você já respondeu

Aba nova em **Codificar Automaticamente**. Se você já respondeu uma categoria em algumas dezenas
de documentos, o critério que você aplicou está nessas respostas — o que falta é escrevê-lo.

A IA lê uma amostra **equilibrada** dos documentos já respondidos (com 90 "Não" e 10 "Sim", uma
amostra ao acaso ensinaria "quase sempre Não"), procura em cada um a passagem que sustenta a sua
resposta, e propõe o texto da definição, que você edita antes de aplicar.

Junto vêm três coisas que costumam valer mais que o texto: **os casos em que a regra proposta
discordaria de você** (ou a sua codificação está inconsistente ali, ou existe um critério que
você aplica sem ter percebido), **os pontos que os seus exemplos não decidem**, e **os documentos
em que nada no texto sustentava a resposta dada**.

Um punhado de documentos fica **separado desde o início** e não é mostrado à IA. Com um clique
você testa a definição neles e vê em quantos ela reproduziu a sua resposta; um botão refaz a
proposta incluindo os casos em que errou. Testar nos mesmos documentos que escreveram a regra
não diria nada — seria dar o gabarito antes da prova.

Requer chave própria de IA (**Minha conta**). Nada é gravado sem você clicar em aplicar, e o
teste roda sobre o texto que está no campo, não sobre o que está salvo.

### O endereço acompanha a tela: link para compartilhar, e o "voltar" funciona

O endereço da página passou a registrar a **tela**, o **documento aberto** e a **sub-aba**. Dá
para copiar o link e mandar a um colega, que abre no mesmo lugar, e o botão *voltar* do navegador
faz o que se espera dele.

## 1.4.20 (07/08/2026)

### Sugerir Categorização: filtrar os documentos que ainda não têm a categoria

Ao pedir à IA que preencha categorias, o trabalho de verdade está nos documentos em que o campo
ainda está **vazio** — mas a lista mostrava os documentos todos, e achar quais faltavam era
conferir um a um na aba Codificação.

Agora, ao lado de "todos" e "limpar", há **"sem valor (N)"**: um clique seleciona apenas os
documentos em que ao menos uma das categorias marcadas está vazia. Cada linha da lista também
diz quantas faltam ali, ou "completo" quando não falta nenhuma.

Por isso as **categorias agora vêm antes dos documentos** no painel: é a escolha delas que
define o que conta como "sem valor". Enquanto nenhuma estiver marcada, o botão fica desligado.

## 1.4.19 (06/08/2026)

### Confirmar o cadastro agora é um código digitado, não um link clicado

Quem criava conta com e-mail institucional podia receber **"link inválido ou expirado"** ao
clicar no e-mail de confirmação, mesmo tendo acabado de recebê-lo e sem ter clicado antes.

O motivo não estava no QualiLab. Servidores de e-mail corporativos (o da FGV, entre eles)
passam cada mensagem por um antivírus que **abre os links sozinho** para verificar se são
seguros. O link de confirmação só vale uma vez: quando a pessoa clicava, o antivírus já o
tinha gasto. A conta ficava confirmada, mas ela via um erro e não entrava.

Agora o e-mail traz um **código de 6 dígitos** em vez de um link. Você cria a conta, o
QualiLab abre uma tela pedindo o código, você digita e entra na hora. Um verificador
automático não tem como digitar um código, então o problema não se repete. A tela também
tem **"Reenviar código"**, para o caso de a mensagem demorar ou se perder.

Isso vale para os dois lugares onde se cria conta: a tela de acesso e o "Enviar para a
nuvem". Neste último, confirmar a conta deixou de descartar o envio pela metade — você
digita o código e segue de onde parou.

Se você guardou um e-mail de confirmação antigo, com link, ele continua funcionando.

## 1.4.18 (06/08/2026)

### O QualiLab abre sem internet

Sem conexão, abrir o QualiLab dava **tela em branco** — nem o aplicativo, nem uma mensagem
dizendo o que houve. O motivo: três bibliotecas pequenas, de que o app precisa antes de
desenhar qualquer coisa, eram buscadas na internet logo no começo. Sem elas, nada acontecia.

Agora elas vêm dentro do próprio arquivo. Sem conexão, a tela inicial aparece normalmente e
você pode criar um projeto em arquivo, abrir um `.qualilab` que já tenha ou usar o rascunho —
com um aviso de que o servidor não respondeu, em vez do vazio. Se você salvou a página no seu
computador, ela passa a funcionar de verdade offline.

Continuam exigindo internet, e avisam quando não conseguem: entrar na nuvem e as funções que
carregam bibliotecas maiores sob demanda — abrir PDF, Word e planilhas, reconhecer texto em
imagem (OCR) e a busca por sentido.

## 1.4.17 (06/08/2026)

Nada muda no aplicativo publicado aqui. Esta versão corrige a leitura assistida do corpus por um
agente, que é uma superfície do QualiLab **fora** deste app (ela vive no repositório do
assistente). O número sobe assim mesmo para que a versão mostrada no cabeçalho corresponda à
fonte de onde este arquivo foi gerado — se você estiver relatando um problema, é esse número que
identifica o build que o seu navegador carregou.

## 1.4.16 (06/08/2026)

### Categorias de número e de Sim/Não

Até agora, "número de páginas", "idade" e "valor da causa" só podiam ser **Texto Aberto**: o app
não ordenava por eles, e ao exportar chegavam ao MAXQDA e ao NVivo como texto — lá também sem
ordenar. Um "tem voto vencido?" virava uma lista de duas opções.

Agora há dois tipos novos no esquema de categorias:

- **Número** — campo numérico. Escreva como se escreve em português (`12,5`, `1.234`); o app guarda
  a forma canônica. O que não for número **não é aceito** (o campo fica vermelho e diz por quê) —
  é isso que mantém a categoria inteira valendo como número.
- **Sim/Não** — dois botões. Funciona como filtro e como eixo nos Gráficos, igual às outras
  categorias fechadas.

Os dois aceitam **"Não informado"**, como os demais tipos.

Na aba **Documentos** da Leitura dá para agrupar por uma categoria numérica, e as seções saem em
ordem de valor (9 antes de 10, e não o contrário).

### O tipo das categorias agora atravessa a exportação

Na exportação **QDPX**, número, Sim/Não e data saem **tipados** (Integer/Float, Boolean, Date) e
chegam ordenáveis nas outras ferramentas — antes tudo saía como texto. Uma ressalva importante:
isso só vale quando **todos** os valores daquela categoria cabem no tipo. Basta um "Não informado",
ou uma data sem o dia, para a categoria inteira voltar a sair como texto; um pacote com valor fora
do tipo declarado é recusado inteiro por importadores mais estritos, e perder o tipo é melhor do
que entregar um arquivo que não abre.

Na **importação**, o tipo declarado pela ferramenta de origem passou a ser respeitado. Antes, um
atributo numérico do NVivo com valores 1, 2 e 3 virava uma lista fechada de três opções, sem aviso.

### Também nesta versão

- Ao importar planilha ou atualizar categorias por planilha, a célula que não corresponde ao tipo
  escolhido é apontada na prévia ("número", "sim/não") em vez de entrar como texto.
- O **Sugerir Categorização** com IA passa a validar o valor contra o tipo: uma sugestão como
  "cerca de 40" não é mais aplicável a uma categoria numérica.

## 1.4.15 (06/08/2026)

### Grupos de documentos do ATLAS.ti chegam ao importar um `.qdpx`

Um projeto exportado do ATLAS.ti traz os **grupos de documentos** (e os de códigos) numa parte do
arquivo que o QualiLab ignorava. Eles sumiam sem aviso: quem importava um corpus organizado em
"Governo Lula I", "EIXO ENERGIA" e "Acordos sobre vistos" recebia os documentos soltos, e nada na
tela dizia que aquela organização tinha ficado para trás.

Agora **cada grupo de documentos vira valor de uma categoria** do tipo Caixa de Seleção, então um
documento que está em três grupos aparece com os três. Isso liga de graça o *agrupar por
categoria* na tela de Leitura e o filtro dos Gráficos. Se o grupo tiver o nome no formato
`Categoria::Valor` (que é como o ATLAS.ti batiza os grupos nascidos de uma categoria do QualiLab),
a categoria original é reconstruída com o nome dela: ida e volta sem perda.

**Grupo de códigos continua não virando família**, porque aqui a família é definida pela
hierarquia do próprio código (um código tem um pai só), e um grupo é uma lista solta em que o
mesmo código pode estar em vários. A diferença é que agora o resumo do import **diz pelo nome**
quais grupos de códigos ficaram de fora, em vez de silenciar.

## 1.4.14 (06/08/2026)

### Preencher categorias no Excel e trazer de volta

O CSV de **atributos por documento** (menu *exportar*) agora tem caminho de volta: preencha as
colunas na planilha e reimporte por **importar ▾ → planilha (.csv / .xlsx → atualizar categorias)**.
É o mesmo arquivo na ida e na volta — não há formato novo para aprender.

Serve para o que a tela faz mal: responder o mesmo atributo em 200 documentos. Na planilha isso é
arrastar uma coluna; no app, 200 cliques.

Antes de gravar, o QualiLab mostra **exatamente o que vai mudar**: quantas respostas serão
preenchidas, quantas alteradas (com o valor atual ao lado do novo), quantas já estão iguais, e
quais linhas não corresponderam a nenhum documento. Nada é aplicado antes de você aprovar.

Como ele se comporta, para você não ter surpresa:

- **Cada linha casa com o documento de mesmo nome.** Nome que não existe no projeto, ou que
  aparece em dois documentos, é ignorado e listado — o QualiLab não escolhe por você.
- **Nenhum documento é criado, renomeado ou excluído.** Para criar documentos a partir de uma
  planilha, o caminho continua sendo o outro item do menu.
- **Célula em branco não apaga nada**, porque o arquivo exportado vem em branco no que nunca foi
  preenchido. Há uma opção para quem quer mesmo esvaziar respostas.
- **Valor que ainda não está na lista de opções é acrescentado à categoria**, e a tela diz quais
  são antes — é onde você percebe um erro de digitação.
- **Coluna que não é uma categoria (como `n_trechos`) nasce ignorada**, e qualquer coluna pode
  virar uma categoria nova, escolhendo o tipo.

Em projeto coletivo, você escolhe se está preenchendo o **gabarito da equipe** (administrador) ou
a **sua resposta**.

Também nesta versão: botão desabilitado agora *parece* desabilitado (antes o "Aplicar" ficava
sólido mesmo quando não havia nada a aplicar).

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
