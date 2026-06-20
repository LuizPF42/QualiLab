# QualiLab

**o seu laboratório de pesquisa qualitativa / your own lab for qualitative research**

QualiLab é uma ferramenta **gratuita e de código aberto** para análise qualitativa de dados. Roda inteira em um único arquivo `index.html` — sem instalação, sem servidor próprio, sem assinatura.

> Inspirado pelo excelente trabalho do **[Taguette](https://www.taguette.org/about.html)**, do **[Magnolia](https://www.caledavis.eu/magnolia.html)** e do **[QualCoder](https://github.com/ccbogel/qualcoder)**, projetos que merecem todo o seu reconhecimento. Se você usa ou aprecia ferramentas abertas para pesquisa qualitativa, visite os projetos deles e considere contribuir — são as referências que tornaram o QualiLab possível.

---

## Motivação

Ferramentas de análise qualitativa — ATLAS.ti, MAXQDA, NVivo — são poderosas, mas sofrem de três problemas combinados: são **caras e fechadas**, têm uma **curva de aprendizado íngreme** que consome horas antes de qualquer análise começar, e oferecem pouco suporte a **categorias fechadas** (atributos estruturados por documento), obrigando pesquisadores a manter planilhas paralelas para o que deveria estar integrado.

O QualiLab busca ser o mais intuitivo possível: você carrega um documento, seleciona um trecho e já codifica — sem configuração prévia. Ao mesmo tempo, oferece um esquema de categorias nativo (texto fechado, múltipla escolha, caixa de seleção, data, texto livre) que convive com a codificação de trechos de forma integrada, no mesmo ambiente. Quem precisa conciliar análise temática com coleta estruturada de atributos não precisa mais alternar entre ferramentas.

---

## Recursos

### Documentos
Importe `.txt`, `.md`, `.docx` e `.pdf`, ou cole texto diretamente. O conteúdo é extraído e exibido para leitura e codificação.

### Codificação por trechos
Selecione qualquer trecho e aplique um código — ou clique com o **botão direito** para um menu de contexto rápido. Os códigos são **hierárquicos** (famílias → subcódigos), com cor por família e tonalidade por profundidade.

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

### Quatro telas principais

- **Codificação** — leitor à esquerda com grifos coloridos; painéis de categorias e de códigos à direita. Filtro **"Ver:"** para alternar entre camadas (individual, por codificador, final).
- **Reconciliação** — agrupa as codificações que se sobrepõem no mesmo código, mostra quantos codificadores concordam e permite **consolidar** na camada final (gabarito).
- **Visualização** — navegação por código à esquerda; trechos do código selecionado à direita, em tipografia legível, agrupados por documento. Filtro por categoria e cruzamento por co-ocorrência de até 2 códigos.
- **Gráficos** — frequência de códigos, distribuição por categoria (gabarito), heatmap código × categoria, produção por codificador e concordância entre codificadores.

### Codificação colaborativa em camadas
Cada codificação registra o autor. O trabalho de cada pesquisador é independente (`layer = individual`); a equipe consolida uma **camada final** na tela de Reconciliação. O mesmo modelo vale para as respostas de categoria: cada pesquisador preenche a sua; o administrador define o gabarito.

### Tipos de projeto
Ao criar um projeto você escolhe:
- **Individual** — uso solo; tudo vai direto para a camada final, sem etapa de reconciliação.
- **Coletivo** — múltiplos pesquisadores codificam de forma independente e reconciliam depois.

O tipo pode ser alterado depois pelo administrador (convertendo Coletivo → Individual de forma irreversível, colapsando todas as codificações num único autor).

### Gestão de projeto e membros
A **pílula do projeto** no cabeçalho abre o hub de gestão: código de convite para colaboradores, tipo do projeto, lista de membros com papéis (admin/membro), renomear, limpar conteúdo, excluir e configuração de conexão.

### Importação e exportação

| Formato | Importa | Exporta | Notas |
|---|:---:|:---:|---|
| **QDPX** (REFI-QDA) | ✅ | ✅ | Interoperável com ATLAS.ti, MAXQDA, NVivo, Quirkos, Taguette, QualCoder. Na exportação, prefere a camada final (gabarito) quando consolidada. |
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

### Modo nuvem — robusto a falhas de rede

- Codificações e valores de categoria que falham por queda de rede vão para uma **fila local** (IndexedDB) em vez de serem perdidos.
- O cabeçalho mostra `offline · N pendente(s)` em âmbar quando sem conexão e `sincronizando…` ao reconectar.
- A fila é enviada automaticamente quando a conexão é restaurada.

---

## Executando localmente

Não há etapa de build. Basta abrir o arquivo:

**Opção mais simples** — acesse diretamente em:
```
https://luizpf42.github.io/QualiLab
```

**Para rodar offline** com um servidor local (evita bloqueios de CORS em alguns navegadores):
```bash
python -m http.server 8000   # ou: npx serve .
```

**Para dados sensíveis** — baixe o `index.html`, abra no Chrome/Edge e use o modo **Arquivo local** (sem servidor necessário).

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

- **[Taguette](https://www.taguette.org/about.html)** — ferramenta pioneira em QDA aberto, com suporte a múltiplos formatos e exportação QDPX. Se você aprecia pesquisa aberta, visite o projeto e considere uma doação.
- **[Magnolia](https://www.caledavis.eu/magnolia.html)** — QDA com foco em poder e intuitividade, transcrição de áudio/vídeo e análise de surveys. Um projeto impressionante e totalmente gratuito que merece sua atenção.
- **[QualCoder](https://github.com/ccbogel/qualcoder)** — QDA maduro e completo (codificação de texto, imagem, áudio e vídeo; relatórios e medidas de concordância), livre e de código aberto. Uma referência robusta para quem precisa de uma ferramenta de desktop full-featured.

Todos demonstram que é possível fazer ferramentas de qualidade sem cobrar das pessoas que mais precisam delas — e que vale a pena apoiá-las.

---

## Licença

MIT License — livre para usar, modificar e distribuir, com ou sem fins comerciais, desde que o aviso de copyright seja mantido.

```
Copyright (c) 2026 Luiz Pimenta Filho
```
