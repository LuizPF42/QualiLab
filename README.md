# QualiLab

**o seu laboratório de pesquisa qualitativa / your own lab for qualitative research**

QualiLab é uma ferramenta **gratuita e de código aberto** para análise qualitativa de dados. Roda inteira em um único arquivo `index.html` — sem instalação, sem servidor próprio, sem assinatura.

> Inspirado pelo excelente trabalho do **[Taguette](https://www.taguette.org/about.html)**, do **[Magnolia](https://www.caledavis.eu/magnolia.html)** e do **[QualCoder](https://github.com/ccbogel/qualcoder)**, projetos que merecem todo o seu reconhecimento. Se você usa ou aprecia ferramentas abertas para pesquisa qualitativa, visite os projetos deles e considere contribuir — são as referências que tornaram o QualiLab possível.

Acesse a ferramenta **[aqui](https://luizpf42.github.io/QualiLab)** / Baixe a ferramenta **[aqui](https://github.com/LuizPF42/QualiLab/releases/download/alpha/index.html)**

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
Selecione qualquer trecho e aplique um código — ou clique com o **botão direito** para um menu de contexto rápido. Os códigos são **hierárquicos** (famílias → subcódigos), com cor por família e tonalidade por profundidade; administradores podem personalizar a cor de uma família (matiz, ou cinza), propagada para os subcódigos.

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

- **Codificação** — leitor à esquerda com grifos coloridos; painéis de categorias e de códigos à direita. Filtro **"Ver:"** para alternar entre camadas (individual, por codificador, final) — afeta tanto os grifos no texto quanto as respostas de categoria exibidas: ver a resposta de outro pesquisador ou o gabarito é só leitura (editar fica restrito à sua própria resposta, pra não sobrescrever a de outra pessoa por engano).
- **Esquema** — tela em branco (sem documento aberto) pra organizar o livro de códigos e o esquema de categorias de uma vez: reorganização em lote de códigos (agrupar, mesclar, promover a Hierarquia 0) e edição das categorias.
- **Reconciliação** — agrupa as codificações que se sobrepõem no mesmo código, mostra quantos codificadores concordam e permite **consolidar** na camada final (gabarito).
- **Visualização** — navegação por código à esquerda; trechos do código selecionado à direita, em tipografia legível, agrupados por documento. Filtro por categoria e cruzamento por co-ocorrência de até 2 códigos.
- **Gráficos** — frequência de códigos, distribuição por categoria (gabarito), heatmap código × categoria, produção por codificador e concordância entre codificadores.
- **Memos** — nota analítica única por alvo (projeto, documento ou código), compartilhada entre os pesquisadores e editável por qualquer membro.

### Codificação colaborativa em camadas
Cada codificação registra o autor. O trabalho de cada pesquisador é independente (`layer = individual`); a equipe consolida uma **camada final** na tela de Reconciliação. O mesmo modelo vale para as respostas de categoria: cada pesquisador preenche a sua; o administrador define o gabarito.

### Tipos de projeto
Ao criar um projeto você escolhe:
- **Individual** — uso solo; tudo vai direto para a camada final, sem etapa de reconciliação.
- **Coletivo** — múltiplos pesquisadores codificam de forma independente e reconciliam depois.

O tipo pode ser alterado depois pelo administrador (convertendo Coletivo → Individual de forma irreversível, colapsando todas as codificações num único autor).

### Gestão de projeto e membros
A **pílula do projeto** no cabeçalho abre o hub de gestão: código de convite para colaboradores, tipo do projeto, lista de membros com papéis (admin/membro), renomear, limpar conteúdo, excluir e configuração de conexão.

### Conta e login (modo nuvem)
No modo nuvem, a tela inicial pede login por **e-mail e senha** (com cadastro direto na mesma tela) ou **"Continuar como visitante"** para testar sem criar conta — sessões de visitante ficam vinculadas ao dispositivo, sem sincronizar entre aparelhos.

Clicando no seu nome no cabeçalho, a tela **Minha Conta** permite:
- Trocar o nome de exibição (usado nas codificações).
- Alterar a senha (contas com e-mail).
- Ver todos os seus projetos em um só lugar, com ações diretas: abrir, renomear (admin), sair ou excluir (admin) — sem precisar entrar em cada um.

### Importação e exportação

| Formato | Importa | Exporta | Notas |
|---|:---:|:---:|---|
| **`.qualilab`** (nativo) | ✅ | ✅ | Botão **"salvar .qualilab"** no cabeçalho — baixa o projeto inteiro (documentos, categorias, valores, códigos, codificações e memos) para reabrir no próprio app. Funciona em qualquer modo. Ao **importar para um projeto coletivo já em uso**, preserva a resposta de categoria de cada pesquisador de origem (não só uma); o gabarito do arquivo entra como gabarito do projeto de destino. |
| **QDPX** (REFI-QDA) | ✅ | ✅ | Interoperável com ATLAS.ti, MAXQDA, NVivo, Quirkos, QualCoder. Na exportação, prefere a camada final (gabarito) quando consolidada. Ao importar um `.qdpx` de outra ferramenta (sem a convenção de tipo do QualiLab), tenta inferir categorias fechadas pelos valores repetidos — revise em "Gerenciar esquema de categorias". **Não inclui o Taguette** — ele só exporta o codebook em REFI-QDA (`.qdc`, sem documentos nem trechos). |
| **`.sqlite3`** (Taguette) | ✅ | — | Lê o projeto nativo do Taguette direto no navegador (via [sql.js](https://github.com/sql-js/sql.js), sem servidor): documentos, tags (com hierarquia por `/` ou `.`, como o próprio Taguette documenta) e trechos codificados. O Taguette não tem atributos de documento nem autor por trecho, então isso não vem no import. |
| **QDC** (codebook REFI-QDA) | ✅ | ✅ | Só o livro de códigos (sem documentos nem trechos — o formato não tem isso). Compatível com o codebook exportado por qualquer ferramenta REFI-QDA, incluindo o Taguette; se a hierarquia não vier em `<Code>` aninhado, tenta reconstruir pelo nome (`/` ou `.`), igual ao import do `.sqlite3`. |
| **CSV — trechos** | — | ✅ | Um trecho por linha, com documento, código, camada e autor. |
| **CSV — atributos** | — | ✅ | Um documento por linha, com os valores de cada categoria. |
| **JSON** | — | ✅ | Projeto completo com camadas e autores. |

---

## Como funciona

O QualiLab opera em três modos, escolhidos automaticamente ou pelo usuário:

| Modo | Armazenamento | Indicador | Quando usar |
|---|---|---|---|
| **Arquivo local** | Arquivo `.qualilab` no disco | `arquivo ·` | Dados sensíveis, uso offline, ambientes sem rede |
| **Local** | `localStorage` do navegador | `local ·` | Uso rápido sem configuração |
| **Nuvem** | Supabase (Postgres + Auth) | `nuvem ·` | Equipes colaborativas, múltiplos dispositivos |

### Modo arquivo — para dados sensíveis

No modo arquivo, o projeto é salvo como um arquivo `.qualilab` (JSON) **visível no sistema de arquivos** — em qualquer pasta, HD externo, volume criptografado ou servidor institucional. Zero tráfego de rede. Zero localStorage. Funciona completamente offline.

- Disponível em **Chrome e Edge** (File System Access API). Firefox e Safari usam o modo local.
- Na tela inicial, clique em **"Novo arquivo…"** ou **"Abrir arquivo…"** para começar.
- O app reabre automaticamente o último arquivo na próxima sessão (com permissão do navegador).
- Ideal para entrevistas clínicas, dados judiciais, pesquisas com aprovação de CEP que exijam ambiente air-gapped.

### Modo local — backup automático em pasta

No modo local (`localStorage`, limite de 5-10MB), você pode ativar um **backup automático**: o app passa a manter um arquivo `backup-automatico.qualilab` sempre atualizado numa pasta do seu computador — por exemplo, a mesma pasta onde está o `index.html`. É um espelho redundante, não o armazenamento principal: continua salvando no navegador normalmente, e também escreve esse arquivo em segundo plano a cada mudança (com uma pequena pausa antes de gravar, maior em projetos grandes, pra não travar a aba).

- Ative em **pílula do projeto → Backup automático em pasta → Escolher pasta…** (disponível em Chrome e Edge).
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

A `anon key` é pública por design e fica protegida pelas políticas de RLS. Você também pode informá-la em tempo de execução pela pílula do projeto → Conexão.

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
    └── *.qdpx        # projeto de exemplo (REFI-QDA) para testes
```

---

## Créditos e inspirações

O QualiLab foi desenvolvido por **Luiz Pimenta Filho** no âmbito do **LabDados / FGV Direito SP** como projeto pessoal. Não representa posição institucional da FGV, que não tem qualquer responsabilidade pelo software.

As principais inspirações foram:

- **[Taguette](https://www.taguette.org/about.html)** — ferramenta pioneira em QDA aberto, com suporte a múltiplos formatos de importação de documentos e exportação do codebook em REFI-QDA (`.qdc`). Se você aprecia pesquisa aberta, visite o projeto e considere uma doação.
- **[Magnolia](https://www.caledavis.eu/magnolia.html)** — QDA com foco em poder e intuitividade, transcrição de áudio/vídeo e análise de surveys. Um projeto impressionante e totalmente gratuito que merece sua atenção.
- **[QualCoder](https://github.com/ccbogel/qualcoder)** — QDA maduro e completo (codificação de texto, imagem, áudio e vídeo; relatórios e medidas de concordância), livre e de código aberto. Uma referência robusta para quem precisa de uma ferramenta de desktop full-featured.

Todos demonstram que é possível fazer ferramentas de qualidade sem cobrar das pessoas que mais precisam delas — e que vale a pena apoiá-las.

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
- **Sem histórico de versões** — não há desfazer (undo) ou log de auditoria de alterações; exclusões de documentos, códigos e categorias são definitivas.
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
- [ ] Pipeline de publicação de relatórios próprios por pesquisador / pesquisa
- [ ] Integração de IA (?) — em avaliação; ferramentas de QDA costumam dividir opiniões sobre IA, o uso teria que ser opt-in e transparente
