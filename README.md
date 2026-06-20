# QualiLab

**o seu laboratório de pesquisa qualitativa / your own lab for qualitative research**

QualiLab é uma ferramenta **gratuita e de código aberto** para análise qualitativa de dados. Ela roda inteira em um único arquivo `index.html` — sem instalação, sem servidor próprio, sem assinatura.

> Inspirado pelo excelente trabalho do **[Taguette](https://www.taguette.org/about.html)**, do **[Magnolia](https://www.caledavis.eu/magnolia.html)** e do **[QualCoder](https://github.com/ccbogel/qualcoder)**, projetos que merecem todo o seu reconhecimento. Se você usa ou aprecia ferramentas abertas para pesquisa qualitativa, visite os projetos deles e considere contribuir — são as referências que tornaram o QualiLab possível.

---

## Motivação

Ferramentas de análise qualitativa — ATLAS.ti, MAXQDA, NVivo — são poderosas, mas caras e fechadas. Pesquisadoras e pesquisadores sem acesso a financiamento institucional ficam excluídos de recursos básicos para o seu trabalho.

O QualiLab não resolve tudo, mas oferece um ponto de partida leve e aberto: codificação hierárquica de trechos, atributos por documento, reconciliação colaborativa e exportação em formato aberto (QDPX), tudo rodando no navegador.

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
- **Visualização** — navegação por código à esquerda; trechos do código selecionado à direita, em tipografia legível, agrupados por documento. Filtro por categoria e cruzamento por co-ocorrência.
- **Gráficos** — frequência de códigos, distribuição por categoria (gabarito), heatmap código × categoria, produção por codificador e concordância entre codificadores.

### Codificação colaborativa em camadas
Cada codificação registra o autor. O trabalho de cada pesquisador é independente (`layer = individual`); a equipe consolida uma **camada final** na tela de Reconciliação. O mesmo modelo vale para as respostas de categoria: cada pesquisador preenche a sua; o administrador define o gabarito.

### Tipos de projeto
Ao criar um projeto você escolhe:
- **Individual** — uso solo; tudo vai direto para a camada final, sem etapa de reconciliação.
- **Coletivo** — múltiplos pesquisadores codificam de forma independente e reconciliam depois.

### Importação e exportação

| Formato | Importa | Exporta | Notas |
|---|:---:|:---:|---|
| **QDPX** (REFI-QDA) | ✅ | ✅ | Interoperável com ATLAS.ti, MAXQDA, NVivo, Quirkos, Taguette, QualCoder. |
| **CSV — trechos** | — | ✅ | Um trecho por linha, com documento, código, camada e autor. |
| **CSV — atributos** | — | ✅ | Um documento por linha, com os valores de cada categoria. |
| **JSON** | — | ✅ | Projeto completo com camadas e autores. |

### Modo coletivo (nuvem)
Quando configurado com um projeto **Supabase**, o QualiLab passa a oferecer:
- Login por e-mail/senha (ou acesso como visitante)
- Tela **Meus Projetos** com histórico
- Sincronização **em tempo real** (Realtime) entre pesquisadores
- Controle de papéis: **admin** (define esquema e gabarito) e **membro** (preenche e codifica)
- Gestão completa: renomear, excluir projeto, adicionar/remover membros, promover admins

---

## Como funciona

O QualiLab abre em um de dois modos:

- **Local** — sem servidor. Dados ficam no `localStorage` do navegador. Funciona offline. Ideal para uso individual.
- **Nuvem** — usa **Supabase** (Postgres + Auth + Realtime). Projetos, documentos, códigos e codificações ficam na conta e são compartilhados por um código de projeto.

O modo é determinado pela presença das credenciais do Supabase no arquivo ou nas configurações em tempo de execução (botão **⚙**).

---

## Executando

Não há etapa de build. Basta servir o `index.html`:

```bash
# Python
python -m http.server 8000

# Node
npx serve .
```

Abra `http://localhost:8000`. Abrir pelo `file://` também funciona na maioria dos navegadores, mas servir via HTTP evita bloqueios de CORS.

As dependências (Preact, htm, pdf.js, mammoth, JSZip, supabase-js) são carregadas via CDN na primeira utilização — é necessária conexão com a internet.

---

## Configuração da nuvem

Para ativar o modo coletivo é necessário um projeto **Supabase** gratuito.

### 1. Credenciais

No topo do `index.html`, preencha:

```js
let SUPABASE_URL  = "https://SEU-PROJETO.supabase.co";
let SUPABASE_ANON_KEY = "SUA_ANON_KEY";
```

A `anon key` é pública por design e fica protegida pelas políticas de RLS. Você também pode informá-la pelo botão **⚙** dentro do app.

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
- **Nuvem** (opcional): [Supabase](https://supabase.com/)

O app é intencionalmente **um único arquivo** (`index.html`) com HTML, CSS e JavaScript. Fácil de inspecionar, copiar, hospedar e modificar.

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

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
