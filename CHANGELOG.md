# Changelog

Mudanças relevantes para quem **usa** o QualiLab. O histórico completo (incluindo refatorações
e decisões internas) está nos commits e no `CLAUDE.md`.

A versão aparece no canto direito do cabeçalho e no rodapé da tela de entrada. **Cite esse
número ao relatar um problema**: sem ele não há como saber qual build o seu navegador carregou.

> Ao publicar uma versão: suba o `QUALILAB_VERSION` no `index.html`, acrescente a seção aqui e
> regenere o estável (`scripts/gen-estavel.sh`).

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
