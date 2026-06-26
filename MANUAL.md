<p align="center">
  <a href="https://luizpf42.github.io/QualiLab"><img src="images/logo.png" alt="QualiLab" width="160"></a>
</p>

# Manual do QualiLab

**Guia completo de uso — do primeiro acesso à publicação dos resultados.**

Este manual ensina a *usar* o QualiLab passo a passo. Para a lista de recursos e a parte técnica (instalação, Supabase, formatos), veja o [README](README.md). Para contribuir com o código, veja o [CLAUDE.md](CLAUDE.md).

> O QualiLab roda inteiro no navegador, num único arquivo. Não há instalação, login obrigatório nem servidor próprio. Você pode começar agora mesmo em **[luizpf42.github.io/QualiLab](https://luizpf42.github.io/QualiLab)**.

---

## ⚠️ Aviso importante — privacidade, segurança e responsabilidade

**Leia antes de usar o QualiLab com dados reais.**

O QualiLab é um **projeto pessoal, experimental e em desenvolvimento ativo**, distribuído sob licença **MIT, SEM QUALQUER GARANTIA** — de correção, disponibilidade ou segurança. **Bugs são esperados.** O software **não passou por auditoria de segurança** e não deve ser tratado como um cofre de dados.

**Para onde vão os seus dados** depende do modo de uso:

- **Arquivo / Local** — ficam **no seu dispositivo** e não saem dele.
- **Nuvem** — são enviados a um **servidor de terceiros** (Supabase), ficam sujeitos aos termos desse provedor e saem do seu controle direto.
- **Publicação** (Relatório Interativo / Web Annotation) — o que você divulgar fica **público**.

**O QualiLab NÃO anonimiza nem identifica dados pessoais** (nomes, CPF, dados de saúde) no conteúdo dos documentos. A **censura** mascara apenas os trechos que **você** marcou à mão, **não** detecta sozinha o que é sensível e **não** cobre as exportações (QDPX/CSV/JSON saem com o texto cru). **Não há rede de segurança automática.**

**A responsabilidade pelo tratamento dos dados é inteiramente sua.** Trabalhando com dados pessoais, sigilosos ou protegidos (LGPD, aprovação de comitê de ética/CEP, segredo de justiça, dados de saúde), cabe a você anonimizar, obter consentimento e escolher o modo adequado. **Para material sensível, use o modo Arquivo local, offline, e não o coloque na nuvem.**

> **Isenção.** O QualiLab é um projeto pessoal de Luiz Pimenta Filho. **Não representa posição nem implica responsabilidade de qualquer instituição (incluindo a FGV).** O autor **não se responsabiliza** por perda de dados, vazamento, uso indevido ou quaisquer consequências do uso do software. Use por sua conta e risco, com as cautelas éticas e legais que a sua pesquisa exige.

---

## Índice

1. [Conceitos fundamentais](#1-conceitos-fundamentais) — o modelo mental antes de tudo
2. [Começando](#2-começando) — acessar, escolher onde salvar, criar projeto
3. [A interface](#3-a-interface) — cabeçalho e as sete telas
4. [Documentos](#4-documentos) — enviar, colar, renomear
5. [Codificação de trechos](#5-codificação-de-trechos) — o coração da ferramenta
6. [Categorias (atributos do documento)](#6-categorias-atributos-do-documento)
7. [Esquema](#7-esquema) — organizar códigos e categorias em lote
8. [Reconciliação](#8-reconciliação) — consolidar o gabarito (projeto coletivo)
9. [Visualização](#9-visualização) — ler os trechos por código
10. [Gráficos](#10-gráficos)
11. [Memos](#11-memos) — notas analíticas
12. [Relatório](#12-relatório) — o hub de publicação e transparência
13. [Colaboração](#13-colaboração) — equipe, papéis, convites
14. [Minha conta](#14-minha-conta)
15. [Importar e exportar](#15-importar-e-exportar)
16. [Salvamento, backup e modos de armazenamento](#16-salvamento-backup-e-modos-de-armazenamento)
17. [Solução de problemas](#17-solução-de-problemas)
18. [Atalhos de teclado](#18-atalhos-de-teclado)
19. [Glossário](#19-glossário)

---

## 1. Conceitos fundamentais

Antes de clicar em qualquer botão, vale entender cinco ideias. Elas se repetem em todas as telas.

### Documento
Um texto a ser analisado: uma entrevista, uma decisão judicial, um artigo, uma transcrição. Você importa (`.txt`, `.md`, `.docx`, `.pdf`) ou cola o texto direto. Cada linha de uma planilha (`.csv`/`.xlsx`) também pode virar um documento.

### Código
Um rótulo que você aplica a **trechos** do texto ("este parágrafo fala de *acesso à justiça*"). Códigos são **hierárquicos**: uma família (Hierarquia 0) pode ter subcódigos, e estes podem ter os seus. A **cor** vem da família (o matiz) e a **tonalidade** indica a profundidade. É a codificação temática clássica de QDA.

### Categoria (atributo do documento)
Diferente do código: a categoria descreve o **documento inteiro**, não um trecho. "Ano", "Tribunal", "Tipo de fonte", "Gênero do entrevistado". É o que normalmente vira coluna numa planilha paralela — aqui fica integrado. Há cinco tipos (Texto Fechado, Texto Aberto, Data, Múltipla Escolha, Caixa de Seleção).

> **Código × Categoria, em uma frase:** *código* marca um **pedaço** do texto; *categoria* responde uma pergunta sobre o **documento todo**.

### Camadas e autoria
Toda codificação e toda resposta de categoria registra **quem** fez. Há duas camadas:

- **Individual** — o trabalho de cada pesquisador, separado.
- **Final (gabarito)** — a versão consolidada da equipe.

Em **projeto individual**, tudo já vai direto para o gabarito. Em **projeto coletivo**, cada um trabalha na sua camada individual e a equipe consolida o gabarito na tela de **Reconciliação**.

### Papéis (projeto coletivo)
- **Admin** — define o esquema de categorias, edita o gabarito, gerencia membros, cores de família e censura.
- **Membro** — codifica, preenche as próprias respostas de categoria, cria códigos e escreve memos.

> Onde os dados ficam (nuvem, navegador ou arquivo no disco) é uma escolha **separada** do tipo de projeto — veja a [seção 16](#16-salvamento-backup-e-modos-de-armazenamento).

---

## 2. Começando

### 2.1. Como acessar

| Forma | Como | Quando usar |
|---|---|---|
| **Online** | Abra [luizpf42.github.io/QualiLab](https://luizpf42.github.io/QualiLab) | O caminho normal |
| **Offline** | [Baixe o `index.html`](https://github.com/LuizPF42/QualiLab/releases) e dê duplo clique | Sem internet, dados sensíveis |

Ao baixar, o arquivo abre direto no navegador (`file://`) sem precisar de servidor — ele só busca as bibliotecas externas pela internet **na primeira vez**. (Se a sua política de navegador bloquear, sirva com `python -m http.server 8000` na pasta do arquivo.)

> **Chrome ou Edge** são recomendados: só neles funciona o **modo Arquivo local** (salvar um `.qualilab` visível no disco) e o **backup automático em pasta**. Firefox e Safari funcionam, mas caem para o modo navegador (`localStorage`).

### 2.2. A tela de login (modo nuvem)

Se o app está configurado com nuvem, a primeira tela é **"Acessar o QualiLab"**, com quatro caminhos:

1. **Entrar** — e-mail e senha de uma conta existente.
2. **Criar conta** — informe um **nome de exibição** (é como você aparece nas codificações), e-mail e senha (mín. 6 caracteres). Dependendo da configuração, pode ser preciso confirmar o e-mail antes de entrar.
3. **Continuar como visitante** — usa a nuvem deste navegador sem criar conta. Bom para testar. *Os projetos ficam vinculados a este dispositivo* e não sincronizam entre aparelhos. (Dá para migrar depois clicando em **"Entrar com conta →"**.)
4. **Usar offline** — pula a nuvem inteiramente e abre um projeto **local** neste dispositivo. Entra em ação automaticamente também se a conexão cair.

> Se o app não tiver credenciais de nuvem configuradas, você já começa direto em modo local/arquivo, sem essa tela.

### 2.3. Escolher / criar um projeto

Depois do login (ou direto, em modo local) aparece **"Meus projetos"**:

- **Abrir um projeto existente** — clique nele na lista, ou em **abrir**.
- **Criar projeto**:
  1. Confirme o **seu nome de exibição**.
  2. Digite o **nome do projeto**.
  3. Escolha o tipo: **Projeto Individual** (uso solo, tudo vai direto pro gabarito, sem reconciliação) ou **Projeto Coletivo** (vários pesquisadores, com reconciliação).
  4. Clique em **Criar**.
- **Entrar com código** — para participar de um projeto coletivo de outra pessoa, cole o **código de acesso** (ex.: `9F2A1C`) e clique em **Entrar**.
- **Arquivo local** (Chrome/Edge) — **Novo arquivo…** cria um `.qualilab` no disco; **Abrir arquivo…** reabre um existente. Ideal para dados sensíveis (sem nuvem, sem rede).

> O tipo do projeto pode ser mudado depois (admin). Converter **Coletivo → Individual é irreversível**: colapsa todas as codificações num único autor e mantém só o gabarito das categorias.

---

## 3. A interface

Depois de abrir um projeto, o **cabeçalho** tem duas linhas:

**Primeira linha**
- **QualiLab** (volta ao GitHub) e o botão 🌙/☀ (tema escuro/claro da *interface* — não confundir com o tema do *leitor*).
- As abas principais (`.seg`):

| Aba | Para quê |
|---|---|
| **Codificação** | Ler o documento e aplicar códigos/categorias |
| **Reconciliação** | *(só projeto coletivo)* consolidar o gabarito |
| **Visualização** | Ver todos os trechos de um código |
| **Gráficos** | Frequências, nuvem, co-ocorrência etc. |
| **Memos** | Notas analíticas |
| **Esquema** | Organizar códigos e categorias em lote |
| **Relatório** | Exportar relatórios e pacotes de transparência |

**Segunda linha**
- A **pílula do projeto** — ex.: `local · Meu Projeto · individual ▾`. O prefixo mostra o modo de armazenamento (`arquivo`/`nuvem`/`local`); clicar abre o **hub de gestão do projeto**.
- Seu **nome** — **clicável em todos os modos** (nuvem, local e arquivo) → Minha conta.
- **trocar projeto** / **sair** (modo nuvem).
- **exportar ▾** e **importar ▾** (aparecem quando há documentos).
- Indicadores `offline` / `sincronizando…` (modo nuvem).

Logo abaixo do cabeçalho podem aparecer **faixas de aviso**: erro (vermelho), importação em andamento (com barra de progresso) e o aviso de falha de salvamento (veja a [seção 16](#16-salvamento-backup-e-modos-de-armazenamento)).

---

## 4. Documentos

### Enviar arquivos
Na aba **Codificação**, no topo do leitor, clique em **＋ enviar** e escolha um ou mais arquivos `.txt`, `.md`, `.docx` ou `.pdf`. O texto é extraído e exibido para leitura.

- **PDF**: o texto é reagrupado em parágrafos (junta linhas quebradas, trata hifenização). Tabelas **não** são reconstruídas — PDFs muito visuais podem sair com a leitura imperfeita.
- **DOCX**: convertido para texto. A formatação rica não é preservada (o foco é o conteúdo a codificar).

### Colar texto
Use o botão de **colar** (ao lado de ＋ enviar) para criar um documento a partir de texto copiado, sem arquivo.

### Trocar de documento e renomear
- O **seletor** no topo do leitor alterna entre os documentos do projeto.
- O lápis **✏️** ao lado renomeia o documento aberto (Enter confirma, Esc cancela).

### Importar muitos documentos de uma vez
Uma planilha (`.csv`/`.xlsx`) vira **um documento por linha** — veja [Importar e exportar](#15-importar-e-exportar).

---

## 5. Codificação de trechos

Esta é a tela **Codificação**: leitor à esquerda, painéis de **Categorias** e **Códigos** à direita.

### 5.1. Criar códigos
No painel **Códigos** (direita) você cria e organiza os rótulos. Um código novo nasce como família (Hierarquia 0). Você pode criar subcódigos, renomear e excluir. Também dá para criar um código **na hora de aplicar** (veja abaixo).

### 5.2. Aplicar um código a um trecho
1. **Selecione** o trecho no texto com o mouse.
2. **Clique com o botão direito** sobre a seleção.
3. No menu de contexto, clique no código desejado — ele é aplicado na hora.
   - Ou clique em **+ Criar novo código**: digite o nome, escolha se é **(nova família — nível 0)** ou **subcódigo de "…"**, e clique em **Criar e aplicar**.

> Ao aplicar, o grifo aparece no texto com a cor do código. **A linha embaixo do grifo só aparece quando há mais de um código sobrepondo o mesmo trecho** — é o sinal de sobreposição. Trecho com um código só fica apenas tintado, sem linha, para não poluir.

### 5.3. Remover um código de um trecho
Você **não precisa selecionar de novo**:
1. Clique com o **botão direito sobre o grifo** existente.
2. No menu, em **Remover código** (admins em projeto coletivo veem "Rejeitar / remover código"), clique no código que quer tirar.

> Em projeto coletivo na nuvem, você só remove codificações **suas** — não dá para apagar o grifo de outro pesquisador. (Em projeto individual, tudo é seu.)

### 5.4. Desfazer (Ctrl+Z)
**Ctrl+Z** desfaz a **última codificação aplicada** na sessão atual (até as últimas 50). Funciona só na aba Codificação e fora de campos de texto. Não há desfazer para outras ações (excluir documento, categoria, código etc.) — essas são definitivas.

### 5.5. Censura (mascarar trechos sensíveis)
Um código pode ser marcado como **censura** (no [Esquema](#7-esquema), por um admin). Trechos com esse código aparecem como uma caixa preta e, nas saídas de transparência ([Relatório](#12-relatório)), saem mascarados como `[trecho censurado]` por padrão — útil para publicar mantendo nomes/dados sensíveis ocultos.

### 5.6. Controles de leitura
A barra no topo do leitor ajusta **só a leitura** (preferência salva no navegador):
- **A-** / **A+** — diminui/aumenta a fonte.
- **⬍ / ⬌** — alterna a largura da coluna (padrão ↔ coluna estreita de leitura).
- **☀** — tema do leitor: claro / sépia / escuro.

### 5.7. Buscar no documento
Clique na **lupa 🔎**. Digite o termo: as ocorrências são destacadas por cima dos grifos, com navegação **‹ anterior / próxima ›** (e **Enter** / **Shift+Enter**), com volta ao início ao chegar no fim.

### 5.8. Filtro "Ver:" (de quem é o que aparece)
O seletor **Ver:** controla **de quem** são os grifos e as respostas de categoria exibidos. Aparece em projeto coletivo e também quando há mais de um codificador (ex.: dados importados com vários autores). Em projeto coletivo, as opções são:
- **Individuais (todos)** — sobrepõe os grifos de todos + o gabarito ao mesmo tempo (só leitura).
- **Minhas** — só o seu trabalho (editável).
- **(nome de cada pesquisador)** — o trabalho de um colega específico (só leitura).
- **Final / gabarito** — a camada consolidada (só leitura aqui; edita-se na Reconciliação).

Em projeto individual com mais de um autor importado, o seletor mostra **Todos os codificadores** e o nome de cada autor.

> **Por que algumas visualizações são só leitura?** Editar enquanto vê o trabalho de *outra* pessoa gravaria sob a *sua* identidade. Por isso só **Minhas** (ou projeto individual) permite editar a resposta de categoria ali. O gabarito se edita na Reconciliação.

---

## 6. Categorias (atributos do documento)

No painel **Categorias** (direita, na aba Codificação) você responde os atributos do **documento aberto**.

### Os cinco tipos
| Tipo | Como preenche |
|---|---|
| **Texto Fechado** | Lista suspensa — escolhe **um** |
| **Texto Aberto** | Campo livre |
| **Data** | DD / MM / AAAA, com partes opcionais (pode pôr só o ano) |
| **Múltipla Escolha** | Botões — escolhe **um** |
| **Caixa de Seleção** | Botões — escolhe **vários** |

Cada categoria pode ter uma **descrição/instrução** e habilitar duas opções especiais: **"Não informado"** e **"Outros"** (com valor livre).

### Quem define e quem preenche
- **Definir o esquema** (criar categorias, tipos, opções) — admin, no item **"Gerenciar esquema de categorias"** (dentro do painel Categorias) ou na aba **Esquema → Categorias**.
- **Preencher** — qualquer membro responde a **sua** versão; o admin define o **gabarito**.
- A resposta exibida segue o filtro **Ver:** (ver a de outro pesquisador é só leitura).

---

## 7. Esquema

A aba **Esquema** é uma tela cheia (sem documento aberto) para organizar tudo de uma vez. Tem duas sub-abas.

### 7.1. Categorias
Mesma edição do painel de Categorias, mas focada em montar o esquema: criar, editar tipos e opções, e **reordenar arrastando** pelo punho **⠿** (o item arrastado fica translúcido; uma linha azul mostra onde vai cair).

### 7.2. Códigos (reorganização em lote)
Pensado para quem terminou uma codificação aberta com **centenas de códigos soltos** e quer organizá-los. É uma árvore com **caixas de seleção**; o painel da direita muda conforme a seleção:

- **Clique simples em um código** (na linha, não na caixa) → editar nome/cor + **Promover a Hierarquia 0** (se for subcódigo).
- **Marque 2 ou mais** (caixas) → aparecem duas ações:
  - **Agrupar** — os marcados viram **filhos** de um código (existente, escolhido na lista, ou novo) — continuam separados, só ganham um pai. Adotam a cor do pai.
  - **Mesclar** — escolhe um **sobrevivente** (sugestão = o mais frequente); as codificações dos demais são **reatribuídas** a ele e os outros são excluídos. **Irreversível** — confirma antes. Os filhos dos mesclados são preservados (passam para o sobrevivente).
- **Reordenar entre irmãos** — arraste pelo punho **⠿** (só reordena dentro do mesmo pai; para mudar de pai, use **Agrupar**).

### 7.3. Cores e censura (admin)
Ao editar um código, o admin pode:
- Escolher a **cor da família** por um controle de **matiz** (0–359), ou **cinza** / **preto** — propagada aos subcódigos.
- Marcar o código como **censura** (força a cor preta) — veja [5.5](#55-censura-mascarar-trechos-sensíveis).

> **Importante:** o painel de Códigos da aba **Codificação** continua existindo e é independente. A reorganização em lote é só aqui no Esquema, de propósito (menos mudança de hábito na tela de codificar).

---

## 8. Reconciliação

*Só em projeto coletivo.* É onde a equipe consolida o **gabarito** a partir do trabalho individual. Tem duas partes:

- **Categorias** — para cada documento/categoria, vê as respostas de cada pesquisador (com ✓/✗) e o admin define o valor final.
- **Códigos** — agrupa as codificações que se **sobrepõem** no mesmo código, mostra **quantos codificadores concordam** e permite **consolidar** o trecho na camada final.

O resultado vira a camada **Final**, usada nos relatórios e gráficos quando você escolhe "gabarito".

---

## 9. Visualização

Tela mestre-detalhe para **ler todos os trechos de um código**:

- **Esquerda** — escolha a camada (Ver:) e navegue pela árvore de códigos (e pelas categorias colapsáveis).
- **Direita** — todos os trechos do código selecionado, em tipografia de leitura, **agrupados por documento**.

Recursos:
- **Filtro por categoria** — restringe aos documentos que atendem certos atributos.
- **Co-ocorrência** — mostra trechos onde dois códigos aparecem juntos.

---

## 10. Gráficos

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
- **Por categoria** — restringe **todos** os gráficos aos documentos que passam ("X de Y documentos no filtro").
- **Ignorar censura** — **ligado por padrão**; remove dos gráficos os trechos de códigos de censura.
- **Nuvem** — uma árvore com caixas seleciona de quais códigos vem o vocabulário (marcar um código marca a subárvore).
- **Co-ocorrência** — dois seletores escolhem os eixos **X** (colunas) e **Y** (linhas); vazio = os 12 mais frequentes.
- **Ver:** e **Top:** (10/25/50/Todos) refinam o recorte.

---

## 11. Memos

A aba **Memos** guarda **notas analíticas**, uma por alvo, compartilhadas entre os membros e com salvamento automático. Os escopos:

- **Projeto** — uma nota geral.
- **Documento** — uma nota por documento.
- **Código** — uma nota por código (sua definição, regra de aplicação etc.).
- **Trecho** — uma nota ancorada num grifo específico.

A nota de **trecho** também se escreve direto na codificação: **botão direito sobre o grifo → "Anotar trecho (nota analítica)"**. Essas notas alimentam as saídas de transparência do [Relatório](#12-relatório).

---

## 12. Relatório

A aba **Relatório** é o **hub de publicação**. Na coluna esquerda você escolhe entre três saídas. Em projeto coletivo, todas respeitam a **camada** escolhida (gabarito final ou individuais); em todas, trechos de **censura** saem mascarados.

### 12.1. Relatório Interativo (ATI)
Uma **página HTML auto-contida** (sem servidor): cada documento aparece com os trechos grifados clicáveis; clicar abre, num painel lateral, a **nota analítica** daquele trecho. Títulos de documento e códigos da legenda também abrem seus memos. É o equivalente ao *overlay* da **Annotation for Transparent Inquiry (ATI)** do QDR — mas hospedável por você (ex.: GitHub Pages, Dataverse como anexo). Documentos vêm colapsados e a legenda é recolhível, para escalar a projetos grandes.

### 12.2. Relatório Padrão
Um **montador**: marque as seções na coluna esquerda e o texto se monta ao vivo. Seções: resumo, lista de documentos, contagens e listas do esquema, frequência de códigos, distribuição por categoria, trechos por código, códigos não utilizados. Depois:
- **Copiar texto** — texto simples pronto para colar em Word/Google Docs.
- **Imprimir / PDF** — abre a impressão do navegador (força tinta escura sobre branco, mesmo se o app estiver em tema escuro).
- Opção de **creditar o QualiLab** no resumo.

### 12.3. Web Annotation (W3C)
Exporta as anotações no padrão aberto **[W3C Web Annotation Data Model](https://www.w3.org/TR/annotation-model/)** (JSON-LD): cada trecho vira uma anotação com seletor de posição/citação + nota analítica. É a "língua de dados" comum ao ATI, ao [hypothes.is](https://web.hypothes.is/), ao Anno-REP e ao Dataverse — interoperável sem casar com nenhuma ferramenta.

---

## 13. Colaboração

*(Projeto coletivo, modo nuvem.)*

### Convidar pessoas
Abra a **pílula do projeto** (cabeçalho) → ali está o **código de acesso**. Compartilhe-o; quem recebe entra por **"Meus projetos" → Entrar com código**. No modo nuvem, o código também aparece na própria pílula (`nuvem · Projeto · CÓDIGO · coletivo ▾`).

### Gerenciar membros e o projeto
Ainda na pílula do projeto, o admin pode: ver a **lista de membros** e mudar papéis (**admin/membro**), **renomear**, **limpar conteúdo**, **excluir** o projeto, mudar o **tipo** e ajustar a **conexão** (credenciais Supabase).

### Enviar para a nuvem
Se o projeto ativo for **local** ou **arquivo**, a pílula mostra **"Enviar para a nuvem"**: cria um projeto novo na nuvem e copia tudo (documentos, categorias, códigos, codificações, memos) de uma vez — sem exportar/importar `.qualilab` na mão.

### Tempo real (e seus limites)
**Codificações** e **respostas de categoria** sincronizam ao vivo entre colaboradores. Já mudanças no **esquema de categorias** ou na **árvore de códigos** só aparecem para os outros ao **recarregar a página**.

---

## 14. Minha conta

Clique no **seu nome** no cabeçalho para abrir **Minha conta** — funciona **em todos os modos** (nuvem, local e arquivo):
- Trocar o **nome de exibição** (usado nas codificações).
- Alterar a **senha** (só contas com e-mail; some nos modos local/arquivo).
- Ver **todos os seus projetos** num lugar só, com ações diretas: abrir, renomear (admin), sair ou excluir (admin).
- **Sair da conta** (só no modo nuvem).

> Antes, no modo offline, o nome não abria nada; agora **Minha conta** abre em qualquer modo (mostrando o que faz sentido em cada um).

> Não há "esqueci minha senha" — a troca de senha exige estar logado.

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
| **planilha (.csv / .xlsx)** | **Cada linha vira um documento** — veja abaixo |

#### Importar uma planilha (passo a passo)
1. **importar ▾ → planilha (.csv / .xlsx)** e escolha o arquivo.
2. No **modal de mapeamento**, para cada coluna escolha o papel: *Ignorar*, **Texto (conteúdo)**, **Nome do documento**, ou **Categoria · <tipo>**.
3. É obrigatório marcar **exatamente uma** coluna como **Texto**.
4. Para categorias fechadas, as opções são deduzidas dos valores observados. Confirme em **Importar**.
- Linhas sem texto na coluna de conteúdo são ignoradas (o resumo informa quantas). O `.csv` detecta o separador (`,`/`;`/tab); o Excel importa a **primeira aba**.

> Depois de importar de outra ferramenta, vale revisar o esquema de categorias (os tipos podem ter sido inferidos).

---

## 16. Salvamento, backup e modos de armazenamento

O QualiLab **salva sozinho** a cada ação. *Onde* ele salva depende do modo:

| Modo | Onde fica | Indicador | Quando usar |
|---|---|---|---|
| **Arquivo local** | Um `.qualilab` no disco | `arquivo ·` | Dados sensíveis, offline, sem rede |
| **Local** | `localStorage` do navegador | `local ·` | Uso rápido sem configuração |
| **Nuvem** | Supabase | `nuvem ·` | Equipes, vários dispositivos |

### Modo arquivo (Chrome/Edge)
O projeto é um arquivo `.qualilab` **visível no sistema de arquivos** — qualquer pasta, HD externo, volume criptografado. Zero rede, zero `localStorage`, 100% offline. Comece em **"Meus projetos" → Novo arquivo… / Abrir arquivo…**. O app reabre o último arquivo na sessão seguinte (com permissão do navegador).

### Backup automático em pasta (modo local, Chrome/Edge)
Mantém um `backup-automatico.qualilab` sempre atualizado numa pasta sua, como espelho do `localStorage`. Ative em **pílula do projeto → Backup automático em pasta → Escolher pasta…**.

### Salvar/baixar manualmente
**exportar ▾ → .qualilab (projeto completo, nativo)** baixa o projeto inteiro a qualquer momento, em qualquer modo. Bom para versões e backups manuais. (O mesmo arquivo é oferecido pelo atalho da faixa de erro, quando o salvamento automático falha.)

### Quando o salvamento falha
Se o navegador não conseguir gravar (`localStorage` cheio, permissão de pasta revogada, disco removido), aparece uma **faixa vermelha persistente** avisando que as últimas alterações **não** foram salvas, com um atalho para **baixar .qualilab** na hora. Ela só some quando um salvamento volta a funcionar. **Não ignore esse aviso** — baixe o backup antes de continuar.

### Modo nuvem offline
O cabeçalho mostra `offline` (âmbar) quando a conexão cai. Escritas (codificar, preencher categoria) exigem rede; sem ela, a ação em andamento falha (dados já salvos não são corrompidos). A fila de reenvio automático de escritas offline ainda **não** está ativa nesta versão.

---

## 17. Solução de problemas

**O app não carrega / tela em branco ao abrir o arquivo baixado.**
Ele precisa de internet na **primeira vez** (para baixar as bibliotecas). Se a política do navegador bloquear o `file://`, sirva por um servidor local: `python -m http.server 8000` na pasta do `index.html`.

**Não vejo "Novo arquivo…" nem o backup em pasta.**
Esses recursos usam a File System Access API, que só existe em **Chrome/Edge**. No Firefox/Safari, use o modo nuvem ou local.

**Faixa vermelha "as últimas alterações NÃO foram salvas".**
O armazenamento encheu ou ficou indisponível. Clique em **baixar .qualilab** imediatamente; depois libere espaço (modo local tem limite de ~5–10 MB) ou migre para o modo **arquivo**/**nuvem**.

**Um colega não vê meus códigos / categorias novas.**
Esquema de categorias e árvore de códigos não sincronizam ao vivo — peça para **recarregar a página**. (Codificações e respostas de categoria, sim, sincronizam.)

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

## 18. Atalhos de teclado

| Atalho | Onde | Ação |
|---|---|---|
| **Botão direito** sobre uma seleção | Codificação | Menu para aplicar/criar código |
| **Botão direito** sobre um grifo | Codificação | Remover código / Anotar trecho |
| **Ctrl+Z** | Codificação | Desfazer a última codificação aplicada |
| **Enter** / **Shift+Enter** | Busca (🔎) | Próxima / anterior ocorrência |
| **Enter** / **Esc** | Renomear documento | Confirmar / cancelar |

---

## 19. Glossário

- **Código** — rótulo aplicado a um trecho; hierárquico (família → subcódigos).
- **Categoria / atributo** — propriedade do documento inteiro (cinco tipos de campo).
- **Codificação** — uma aplicação de um código a um trecho específico (com autor e camada).
- **Camada** — *individual* (de cada pesquisador) ou *final* (gabarito consolidado).
- **Gabarito** — a camada final consolidada da equipe.
- **Reconciliação** — tela onde a equipe consolida o gabarito (projeto coletivo).
- **Memo** — nota analítica por projeto/documento/código/trecho.
- **Censura** — código que mascara trechos sensíveis nas exportações.
- **Co-ocorrência** — dois códigos aplicados ao mesmo trecho (ou sobrepostos).
- **Modo (armazenamento)** — onde os dados ficam: arquivo, local ou nuvem.
- **Tipo de projeto** — individual (sem reconciliação) ou coletivo.
- **Papel** — admin (define esquema/gabarito/membros) ou membro.
- **REFI-QDA / QDPX / QDC** — padrão aberto de intercâmbio entre ferramentas de QDA.
- **ATI** — *Annotation for Transparent Inquiry*, método de transparência do QDR.
- **W3C Web Annotation** — padrão aberto de dados de anotação (base do ATI, hypothes.is etc.).

---

<p align="center"><sub>QualiLab — o seu laboratório de pesquisa qualitativa. Desenvolvido por Luiz Pimenta Filho (LabDados / FGV Direito SP). Licença MIT.</sub></p>
