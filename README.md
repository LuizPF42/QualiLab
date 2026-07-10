<p align="center">
  <a href="https://luizpf42.github.io/QualiLab"><img src="images/logo.png" alt="QualiLab" width="180"></a>
</p>

# QualiLab

**o seu laboratório de pesquisa qualitativa / your own lab for qualitative research**

QualiLab é uma ferramenta **gratuita e de código aberto** para análise qualitativa de dados. Roda inteira em um único arquivo `index.html` — sem instalação, sem servidor próprio, sem assinatura.

> Inspirado pelo excelente trabalho do **[Taguette](https://www.taguette.org/about.html)**, do **[Magnolia](https://www.caledavis.eu/magnolia.html)** e do **[QualCoder](https://github.com/ccbogel/qualcoder)**, projetos que merecem todo o seu reconhecimento. Se você usa ou aprecia ferramentas abertas para pesquisa qualitativa, visite os projetos deles e considere contribuir — são as referências que tornaram o QualiLab possível.

Acesse a ferramenta **[aqui](https://luizpf42.github.io/QualiLab)** / Baixe a ferramenta **[aqui](https://github.com/LuizPF42/QualiLab/releases/download/alpha/index.html)**

📖 **Novo por aqui?** Comece pelo **[Manual de uso](MANUAL.md)** — guia completo, passo a passo, de todas as telas.

---

## ⚠️ Aviso importante — privacidade, segurança e responsabilidade

**Leia antes de usar o QualiLab com dados reais.**

O QualiLab é um **projeto pessoal, experimental e em desenvolvimento ativo**, distribuído sob licença **MIT, SEM QUALQUER GARANTIA** — de correção, disponibilidade ou segurança. **Bugs são esperados.** O software **não passou por auditoria de segurança** e não deve ser tratado como um cofre de dados.

**Para onde vão os seus dados** depende do modo de uso:

- **Arquivo / Rascunho** — ficam **no seu dispositivo** e não saem dele.
- **Nuvem** — são enviados a um **servidor de terceiros** (Supabase), ficam sujeitos aos termos desse provedor e saem do seu controle direto.
- **Publicação** (Relatório Interativo / Web Annotation) — o que você divulgar fica **público**.

**O QualiLab NÃO anonimiza nem identifica dados pessoais** (nomes, CPF, dados de saúde) no conteúdo dos documentos. A **censura** mascara apenas os trechos que **você** marcou à mão, **não** detecta sozinha o que é sensível e **não** cobre as exportações (QDPX/CSV/JSON saem com o texto cru). **Não há rede de segurança automática.**

**A responsabilidade pelo tratamento dos dados é inteiramente sua.** Trabalhando com dados pessoais, sigilosos ou protegidos (LGPD, aprovação de comitê de ética/CEP, segredo de justiça, dados de saúde), cabe a você anonimizar, obter consentimento e escolher o modo adequado. **Para material sensível, use o modo Arquivo local, offline, e não o coloque na nuvem.**

> **Isenção.** O QualiLab é um projeto pessoal de Luiz Pimenta Filho. **Não representa posição nem implica responsabilidade de qualquer instituição (incluindo a FGV).** O autor **não se responsabiliza** por perda de dados, vazamento, uso indevido ou quaisquer consequências do uso do software. Use por sua conta e risco, com as cautelas éticas e legais que a sua pesquisa exige.

---

## Motivação

Ferramentas de análise qualitativa — ATLAS.ti, MAXQDA, NVivo — são poderosas, mas sofrem de três problemas combinados: são **caras e fechadas**, têm uma **curva de aprendizado íngreme** que consome horas antes de qualquer análise começar, e oferecem pouco suporte a **categorias fechadas** (atributos estruturados por documento), obrigando pesquisadores a manter planilhas paralelas para o que deveria estar integrado.

O QualiLab busca ser o mais intuitivo possível: você carrega um documento, seleciona um trecho e já codifica — sem configuração prévia. Ao mesmo tempo, oferece um esquema de categorias nativo (texto fechado, múltipla escolha, caixa de seleção, data, texto livre) que convive com a codificação de trechos de forma integrada, no mesmo ambiente. Quem precisa conciliar análise temática com coleta estruturada de atributos não precisa mais alternar entre ferramentas.

As ferramentas disponíveis, pagas ou gratuitas, também não têm colaboração e pesquisa coletiva como seus objetivos primários. O QualiLab busca encontrar um bom meio termo, sendo desenvolvido para necessidades individuais e coletivas — camadas de codificação por pesquisador, reconciliação, papéis de administrador e membro, tudo nativo, sem precisar de planilha paralela ou ferramenta de terceiros para coordenar a equipe.

---

## Recursos

### Documentos
Importe `.txt`, `.md`, `.docx` e `.pdf`, ou cole texto diretamente. O conteúdo é extraído e exibido para leitura e codificação.

### Codificação por trechos
Selecione qualquer trecho e aplique um código — ou clique com o **botão direito** para um menu de contexto rápido. Clicar com o botão direito num trecho **já codificado** (sem selecionar nada novo) abre direto a opção de **remover** aquele código, sem precisar reselecionar o trecho. **Ctrl+Z** desfaz a última codificação aplicada na sessão atual. Os códigos são **hierárquicos** (famílias → subcódigos), com cor por família e tonalidade por profundidade; administradores podem personalizar a cor de uma família (matiz, ou cinza), propagada para os subcódigos.

### Esquema de categorias (atributos do documento)
Cada documento pode receber atributos com cinco tipos de campo:

| Tipo | Comportamento |
|---|---|
| **Texto Fechado** | Lista suspensa, escolhe um |
| **Texto Aberto** | Campo livre |
| **Data** | DD / MM / AAAA com partes opcionais |
| **Múltipla Escolha** | Botões, escolhe um |
| **Caixa de Seleção** | Botões, escolhe vários |

Cada categoria pode ter descrição/instrução e habilitar as opções **"Não informado"** e **"Outros"** (valor livre). O esquema é definido pelos administradores do projeto; os membros apenas preenchem.

### Telas principais

- **Codificação** — leitor à esquerda com grifos coloridos (a linha embaixo do grifo só aparece quando há mais de um código sobreposto no mesmo trecho, pra não poluir visualmente); painéis de categorias e de códigos à direita. Uma barra de ferramentas no leitor traz zoom de fonte, largura de coluna e tema de leitura (claro/sépia/escuro), além de busca com navegação entre ocorrências (🔎). Filtro **"Ver:"** para alternar entre camadas (individual, por codificador, final, ou "Individuais (todos)" — que sobrepõe os grifos de todos os pesquisadores **e** o gabarito ao mesmo tempo) — afeta tanto os grifos no texto quanto as respostas de categoria exibidas: ver a resposta de outro pesquisador ou o gabarito é só leitura (editar fica restrito à sua própria resposta, pra não sobrescrever a de outra pessoa por engano).
- **Esquema** — tela em branco (sem documento aberto) pra organizar o livro de códigos e o esquema de categorias de uma vez: reorganização em lote de códigos (agrupar, mesclar, promover a Hierarquia 0) e edição das categorias.
- **Reconciliação** — agrupa as codificações que se sobrepõem no mesmo código, mostra quantos codificadores concordam e permite **consolidar** na camada final (gabarito).
- **Visualização** — navegação por código à esquerda; trechos do código selecionado à direita, em tipografia legível, agrupados por documento. Filtro por categoria e cruzamento por co-ocorrência de até 2 códigos.
- **Gráficos** — frequência de códigos, distribuição por categoria (gabarito), heatmap código × categoria, produção por codificador e concordância entre codificadores. **Clicar numa barra ou célula abre a Visualização já naquele código** (na co-ocorrência, com o par de códigos cruzado; o filtro de categorias do gráfico vai junto, então os trechos exibidos batem com a contagem clicada).
- **Memos** — nota analítica única por alvo (projeto, documento, código **ou trecho codificado**), compartilhada entre os pesquisadores e editável por qualquer membro. A nota por trecho é escrita pelo menu de contexto do leitor (botão direito num grifo → "Anotar trecho") e também aparece na própria aba Memos.
- **Relatório** — é o **hub de publicação**, com três tipos de saída escolhidos na coluna esquerda:
  - **Relatório Interativo (ATI)** — uma página HTML auto-contida (sem servidor) com cada documento em trechos grifados clicáveis; clicar abre, num painel lateral, a nota analítica daquele trecho. Títulos de documento e códigos da legenda também abrem seus memos. Equivale ao *overlay* da **Annotation for Transparent Inquiry (ATI)** do QDR, mas hospedável por você (ex.: GitHub Pages). Os documentos vêm colapsados e a legenda é recolhível, para escalar a projetos grandes.
  - **Relatório Padrão** — montador de relatório: liga/desliga seções por caixas de seleção (resumo, lista de documentos, contagens e listas do esquema, frequência de códigos, distribuição por categoria, trechos por código, códigos não utilizados) e o texto se monta ao vivo. **Copiar texto** (pronto pra colar em `.docx`/Docs) e **Imprimir / PDF**. Crédito opcional ao QualiLab no resumo.
  - **Web Annotation (W3C)** — exporta as anotações no padrão aberto **[W3C Web Annotation Data Model](https://www.w3.org/TR/annotation-model/)** (JSON-LD), a mesma "língua de dados" sob o ATI, o [hypothes.is](https://web.hypothes.is/), o Anno-REP e o Dataverse — interoperável sem casar com nenhuma ferramenta específica.
  - Em projeto coletivo, os três respeitam a camada escolhida (gabarito final ou individuais). Em todas as saídas de transparência, trechos marcados como **censura** são mascarados por padrão.

### Codificação colaborativa em camadas
Cada codificação registra o autor. O trabalho de cada pesquisador é independente (`layer = individual`); a equipe consolida uma **camada final** na tela de Reconciliação. O mesmo modelo vale para as respostas de categoria: cada pesquisador preenche a sua; o administrador define o gabarito.

### Tipos de projeto
Ao criar um projeto você escolhe:
- **Individual** — uso solo; tudo vai direto para a camada final, sem etapa de reconciliação.
- **Coletivo** — múltiplos pesquisadores codificam de forma independente e reconciliam depois.

O tipo pode ser alterado depois pelo administrador (convertendo Coletivo → Individual de forma irreversível, colapsando todas as codificações num único autor).

### Gestão de projeto e membros
A **pílula do projeto** no cabeçalho muda de cor conforme **onde os seus dados estão**: neutra = rascunho (neste navegador, efêmero), **verde** = arquivo no seu disco, **azul** = nuvem (servidor padrão), **violeta** = nuvem no **seu próprio** servidor Supabase, **âmbar** = nuvem sem conexão (nada está sendo salvo). Passe o mouse para a explicação completa; em modo rascunho, o tooltip também mostra **quanto do armazenamento do navegador (~5 MB) o projeto já usa**, e um aviso aparece no cabeçalho a partir de 75%. Nos modos rascunho e arquivo, um **"✓ salvo HH:MM"** discreto confirma a última gravação automática.

Clicar na pílula abre o hub de gestão: código de convite para colaboradores, tipo do projeto, lista de membros com papéis (admin/membro), renomear, limpar conteúdo, excluir e configuração de conexão. No card **Conexão (Supabase)** dá para apontar o app pro **seu próprio projeto Supabase** (as credenciais valem só naquele navegador e passam a ter precedência), voltar ao servidor padrão, ou **desconectar de verdade** para o modo rascunho. Conforme o modo, o hub também mostra atalhos para trocar de armazenamento sem exportar/importar `.qualilab` na mão: **"Salvar como arquivo"** (só no rascunho, Chromium) migra o projeto atual pra um arquivo `.qualilab` no disco num clique (pílula fica verde); **"Enviar para a nuvem"** (rascunho ou arquivo) cria um projeto novo na nuvem e copia tudo pra ele (documentos, categorias, códigos, codificações e memos); **"Sair deste arquivo"** (só no modo arquivo) desanexa do arquivo atual e volta à tela de entrada, deixando o `.qualilab` intacto no disco.

### Tela de entrada, conta e login
Na primeira execução (sem sessão nem arquivo salvo), a **tela de entrada** oferece três caminhos, com o logo do projeto no topo: **Novo em arquivo** e **Entrar na nuvem** lado a lado, e **Só testar (rascunho)** abaixo. "Entrar na nuvem" leva ao login por **e-mail e senha** (com cadastro na mesma tela); **"← Voltar"** retorna à tela de escolha. Um botão violeta **"Conectar ao meu Supabase"** (na tela de entrada e no login) aponta o app pro **seu próprio servidor Supabase** antes de logar — é onde ficam seus projetos coletivos; depois de conectar, você loga ali e entra no projeto pelo código. Sessões de rascunho ficam vinculadas ao dispositivo, sem sincronizar entre aparelhos.

Clicando no seu nome no cabeçalho — **em qualquer modo (nuvem, local ou arquivo)** — a tela **Minha Conta** permite:
- Trocar o nome de exibição (usado nas codificações).
- Alterar a senha (contas com e-mail; some nos modos local/arquivo).
- Ver todos os seus projetos em um só lugar, com ações diretas: abrir, renomear (admin), sair ou excluir (admin) — sem precisar entrar em cada um.
- Sair da conta (desconecta do Supabase e volta pra tela de login; só no modo nuvem).

> Antes, o nome só era clicável no modo nuvem; em local/arquivo ele não abria nada. Agora **Minha Conta** abre em qualquer modo (oferecendo o que faz sentido em cada um).

### Importação e exportação

| Formato | Importa | Exporta | Notas |
|---|:---:|:---:|---|
| **`.qualilab`** (nativo) | ✅ | ✅ | **exportar ▾ → .qualilab (projeto completo, nativo)** baixa o projeto inteiro (documentos, categorias, valores, códigos, codificações e memos) para reabrir no próprio app. Funciona em qualquer modo. Ao **importar para um projeto coletivo já em uso**, preserva a resposta de categoria de cada pesquisador de origem (não só uma); o gabarito do arquivo entra como gabarito do projeto de destino. |
| **QDPX** (REFI-QDA) | ✅ | ✅ | Interoperável com ATLAS.ti, MAXQDA, NVivo, Quirkos, QualCoder. O `.qdpx` exportado é **validado contra o `Project.xsd` oficial do REFI-QDA (v1.0, MIT)** — mas isso é **tentativa de intercompatibilidade, não garantia**: schema válido não substitui testar na ferramenta de destino real. Na exportação, prefere a camada final (gabarito) quando consolidada. Ao importar um `.qdpx` de outra ferramenta (sem a convenção de tipo do QualiLab), tenta inferir categorias fechadas pelos valores repetidos — revise em "Gerenciar esquema de categorias". **Não inclui o Taguette** — ele só exporta o codebook em REFI-QDA (`.qdc`, sem documentos nem trechos). |
| **`.sqlite3`** (Taguette) | ✅ | — | Lê o projeto nativo do Taguette direto no navegador (via [sql.js](https://github.com/sql-js/sql.js), sem servidor): documentos, tags (com hierarquia por `/` ou `.`, como o próprio Taguette documenta) e trechos codificados. O Taguette não tem atributos de documento nem autor por trecho, então isso não vem no import. |
| **QDC** (codebook REFI-QDA) | ✅ | ✅ | Só o livro de códigos (sem documentos nem trechos — o formato não tem isso). Compatível com o codebook exportado por qualquer ferramenta REFI-QDA, incluindo o Taguette; se a hierarquia não vier em `<Code>` aninhado, tenta reconstruir pelo nome (`/` ou `.`), igual ao import do `.sqlite3`. |
| **Planilha (`.csv` / `.xlsx`)** | ✅ | — | Importa uma planilha onde **cada linha vira um documento**: você escolhe, num modal de mapeamento, qual coluna é o **texto** (o conteúdo a codificar), qual é o **nome do documento** (opcional) e quais colunas viram **categorias** (de qualquer tipo — Texto Fechado/Aberto, Data, Múltipla Escolha, Caixa de Seleção). Para categorias fechadas, as opções são deduzidas dos valores observados. O `.csv` é lido nativamente (detecta separador `,`/`;`/tab); o Excel via [SheetJS](https://sheetjs.com/), importando a **primeira aba**. Linhas sem texto na coluna de conteúdo são ignoradas (não viram documento vazio) e o resumo informa quantas. Sem códigos nem trechos codificados — a planilha não tem esse conceito. |
| **Web Annotation (W3C)** | — | ✅ | Anotações no padrão aberto [W3C Web Annotation Data Model](https://www.w3.org/TR/annotation-model/) (JSON-LD). Cada trecho codificado vira uma anotação com seletor de posição/citação + nota analítica (a do trecho tem prioridade sobre a do código). É a base interoperável do ATI/QDR, hypothes.is, Anno-REP e Dataverse. Censura mascarada. Na aba **Relatório**. |
| **Leitor de Transparência (HTML)** | — | ✅ | Página HTML auto-contida (sem servidor): documentos com grifos clicáveis e nota analítica — o *overlay* do ATI, hospedável por você (ex.: GitHub Pages). Na aba **Relatório**. |
| **CSV — trechos** | — | ✅ | Um trecho por linha, com documento, código, camada e autor. |
| **CSV — atributos** | — | ✅ | Um documento por linha, com os valores de cada categoria. |
| **JSON** | — | ✅ | Projeto completo com camadas e autores. |

---

## Como funciona

O QualiLab opera em três modos, escolhidos na **tela de entrada** (ou reabertos automaticamente):

| Modo | Armazenamento | Indicador | Quando usar |
|---|---|---|---|
| **Arquivo** | Arquivo `.qualilab` no disco | `arquivo ·` | Trabalho solo sério, dados sensíveis, uso offline |
| **Nuvem** | Supabase (Postgres + Auth) | `nuvem ·` | Equipes colaborativas, múltiplos dispositivos |
| **Rascunho** | `localStorage` do navegador | `rascunho ·` | Só testar rápido, sem compromisso (efêmero) |

Arquivo e nuvem são as opções de trabalho de verdade; o **rascunho** é a entrada sem fricção (um clique, zero configuração), mas **efêmero** — os dados ficam só naquele navegador e somem se você limpar os dados do site. Por isso um aviso discreto abaixo do cabeçalho sugere, a qualquer momento, **salvar como arquivo** ou **conectar à nuvem** (a migração é de um clique no hub do projeto, sem exportar/importar). Um arquivo já aberto **reabre sozinho** na próxima sessão (com a permissão do navegador); "Sair deste arquivo" no hub volta à tela de entrada.

### Modo arquivo — para dados sensíveis

No modo arquivo, o projeto é salvo como um arquivo `.qualilab` (JSON) **visível no sistema de arquivos** — em qualquer pasta, HD externo, volume criptografado ou servidor institucional. Zero tráfego de rede. Zero localStorage. Funciona completamente offline.

- Disponível em **Chrome e Edge** (File System Access API). Firefox e Safari usam o modo local.
- Na tela inicial, clique em **"Novo arquivo…"** ou **"Abrir arquivo…"** para começar.
- O app reabre automaticamente o último arquivo na próxima sessão (com permissão do navegador).
- Ideal para entrevistas clínicas, dados judiciais, pesquisas com aprovação de CEP que exijam ambiente air-gapped.

### Modo rascunho — backup automático em pasta

No modo rascunho (`localStorage`, limite de 5-10MB), você pode ativar um **backup automático**: o app passa a manter um arquivo `backup-automatico.qualilab` sempre atualizado numa pasta do seu computador — por exemplo, a mesma pasta onde está o `index.html`. É um espelho redundante, **não** o mesmo que o modo arquivo (que grava direto no disco como armazenamento principal): continua salvando no navegador normalmente, e também escreve esse arquivo em segundo plano a cada mudança (com uma pequena pausa antes de gravar, maior em projetos grandes, pra não travar a aba). Para virar modo arquivo de verdade (pílula verde), use **"Salvar como arquivo"** no hub do projeto.

- Ative em **pílula do projeto → Backup automático em pasta → Escolher pasta…** (disponível em Chrome e Edge).
- O app avisa **antes** de o armazenamento estourar: o tooltip da pílula do projeto mostra o % usado do limite (~5 MB) e, a partir de 75%, um aviso âmbar aparece no cabeçalho sugerindo baixar um `.qualilab` e migrar para o modo arquivo ou nuvem.
- Se o app não conseguir salvar de verdade (`localStorage` cheio, navegador sem suporte), um aviso vermelho aparece na tela com um atalho pra baixar o projeto na hora — isso não depende do backup automático estar ativado.

### Modo nuvem — status de conexão

- O cabeçalho mostra um indicador `offline` em âmbar quando a conexão cai.
- Operações de escrita (codificar, preencher categoria) exigem rede ativa. Sem conexão, elas falham — dados já salvos não são corrompidos, mas a ação em andamento não se completa.
- Uma fila de reenvio automático para escritas feitas offline está planejada, mas ainda não está ativa nesta versão.

---

## Executando localmente

Não há etapa de build. Basta abrir o arquivo:

**Opção mais simples** — acesse diretamente em:
```
https://luizpf42.github.io/QualiLab
```

**Para usar offline** — baixe o `index.html` e dê duplo clique pra abrir direto no navegador (`file://`), **sem precisar de servidor**: ele só importa bibliotecas externas via URL `https://` (nunca por caminho de arquivo local), então não bate no bloqueio clássico de módulo ES via `file://`. Em Chrome/Edge dá pra usar inclusive o modo **Arquivo local**, que salva o projeto como `.qualilab` visível no disco, ao lado do `index.html`.

**Se ainda assim algo não carregar** (extensão de segurança, política de navegador corporativo, ou outro navegador com bloqueio mais estrito de `file://`), sirva por um servidor local como alternativa:
```bash
python -m http.server 8000   # ou: npx serve .
```

As dependências (Preact, htm, pdf.js, mammoth, JSZip, supabase-js) são carregadas via CDN na primeira utilização — conexão com a internet é necessária na primeira vez, mas depois o app funciona com o arquivo já baixado.

---

## Configuração da nuvem (Supabase)

Para ativar o modo coletivo é necessário um projeto **Supabase** gratuito.

### 1. Credenciais

No topo do `index.html`, preencha:

```js
let SUPABASE_URL  = "https://SEU-PROJETO.supabase.co";
let SUPABASE_ANON_KEY = "SUA_ANON_KEY";
```

A `anon key` é pública por design e fica protegida pelas políticas de RLS. Você também pode informá-las **em tempo de execução**, sem editar o arquivo: pílula do projeto → **Conexão (Supabase)**. Credenciais salvas ali valem só naquele navegador e **têm precedência** sobre as embutidas — a pílula fica **violeta** ("nuvem pessoal") pra sinalizar, com botão pra voltar ao servidor padrão quando quiser.

### 2. Banco de dados

Abra o **SQL Editor** do Supabase, cole o conteúdo de [`supabase/schema.sql`](supabase/schema.sql) e clique em **Run**. O script é idempotente (pode rodar mais de uma vez) e cria todas as tabelas, funções (RPC), políticas de RLS e a configuração de realtime.

### 3. Autenticação

Em **Authentication → Providers**:
- Habilite **Email** para login por e-mail e senha.
- Habilite **Allow anonymous sign-ins** para o modo visitante.
- Opcional: desative **Confirm email** para que o cadastro entre direto (o app trata os dois casos).

---

## Stack

Sem build, sem bundler, sem framework pesado.

- **UI**: [Preact](https://preactjs.com/) + [htm](https://github.com/developit/htm) via `esm.sh`
- **PDF**: [pdf.js](https://github.com/mozilla/pdf.js)
- **DOCX**: [mammoth](https://github.com/mwilliamson/mammoth.js)
- **QDPX**: [JSZip](https://stuk.github.io/jszip/)
- **Import Taguette (`.sqlite3`)**: [sql.js](https://github.com/sql-js/sql.js) (SQLite compilado para WASM)
- **Import Excel (`.xlsx`)**: [SheetJS](https://sheetjs.com/) (carregado sob demanda, só ao importar uma planilha)
- **Armazenamento local**: File System Access API + IndexedDB (nativos do navegador)
- **Nuvem** (opcional): [Supabase](https://supabase.com/)

```
QualiLab/
├── index.html        # o app inteiro (front-end)
├── README.md         # este arquivo
├── CLAUDE.md         # guia técnico para contribuir / continuar o projeto
├── LICENSE           # MIT
├── supabase/
│   └── schema.sql    # schema completo do backend (tabelas, RPCs, RLS, realtime)
└── examples/
    └── *.qualilab    # projeto de exemplo (formato nativo) para testes/demonstração
```

---

## Créditos e inspirações

O QualiLab foi desenvolvido por **Luiz Pimenta Filho** no âmbito do **LabDados / FGV Direito SP** como projeto pessoal. Não representa posição institucional da FGV, que não tem qualquer responsabilidade pelo software.

A maior parte do código deste projeto foi escrita com assistência do [Claude Code](https://claude.com/claude-code) (Anthropic).

As principais inspirações foram:

- **[Taguette](https://www.taguette.org/about.html)** — ferramenta de QDA aberto, pioneira em simplicidade e funcionamento on-line, com suporte a múltiplos formatos de importação de documentos e exportação do codebook em REFI-QDA (`.qdc`).
- **[Magnolia](https://www.caledavis.eu/magnolia.html)** — QDA com foco em poder e intuitividade, transcrição de áudio/vídeo e análise de surveys. Um projeto impressionante e totalmente gratuito que merece sua atenção.
- **[QualCoder](https://github.com/ccbogel/qualcoder)** — QDA maduro e completo (codificação de texto, imagem, áudio e vídeo; relatórios e medidas de concordância), livre e de código aberto. Uma referência robusta para quem precisa de uma ferramenta de desktop full-featured.

Todos demonstram que é possível fazer ferramentas de qualidade sem cobrar das pessoas que mais precisam delas — e que vale a pena apoiá-las.

### Formato de intercâmbio

Os formatos **QDPX** (projeto completo) e **QDC** (livro de códigos) são definidos pela **[REFI-QDA Standard](https://www.qdasoftware.org/)**, o padrão aberto criado pela *Rotterdam Exchange Format Initiative (REFI)* para permitir a troca de projetos entre ferramentas de análise qualitativa. A importação e exportação desses formatos no QualiLab seguem essa especificação — todo o crédito pelo formato é da iniciativa REFI-QDA. Conheça e apoie o padrão em [qdasoftware.org](https://www.qdasoftware.org/).

### Transparência ativa (DA-RT / QDR / ATI)

Além do intercâmbio entre ferramentas de QDA, o QualiLab mira o ecossistema de **transparência da pesquisa qualitativa** ligado ao movimento **DA-RT** (*Data Access and Research Transparency*) e ao **[Qualitative Data Repository (QDR)](https://qdr.syr.edu/)**. O método atual do QDR é a **Annotation for Transparent Inquiry (ATI)**: anotar passagens de um texto com notas analíticas, excertos e links para as fontes que sustentam cada afirmação.

A camada técnica sob o ATI (e sob o [hypothes.is](https://web.hypothes.is/), o Anno-REP e o repositório Dataverse) é o **[W3C Web Annotation Data Model](https://www.w3.org/TR/annotation-model/)** — uma recomendação aberta do W3C. O QualiLab **mira nesse padrão**, não numa ferramenta específica: a aba **Relatório** gera tanto o **Relatório Interativo (ATI)** — uma página HTML auto-contida equivalente ao *overlay* do ATI, hospedável por você — quanto a exportação **Web Annotation (W3C)** em JSON-LD, interoperável com qualquer ferramenta que fale o padrão. Assim, a "nota analítica" de cada trecho (e dos códigos, documentos e do projeto) vira um apêndice de transparência publicável, sem depender de nenhum fornecedor.

---

## Restrições atuais

O QualiLab é um projeto em desenvolvimento ativo. Vale conhecer as limitações antes de adotar para um projeto de pesquisa importante:

- **Capacidade do Supabase (modo nuvem)** — o plano gratuito do Supabase tem limites de armazenamento e processamento (na ordem de **500MB de banco de dados** e **alguns GB de tráfego mensal**, sujeitos a mudança pelo provedor — confira os valores atuais em [supabase.com/pricing](https://supabase.com/pricing)). Projetos muito grandes (muitos documentos longos, milhares de codificações) podem exigir um plano pago do Supabase ou o modo **Arquivo local**, que não tem esse limite.
- **Sem anonimização automática** — documentos e trechos sensíveis (nomes, CPFs, dados de saúde) não são identificados ou mascarados automaticamente. A responsabilidade de anonimizar antes de subir o documento, ou de tratar a confidencialidade dos dados, é inteiramente do pesquisador.
- **Sem recuperação de senha** — contas de e-mail não têm fluxo de "esqueci minha senha"; a troca de senha exige estar logado.
- **Fila de escritas offline inativa** — como já indicado acima, escritas feitas sem conexão falham em vez de serem enviadas automaticamente depois.
- **QDPX não carrega categorias por pesquisador** — é uma limitação do próprio formato REFI-QDA, não do QualiLab: o padrão não tem campo de autoria para atributos de documento (só para trechos codificados). Ao importar um `.qdpx`, todos os atributos chegam atribuídos a quem importou.
- **Tipo dos atributos em `.qdpx` de outras ferramentas é inferido, não declarado** — o REFI-QDA não distingui campo fechado de aberto. Ao importar um `.qdpx` de outro software (QualCoder, ATLAS.ti etc.), o QualiLab tenta adivinhar pelas respostas: poucos valores distintos repetidos entre documentos viram Texto Fechado; valores todos diferentes viram Texto Aberto. O resumo do import avisa quantas categorias foram decididas assim — vale revisar em "Gerenciar esquema de categorias".
- **Sincronização em tempo real parcial** — apenas codificações e valores de categoria sincronizam ao vivo entre colaboradores. Mudanças no esquema de categorias ou na árvore de códigos exigem recarregar a página para aparecer para outros membros.
- **Governança do livro de códigos é binária** — qualquer membro pode criar, renomear e excluir códigos livremente (necessário para codificação colaborativa em tempo real); apenas a cor personalizada de uma família é restrita a administradores. Não há, ainda, um modo intermediário de aprovação antes de um código novo ficar visível a todos.
- **Desfazer é limitado** — Ctrl+Z desfaz só a última codificação aplicada na sessão atual (sem histórico entre sessões). Não há desfazer para categorias, código em si, documentos, ou qualquer outra ação; exclusões desses são definitivas. Também não há log de auditoria de alterações.
- **Modo Arquivo local restrito a Chromium** — a File System Access API que sustenta esse modo só existe em Chrome e Edge; Firefox e Safari caem automaticamente para o modo local (`localStorage`).

---

## Licença

MIT License — livre para usar, modificar e distribuir, com ou sem fins comerciais, desde que o aviso de copyright seja mantido.

```
Copyright (c) 2026 Luiz Pimenta Filho
```

---

## To-dos

- [ ] Migrar para um supabase (ou outro backend) mais robusto
- [x] Incluir ferramenta para anonimização automática / autotimizada
- [ ] Melhorar gráficos
  - [ ] Cards "síntese" (número de documentos, tipo, códigos, etc.)
  - [ ] Distribuição por famílias analíticas
  - [ ] Análises textuais automatizadas (similaridade, coocorrência, redes textuais)
- [x] Pipeline de publicação de relatórios próprios por pesquisador / pesquisa (aba **Relatório**: montador de seções, copiar texto, imprimir/PDF)
- [x] Integração de IA — **disponível** (opt-in e transparente): telas **Codificar com IA** e **Analisar com IA**, em modo **BYOK** (cada pesquisador traz a própria chave — Gemini/OpenAI/Anthropic/Azure/compatível-OpenAI, ou **Ollama local**, em que o material não sai da máquina). Nada é enviado sem você clicar, e você vê o prompt exato antes.
