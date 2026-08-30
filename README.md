<p align="center">
  <a href="https://luizpf42.github.io/QualiLab"><img src="images/logo.png" alt="QualiLab" width="180"></a>
</p>

# QualiLab

**o seu laboratório de pesquisa qualitativa / your own lab for qualitative research**

[![DOI](https://zenodo.org/badge/1274527946.svg)](https://doi.org/10.5281/zenodo.21935682)

QualiLab é uma ferramenta **gratuita e de código aberto** para análise qualitativa de dados. Roda inteira em um único arquivo `index.html`, sem instalação, sem servidor próprio, sem assinatura.

> Inspirado por **[Taguette](https://www.taguette.org/about.html)**, **[Magnolia](https://www.caledavis.eu/magnolia.html)**, **[QualCoder](https://github.com/ccbogel/qualcoder)** e **[OpenQDA](https://openqda.org/)** — projetos que merecem o seu apoio; os créditos estão [no fim](#créditos-referência-e-licença).

Acesse a ferramenta **[aqui](https://luizpf42.github.io/QualiLab)** / Instale como aplicativo **[aqui](docs/MANUAL.md#instalar-como-aplicativo-e-abrir-sem-internet)** — abre sem internet, ganha janela e ícone próprios, e o duplo clique num `.qualilab` passa a abrir no QualiLab; **no Windows, instale pelo Edge**.

📖 **Novo por aqui?** Comece pelo **[Manual de uso](https://luizpf42.github.io/QualiLab/manual.html)**: guia completo, passo a passo, de todas as telas. · 📝 **O que mudou em cada versão:** [`CHANGELOG.md`](CHANGELOG.md)

*A **versão em uso** aparece no cabeçalho e no rodapé do próprio app. Cite esse número ao relatar um problema: sem ele não há como saber qual build o seu navegador carregou.*

> ⚠️ **Leia antes de usar com dados reais.** O QualiLab é um projeto **pessoal e experimental**, sob licença **MIT, SEM QUALQUER GARANTIA**, que **não passou por auditoria de segurança**; **bugs são esperados**. E ele **não anonimiza** o seu material: a censura mascara só o que **você** marcou à mão, e só em algumas saídas. Para onde cada modo de uso leva os seus dados está em **[Onde os seus dados ficam](#onde-os-seus-dados-ficam)**; o que a ferramenta não faz por você, em **[Limites e responsabilidade](#limites-e-responsabilidade)**.
>
> **Isenção.** O QualiLab é um projeto pessoal de **[Luiz Pimenta Filho](https://orcid.org/0000-0002-5165-6232)**, no âmbito do **[LabDados / FGV Direito SP](https://direitosp.fgv.br/nucleos-de-pesquisa/laboratorio-dados-pesquisa-empirica-direito-labdados)**. **Não representa posição nem implica responsabilidade de qualquer instituição (incluindo a FGV).** O autor **não se responsabiliza** por perda de dados, vazamento, uso indevido ou quaisquer consequências do uso do software. Use por sua conta e risco, com as cautelas éticas e legais que a sua pesquisa exige.

---

## Por que existe

Um levantamento sistemático de 28 ferramentas de análise qualitativa, publicado em 2025 por Jan Küster e Karsten D. Wolf (Universidade de Bremen), conclui que **"o estado atual do CAQDAS é inadequado para sustentar plenamente práticas de pesquisa qualitativa de ciência aberta"**. Entre os achados: o campo é dominado por software proprietário (13 das 28 ferramentas examinadas), com licenças de **€95 a €430 por usuário/ano**; colaboração em tempo real existe em **5** das 28; trilha de auditoria do processo de análise, em **7**; política de segurança pública, em **2**; e, das 9 ferramentas com IA integrada, **nenhuma revela ao usuário o *system prompt*** que antecede as chamadas, enquanto apenas **2** permitem usar um modelo local ou próprio. Os autores registram ainda que as ferramentas veteranas "evoluíram para aplicações grandes, complexas e pesadas, com interfaces por vezes confusas".

A esses achados o QualiLab acrescenta uma queixa de prática que o levantamento não mede: o suporte a **categorias fechadas** (atributos estruturados por documento) é pobre nas ferramentas grandes, o que obriga o pesquisador a manter planilhas paralelas para o que deveria estar integrado à análise.

O QualiLab busca ser o mais intuitivo possível: você carrega um documento, seleciona um trecho e já codifica, sem configuração prévia. Ao mesmo tempo, oferece um esquema de categorias nativo (texto fechado, texto aberto, número, data, sim/não, múltipla escolha, caixa de seleção) que convive com a codificação de trechos de forma integrada, no mesmo ambiente. Quem precisa conciliar análise temática com coleta estruturada de atributos não precisa mais alternar entre ferramentas.

As ferramentas disponíveis, pagas ou gratuitas, também não têm colaboração e pesquisa coletiva como seus objetivos primários. O QualiLab busca encontrar um bom meio termo, sendo desenvolvido para necessidades individuais e coletivas: camadas de codificação por pesquisador, reconciliação, papéis de administrador e membro, tudo nativo, sem precisar de planilha paralela ou ferramenta de terceiros para coordenar a equipe.

> Küster, J.; Wolf, K. D. **The Current State of CAQDAS is Insufficient for Open Science Qualitative Research.** *Electronic Communications of the EASST*, v. 85 (deRSE25), 2025. DOI [10.14279/eceasst.v85.2709](https://doi.org/10.14279/eceasst.v85.2709), licença CC-BY 4.0. Os autores desenvolvem o [OpenQDA](https://openqda.org/), que integra a amostra examinada. Os números acima descrevem as 28 ferramentas que **eles** examinaram (o QualiLab não estava entre elas) e valem para o levantamento de 2025.

### Onde o QualiLab está nessa régua

Comparação direta com os achados de Küster & Wolf (2025) sobre 28 ferramentas de análise qualitativa. O número do meio é quantas das 28 atendem ao critério, segundo o levantamento deles.

| Critério | Levantamento (n=28) | QualiLab |
|---|---|---|
| Licença livre | 12 livres, 13 proprietárias, 3 sem licença | ✅ MIT |
| Custo por usuário/ano | €95 a €430 nas proprietárias | ✅ €0 |
| Roda sem competência técnica para instalar | apontado como **o** gargalo do software aberto do campo | ✅ é uma URL, sem instalação e sem build |
| Windows · macOS · Linux · Web | 13 · 12 · 7 · 18 | ✅ os quatro |
| Interoperabilidade REFI-QDA completa | 9 (sendo 7 proprietárias) | ✅ QDPX + QDC, validados contra o `Project.xsd` oficial |
| Colaboração em tempo real | 5 | ✅ |
| Sem servidor obrigatório | 20 oferecem alguma forma de *on-premise* | ✅ o modo Arquivo não tem servidor nenhum; a nuvem pode ser a sua |
| Exportação sem perda para revisão | "a perda de dados na exportação impossibilita a reprodução" | ✅ o `.qualilab` é *round-trip* completo |
| **`system prompt` da IA visível ao usuário** | **0** | ✅ o prompt inteiro é exibido antes de enviar |
| **`system prompt` editável** | 0 | ✅ postura, instruções e memos injetados |
| Modelo de IA local ou próprio | 2 | ✅ Ollama local, endpoint próprio, Azure |
| Análise de IA sem passar por servidor do fornecedor | 0 entre as proprietárias | ✅ BYOK, o navegador chama o provedor direto |
| Codificar texto · PDF | 26 · 6 | ✅ os dois (no PDF, texto **e** região) |
| Codificar áudio · vídeo · imagem · planilha | 11 · 12 · 11 · 2 | ❌ fora de escopo (abaixo) |
| **Trilha de auditoria do processo** | 7 | ❌ ainda não |
| Metadado de citação (`CITATION.cff`) | 3 | ✅ |
| Política de segurança pública | 2 | ✅ [`SECURITY.md`](SECURITY.md) |
| Arquivado com DOI (Zenodo) | 4 | ✅ [`10.5281/zenodo.21935682`](https://doi.org/10.5281/zenodo.21935682) |
| Arquitetura de plugins · scripts | 1 · 3 | ❌ por decisão (abaixo) |

**O que fica de fora por escopo, e não por acaso.** O QualiLab é uma ferramenta de **texto e PDF**. Áudio, vídeo e imagem exigem anotação sobre linha do tempo ou sobre pixels, que é outro produto e não uma funcionalidade a mais. Para isso, veja o [ELAN](https://archive.mpi.nl/tla/elan/), o [Transana](https://www.transana.com/), o [dicto](https://dictoapp.github.io/dicto/) ou o [QualCoder](https://github.com/ccbogel/qualcoder).

**Extensibilidade por dados, não por plugins.** O QualiLab não tem arquitetura de plugins, e não pretende ter: ela briga de frente com o desenho de arquivo único que faz o app rodar sem instalação e sem build. O que ele oferece no lugar são três superfícies abertas: o formato **`.qualilab`** (sem perda, documentado), a exportação em **REFI-QDA** e **W3C Web Annotation**, e um **servidor MCP de leitura** que deixa qualquer assistente ler o corpus com a censura já aplicada.

---

## O que ele faz

Uma linha por recurso: aqui é o inventário. O **passo a passo** de cada um está no [manual do usuário](docs/MANUAL.md).

### Material

| Recurso | O que é |
|---|---|
| **Formatos de entrada** | `.txt`, `.md`, `.docx`, `.pdf` e colar texto. Planilha (`.csv`/`.xlsx`): cada linha vira um documento. Pasta do **Zotero** (RDF): cada referência com PDF vira um documento, os metadados viram categorias e a referência vira memo |
| **Reflow de PDF** | detecta **colunas** (artigo em duas colunas deixa de sair embaralhado), remove cabeçalho, rodapé e número de página repetidos, remonta parágrafos independentemente da entrelinha, corrige hifenização de fim de linha e de-duplica sobre-impressão |
| **`.docx` sem sujeira** | títulos, listas e tabelas viram texto limpo por quebra de linha e indentação, **sem marcadores injetados** (que virariam conteúdo codificável) |
| **PDF original** | a página de verdade, com os seus grifos desenhados sobre ela; dá para selecionar e codificar ali |
| **OCR no navegador** | a página inteira ou **por área** (arraste um retângulo, revise o texto lido, codifique). Offline, sem servidor |
| **Página do trecho** | a correspondência trecho ↔ página sobrevive à ida e volta e aparece na Leitura, no Relatório e nos exports (CSV/JSON/W3C) |
| **Editar o texto extraído** | corrige a extração e **reancora automaticamente os grifos** já feitos |
| **Sinal de qualidade** | avisa quando um documento provavelmente saiu mal extraído (vazio, sem espaços entre palavras, glifos quebrados, OCR de baixa confiança) |

### Codificação e esquema

| Recurso | O que é |
|---|---|
| **Codificar trechos** | selecione e aplique pelo botão direito; **Ctrl+Z** desfaz a última |
| **Códigos hierárquicos** | cor por família e tonalidade por profundidade; matiz e saturação personalizáveis, propagados à subárvore |
| **Família × código** | uma regra só: quem tem subcódigos **agrupa** e não recebe trechos; a contagem da família soma os filhos |
| **Categorias do documento** | sete tipos (texto fechado, texto aberto, número, data, sim/não, múltipla escolha, caixa de seleção). A descrição de cada uma é a **instrução de codificação** — o mesmo texto que a pessoa lê e que entra no prompt da IA |
| **Esquema em lote** | agrupar, mesclar, promover a Hierarquia 0, **dividir** um código em subcódigos, e um **mapa espacial** dos códigos |
| **Busca** | literal (expressão regular, maiúsculas, palavra inteira) e global em todo o corpus |
| **Censura** | um código marcado 🚫 mascara os trechos dele nas saídas de transparência e no que vai para a IA |

**Busca semântica (`≈ termos`), sem chave e sem servidor.** Você descreve o *sentido* que procura e o app sugere **palavras e expressões do seu próprio corpus** próximas dele; clicar dispara a busca **literal** por elas. Roda com [transformers.js](https://github.com/huggingface/transformers.js) e o modelo [`paraphrase-multilingual-MiniLM-L12-v2`](https://huggingface.co/Xenova/paraphrase-multilingual-MiniLM-L12-v2) **dentro do navegador**: o modelo vem até os dados, não o contrário — por isso vale nos modos arquivo e rascunho sem quebrar a promessa de privacidade deles. Custo: um download único (~113 MB no caminho WASM, ~224 MB no WebGPU) e ~10 s na primeira consulta da sessão. O índice é cache local, refeito quando o corpus muda, e **não viaja** no `.qualilab`.

### Telas

| Tela | Para quê |
|---|---|
| **Codificação** | o leitor com os grifos, mais os painéis de categorias e de códigos |
| **Reconciliação** | *(coletivo)* agrupa as codificações sobrepostas, mostra quem concorda e consolida o gabarito |
| **Leitura** | reler o resultado: o documento inteiro com os grifos no contexto, ou todos os trechos de um código |
| **Gráficos** | frequência, nuvem de palavras, co-ocorrência, cobertura, código × atributo, tempo e concordância entre codificadores. Clicar numa barra abre a Leitura naquele código. Opção de **texturas nas barras** (hachuras) para distinguir cores parecidas — útil para daltonismo, e sai junto no SVG/PNG exportado |
| **Memos** | nota analítica por projeto, documento, código **ou trecho**, compartilhada e co-editável |
| **Esquema** | organizar códigos e categorias em lote |
| **Relatório** | o hub de publicação (abaixo) |

### Equipe e projeto

| Recurso | O que é |
|---|---|
| **Camadas** | cada pesquisador codifica na sua (`individual`); a equipe consolida um gabarito (`final`) na Reconciliação. Vale também para as respostas de categoria |
| **Papéis** | admin e membro, **impostos pelo servidor** (RLS), não escondidos na interface: excluir documento ou código, editar texto compartilhado, mesclar códigos e importar exigem admin |
| **Distribuição de documentos** | matriz documentos × pesquisadores, com rodízio: cada um só **enxerga** o que lhe foi atribuído |
| **Codificação cega** | cada um só enxerga o **próprio** trabalho (o gabarito também some). Com o mesmo documento para duas pessoas, o estudo fica duplo-cego |
| **Tipos de projeto** | individual (tudo vai direto ao gabarito) ou coletivo |
| **Tempo real** | codificações e respostas de categoria sincronizam ao vivo; esquema de códigos e categorias exigem recarregar |
| **Onde os dados ficam** | arquivo no disco, rascunho no navegador ou nuvem — trocar entre eles é um clique no hub do projeto, sem exportar e importar à mão |
| **Sua própria nuvem** | apontar o app para um projeto **Supabase seu**, pela tela de entrada ou pelo hub |

### IA: desligada por padrão, e com a sua chave

**Ela vem desligada, e ligar é um ato.** Todo projeto novo — na nuvem, em arquivo ou no rascunho — pergunta se os recursos de IA ficam disponíveis, e a opção que **já vem marcada é "Sem IA"**: ativar exige trocar a escolha, e fechar sem responder mantém desligado. A escolha tem três alcances (**ninguém** · **só administradores** · **todos**), é **imposta no banco** e não só escondida na interface, e **viaja dentro do `.qualilab`**.

Um selo no cabeçalho mostra o estado o tempo todo — **✔︎** ativada, **~~IA~~** desligada — e é por ele que se troca. Com a IA desligada as telas somem; com ela ligada, **nada é enviado a modelo nenhum sem você pedir**: toda chamada é um clique seu.

**O padrão é o navegador chamar o provedor direto**: com a sua chave (guardada só no navegador), **nenhum servidor do QualiLab vê o material** da análise. A Edge Function `ai-ask` cobre só dois casos: um endpoint *Personalizado*/*Azure* que não libere chamadas de navegador (CORS) e uma eventual chave de servidor — que a instância pública não tem.

| Recurso | O que é |
|---|---|
| **Auto-codificação** | cinco assistentes: **Sugerir Codificação** (segunda codificadora, recall) · **Sugerir Categorização** (preenche categorias existentes) · **Definir Categoria** (escreve a instrução a partir do gabarito que você já deu) · **Organizar Códigos** · **Repetir Codificação** (esta **sem IA**: acha ocorrências exatas). Em todos: a IA **propõe**, você aprova ou recusa **item a item**, nada é gravado sem confirmação |
| **Analisar com IA** | conversa sobre o material que você recorta (documentos, trechos por código, ou os dois), citando as fontes, com postura metodológica escolhível e prompts salvos |
| **Explorar com IA** *(experimental)* | a IA **pede** o material em vez de receber um recorte pronto, por ferramentas de só-leitura; **cada chamada aparece na tela**, lida do dado e não da narração do modelo |
| **Prompt visível e editável** | o **⚙ Configurar Prompt** mostra o que será enviado, seção por seção, com o modelo ativo, a estimativa de tokens e o **custo em R$** — antes de enviar |
| **Modo cego** | a IA responde **sem ver** o seu gabarito e o painel devolve um placar de concordância: deixa de ser conferente e vira régua |
| **Memória do projeto** | diário de insights entre sessões; a IA propõe, você aprova, e cada entrada tem interruptor de uso |
| **Provedores** | Gemini, OpenAI, Anthropic, Azure OpenAI, qualquer API no formato clássico da OpenAI (DeepSeek, Mistral, Qwen, vLLM) e **Ollama local** — o único em que nada sai da sua máquina |
| **Corte de material avisado** | há teto por documento e por envio; sempre que algo é cortado, uma faixa diz **quantos documentos ficaram de fora** e quantos entraram só pelo começo |

> **Ressalva honesta:** desligar a IA **não é bloqueio técnico** — qualquer pessoa copia um trecho e cola noutra ferramenta. O que a chave tira do aplicativo é o trabalho **em massa**, que é o que de fato desloca uma análise. Por isso o Relatório **relata** o que passou pelo QualiLab, em vez de prometer que nada passou por fora.

### Publicação e transparência

| Saída | O que é |
|---|---|
| **Relatório Interativo (ATI)** | página HTML **auto-contida** (sem servidor) com os trechos grifados clicáveis; clicar abre a nota analítica num painel lateral. Equivale ao *overlay* da **Annotation for Transparent Inquiry** do QDR, hospedável por você |
| **Relatório Padrão** | montador por seções, com prévia ao vivo, **copiar texto** e **imprimir / PDF** |
| **Web Annotation (W3C)** | as anotações no [padrão aberto do W3C](https://www.w3.org/TR/annotation-model/) (JSON-LD), a mesma língua de dados sob o ATI, o [hypothes.is](https://web.hypothes.is/), o Anno-REP e o Dataverse |

Em projeto coletivo as três respeitam a camada escolhida; em todas, os trechos de **censura** saem mascarados, e ATI e W3C ainda oferecem **anonimizar a autoria**.

### Apontar o seu assistente para o corpus

*Experimental, e não faz parte do app: vive num repositório próprio, de onde qualquer pessoa instala.*

Se você já paga uma assinatura de Claude ou de ChatGPT, dá para usá-la: em vez de o QualiLab falar com o modelo pela sua chave, **o cliente que você já usa** alcança o corpus. [**LuizPF42/QualiLab-plugin**](https://github.com/LuizPF42/QualiLab-plugin) empacota um servidor **MCP de só-leitura**. O assistente ganha as **mesmas ferramentas** da tela Explorar com IA (a MCP/RAG de até a v1.4.37) — literalmente o mesmo código, extraído do `index.html` —, com o mesmo vocabulário e as mesmas regras de conduta.

Você aponta uma **pasta**, não um arquivo: o assistente lista os projetos que estão lá e abre o que você pedir. **Nenhuma ferramenta escreve.** A censura vale igual, com uma ressalva honesta: no chat do Claude a máscara é fronteira real, porque o servidor é o único caminho até o corpus; num cliente **agêntico** ele tem ferramentas de arquivo próprias e o `.qualilab` carrega o texto cru, então ali ela é convenção respeitada, não tranca.

---

## Onde os seus dados ficam

É a pergunta que decide o quanto da ferramenta você pode usar, e a resposta depende do modo. A regra de ouro: **o material só sai do seu dispositivo se você deixar.**

- **Arquivo / Rascunho**: ficam **no seu dispositivo** e não saem dele.
- **Nuvem**: são enviados a um **servidor de terceiros** (Supabase), ficam sujeitos aos termos desse provedor e saem do seu controle direto.
- **IA**: **vem desligada** — todo projeto nasce sem ela, e ativar é um ato ([abaixo](#ia-desligada-por-padrão-e-com-a-sua-chave)). Depois de ativada, os trechos que você **pedir** para analisar são enviados ao **provedor de IA** que você usar (Gemini/OpenAI/Anthropic/Azure…), sob a política dele; o **Ollama local** é a exceção (roda na sua máquina, nada sai dela). A censura é mascarada antes do envio.
- **Publicação** (Relatório Interativo / Web Annotation): o que você divulgar fica **público**.

O QualiLab opera em três modos, escolhidos na **tela de entrada** (ou reabertos automaticamente):

| Modo | Armazenamento | Indicador | Quando usar |
|---|---|---|---|
| **Arquivo** | Arquivo `.qualilab` no disco | `arquivo ·` | Trabalho solo sério, dados sensíveis, uso offline |
| **Nuvem** | Supabase (Postgres + Auth) | `nuvem ·` | Equipes colaborativas, múltiplos dispositivos |
| **Rascunho** | `localStorage` do navegador | `rascunho ·` | Só testar rápido, sem compromisso (efêmero) |

Arquivo e nuvem são as opções de trabalho de verdade; o **rascunho** é a entrada sem fricção (um clique, zero configuração), mas **efêmero**: os dados ficam só naquele navegador e somem se você limpar os dados do site. Por isso um aviso discreto abaixo do cabeçalho sugere, a qualquer momento, **salvar como arquivo** ou **conectar à nuvem** (a migração é de um clique no hub do projeto, sem exportar/importar). Um arquivo já aberto **reabre sozinho** na próxima sessão (com a permissão do navegador); "Sair deste arquivo" no hub volta à tela de entrada.

### Modo arquivo: para dados sensíveis

No modo arquivo, o projeto é salvo como um arquivo `.qualilab` (JSON) **visível no sistema de arquivos**: em qualquer pasta, HD externo, volume criptografado ou servidor institucional. Zero tráfego de rede. Zero localStorage. Funciona completamente offline.

- Disponível em **Chrome e Edge** (File System Access API). Firefox e Safari usam o modo local.
- Na tela inicial, clique em **"Novo arquivo…"** ou **"Abrir arquivo…"** para começar.
- O app reabre automaticamente o último arquivo na próxima sessão (com permissão do navegador).
- Ideal para entrevistas clínicas, dados judiciais, pesquisas com aprovação de CEP que exijam ambiente air-gapped.

### Modo rascunho: backup automático em pasta

No modo rascunho (`localStorage`, limite de 5-10MB), você pode ativar um **backup automático**: o app passa a manter um arquivo `backup-automatico.qualilab` sempre atualizado numa pasta do seu computador, por exemplo a mesma pasta onde está o `index.html`. É um espelho redundante, **não** o mesmo que o modo arquivo (que grava direto no disco como armazenamento principal): continua salvando no navegador normalmente, e também escreve esse arquivo em segundo plano a cada mudança (com uma pequena pausa antes de gravar, maior em projetos grandes, pra não travar a aba). Para virar modo arquivo de verdade (pílula verde), use **"Salvar como arquivo"** no hub do projeto.

- Ative em **pílula do projeto → Backup automático em pasta → Escolher pasta…** (disponível em Chrome e Edge).
- Se o app não conseguir salvar de verdade (`localStorage` cheio, navegador sem suporte), um aviso vermelho aparece na tela com um atalho pra baixar o projeto na hora; isso não depende do backup automático estar ativado.

### Modo nuvem: status de conexão

- O cabeçalho mostra um indicador `offline` em âmbar quando a conexão cai.
- **Escrita que falha por motivo passageiro entra numa fila e sobe sozinha** (desde a v1.4.7). Vale para o trabalho do dia a dia: codificações, respostas de categoria, notas, conversas salvas da IA e memórias. A alteração continua aparecendo na tela enquanto espera, o cabeçalho mostra quantas estão pendentes (clique para tentar na hora) e **fechar a aba não perde a fila** — ela volta ao reabrir o projeto.
- Mudanças **estruturais** ficam de fora da fila de propósito e avisam na hora se falharem: criar/excluir documento, mexer no esquema de códigos, gestão do projeto e importações. Numa pesquisa coletiva, reaplicar esse tipo de mudança minutos depois produziria um estado que ninguém pediu.
- Se a nuvem **recusar** de vez uma alteração (seu papel no projeto mudou, ou outra pessoa excluiu o alvo), ela não some calada: aparece um aviso do que foi recusado, com atalho para baixar um `.qualilab` antes de refazer.

**O QualiLab NÃO anonimiza nem identifica dados pessoais** (nomes, CPF, dados de saúde) no conteúdo dos documentos. A **censura** mascara apenas os trechos que **você** marcou à mão, **não** detecta sozinha o que é sensível e **não** cobre as exportações (QDPX/CSV/JSON saem com o texto cru). **Não há rede de segurança automática.**

---

## Executando localmente

Não há etapa de build. Basta abrir o arquivo:

**Opção mais simples:** acesse diretamente em:
```
https://luizpf42.github.io/QualiLab
```

**Instalável como aplicativo (PWA):** "Instalar QualiLab" na barra de endereço dá janela própria e ícone no menu iniciar/dock. Instalado, o app **abre sem internet desde a primeira visita** (a cópia offline é guardada na instalação; com rede, vem sempre a versão mais nova, e a barra de status avisa quando há atualização) e o **duplo clique num `.qualilab` abre no QualiLab**, como um `.docx` abre no Word. **No Windows, instale pelo Edge**: é ele que registra o `.qualilab` no sistema com nome de tipo e ícone próprios — pelo Chrome a instalação funciona, mas os ícones dos `.qualilab` saem **quebrados** — a folha em branco genérica do Explorer (limitação do Chrome no Windows, não do QualiLab). O que é um PWA, por que instalar e o passo a passo estão no manual, em **[Instalar como aplicativo](docs/MANUAL.md#instalar-como-aplicativo-e-abrir-sem-internet)**.

**Para usar offline:** baixe o `index.html` e dê duplo clique pra abrir direto no navegador (`file://`), **sem precisar de servidor**: ele só importa bibliotecas externas via URL `https://` (nunca por caminho de arquivo local), então não bate no bloqueio clássico de módulo ES via `file://`. Em Chrome/Edge dá pra usar inclusive o modo **Arquivo local**, que salva o projeto como `.qualilab` visível no disco, ao lado do `index.html`.

**Se ainda assim algo não carregar** (extensão de segurança, política de navegador corporativo, ou outro navegador com bloqueio mais estrito de `file://`), sirva por um servidor local como alternativa:
```bash
python -m http.server 8000   # ou: npx serve .
```

O **núcleo do front-end (Preact + htm) vem embutido** no próprio `index.html`, então o app abre e chega à tela inicial **mesmo sem rede**. As demais bibliotecas (pdf.js, mammoth, JSZip, sql.js, XLSX, tesseract.js, transformers.js e o supabase-js) são carregadas **por CDN e sob demanda**: cada uma só é buscada quando você usa o recurso que depende dela, e a falta de rede derruba **aquele recurso**, com uma mensagem, em vez do app inteiro.

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

Abra o **SQL Editor** do Supabase, cole o conteúdo de [`supabase/schema.sql`](supabase/schema.sql) e clique em **Run**. O script é idempotente (pode rodar mais de uma vez) e cria todas as tabelas, funções (RPC), políticas de RLS e a configuração de realtime. **Atualizando um projeto já existente?** Basta rodar o `schema.sql` de novo. Por ser idempotente, ele adiciona o que faltar (ex.: a tabela `ia_memory` da memória de projeto da IA) sem mexer nos dados existentes.

### 3. Autenticação

Em **Authentication → Providers**:
- Habilite **Email** para login por e-mail e senha. A **recuperação de senha** ("Esqueci minha senha") já funciona com isso: o app manda o link de redefinição de volta para a própria URL do app, que precisa estar em **Auth → URL Configuration → Redirect URLs** (a mesma entrada `.../**` usada pelo login com Google já serve). ⚠️ **Atenção ao SMTP embutido do Supabase: são ~2 e-mails por hora, e a cota é do projeto** (medido em jul/2026), **compartilhada entre a confirmação de cadastro e a recuperação de senha**. Ou seja: duas pessoas usando na mesma hora e a terceira não recebe nada. Para uso real, **configure um SMTP próprio** em `Authentication > Emails > SMTP Settings`: aí o limite começa em 30/hora e fica ajustável em `Authentication > Rate Limits`. Serve qualquer serviço com SMTP (Brevo, Resend, AWS SES, Postmark, SendGrid, ZeptoMail); o **Brevo** dispensa domínio próprio, pois verifica um remetente individual.
- **Não** habilite *Allow anonymous sign-ins*: o QualiLab não usa mais modo visitante. Os três fluxos são **arquivo** (no disco), **nuvem** (com login) e **rascunho** (local, temporário).
- **A confirmação de cadastro é por CÓDIGO DIGITADO, não por link** (v1.4.19). O app abre uma tela pedindo o número que chega por e-mail, então o template **Authentication → Emails → Confirm signup** precisa mandar `{{ .Token }}`, e **não** `{{ .ConfirmationURL }}`. Existe porque antivírus de link de caixa corporativa (Safe Links e afins) **abre o link sozinho** e o queima antes do clique da pessoa, o que dava "link inválido ou expirado" a quem nunca tinha clicado. ⚠️ **O Supabase só libera a edição de templates com SMTP próprio configurado**: sem ele vale o template padrão deles, que manda um link — ou seja, **configure o SMTP antes do template**, senão a tela do app pede um número que o e-mail não traz. O tamanho do código é do projeto (**Authentication → Providers → Email**, de 6 a 10 dígitos); o app aceita qualquer um deles e não promete quantidade.
- Alternativa: desative **Confirm email** e o cadastro entra direto, sem código nenhum.

### 4. IA (Edge Function `ai-ask`: opcional, só para chave de servidor e fallback de CORS)

O **padrão é BYOK**: cada pesquisador traz a sua chave e o **navegador chama o provedor direto**, sem passar por servidor nenhum. Nesse caminho a função **não é usada**. Faça o deploy dela se você for (a) oferecer uma **chave de servidor** (mantida fora do HTML público) ou (b) dar suporte a endpoints *Personalizado*/*Azure* que não liberem chamadas de navegador (CORS) — aí a função faz o proxy. O **Ollama local** nunca a usa (o servidor do Supabase não alcança o `localhost` do pesquisador).

1. **(Opcional, só se for oferecer uma chave de servidor)** Gere uma chave do provedor: [Gemini](https://aistudio.google.com/apikey) (gratuito), [OpenAI](https://platform.openai.com/api-keys) ou [Anthropic](https://console.anthropic.com/settings/keys). Pule este passo se cada pesquisador for usar a própria chave (BYOK).
2. **Secrets** → em *Edge Functions → Secrets*, adicione `GEMINI_API_KEY` e/ou `OPENAI_API_KEY` e/ou `ANTHROPIC_API_KEY` (configure só o(s) que for usar). Opcional: `GEMINI_MODEL`/`OPENAI_MODEL`/`ANTHROPIC_MODEL` pra trocar o modelo padrão de cada um (`gemini-3.1-flash-lite`/`gpt-5.4`/`claude-sonnet-4-6`) sem reeditar o código.
3. **Deploy** → em *Edge Functions*, crie/edite a função `ai-ask`, cole o conteúdo de [`supabase/functions/ai-ask/index.ts`](supabase/functions/ai-ask/index.ts) e clique em **Deploy**. (Sem CLI necessária.)

Sem nenhuma chave configurada, as telas de IA retornam um erro claro; o restante do app funciona normalmente.

**Chave pessoal (BYOK)**: em **Minha Conta**, cada pesquisador pode informar a própria chave (de qualquer um dos três provedores) e escolher o modelo. Ela fica salva só no navegador dele (nunca no servidor) e passa a valer pras análises dele — que vão **direto** do navegador ao provedor. Os provedores **Azure** e **Personalizado** são BYOK puro (nunca usam chave de servidor) e são os únicos que podem recair na Edge Function, quando o endpoint não libera o navegador. O **Ollama local** dispensa toda esta configuração de servidor (ver "Análise com IA" acima).

---

## Formatos e interoperabilidade

Nada do que você produz aqui fica preso aqui. Esta seção reúne o que entra, o que sai, e o que cada formato preserva ou perde.

### Importação e exportação

| Formato | Importa | Exporta | Notas |
|---|:---:|:---:|---|
| **`.qualilab`** (nativo) | ✅ | ✅ | O projeto inteiro, sem perda, em qualquer modo. Ao importar num projeto coletivo, **preserva a resposta de cada pesquisador** de origem. Formato aberto e documentado ([abaixo](#o-qualilab-não-é-um-formato-mágico)) |
| **QDPX** (REFI-QDA) | ✅ | ✅ | Intercâmbio com ATLAS.ti, MAXQDA, NVivo, Quirkos, QualCoder. O pacote gerado é **validado contra o `Project.xsd` oficial (v1.0)** por um harness de round-trip mantido no repositório de desenvolvimento — o que é **tentativa de intercompatibilidade, não garantia**. Importa `.qdpx` do ATLAS.ti com os PDFs |
| **QDC** (codebook REFI-QDA) | ✅ | ✅ | Só o livro de códigos (é o que o formato tem). Compatível com o codebook do Taguette |
| **`.sqlite3`** (Taguette) | ✅ | ✕ | O projeto nativo do Taguette lido direto no navegador, via [sql.js](https://github.com/sql-js/sql.js): documentos, tags com hierarquia e trechos |
| **Zotero RDF** (pasta) | ✅ | ✕ | Coleção exportada com arquivos. Você escolhe quais metadados viram categorias e o que é listado, pelo nome, antes de entrar |
| **Planilha** (`.csv`/`.xlsx`) | ✅ | ✅ | Uma linha por documento na ida; e o **CSV de atributos tem caminho de volta** — preencha na planilha e reimporte, com prévia do que muda antes de gravar |
| **Web Annotation (W3C)** · **Leitor ATI** | ✕ | ✅ | Na aba Relatório. Censura mascarada |
| **CSV de trechos** · **JSON** | ✕ | ✅ | Um trecho por linha (documento, código, camada, autor); ou o projeto completo com camadas e autores |

> Os formatos de **trabalho e migração** saem **crus, censura inclusive**: é por eles que você leva o seu material para outra ferramenta e o traz de volta, e mascarar ali seria perda irreversível. Quem mascara são as saídas de **transparência**. O menu de exportação avisa isso na hora.

### O `.qualilab` não é um formato mágico

O formato nativo é **deliberadamente legível por máquina**, e isso é resposta direta à queixa do levantamento contra formatos de projeto fechados que viram silos de dados. Não há binário proprietário, não há esquema secreto, e **não é preciso ter o QualiLab para ler um `.qualilab`**.

São duas formas, escolhidas pelo conteúdo:

- **Sem PDF: JSON puro.** Um projeto só-texto abre em qualquer editor de texto. Os arquivos em [`examples/`](examples/) são assim.
- **Com PDF: um zip** com `project.json`, `pdfs/<docId>.pdf` (guardados sem recompressão) e `pdfindex/<docId>.json` (a correspondência trecho ↔ página ↔ retângulo, que é o que faz "ver original", o número de página e o OCR sobreviverem à ida e volta).

A leitura decide pelo **primeiro byte** (`PK` = zip), então arquivos antigos, anteriores ao contêiner, continuam abrindo. O `project.json` tem nove chaves de topo: `_meta`, `documents`, `categories`, `doc_values`, `codes`, `codings`, `memos`, `ia_results` e `ia_memory`.

Ler é isto, sem dependência nenhuma além da biblioteca padrão:

```python
import json, zipfile

def abrir(caminho):
    with open(caminho, "rb") as f:
        zipado = f.read(2) == b"PK"
    if zipado:
        with zipfile.ZipFile(caminho) as z:
            return json.loads(z.read("project.json"))
    with open(caminho, encoding="utf-8") as f:
        return json.load(f)

db = abrir("meu_projeto.qualilab")
nome = {c["id"]: c["name"] for c in db["codes"]}
texto = {d["id"]: d["content"] for d in db["documents"]}

for t in db["codings"]:
    print(nome[t["code_id"]], "|", t["layer"], "|", t["author_name"], "|", t["quote"])
```

**Tudo se ancora em posição de caractere.** Cada trecho é `(document_id, span_start, span_end)` sobre o `content` do documento, que é texto puro. Ou seja, você pode recortar por conta própria e **conferir a promessa**:

```python
assert all(t["quote"] == texto[t["document_id"]][t["span_start"]:t["span_end"]]
           for t in db["codings"])
```

Nos exemplos do repositório isso vale para todos os trechos. É a mesma invariante que o servidor MCP e os testes de censura verificam, e é ela que permite reprocessar o corpus fora do app sem depender de nada nosso.

Duas coisas que **não** estão no arquivo, e é bom saber: a **distribuição de documentos** (ela depende de identificadores de usuário que só existem na nuvem) e os **caches derivados**, como o índice da busca semântica, que é refeito quando o corpus muda. E uma que **está**: o `.qualilab` é formato de **trabalho**, então carrega o texto **cru, censura inclusive** — mascarar aqui destruiria dado de forma irreversível. Quem mascara são as saídas de transparência (ATI, W3C) e o prompt da IA.

### Formato de intercâmbio

Os formatos **QDPX** (projeto completo) e **QDC** (livro de códigos) são definidos pela **[REFI-QDA Standard](https://www.qdasoftware.org/)**, o padrão aberto criado pela *Rotterdam Exchange Format Initiative (REFI)* para permitir a troca de projetos entre ferramentas de análise qualitativa. A importação e exportação desses formatos no QualiLab seguem essa especificação; todo o crédito pelo formato é da iniciativa REFI-QDA. Conheça e apoie o padrão em [qdasoftware.org](https://www.qdasoftware.org/).

**Declaração de conformidade** (a versão 1.0 do padrão, §6, pede que o software diga a que partes ele reivindica conformidade): o QualiLab **importa e exporta as duas** — *Project exchange* (`.qdpx`) e *Codebook exchange* (`.qdc`). Os pacotes gerados são validados contra o `Project.xsd` oficial (v1.0) por um harness de round-trip mantido no repositório de desenvolvimento. Duas ressalvas honestas, porque conformidade de schema não é compatibilidade: o padrão não tem onde guardar autoria de atributo por pesquisador nem camada de codificação, então o `.qdpx` sempre perde algo em relação ao `.qualilab` (o app diz o quê, no momento em que você exporta); e schema válido não substitui testar na ferramenta de destino real.

### Transparência ativa (DA-RT / QDR / ATI)

Além do intercâmbio entre ferramentas de QDA, o QualiLab mira o ecossistema de **transparência da pesquisa qualitativa** ligado ao movimento **DA-RT** (*Data Access and Research Transparency*) e ao **[Qualitative Data Repository (QDR)](https://qdr.syr.edu/)**. O método atual do QDR é a **Annotation for Transparent Inquiry (ATI)**: anotar passagens de um texto com notas analíticas, excertos e links para as fontes que sustentam cada afirmação.

A camada técnica sob o ATI (e sob o [hypothes.is](https://web.hypothes.is/), o Anno-REP e o repositório Dataverse) é o **[W3C Web Annotation Data Model](https://www.w3.org/TR/annotation-model/)**, uma recomendação aberta do W3C. O QualiLab **mira nesse padrão**, não numa ferramenta específica: a aba **Relatório** gera tanto o **Relatório Interativo (ATI)** (uma página HTML auto-contida equivalente ao *overlay* do ATI, hospedável por você) quanto a exportação **Web Annotation (W3C)** em JSON-LD, interoperável com qualquer ferramenta que fale o padrão. Assim, a "nota analítica" de cada trecho (e dos códigos, documentos e do projeto) vira um apêndice de transparência publicável, sem depender de nenhum fornecedor.

---

## Como é feito, e como se verifica

Sem build, sem bundler, sem framework pesado.

- **UI**: [Preact](https://preactjs.com/) + [htm](https://github.com/developit/htm), **embutidos no `index.html`** (UMD, ~17 KB) — é o que faz o app renderizar sem depender de rede
- **PDF**: [pdf.js](https://github.com/mozilla/pdf.js)
- **DOCX**: [mammoth](https://github.com/mwilliamson/mammoth.js)
- **QDPX**: [JSZip](https://stuk.github.io/jszip/)
- **Import Taguette (`.sqlite3`)**: [sql.js](https://github.com/sql-js/sql.js) (SQLite compilado para WASM)
- **Busca semântica**: [transformers.js](https://github.com/huggingface/transformers.js) + o modelo de *embeddings* [`paraphrase-multilingual-MiniLM-L12-v2`](https://huggingface.co/Xenova/paraphrase-multilingual-MiniLM-L12-v2) (ONNX, baixado sob demanda e executado **no navegador**; nenhuma chave, nenhuma chamada a servidor de IA)
- **Armazenamento local**: File System Access API + IndexedDB (nativos do navegador)
- **Nuvem** (opcional): [Supabase](https://supabase.com/)
- **Entrega das dependências**: import map com **SRI** (`integrity` por URL), servindo do **jsdelivr** com o `esm.sh` de reserva. O hash cobre o módulo de topo; o *worker* do pdf.js e o `.wasm` do sql.js não são *module script* e ficam declaradamente fora. É defesa em profundidade, não garantia.

```
QualiLab/
├── docs/index.html   # o app, publicado pelo GitHub Pages
├── docs/MANUAL.md    # manual do usuário (e manual.html, que o renderiza)
├── scripts/          # as verificações que rodam aqui (invariantes, SRI)
├── supabase/
│   ├── schema.sql              # backend: tabelas, RPCs, políticas de RLS, realtime
│   └── functions/ai-ask/       # Edge Function: proxy de reserva (chave de servidor / CORS)
├── examples/         # projetos de exemplo (.qualilab, .qdpx)
├── CHANGELOG.md      # o que mudou em cada versão
├── CITATION.cff      # como citar
├── SECURITY.md       # política de segurança
└── LICENSE           # MIT
```

O `docs/index.html` deste repositório é o **artefato publicado**: um arquivo único, sem bundler, sem npm e sem etapa de compilação do seu lado. Ele é **gerado** a partir de uma fonte modular (dezenas de fragmentos concatenados em bytes, sem transformação nenhuma) mantida no repositório de desenvolvimento.

A seção [Sustentabilidade](#o-qualilab-não-é-um-formato-mágico) diz que há verificação a cada mudança. **Neste repositório** ela roda a cada push, e você pode inspecionar o `ci.yml`:

| Verificação | O que ela prova |
|---|---|
| `scripts/check_index.py` + `node --check` | as invariantes do arquivo único (um só `<script type="module">`, nenhuma aspa tipográfica em atributo, nenhum `</script>` literal dentro do módulo) e a sintaxe do módulo |
| `scripts/sri.py` + `sri_selftest.py` | as dependências de CDN conferem com o hash declarado no import map |
| checagem de credenciais | o app publicado aponta o projeto Supabase **público**, e nenhum outro |

O restante da bateria roda no repositório de desenvolvimento, a cada push, sobre a fonte modular: testes de funções puras (censura, âncoras de trecho, offsets, parsing dos formatos), **23 suítes de navegador** que verificam que cada tela renderiza e que as regras que falham **mudas** continuam valendo (o modo cego não vazar o gabarito, a indução não ver os documentos guardados, o código de confirmação não perder dígito, **zero requisição externa no boot**), **pgTAP** sobre as políticas de RLS (papéis, codificação cega, distribuição, acesso à IA) e o harness de round-trip que valida o `.qdpx` gerado contra o `Project.xsd` oficial.

---

## Limites e responsabilidade

Projeto em desenvolvimento ativo. Vale conhecer os limites antes de adotar num trabalho importante.

- **Modo Arquivo local só em Chromium.** A File System Access API que o sustenta só existe em Chrome e Edge; Firefox e Safari caem no rascunho (`localStorage`, ~5 MB).
- **Nem tudo sincroniza ao vivo.** Só codificações e respostas de categoria. Mudar o esquema de códigos, as categorias ou a distribuição de documentos exige recarregar a página.
- **A fila de escrita não é modo offline.** Ela guarda e reenvia o que você *escreve* quando a nuvem falha, mas **ler** continua exigindo rede: sem conexão, abrir um documento ainda não carregado ou trocar de projeto não funciona. Para trabalhar sem rede, use o modo Arquivo.
- **Capacidade do plano gratuito do Supabase** (ordem de 500 MB de banco, sujeita a mudança — confira em [supabase.com/pricing](https://supabase.com/pricing)). Projetos muito grandes podem exigir plano pago ou o modo Arquivo, que não tem esse teto.
- **O QualiLab NÃO anonimiza.** A censura mascara **só os trechos que você marcou à mão**, e só nas saídas de transparência e no prompt da IA: não detecta o que é sensível, não cobre as exportações de trabalho (QDPX/CSV/JSON saem crus) e não alcança **título do documento, valor de categoria nem memo**. O manual traz o [fluxo de publicação](docs/MANUAL.md) que cuida desses três.
- **Sem trilha de auditoria do processo.** Não há log de operações do projeto, e o **Ctrl+Z** desfaz só a última codificação da sessão. Excluir documento, código ou categoria é definitivo. É o critério em que o QualiLab está abaixo da mediana do campo, na régua acima.
- **QDPX perde o que o formato não modela**: camadas individuais e autoria de atributo por pesquisador (limite do REFI-QDA, não nosso). E o tipo das categorias vindas de outra ferramenta é **inferido** quando ela não o declara — o resumo do import diz quantas foram, e vale revisar no esquema.
- **A fidelidade do round-trip é medida, não presumida** (harness mantido no repositório de desenvolvimento, com corpus adversarial e matriz de sobrevive/degrada/se perde). Ainda assim, **validade de schema não substitui testar na ferramenta de destino real**, que pode ler o padrão de outro jeito.
- **PDF original na nuvem é opt-in**, com consentimento explícito no envio: quem administra o banco passa a poder abrir o arquivo inteiro, e não só o texto codificado. Para dado sensível, mantenha o PDF no modo Arquivo.
- **Distribuição e codificação cega só existem na nuvem coletiva** (dependem de contas de vários pesquisadores) e **não** viajam no `.qualilab`.
- **Livro de códigos sem etapa de aprovação**: qualquer membro cria e renomeia códigos (necessário para codificar em equipe); excluir, mesclar e mexer na censura são de admin. Não há um estado intermediário antes de um código novo ficar visível a todos.
- **E-mail da conta não pode ser trocado** no app; nome de exibição e senha, sim.
- **Áudio, vídeo, imagem e planilha não são material codificável** — é escopo declarado, não pendência (veja acima).

**A responsabilidade pelo tratamento dos dados é inteiramente sua.** Trabalhando com dados pessoais, sigilosos ou protegidos (LGPD, aprovação de comitê de ética/CEP, segredo de justiça, dados de saúde), cabe a você anonimizar, obter consentimento e escolher o modo adequado. **Para material sensível, use o modo Arquivo local, offline, e não o coloque na nuvem.**

**Sustentabilidade, com franqueza.** O QualiLab é mantido por uma pessoa, sem financiamento, e **a maior parte do código foi escrita por um modelo de linguagem** ([Claude Code](https://claude.com/claude-code)), sob direção e revisão do autor. Pese isso antes de adotar a ferramenta num projeto importante. A favor: um projeto deste tamanho não existiria de outra forma; cada decisão de desenho fica registrada por escrito, porque documentá-la é parte do método de trabalho e não um extra; e há testes automatizados e verificações rodando no CI a cada mudança. Contra: o código **não** passou por revisão por pares nem por auditoria de segurança independente. Vale notar que o levantamento citado acima excluiu qualidade de código do seu escopo por exigir inspeção profunda, ou seja, esse aspecto não foi medido em nenhuma das 28 ferramentas comparadas, nem nesta.

O risco de abandono é mitigado pelo desenho, não por uma promessa: licença MIT, um arquivo HTML que roda offline, e todos os dados exportáveis a qualquer momento em formatos abertos (`.qualilab`, REFI-QDA, W3C, CSV, JSON). Se o projeto parar amanhã, o seu material não fica preso nele.

---

## Backlog

O backlog completo é mantido no repositório de desenvolvimento, com o raciocínio de cada item e também o que foi **avaliado e descartado**, com o porquê. As prioridades declaradas hoje:

- **Backend sem credencial enterrada**: catálogo de nuvens nomeado na configuração, "usar minha própria nuvem" como caminho de primeira classe e link-convite com tela de confirmação.
- **Relações nomeadas** entre códigos e entre trechos ("X contradiz Y", "X é causa de Y"), criadas pelo menu de contexto.
- **Rastro e auditoria**: log de operações do projeto (imports, merges, exclusões, aplicações em lote) e desfazer em lote — o critério em que estamos abaixo da mediana do campo.
- **Criptografia ponta a ponta** com passkey, para colaboração ao vivo sem que o operador do servidor possa ler o corpus: desenho pronto, nada decidido.

---

## Créditos, referência e licença

O QualiLab foi desenvolvido por **[Luiz Pimenta Filho](https://orcid.org/0000-0002-5165-6232)** no âmbito do **[LabDados / FGV Direito SP](https://direitosp.fgv.br/nucleos-de-pesquisa/laboratorio-dados-pesquisa-empirica-direito-labdados)** como projeto pessoal. Não representa posição institucional da FGV, que não tem qualquer responsabilidade pelo software.

A maior parte do código deste projeto foi escrita com assistência do [Claude Code](https://claude.com/claude-code) (Anthropic).

As principais inspirações foram:

- **[Taguette](https://www.taguette.org/about.html)**: ferramenta de QDA aberto, pioneira em simplicidade e funcionamento on-line, com suporte a múltiplos formatos de importação de documentos e exportação do codebook em REFI-QDA (`.qdc`).
- **[Magnolia](https://www.caledavis.eu/magnolia.html)**: QDA com foco em poder e intuitividade, transcrição de áudio/vídeo e análise de surveys. Um projeto impressionante e totalmente gratuito que merece sua atenção.
- **[QualCoder](https://github.com/ccbogel/qualcoder)**: QDA maduro e completo (codificação de texto, imagem, áudio e vídeo; relatórios e medidas de concordância), livre e de código aberto. Uma referência robusta para quem precisa de uma ferramenta de desktop full-featured.
- **[OpenQDA](https://openqda.org/)** ([código](https://github.com/openqda/openqda), AGPL-3.0): QDA aberto e colaborativo, feito na Universidade de Bremen, com arquitetura pensada desde o começo para receber extensões da comunidade. É o projeto de Jan Küster e Karsten D. Wolf, os autores do levantamento que enquadra a [Motivação](#por-que-existe) deste README: a crítica que abre o texto vem de quem também está construindo uma resposta para ela.

Todos demonstram que é possível fazer ferramentas de qualidade sem cobrar das pessoas que mais precisam delas, e que vale a pena apoiá-las.

### Referência

O enquadramento da [Motivação](#por-que-existe) e a tabela [Onde o QualiLab está nessa régua](#onde-o-qualilab-está-nessa-régua) se apoiam em:

> Küster, J.; Wolf, K. D. *The Current State of CAQDAS is Insufficient for Open Science Qualitative Research.* **Electronic Communications of the EASST**, v. 85 (deRSE25: Selected Contributions of the 5th Conference for Research Software Engineering in Germany), 2025. DOI [10.14279/eceasst.v85.2709](https://doi.org/10.14279/eceasst.v85.2709). Licença CC-BY 4.0.

Os dados do levantamento estão publicados em domínio público (CC-0) no Zenodo e no Harvard Dataverse, e a metodologia é mantida no repositório [zemki/state-of-caqdas](https://github.com/zemki/state-of-caqdas), que aceita contribuições da comunidade.

### Licença

MIT License: livre para usar, modificar e distribuir, com ou sem fins comerciais, desde que o aviso de copyright seja mantido.

```
Copyright (c) 2026 Luiz Pimenta Filho
```
