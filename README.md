<p align="center">
  <a href="https://luizpf42.github.io/QualiLab"><img src="images/logo.png" alt="QualiLab" width="180"></a>
</p>

# QualiLab

**o seu laboratório de pesquisa qualitativa / your own lab for qualitative research**

[![DOI](https://zenodo.org/badge/1274527946.svg)](https://doi.org/10.5281/zenodo.21935682)

QualiLab é uma ferramenta **gratuita e de código aberto** para análise qualitativa de dados. Roda inteira em um único arquivo `index.html`, sem instalação, sem servidor próprio, sem assinatura.

> Inspirado pelo excelente trabalho do **[Taguette](https://www.taguette.org/about.html)**, do **[Magnolia](https://www.caledavis.eu/magnolia.html)**, do **[QualCoder](https://github.com/ccbogel/qualcoder)** e do **[OpenQDA](https://openqda.org/)**, projetos que merecem todo o seu reconhecimento. Se você usa ou aprecia ferramentas abertas para pesquisa qualitativa, visite os projetos deles e considere usar ou contribuir: são as referências que tornaram o QualiLab possível.

Acesse a ferramenta **[aqui](https://luizpf42.github.io/QualiLab)** / Baixe a ferramenta **[aqui](https://github.com/LuizPF42/QualiLab/releases/download/alpha/index.html)**

📖 **Novo por aqui?** Comece pelo **[Manual de uso](https://luizpf42.github.io/QualiLab/manual.html)**: guia completo, passo a passo, de todas as telas.

---

## ⚠️ Aviso importante: privacidade, segurança e responsabilidade

**Leia antes de usar o QualiLab com dados reais.**

O QualiLab é um **projeto pessoal, experimental e em desenvolvimento ativo**, distribuído sob licença **MIT, SEM QUALQUER GARANTIA** de correção, disponibilidade ou segurança. **Bugs são esperados.** O software **não passou por auditoria de segurança** e não deve ser tratado como um cofre de dados.

**Para onde vão os seus dados** depende do modo de uso:

- **Arquivo / Rascunho**: ficam **no seu dispositivo** e não saem dele.
- **Nuvem**: são enviados a um **servidor de terceiros** (Supabase), ficam sujeitos aos termos desse provedor e saem do seu controle direto.
- **IA de nuvem**: os trechos que você analisar são enviados ao **provedor de IA** que você usar (Gemini/OpenAI/Anthropic/Azure…), sob a política dele; o **Ollama local** é a exceção (roda na sua máquina, nada sai dela). A censura é mascarada antes do envio.
- **Publicação** (Relatório Interativo / Web Annotation): o que você divulgar fica **público**.

**O QualiLab NÃO anonimiza nem identifica dados pessoais** (nomes, CPF, dados de saúde) no conteúdo dos documentos. A **censura** mascara apenas os trechos que **você** marcou à mão, **não** detecta sozinha o que é sensível e **não** cobre as exportações (QDPX/CSV/JSON saem com o texto cru). **Não há rede de segurança automática.**

**A responsabilidade pelo tratamento dos dados é inteiramente sua.** Trabalhando com dados pessoais, sigilosos ou protegidos (LGPD, aprovação de comitê de ética/CEP, segredo de justiça, dados de saúde), cabe a você anonimizar, obter consentimento e escolher o modo adequado. **Para material sensível, use o modo Arquivo local, offline, e não o coloque na nuvem.**

> **Isenção.** O QualiLab é um projeto pessoal de Luiz Pimenta Filho. **Não representa posição nem implica responsabilidade de qualquer instituição (incluindo a FGV).** O autor **não se responsabiliza** por perda de dados, vazamento, uso indevido ou quaisquer consequências do uso do software. Use por sua conta e risco, com as cautelas éticas e legais que a sua pesquisa exige.

---

## Motivação

Um levantamento sistemático de 28 ferramentas de análise qualitativa, publicado em 2025 por Jan Küster e Karsten D. Wolf (Universidade de Bremen), conclui que **"o estado atual do CAQDAS é inadequado para sustentar plenamente práticas de pesquisa qualitativa de ciência aberta"**. Entre os achados: o campo é dominado por software proprietário (13 das 28 ferramentas examinadas), com licenças de **€95 a €430 por usuário/ano**; colaboração em tempo real existe em **5** das 28; trilha de auditoria do processo de análise, em **7**; política de segurança pública, em **2**; e, das 9 ferramentas com IA integrada, **nenhuma revela ao usuário o *system prompt*** que antecede as chamadas, enquanto apenas **2** permitem usar um modelo local ou próprio. Os autores registram ainda que as ferramentas veteranas "evoluíram para aplicações grandes, complexas e pesadas, com interfaces por vezes confusas".

A esses achados o QualiLab acrescenta uma queixa de prática que o levantamento não mede: o suporte a **categorias fechadas** (atributos estruturados por documento) é pobre nas ferramentas grandes, o que obriga o pesquisador a manter planilhas paralelas para o que deveria estar integrado à análise.

O QualiLab busca ser o mais intuitivo possível: você carrega um documento, seleciona um trecho e já codifica, sem configuração prévia. Ao mesmo tempo, oferece um esquema de categorias nativo (texto fechado, texto aberto, número, data, sim/não, múltipla escolha, caixa de seleção) que convive com a codificação de trechos de forma integrada, no mesmo ambiente. Quem precisa conciliar análise temática com coleta estruturada de atributos não precisa mais alternar entre ferramentas.

As ferramentas disponíveis, pagas ou gratuitas, também não têm colaboração e pesquisa coletiva como seus objetivos primários. O QualiLab busca encontrar um bom meio termo, sendo desenvolvido para necessidades individuais e coletivas: camadas de codificação por pesquisador, reconciliação, papéis de administrador e membro, tudo nativo, sem precisar de planilha paralela ou ferramenta de terceiros para coordenar a equipe.

> Küster, J.; Wolf, K. D. **The Current State of CAQDAS is Insufficient for Open Science Qualitative Research.** *Electronic Communications of the EASST*, v. 85 (deRSE25), 2025. DOI [10.14279/eceasst.v85.2709](https://doi.org/10.14279/eceasst.v85.2709), licença CC-BY 4.0. Os autores desenvolvem o [OpenQDA](https://openqda.org/), que integra a amostra examinada. Os números acima descrevem as 28 ferramentas que **eles** examinaram (o QualiLab não estava entre elas) e valem para o levantamento de 2025.

---

## Recursos

### Documentos
Importe `.txt`, `.md`, `.docx` e `.pdf`, ou cole texto diretamente. O conteúdo é extraído e exibido para leitura e codificação. A extração de **`.docx`** preserva a estrutura do documento como texto limpo e bem espaçado: títulos, parágrafos, listas com o aninhamento por indentação e tabelas em linhas e colunas. Nada disso suja o conteúdo com marcadores artificiais, para que o material fique legível na hora de codificar. O **`.pdf`** passa por um reflow geométrico que **detecta colunas** (artigos em duas colunas deixam de sair embaralhados), **remove cabeçalhos, rodapés e números de página** repetidos, remonta parágrafos (independente da entrelinha) e corrige hifenização de fim de linha; páginas desenhadas em duplicata (falso-negrito / camada de texto dupla) são de-duplicadas.

Como a extração de PDF é imperfeita por natureza (sobretudo em documentos antigos ou digitalizados), você pode **editar o texto extraído** (e o **título**) de qualquer documento pelo botão **✏ editar** no cabeçalho do leitor: um trecho grudado, um rodapé que sobrou, uma linha quebrada. Ao salvar, **os grifos já feitos são reancorados automaticamente** às novas posições (e você é avisado se alguma codificação cair exatamente no trecho que você mexeu). Casos de corrupção sistêmica (um PDF inteiro sem espaços, por exemplo) continuam sendo tarefa para OCR, não para edição manual.

Documentos vindos de **PDF** trazem ainda um leitor do **original**: o botão **▤ original** no cabeçalho do leitor mostra a página do PDF de verdade (com zoom e navegação), e os seus grifos são desenhados sobre ela; dá para selecionar e codificar direto na página. Para **PDF digitalizado** (escaneado), o botão **◫ OCR** reconstrói o texto no próprio navegador (offline), a página inteira ou por **área** (arraste um retângulo → revise o texto lido → codifique). Como o app guarda a correspondência trecho ↔ página, o número de página do original (**p. N**) acompanha o trecho na Leitura, no Relatório e nos exports (CSV/JSON/W3C), e "ver original" abre já na página do trecho. Um **sinal de qualidade da extração** (⚠︎ no nome do documento e uma pílula "⚠︎ extração" no leitor) avisa quando um documento provavelmente saiu mal extraído (vazio, sem espaços entre palavras, glifos quebrados, OCR de baixa confiança), para você conferir/limpar ou rodar OCR antes de codificar.

### Codificação por trechos
Selecione qualquer trecho e aplique um código, ou clique com o **botão direito** para um menu de contexto rápido. Clicar com o botão direito num trecho **já codificado** (sem selecionar nada novo) abre direto a opção de **remover** aquele código, sem precisar reselecionar o trecho. **Ctrl+Z** desfaz a última codificação aplicada na sessão atual. Os códigos são **hierárquicos** (famílias → subcódigos), com cor por família e tonalidade por profundidade; administradores podem personalizar a cor de uma família (matiz, ou cinza), propagada para os subcódigos.

### Esquema de categorias (atributos do documento)
Cada documento pode receber atributos com sete tipos de campo:

| Tipo | Comportamento |
|---|---|
| **Texto Fechado** | Lista suspensa, escolhe um |
| **Texto Aberto** | Campo livre |
| **Número** | Aceita inteiro ou decimal (vírgula ou ponto), ordena como número e sai tipado no `.qdpx` |
| **Data** | DD / MM / AAAA com partes opcionais |
| **Sim/Não** | Dois botões |
| **Múltipla Escolha** | Botões, escolhe um |
| **Caixa de Seleção** | Botões, escolhe vários |

Cada categoria pode ter descrição/instrução e habilitar as opções **"Não informado"** e **"Outros"** (valor livre). O esquema é definido pelos administradores do projeto; os membros apenas preenchem.

### Telas principais

- **Codificação**: leitor à esquerda com grifos coloridos (a linha embaixo do grifo só aparece quando há mais de um código sobreposto no mesmo trecho, pra não poluir visualmente); painéis de categorias e de códigos à direita. Uma barra de ferramentas no leitor traz zoom de fonte, largura de coluna e tema de leitura (claro/sépia/escuro), além de busca com navegação entre ocorrências (🔎): o destaque da busca sobrepõe os grifos de código e censura sem substituí-los. Filtro **"Ver:"** para alternar entre camadas (individual, por codificador, final, ou "Individuais (todos)" (que sobrepõe os grifos de todos os pesquisadores **e** o gabarito ao mesmo tempo)) afeta tanto os grifos no texto quanto as respostas de categoria exibidas: ver a resposta de outro pesquisador ou o gabarito é só leitura (editar fica restrito à sua própria resposta, pra não sobrescrever a de outra pessoa por engano).
- **Esquema**: tela em branco (sem documento aberto) pra organizar o livro de códigos e o esquema de categorias de uma vez: reorganização em lote de códigos (agrupar, mesclar, promover a Hierarquia 0) e edição das categorias.
- **Reconciliação**: agrupa as codificações que se sobrepõem no mesmo código, mostra quantos codificadores concordam e permite **consolidar** na camada final (gabarito).
- **Leitura**: dois modos de reler o que já foi codificado. Em **Documentos**, o documento inteiro com os grifos no contexto em que foram feitos (passar o mouse mostra o código e o autor; clicar abre o caminho do código, a camada e a nota analítica), com a lista do corpus à esquerda — filtro por nome, ordenação, agrupamento por categoria e nº de trechos por documento. Em **Trechos**, os trechos do código selecionado em todo o projeto, em tipografia legível, agrupados por documento. Filtro por categoria e cruzamento por co-ocorrência de até 2 códigos.
- **Gráficos**: frequência de códigos, distribuição por categoria (gabarito), heatmap código × categoria, produção por codificador e concordância entre codificadores. **Clicar numa barra ou célula abre a Leitura já naquele código** (na co-ocorrência, com o par de códigos cruzado; o filtro de categorias do gráfico vai junto, então os trechos exibidos batem com a contagem clicada).
- **Memos**: nota analítica única por alvo (projeto, documento, código **ou trecho codificado**), compartilhada entre os pesquisadores e editável por qualquer membro. A nota por trecho é escrita pelo menu de contexto do leitor (botão direito num grifo → "Anotar trecho") e também aparece na própria aba Memos. A aba Memos também reúne, abaixo dos códigos, as **Conversas salvas** (cada conversa do "Analisar com IA" abre por inteiro) e a **Memória do projeto** (o diário de insights da IA).
- **Relatório**: é o **hub de publicação**, com três tipos de saída escolhidos na coluna esquerda:
  - **Relatório Interativo (ATI)**: uma página HTML auto-contida (sem servidor) com cada documento em trechos grifados clicáveis; clicar abre, num painel lateral, a nota analítica daquele trecho. Títulos de documento e códigos da legenda também abrem seus memos. Equivale ao *overlay* da **Annotation for Transparent Inquiry (ATI)** do QDR, mas hospedável por você (ex.: GitHub Pages). Os documentos vêm colapsados e a legenda é recolhível, para escalar a projetos grandes.
  - **Relatório Padrão**: montador de relatório. Você liga e desliga seções por caixas de seleção (resumo, lista de documentos, contagens e listas do esquema, frequência de códigos, distribuição por categoria, trechos por código, códigos não utilizados) e o texto se monta ao vivo. **Copiar texto** (pronto pra colar em `.docx`/Docs) e **Imprimir / PDF**. Crédito opcional ao QualiLab no resumo.
  - **Web Annotation (W3C)**: exporta as anotações no padrão aberto **[W3C Web Annotation Data Model](https://www.w3.org/TR/annotation-model/)** (JSON-LD), a mesma "língua de dados" sob o ATI, o [hypothes.is](https://web.hypothes.is/), o Anno-REP e o Dataverse. É interoperável sem casar com nenhuma ferramenta específica.
  - Em projeto coletivo, os três respeitam a camada escolhida (gabarito final ou individuais). Em todas as saídas de transparência, trechos marcados como **censura** são mascarados por padrão.

### Busca semântica (sem chave, no seu navegador)

Além da busca literal (com expressão regular, diferenciação de maiúsculas e palavra inteira) e da busca global em todo o corpus, o leitor tem **"≈ termos"**: você descreve o *sentido* que procura e o app sugere **palavras e expressões do seu próprio corpus** próximas daquele sentido. Clicar numa sugestão dispara a busca **literal** por ela, com a etiqueta `≈ termo` em cada ocorrência — o resultado continua sendo texto que está mesmo lá, não um palpite do modelo.

Isso **não é IA generativa e não pede chave nenhuma**. Roda com [transformers.js](https://github.com/huggingface/transformers.js) e o modelo [`paraphrase-multilingual-MiniLM-L12-v2`](https://huggingface.co/Xenova/paraphrase-multilingual-MiniLM-L12-v2), um modelo de *embeddings* (converte texto em coordenadas, para medir proximidade de sentido; não escreve nada), **executado dentro do navegador**: o modelo vem até os dados, os dados não vão até o modelo. Por isso vale também nos modos rascunho e arquivo sem quebrar a promessa de privacidade deles, e funciona sem conexão depois do primeiro uso.

Dois custos a saber: o modelo é baixado **uma vez** (~113 MB no caminho WASM, ~224 MB no caminho WebGPU, em cache do navegador depois disso) e a **primeira consulta da sessão leva ~10 s** enquanto o motor sobe. O índice do vocabulário é um **cache derivado**: fica no IndexedDB deste navegador, é refeito quando o corpus muda e **não viaja** no `.qualilab`.

### Análise com IA

Duas telas opcionais conversam com um modelo de linguagem. O modo é **BYOK**: cada pesquisador traz a própria chave (Gemini/OpenAI/Anthropic/Azure/compatível-OpenAI ou **Ollama local**), guardada **só no navegador** — e é o **próprio navegador que chama o provedor**, sem intermediário: nenhum servidor do QualiLab vê o material da análise. A Edge Function `ai-ask` cobre os dois casos que sobram: um endpoint *Personalizado*/*Azure* que não libere chamadas de navegador (CORS) e uma eventual **chave de servidor** (a instância pública não tem):

- **Codificar Automaticamente**: cinco assistentes em abas, todos no mesmo padrão (a IA **propõe**, você **aprova/recusa item a item**, nada é gravado sem confirmação):
  - **Sugerir Codificação**, no papel de **segunda codificadora (recall)**: a IA lê os documentos e aponta trechos que se encaixam em **códigos existentes** mas escaparam; o trecho é localizado no texto (quote→span) e vira uma codificação ao aprovar. Trechos já codificados não são repropostos; censura nunca é codificada.
  - **Repetir Codificação**: sem IA e sem chave nenhuma — acha as ocorrências **exatas** dos trechos que um código já tem e propõe aplicá-lo a cada uma. Útil sobretudo na censura: censurar é por trecho, e o mesmo nome costuma reaparecer descoberto adiante. Acha texto idêntico, não variante.
  - **Sugerir Categorização**: preenche o **valor de categorias já existentes** por documento (não cria categorias). No modo normal a IA vê o que **já está preenchido** e só devolve **diferenças ou campos vazios**; cada sugestão mostra se a categoria está "já aplicada" (com o valor atual) ou "vazia". Há também um **modo cego**, em que ela responde **sem ver** as suas respostas, um documento por chamada, e o painel devolve um **placar** de concordância com o seu gabarito — o mesmo painel deixa de ser conferente e vira régua.
  - **Definir Categoria**: escreve a **instrução de codificação** de uma categoria a partir das respostas que você já deu. A premissa é que o seu gabarito **contém** a regra que você aplicou e o que falta é escrevê-la; por isso ela serve ao **começo do zero**, quando não existe definição nenhuma para conferir e ajustar. Detalhado abaixo.
  - **Organizar Códigos**: reorganiza o esquema. A IA propõe operações (mesclar, agrupar, mover, renomear, promover) com a justificativa de cada uma.
- **Analisar com IA**: análise **conversacional** do material do projeto, em formato de chat. Você escolhe **o material**: Documentos brutos · Trechos + Código · Documentos + Trechos + Código (a seleção de códigos é uma **árvore** com cores e contagem, como na Leitura), e uma **modalidade** adequada a cada escopo (mais uma opção **Personalizado** com instrução livre). A IA responde com o **memo do projeto como contexto**, citando as fontes; o prompt **inteiro** enviado é exibível antes de rodar (transparência total). A partir da primeira resposta, a conversa continua com **perguntas de acompanhamento** (follow-ups) sobre o mesmo material. As respostas saem formatadas (títulos, listas) e cada conversa pode ser **salva**: ela passa a aparecer na aba **Memos**, em "Conversas salvas".

**Definir Categoria (escrever a instrução a partir do que você já respondeu)**: depois de responder alguns documentos numa categoria, a regra que você aplicou já existe — ela está nas suas respostas, só não está escrita. Esta aba lê uma amostra dos documentos já respondidos e propõe o texto da **descrição** da categoria, que é o mesmo campo que o codificador humano lê ao preencher e que entra no prompt das telas de IA: **uma definição só governando os dois avaliadores**. O texto vem editável, você aprova, e gravar chama o mesmo caminho de sempre (é o campo de descrição do esquema, sem tabela nova) — por isso exige **administrador**, como qualquer mudança de esquema.

- **A amostra é dividida antes de qualquer chamada**, em casos de **treino** (vão no prompt) e **guardados** (não vão, e servem para testar depois: decorar um caso que a IA já viu aparece como acerto). Ela é **equilibrada por valor**, não proporcional ao corpus — com 90 "Não" e 10 "Sim", um sorteio simples ensinaria "quase sempre Não", uma regra que acerta 90% e não serve para nada. Um cartão mostra a repartição que de fato saiu, valor por valor. Com menos de **seis** documentos respondidos a aba se recusa a rodar, e diz por quê: com tão poucos casos qualquer texto sairia conjectura com aparência de critério.
- **Roda em dois tempos.** Primeiro uma **passada de localização**: uma chamada curta por caso, que **não julga nada** — só copia do documento o trecho literal que sustenta a resposta que **você** já deu. É o que faz um corpus longo caber numa indução (o material da chamada seguinte passa a ser um trecho por caso, não o texto inteiro), e de graça ela separa os casos em que **nada no documento** sustenta o rótulo: resposta vinda de fora, engano de preenchimento ou extração ruim do texto. Depois vem a chamada que escreve o verbete.
- **Junto do verbete vêm os casos que a regra não explica**, e é essa lista que paga a tela: a IA é obrigada a aplicar a própria regra a cada caso recebido e a apontar aqueles em que ela daria resposta **diferente da sua**, sem ajustar a regra para explicar todos. Ou a sua codificação está inconsistente ali, ou existe um critério que você aplica sem ter percebido. **Lista vazia é motivo de desconfiança, não elogio**: uma regra que explica 100 de 100 quase sempre decorou os exemplos. Vêm também os **pontos que os exemplos não decidem**, deixados em aberto de propósito — onde os casos não bastam, a IA é proibida de completar com o que soa razoável, e a escolha fica sua.
- **Teste e laço.** *Testar a definição* responde os documentos **guardados às cegas**, com o texto que está no campo (o rascunho, não o que está gravado: a graça é saber **antes** de aplicar), e compara com o seu gabarito. É o mesmo motor e o mesmo placar da avaliação cega da aba Sugerir Categorização, de propósito — os dois números medem a mesma coisa e você vai compará-los. Onde a definição errou, cada caso aparece com a sua resposta ao lado da resposta da IA, e um botão **refaz a indução incluindo esses casos**: eles entram no treino da volta seguinte, e os novos guardados saem só de documentos que **nunca entraram em prompt nenhum**.
- **O que o número não é**, e a tela declara: ele conta só os pares em que os dois responderam; mede **concordância com o seu gabarito**, não acerto (onde vocês divergem, a resposta incompleta pode ser a sua); com poucos casos não distingue 27 de 28; e, depois de várias voltas, tende a ficar **otimista**, porque o conjunto guardado é novo mas as suas escolhas passaram a depender do que você viu. Para uma medida limpa, separe documentos que não vai usar em volta nenhuma — isso é método, não botão.
- As **cinco regras da indução** (escrever instrução e não descrição · a regra vale para o caso 101 · só escrever critério que os casos sustentam · declarar o que não conseguiu explicar · a anatomia do verbete) são fixas e vão em todo prompt; aparecem inteiras no **⚙ Configurar Prompt** e podem ser editadas ali — são o piso, não algema, e a edição vale para a sessão. Esta aba **precisa da sua própria chave**: a saída é estruturada por ferramenta e conversa direto com o provedor, sem passar pela função do servidor.

**Memória do projeto (diário de insights da IA)**: um caderno de memórias curtas (fatos e decisões do projeto) que a IA passa a levar em conta entre sessões. Ao fim de uma análise ou organização de códigos, a IA pode **sugerir** memórias (cada uma com a justificativa); você **aprova, edita ou recusa** cada uma antes de gravar, e também pode adicionar memórias à mão. Cada memória tem um **interruptor "usar na análise"**: só as marcadas entram no prompt da IA, e assim você controla o que ela usa (economiza tokens e deixa explícito o contexto). Para transparência em projetos colaborativos, cada memória registra **quem a criou** e **qual modelo a gerou**.

O uso de IA é **opt-in e transparente**: nada é enviado sem você clicar, e você vê exatamente o prompt. Suporta **Google Gemini, OpenAI ou Anthropic**. O padrão é **BYOK**: cada pesquisador **traz a própria chave** em "Minha Conta", guardada só no navegador (nas chamadas de nuvem, transita pela Edge Function e é usada em memória, sem ser gravada no servidor). (Quem hospeda a própria instância pode, opcionalmente, configurar uma chave de servidor nos secrets do Supabase. Ver [Configuração da nuvem](#configuração-da-nuvem-supabase).) Além desses, há suporte BYOK a **Azure OpenAI**, a um provedor **Personalizado** (qualquer API no formato clássico da OpenAI) e ao **Ollama local** (modelo na sua própria máquina, chamado direto pelo navegador). Ver abaixo.

**Azure OpenAI (BYOK apenas)**: em "Minha Conta", escolha o provedor **Azure OpenAI** e preencha o endpoint do seu recurso na superfície "v1" (`https://SEU-RECURSO.openai.azure.com/openai/v1`), a chave de API do recurso (obrigatória) e o nome do **deployment** (não o nome do modelo base). Usa o formato clássico de chat completions, autenticando pela chave do Azure. Sem chave de servidor: só funciona com BYOK (sua chave).

**Provedor "Personalizado" (BYOK apenas)**: em "Minha Conta", além de Gemini/OpenAI/Anthropic/Azure, há a opção **Personalizado**: você preenche a URL base da API, uma chave (opcional) e o modelo. Cobre qualquer API compatível com o formato clássico da OpenAI (`/chat/completions`): **DeepSeek, Mistral, Qwen** hospedados, ou um servidor próprio (Ollama/vLLM) **exposto numa URL pública** (a Edge Function roda no servidor do Supabase, não alcança `localhost` da sua máquina sem um túnel). Não tem chave de servidor nem modelo padrão: só funciona com BYOK.

**Ollama local (BYOK apenas, chamada direta do navegador)**: para rodar um modelo **na sua própria máquina** sem expor nada na internet, escolha o provedor **Ollama (local)** em "Minha Conta". Diferente do Personalizado (que passa pela Edge Function no servidor e por isso **não** alcança o seu `localhost`), aqui o **navegador chama o Ollama direto** (`http://localhost:11434/v1` por padrão): o material não sai da máquina e a Edge Function nem é tocada. O modelo é **texto livre** (qualquer modelo baixado, ex.: `llama3.1`, `qwen2.5:14b`), com uma lista de sugestões. As chamadas que esperam saída estruturada (organizar códigos, sugerir memórias) usam o **modo JSON** do Ollama/vLLM (`response_format: json_object`), que restringe a resposta a JSON válido. Isso resolve o caso clássico do modelo local pequeno que entende a tarefa mas devolve prosa em vez de JSON. Dois cuidados operacionais: (1) inicie o Ollama com `OLLAMA_ORIGINS=*` (ou a origem exata) para liberar o **CORS**, senão o navegador barra a chamada; (2) app em **HTTPS** (GitHub Pages) + `http://localhost` é bloqueado por Firefox/Safari por *mixed content* (Chrome/Edge têm exceção para localhost); o caminho mais confiável é **rodar o app localmente** (`python -m http.server 8000`). Modelos melhores em seguir formato estruturado rendem mais aqui (`qwen2.5` > `llama3.1` no mesmo tamanho).

**Censura de trechos sensíveis**: marque um código como 🚫 (em qualquer código, não só famílias; ex.: "Censura: nomes" separado de "Censura: cidades") e os trechos com ele ficam **de fora** do material enviado à IA por padrão. Na tela "Analisar com IA", se a seleção tiver trechos censurados, aparece um checkbox por código de censura, útil quando uma censura é irrelevante pro contexto (nomes) e outra é informação relevante que você quer que a IA considere (ex.: cidade).

### Codificação colaborativa em camadas
Cada codificação registra o autor. O trabalho de cada pesquisador é independente (`layer = individual`); a equipe consolida uma **camada final** na tela de Reconciliação. O mesmo modelo vale para as respostas de categoria: cada pesquisador preenche a sua; o administrador define o gabarito. Ações **destrutivas ou que afetam todo mundo** (excluir documentos ou códigos, editar o texto de um documento, importar material e mesclar códigos) são restritas ao **administrador** e impostas pelo servidor (não só escondidas na interface).

### Distribuição de documentos e codificação cega
Em projeto **coletivo na nuvem**, o administrador pode controlar **quem vê o quê** por dois interruptores independentes, ambos desligados por padrão:

- **Distribuição restritiva**: cada pesquisador só **enxerga** os documentos atribuídos a ele. Serve para **dividir o corpus**: cada um cuida da sua parte, ninguém codifica em duplicidade.
- **Codificação cega (*true blind*)**: cada pesquisador só **enxerga as próprias** codificações e respostas. Atribuindo o **mesmo** documento a duas pessoas, o estudo fica **duplo-cego**, para medir a confiabilidade entre codificadores.

A atribuição é feita numa **matriz documentos × pesquisadores** (com rodízio automático e um selo de quem já codificou cada documento), no hub do projeto. As duas regras são **impostas pelo servidor** (RLS), não só escondidas na interface: um membro não alcança pela API o texto do trecho, o PDF original nem a codificação que estão ocultos. É recurso exclusivo da **nuvem coletiva** (depende de contas de vários pesquisadores) e não viaja no `.qualilab`.

### Tipos de projeto
Ao criar um projeto você escolhe:
- **Individual**: uso solo; tudo vai direto para a camada final, sem etapa de reconciliação.
- **Coletivo**: múltiplos pesquisadores codificam de forma independente e reconciliam depois.

O tipo pode ser alterado depois pelo administrador (convertendo Coletivo → Individual de forma irreversível, colapsando todas as codificações num único autor).

### Gestão de projeto e membros
A **pílula do projeto** no cabeçalho muda de cor conforme **onde os seus dados estão**: neutra = rascunho (neste navegador, efêmero), **verde** = arquivo no seu disco, **azul** = nuvem (servidor padrão), **violeta** = nuvem no **seu próprio** servidor Supabase, **âmbar** = nuvem sem conexão (nada está sendo salvo). Passe o mouse para a explicação completa; em modo rascunho, o tooltip também mostra **quanto do armazenamento do navegador (~5 MB) o projeto já usa**, e um aviso aparece no cabeçalho a partir de 75%. Nos modos rascunho e arquivo, um **"✓ salvo HH:MM"** discreto confirma a última gravação automática.

Clicar na pílula abre o hub de gestão: código de convite para colaboradores, tipo do projeto, lista de membros com papéis (admin/membro), renomear, limpar conteúdo, excluir e configuração de conexão. No card **Conexão (Supabase)** dá para apontar o app pro **seu próprio projeto Supabase** (as credenciais valem só naquele navegador e passam a ter precedência), voltar ao servidor padrão, ou **desconectar de verdade** para o modo rascunho. Conforme o modo, o hub também mostra atalhos para trocar de armazenamento sem exportar/importar `.qualilab` na mão: **"Salvar como arquivo"** (só no rascunho, Chromium) migra o projeto atual pra um arquivo `.qualilab` no disco num clique (pílula fica verde); **"Enviar para a nuvem"** (rascunho ou arquivo) cria um projeto novo na nuvem e copia tudo pra ele (documentos, categorias, códigos, codificações, memos e resultados de IA salvos); **"Sair deste arquivo"** (só no modo arquivo) desanexa do arquivo atual e volta à tela de entrada, deixando o `.qualilab` intacto no disco.

### Tela de entrada, conta e login
Na primeira execução (sem sessão nem arquivo salvo), a **tela de entrada** oferece três caminhos, com o logo do projeto no topo: **Novo em arquivo** e **Entrar na nuvem** lado a lado, e **Só testar (rascunho)** abaixo. "Entrar na nuvem" leva ao login por **Google** ou **e-mail e senha** (com cadastro e **"Esqueci minha senha"** na mesma tela); **"← Voltar"** retorna à tela de escolha. Um botão violeta **"Conectar ao meu Supabase"** (na tela de entrada e no login) aponta o app pro **seu próprio servidor Supabase** antes de logar: é onde ficam seus projetos coletivos; depois de conectar, você loga ali e entra no projeto pelo código. Sessões de rascunho ficam vinculadas ao dispositivo, sem sincronizar entre aparelhos.

Clicando no seu nome no cabeçalho, **em qualquer modo** (nuvem, local ou arquivo), a tela **Minha Conta** permite:
- Trocar o nome de exibição (usado nas codificações).
- Alterar a senha (contas com e-mail; some nos modos local/arquivo). Esqueceu a senha? A tela de acesso tem **"Esqueci minha senha"**, que envia um link para você criar uma nova.
- Ver todos os seus projetos em um só lugar, com ações diretas: abrir, renomear (admin), sair ou excluir (admin), sem precisar entrar em cada um.
- Configurar a sua **chave/modelo de IA** (BYOK), incluindo o **Ollama local**. Por isso o nome agora é clicável também offline (antes, em local/arquivo, ele não abria nada e não havia como configurar a IA local sem a nuvem).
- Sair da conta (desconecta do Supabase e volta pra tela de login; só no modo nuvem).

### Importação e exportação

| Formato | Importa | Exporta | Notas |
|---|:---:|:---:|---|
| **`.qualilab`** (nativo) | ✅ | ✅ | Botão **"salvar .qualilab"** no cabeçalho: baixa o projeto inteiro (documentos, categorias, valores, códigos, codificações, memos e resultados de IA salvos) para reabrir no próprio app. Funciona em qualquer modo. Ao **importar para um projeto coletivo já em uso**, preserva a resposta de categoria de cada pesquisador de origem (não só uma); o gabarito do arquivo entra como gabarito do projeto de destino. |
| **QDPX** (REFI-QDA) | ✅ | ✅ | Interoperável com ATLAS.ti, MAXQDA, NVivo, Quirkos, QualCoder. O `.qdpx` exportado é **validado contra o `Project.xsd` oficial do REFI-QDA (v1.0, MIT)**, mas isso é **tentativa de intercompatibilidade, não garantia**: schema válido não substitui testar na ferramenta de destino real. Na exportação, prefere a camada final (gabarito) quando consolidada. Ao importar um `.qdpx` de outra ferramenta (sem a convenção de tipo do QualiLab), tenta inferir categorias fechadas pelos valores repetidos (revise em "Gerenciar esquema de categorias". **Não inclui o Taguette**) ele só exporta o codebook em REFI-QDA (`.qdc`, sem documentos nem trechos). |
| **`.sqlite3`** (Taguette) | ✅ | ✕ | Lê o projeto nativo do Taguette direto no navegador (via [sql.js](https://github.com/sql-js/sql.js), sem servidor): documentos, tags (com hierarquia por `/` ou `.`, como o próprio Taguette documenta) e trechos codificados. O Taguette não tem atributos de documento nem autor por trecho, então isso não vem no import. |
| **QDC** (codebook REFI-QDA) | ✅ | ✅ | Só o livro de códigos (sem documentos nem trechos: o formato não tem isso). Compatível com o codebook exportado por qualquer ferramenta REFI-QDA, incluindo o Taguette; se a hierarquia não vier em `<Code>` aninhado, tenta reconstruir pelo nome (`/` ou `.`), igual ao import do `.sqlite3`. |
| **Zotero RDF** (pasta) | ✅ | ✕ | Importa uma coleção do Zotero exportada em **Zotero RDF com arquivos** (que é uma pasta: um `.rdf` mais `files/`). Cada referência com PDF anexado vira um documento, com o texto extraído pelo mesmo caminho do envio manual (o "ver original", a página do trecho e o OCR continuam funcionando). Antes de importar, você escolhe **quais metadados viram categorias** (tipo de item, ano, autores, publicação e palavras-chave vêm marcados; identificadores, desmarcados), o **nome do documento** e se guarda o PDF original; o que não vai entrar (referência sem PDF, anexo que é página salva, arquivo ausente) é listado **pelo nome antes de confirmar**. Referência, resumo e as notas escritas no Zotero vão para o **memo do documento**. Não vêm códigos nem trechos: uma biblioteca de referências não tem isso, e as marcações do leitor de PDF do Zotero não saem na exportação dele. |
| **Web Annotation (W3C)** | ✕ | ✅ | Anotações no padrão aberto [W3C Web Annotation Data Model](https://www.w3.org/TR/annotation-model/) (JSON-LD). Cada trecho codificado vira uma anotação com seletor de posição/citação + nota analítica (a do trecho tem prioridade sobre a do código). É a base interoperável do ATI/QDR, hypothes.is, Anno-REP e Dataverse. Censura mascarada. Na aba **Relatório**. |
| **Leitor de Transparência (HTML)** | ✕ | ✅ | Página HTML auto-contida (sem servidor): documentos com grifos clicáveis e nota analítica. É o *overlay* do ATI, hospedável por você (ex.: GitHub Pages). Na aba **Relatório**. |
| **CSV de trechos** | ✕ | ✅ | Um trecho por linha, com documento, código, camada e autor. |
| **CSV de atributos** | ✕ | ✅ | Um documento por linha, com os valores de cada categoria. |
| **JSON** | ✕ | ✅ | Projeto completo com camadas e autores. |

---

## Onde o QualiLab está nessa régua

Comparação direta com os achados de [Küster & Wolf (2025)](#motivação) sobre 28 ferramentas de análise qualitativa. O número do meio é quantas das 28 atendem ao critério, segundo o levantamento deles.

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

**Extensibilidade por dados, não por plugins.** O QualiLab não tem arquitetura de plugins, e não pretende ter: ela briga de frente com o desenho de arquivo único que faz o app rodar sem instalação e sem build. O que ele oferece no lugar são superfícies abertas: o formato **`.qualilab`** (sem perda, documentado) e a exportação em **REFI-QDA** e **W3C Web Annotation**, para que qualquer outra ferramenta possa ler o que foi produzido aqui.

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

Nos exemplos do repositório isso vale para todos os trechos. É a mesma invariante que os testes de censura verificam, e é ela que permite reprocessar o corpus fora do app sem depender de nada nosso.

Duas coisas que **não** estão no arquivo, e é bom saber: a **distribuição de documentos** (ela depende de identificadores de usuário que só existem na nuvem) e os **caches derivados**, como o índice da busca semântica, que é refeito quando o corpus muda. E uma que **está**: o `.qualilab` é formato de **trabalho**, então carrega o texto **cru, censura inclusive** — mascarar aqui destruiria dado de forma irreversível. Quem mascara são as saídas de transparência (ATI, W3C) e o prompt da IA.

**Sustentabilidade, com franqueza.** O QualiLab é mantido por uma pessoa, sem financiamento, e **a maior parte do código foi escrita por um modelo de linguagem** ([Claude Code](https://claude.com/claude-code)), sob direção e revisão do autor. Pese isso antes de adotar a ferramenta num projeto importante. A favor: um projeto deste tamanho não existiria de outra forma; cada decisão de desenho fica registrada por escrito, porque documentá-la é parte do método de trabalho e não um extra; e há testes automatizados e verificações rodando no CI a cada mudança. Contra: o código **não** passou por revisão por pares nem por auditoria de segurança independente. Vale notar que o levantamento citado acima excluiu qualidade de código do seu escopo por exigir inspeção profunda, ou seja, esse aspecto não foi medido em nenhuma das 28 ferramentas comparadas, nem nesta.

O risco de abandono é mitigado pelo desenho, não por uma promessa: licença MIT, um arquivo HTML que roda offline, e todos os dados exportáveis a qualquer momento em formatos abertos (`.qualilab`, REFI-QDA, W3C, CSV, JSON). Se o projeto parar amanhã, o seu material não fica preso nele.

---

## Como funciona

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

---

## Executando localmente

Não há etapa de build. Basta abrir o arquivo:

**Opção mais simples:** acesse diretamente em:
```
https://luizpf42.github.io/QualiLab
```

**Para usar offline:** baixe o `index.html` e dê duplo clique pra abrir direto no navegador (`file://`), **sem precisar de servidor**: ele só importa bibliotecas externas via URL `https://` (nunca por caminho de arquivo local), então não bate no bloqueio clássico de módulo ES via `file://`. Em Chrome/Edge dá pra usar inclusive o modo **Arquivo local**, que salva o projeto como `.qualilab` visível no disco, ao lado do `index.html`.

**Se ainda assim algo não carregar** (extensão de segurança, política de navegador corporativo, ou outro navegador com bloqueio mais estrito de `file://`), sirva por um servidor local como alternativa:
```bash
python -m http.server 8000   # ou: npx serve .
```

As dependências (Preact, htm, pdf.js, mammoth, JSZip, supabase-js) são carregadas via CDN na primeira utilização: conexão com a internet é necessária na primeira vez, mas depois o app funciona com o arquivo já baixado.

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
- Opcional: desative **Confirm email** para que o cadastro entre direto (o app trata os dois casos).

### 4. IA (Edge Function `ai-ask`: opcional, só para chave de servidor e fallback de CORS)

O **padrão é BYOK**: cada pesquisador traz a sua chave e o **navegador chama o provedor direto**, sem passar por servidor nenhum. Nesse caminho a função **não é usada**. Faça o deploy dela se você for (a) oferecer uma **chave de servidor** (mantida fora do HTML público) ou (b) dar suporte a endpoints *Personalizado*/*Azure* que não liberem chamadas de navegador (CORS) — aí a função faz o proxy. O **Ollama local** nunca a usa (o servidor do Supabase não alcança o `localhost` do pesquisador).

1. **(Opcional, só se for oferecer uma chave de servidor)** Gere uma chave do provedor: [Gemini](https://aistudio.google.com/apikey) (gratuito), [OpenAI](https://platform.openai.com/api-keys) ou [Anthropic](https://console.anthropic.com/settings/keys). Pule este passo se cada pesquisador for usar a própria chave (BYOK).
2. **Secrets** → em *Edge Functions → Secrets*, adicione `GEMINI_API_KEY` e/ou `OPENAI_API_KEY` e/ou `ANTHROPIC_API_KEY` (configure só o(s) que for usar). Opcional: `GEMINI_MODEL`/`OPENAI_MODEL`/`ANTHROPIC_MODEL` pra trocar o modelo padrão de cada um (`gemini-3.1-flash-lite`/`gpt-5.4`/`claude-sonnet-4-6`) sem reeditar o código.
3. **Deploy** → em *Edge Functions*, crie/edite a função `ai-ask`, cole o conteúdo de [`supabase/functions/ai-ask/index.ts`](supabase/functions/ai-ask/index.ts) e clique em **Deploy**. (Sem CLI necessária.)

Sem nenhuma chave configurada, as telas de IA retornam um erro claro; o restante do app funciona normalmente.

**Chave pessoal (BYOK)**: em **Minha Conta**, cada pesquisador pode informar a própria chave (de qualquer um dos três provedores) e escolher o modelo. Ela fica salva só no navegador dele (nunca no servidor) e passa a valer pras análises dele — que vão **direto** do navegador ao provedor. Os provedores **Azure** e **Personalizado** são BYOK puro (nunca usam chave de servidor) e são os únicos que podem recair na Edge Function, quando o endpoint não libera o navegador. O **Ollama local** dispensa toda esta configuração de servidor (ver "Análise com IA" acima).

---

## Stack

Sem build, sem bundler, sem framework pesado.

- **UI**: [Preact](https://preactjs.com/) + [htm](https://github.com/developit/htm) via `esm.sh`
- **PDF**: [pdf.js](https://github.com/mozilla/pdf.js)
- **DOCX**: [mammoth](https://github.com/mwilliamson/mammoth.js)
- **QDPX**: [JSZip](https://stuk.github.io/jszip/)
- **Import Taguette (`.sqlite3`)**: [sql.js](https://github.com/sql-js/sql.js) (SQLite compilado para WASM)
- **Busca semântica**: [transformers.js](https://github.com/huggingface/transformers.js) + o modelo de *embeddings* [`paraphrase-multilingual-MiniLM-L12-v2`](https://huggingface.co/Xenova/paraphrase-multilingual-MiniLM-L12-v2) (ONNX, baixado sob demanda e executado **no navegador**; nenhuma chave, nenhuma chamada a servidor de IA)
- **Armazenamento local**: File System Access API + IndexedDB (nativos do navegador)
- **Nuvem** (opcional): [Supabase](https://supabase.com/)

```
QualiLab/
├── docs/index.html   # o app inteiro (front-end), publicado pelo GitHub Pages
├── docs/MANUAL.md    # manual do usuário (e manual.html, que o renderiza)
├── README.md         # este arquivo
├── CITATION.cff      # como citar
├── SECURITY.md       # política de segurança
├── LICENSE           # MIT
├── supabase/
│   ├── schema.sql              # schema completo do backend (tabelas, RPCs, RLS, realtime)
│   └── functions/ai-ask/       # Edge Function: proxy de reserva (chave de servidor / CORS)
│       └── index.ts
└── examples/
    └── *.qdpx        # projeto de exemplo (REFI-QDA) para testes
```

---

## Créditos e inspirações

O QualiLab foi desenvolvido por **Luiz Pimenta Filho** no âmbito do **LabDados / FGV Direito SP** como projeto pessoal. Não representa posição institucional da FGV, que não tem qualquer responsabilidade pelo software.

A maior parte do código deste projeto foi escrita com assistência do [Claude Code](https://claude.com/claude-code) (Anthropic).

As principais inspirações foram:

- **[Taguette](https://www.taguette.org/about.html)**: ferramenta de QDA aberto, pioneira em simplicidade e funcionamento on-line, com suporte a múltiplos formatos de importação de documentos e exportação do codebook em REFI-QDA (`.qdc`).
- **[Magnolia](https://www.caledavis.eu/magnolia.html)**: QDA com foco em poder e intuitividade, transcrição de áudio/vídeo e análise de surveys. Um projeto impressionante e totalmente gratuito que merece sua atenção.
- **[QualCoder](https://github.com/ccbogel/qualcoder)**: QDA maduro e completo (codificação de texto, imagem, áudio e vídeo; relatórios e medidas de concordância), livre e de código aberto. Uma referência robusta para quem precisa de uma ferramenta de desktop full-featured.
- **[OpenQDA](https://openqda.org/)** ([código](https://github.com/openqda/openqda), AGPL-3.0): QDA aberto e colaborativo, feito na Universidade de Bremen, com arquitetura pensada desde o começo para receber extensões da comunidade. É o projeto de Jan Küster e Karsten D. Wolf, os autores do levantamento que enquadra a [Motivação](#motivação) deste README: a crítica que abre o texto vem de quem também está construindo uma resposta para ela.

Todos demonstram que é possível fazer ferramentas de qualidade sem cobrar das pessoas que mais precisam delas, e que vale a pena apoiá-las.

### Referência

O enquadramento da [Motivação](#motivação) e a tabela [Onde o QualiLab está nessa régua](#onde-o-qualilab-está-nessa-régua) se apoiam em:

> Küster, J.; Wolf, K. D. *The Current State of CAQDAS is Insufficient for Open Science Qualitative Research.* **Electronic Communications of the EASST**, v. 85 (deRSE25: Selected Contributions of the 5th Conference for Research Software Engineering in Germany), 2025. DOI [10.14279/eceasst.v85.2709](https://doi.org/10.14279/eceasst.v85.2709). Licença CC-BY 4.0.

Os dados do levantamento estão publicados em domínio público (CC-0) no Zenodo e no Harvard Dataverse, e a metodologia é mantida no repositório [zemki/state-of-caqdas](https://github.com/zemki/state-of-caqdas), que aceita contribuições da comunidade.

### Formato de intercâmbio

Os formatos **QDPX** (projeto completo) e **QDC** (livro de códigos) são definidos pela **[REFI-QDA Standard](https://www.qdasoftware.org/)**, o padrão aberto criado pela *Rotterdam Exchange Format Initiative (REFI)* para permitir a troca de projetos entre ferramentas de análise qualitativa. A importação e exportação desses formatos no QualiLab seguem essa especificação; todo o crédito pelo formato é da iniciativa REFI-QDA. Conheça e apoie o padrão em [qdasoftware.org](https://www.qdasoftware.org/).

**Declaração de conformidade** (a versão 1.0 do padrão, §6, pede que o software diga a que partes ele reivindica conformidade): o QualiLab **importa e exporta as duas** — *Project exchange* (`.qdpx`) e *Codebook exchange* (`.qdc`). Os pacotes gerados são validados contra o `Project.xsd` oficial (v1.0) por um harness de round-trip mantido no repositório de desenvolvimento. Duas ressalvas honestas, porque conformidade de schema não é compatibilidade: o padrão não tem onde guardar autoria de atributo por pesquisador nem camada de codificação, então o `.qdpx` sempre perde algo em relação ao `.qualilab` (o app diz o quê, no momento em que você exporta); e schema válido não substitui testar na ferramenta de destino real.

### Transparência ativa (DA-RT / QDR / ATI)

Além do intercâmbio entre ferramentas de QDA, o QualiLab mira o ecossistema de **transparência da pesquisa qualitativa** ligado ao movimento **DA-RT** (*Data Access and Research Transparency*) e ao **[Qualitative Data Repository (QDR)](https://qdr.syr.edu/)**. O método atual do QDR é a **Annotation for Transparent Inquiry (ATI)**: anotar passagens de um texto com notas analíticas, excertos e links para as fontes que sustentam cada afirmação.

A camada técnica sob o ATI (e sob o [hypothes.is](https://web.hypothes.is/), o Anno-REP e o repositório Dataverse) é o **[W3C Web Annotation Data Model](https://www.w3.org/TR/annotation-model/)**, uma recomendação aberta do W3C. O QualiLab **mira nesse padrão**, não numa ferramenta específica: a aba **Relatório** gera tanto o **Relatório Interativo (ATI)** (uma página HTML auto-contida equivalente ao *overlay* do ATI, hospedável por você) quanto a exportação **Web Annotation (W3C)** em JSON-LD, interoperável com qualquer ferramenta que fale o padrão. Assim, a "nota analítica" de cada trecho (e dos códigos, documentos e do projeto) vira um apêndice de transparência publicável, sem depender de nenhum fornecedor.

---

## Restrições atuais

O QualiLab é um projeto em desenvolvimento ativo. Vale conhecer as limitações antes de adotar para um projeto de pesquisa importante:

- **Capacidade do Supabase (modo nuvem)**: o plano gratuito do Supabase tem limites de armazenamento e processamento (na ordem de **500MB de banco de dados** e **alguns GB de tráfego mensal**, sujeitos a mudança pelo provedor; confira os valores atuais em [supabase.com/pricing](https://supabase.com/pricing)). Projetos muito grandes (muitos documentos longos, milhares de codificações) podem exigir um plano pago do Supabase ou o modo **Arquivo local**, que não tem esse limite.
- **Anonimização é manual, via código de censura**: marque um código como 🚫 (em "Renomear código") e os trechos com ele ficam de fora, por padrão, do que é enviado pra IA (com opção de incluir caso a caso na hora da análise). Não há detecção automática de informação sensível (nomes, CPFs, dados de saúde): o pesquisador precisa identificar e codificar os trechos. Também **não cobre export** (QDPX/CSV/JSON continuam exportando o texto cru, sem mascarar) nem qualquer informação fora dos trechos explicitamente codificados.
- **E-mail da conta não pode ser trocado**: nome de exibição e senha sim; e-mail, não (há **"Esqueci minha senha"** na tela de acesso, que redefine por link no e-mail). Se o servidor estiver usando o SMTP embutido do Supabase, o envio desses e-mails é limitado a poucos por hora.
- **A fila de escrita não é modo offline**: ela guarda e reenvia o que você *escreve* quando a nuvem falha, mas **ler** continua exigindo rede. Sem conexão, abrir um documento que ainda não está carregado ou trocar de projeto não funciona. Para trabalhar de fato sem rede, use o modo Arquivo local.
- **QDPX não carrega categorias por pesquisador**: é uma limitação do próprio formato REFI-QDA, não do QualiLab. O padrão não tem campo de autoria para atributos de documento (só para trechos codificados). Ao importar um `.qdpx`, todos os atributos chegam atribuídos a quem importou.
- **Tipo dos atributos em `.qdpx` de outras ferramentas é inferido, não declarado**: o REFI-QDA não distingue campo fechado de aberto. Ao importar um `.qdpx` de outro software (QualCoder, ATLAS.ti etc.), o QualiLab tenta adivinhar pelas respostas: poucos valores distintos repetidos entre documentos viram Texto Fechado; valores todos diferentes viram Texto Aberto. O resumo do import avisa quantas categorias foram decididas assim; vale revisar em "Gerenciar esquema de categorias".
- **Fidelidade do round-trip QDPX (medida, não presumida)**: o que sobrevive a `QualiLab → QDPX → QualiLab/QualCoder` é verificado por um harness de round-trip mantido no repositório de desenvolvimento, com uma **matriz de fidelidade** (sobrevive / degrada / se perde) e um corpus adversarial. Resumo: códigos, hierarquia e trechos em texto limpo **sobrevivem** (inclusive após emoji/char fora do BMP, desde o fix de offsets em code points); **degradam** tipos de categoria inferidos e multi-valor; **se perdem** camadas individuais e autoria de atributo (limites do próprio formato REFI-QDA). O `.qdpx` exportado é **validado contra o `Project.xsd` oficial do REFI-QDA (v1.0, MIT)**, vendorizado no repositório. ⚠️ Isso é uma **tentativa de intercompatibilidade, não uma garantia**: validade de schema e round-trip interno não substituem testar o arquivo na ferramenta de destino real (ATLAS.ti, MAXQDA, NVivo, QualCoder), que pode interpretar partes do padrão de forma diferente.
- **Sincronização em tempo real parcial**: apenas codificações e valores de categoria sincronizam ao vivo entre colaboradores. Mudanças no esquema de categorias ou na árvore de códigos exigem recarregar a página para aparecer para outros membros. O mesmo vale para mudanças na **distribuição de documentos / sigilo**.
- **Distribuição e codificação cega só na nuvem coletiva**: atribuir documentos, restringir a visão por pesquisador e o modo cego dependem de contas de vários pesquisadores; não existem em rascunho, arquivo ou projeto individual, e a distribuição **não** é exportada no `.qualilab` (os identificadores de usuário só existem na nuvem).
- **PDF original na nuvem é opt-in**: guardar os bytes do PDF original na nuvem (para "ver original"/OCR em outro aparelho) exige **consentimento explícito** no envio, porque quem administra o banco passa a poder abrir o PDF inteiro. Sem consentir, sobe só o texto e a codificação. Para dado sensível, mantenha o PDF no **modo arquivo**.
- **Governança do livro de códigos**: qualquer membro **cria e renomeia** códigos (necessário para codificação colaborativa em tempo real), mas **excluir** um código, **mesclar/reorganizar** o esquema em lote e marcar/desmarcar **censura** são restritos ao **administrador**, imposto pelo servidor (RLS), não só escondido na interface, porque excluir um código apaga em cascata as codificações de toda a equipe. Ainda **não** há um modo intermediário de aprovação antes de um código novo (criado por um membro) ficar visível a todos.
- **Desfazer é limitado**: Ctrl+Z desfaz só a última codificação aplicada na sessão atual (sem histórico entre sessões). Não há desfazer para categorias, código em si, documentos, ou qualquer outra ação; exclusões desses são definitivas. Também não há log de auditoria de alterações.
- **Modo Arquivo local restrito a Chromium**: a File System Access API que sustenta esse modo só existe em Chrome e Edge; Firefox e Safari caem automaticamente para o modo local (`localStorage`).

---

## Licença

MIT License: livre para usar, modificar e distribuir, com ou sem fins comerciais, desde que o aviso de copyright seja mantido.

```
Copyright (c) 2026 Luiz Pimenta Filho
```

---

## To-dos

O backlog completo, com o raciocínio e as decisões já tomadas, é mantido no repositório de desenvolvimento. Resumo do que está pendente, por tema:

**Prioridades declaradas**

- Backend sem credencial enterrada: catálogo de nuvens nomeado na configuração, "usar minha própria nuvem" como caminho de primeira classe e link-convite com tela de confirmação.
- Relações nomeadas entre códigos e entre trechos ("X contradiz Y", "X é causa de Y"): tabela de ligações com comentário, criadas pelo menu de contexto — sem editor gráfico por ora.

**Decisões em aberto (é escolha, não código)**

- Fontes: o `@import` do Google Fonts nunca funcionou e o app sempre rodou nas fontes de sistema. Corrigir liga o app ao Google em todo boot (questão de privacidade); apagar formaliza a pilha de sistema; embutir custa centenas de KB no arquivo único.
- Criptografia ponta a ponta com passkey, para colaboração ao vivo sem que o operador do servidor possa ler o corpus: desenho pronto, nada decidido, e duas sondagens de viabilidade vêm antes de qualquer código.

**Rastro e auditoria**

- Registro de mesclagem no código sobrevivente (quais códigos foram fundidos nele).
- Log de operações do projeto: imports, merges, exclusões, aplicações em lote — operações, não linhas.
- Desfazer em lote: quando a IA aplica 40 codificações, não há como desfazer o conjunto.

**Interoperabilidade**

- Citação em norma (ABNT, via citeproc-js) no import do Zotero; referência sem PDF virar documento, marcada como "resumo" ou "texto integral".
- Grupo de códigos do ATLAS.ti virar família quando a associação permitir.
- Testar o export QDPX contra MAXQDA e NVivo reais (ATLAS.ti e QualCoder já foram).

**Codificação sem IA (barata e valiosa)**

- Unidades de fala: reconhecer `Nome:` na transcrição e codificar cada fala com o código do falante.
- Planilha que nasce codificada (colunas de pergunta aberta viram trechos já codificados).
- Import de codebook por planilha (nome, definição, hierarquia).
- Comentários de margem do `.docx` virarem trechos anotados.

**Gráficos e medidas**

- Cards de síntese (nº de documentos, códigos, cobertura), distribuição por famílias analíticas e análises textuais automatizadas (similaridade, co-ocorrência, redes textuais).
- Frequências relativas e normalização na matriz código × atributo; coeficiente-C de co-ocorrência, com os avisos de leitura.
- Se exibimos "concordância", dizer o que é — e, se virar coeficiente, alfa de Krippendorff por caractere.
- Decidir a deduplicação das contagens: hoje árvore, frequência e cobertura contam codificações, então em equipe medem em parte o tamanho da equipe.

**UI e diversos**

- Definição do código visível onde se codifica, não só na aba Memos.
- "Buscar no contexto" a partir da nuvem de palavras; lista de "só contar estas" (GO list).
- Botão "Não informado" no tipo data; filtro por parte de valor; troca de e-mail da conta; sintaxe hierárquica no nome do código ("Tema: Subtema" cria a cadeia).
- Pastas por categoria e seleção declarada do que entra no relatório de transparência — o embrião do pipeline de publicação por pesquisador/pesquisa.

**Desempenho e robustez**

- Upload de PDFs e OCR em paralelo; carregamento agregado numa chamada só; rascunho local no IndexedDB (tira o teto de ~5 MB); streaming das respostas de IA; o realtime não propaga mudança de esquema (só de codificações).
- Reimportar o mesmo projeto duplica conversas e memórias de IA (idem coleção do Zotero) — falta deduplicação.

**Operacional (painel do Supabase, não código)**

- SMTP próprio (o embutido manda ~2 e-mails por hora, por projeto).
