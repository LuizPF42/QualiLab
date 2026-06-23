# CLAUDE.md — guia para continuar o QualiLab

Instruções para uma futura sessão do Claude trabalhar neste repositório. Leia antes de editar.

---

## O que é

Ferramenta de análise qualitativa (QDA) que roda **inteira em um único arquivo**: [`index.html`](index.html). HTML + CSS + JavaScript juntos. Sem build, sem bundler, sem npm. As dependências vêm de CDN (`esm.sh` / `jsdelivr`) carregadas sob demanda.

- **Front-end**: Preact + htm (template literals, **não** JSX).
- **Backend opcional**: Supabase (Postgres + Auth + Realtime). Sem credenciais, roda em modo **local** (`localStorage`).
- **Schema SQL**: a fonte da verdade do banco é [`supabase/schema.sql`](supabase/schema.sql) (idempotente). Mudou o banco? Atualize esse arquivo **e** o README.

---

## Regras de ouro (gotchas que já nos morderam)

1. **SÓ aspas retas (`"` `'`).** Aspas tipográficas/curvas (`"` `"` `'`) dentro de atributos quebram tudo: `class="card"` com aspa curva NÃO aplica a classe `.card`, então o elemento perde estilo (ex.: `.swatch` vira 0×0 e some). Já aconteceu de autocorreção inserir aspas curvas. Se algo "perdeu o estilo" sem motivo, **procure aspas curvas primeiro**:
   ```powershell
   # conta aspas curvas duplas no arquivo
   $t=[IO.File]::ReadAllText((Resolve-Path index.html),[Text.Encoding]::UTF8)
   ([regex]::Matches($t,[char]0x201C+'|'+[char]0x201D)).Count
   ```
   Para corrigir em massa: `.Replace([char]0x201C,'"').Replace([char]0x201D,'"')` e gravar com `UTF8Encoding($false)` (sem BOM).

   **Mesma armadilha pra busca-e-substituição em massa via PowerShell** (`Get-Content`/`Set-Content`): sem especificar encoding correto em ambas as pontas, acentos e travessões viram mojibake (`â€"` no lugar de `—`, `Ã³` no lugar de `ó`) e `-Encoding utf8` ainda adiciona BOM. Pra substituições simples de texto (ex.: renomear um prefixo de chave em todo o arquivo), **use `sed` via Bash em vez de PowerShell** — `sed -i 's/antigo/novo/g' index.html` preserva UTF-8 sem BOM de cara, sem essa cerimônia toda. Confira sempre com `git diff` depois: se aparecer muito mais linhas alteradas do que o esperado pra uma troca simples, é sinal de mojibake.

2. **htm, não JSX.** Sintaxe: `` html`<div class="x">${valor}</div>` ``. Componentes: `` html`<${Componente} prop=${v} />` ``. Listas com `key=${...}`. Não existe `className`; é `class`.

3. **Reaproveite as classes CSS existentes** (definidas no `<style>` do `<head>`) em vez de reinventar inline. Copiar o visual de um componente que já funciona (ex.: `TreeNode` → `VizCodeNode`) é mais seguro do que estilizar do zero.

4. **Mudou o banco? Entregue o SQL ao usuário e atualize `supabase/schema.sql`.** Eu não rodo SQL no Supabase dele. Forneço o bloco para colar no **SQL Editor → Run**. Tudo idempotente (`if not exists`, `create or replace`, `drop policy if exists`). **Trocar a assinatura de retorno** de uma função exige `drop function if exists ...()` antes do `create`. A fonte da verdade é [`supabase/schema.sql`](supabase/schema.sql) — mantenha-o completo; atualize o `README.md` se a doc de usuário também mudar.

5. **Não quebre o modo local.** Toda funcionalidade de store tem implementação em `LocalStore` **e** `SupabaseStore`. Métodos novos precisam de stub no LocalStore.

6. **Popup/menu posicionado por JS (`ctxMenu` em `App`) precisa de largura fixa, não só calculada.** O cálculo de `left`/`top` usa uma largura assumida (`menuW`) pra não vazar da tela; se o elemento real crescer pra caber conteúdo (nome de código longo, `min-width` sem `max-width`/`width`), o cálculo erra e o menu estoura a borda. Sempre trave `width:${menuW}px` (não `min-width`) no elemento e trunque o conteúdo interno com `text-overflow:ellipsis` em vez de deixar crescer.

7. **`header.top` é duas linhas, não uma** (`flex-direction:column` + dois `.top-row`): 1ª linha = marca "QualiLab" + `.seg` das views principais; 2ª linha = pílula do projeto, nome do usuário, "trocar projeto", "sair", "exportar ▾", "importar ▾" e o indicador de offline/sincronizando, nessa ordem, alinhados à esquerda. Existia antes como uma única linha (`flex-wrap`) que quebrava de forma imprevisível com muitos itens e empurrava o conteúdo da página pra baixo. Botão novo no cabeçalho → decida em qual `.top-row` ele entra (views → 1ª linha; ações de conta/projeto/import-export → 2ª linha).

8. **`.modal` tem `max-height:calc(100vh - 36px)` + `overflow-y:auto`.** Sem isso, um modal com muitos cards empilhados (ex.: `ProjectModal` em projeto coletivo na nuvem) cresce além da altura da tela e deixa botões inacessíveis, sem scroll. Qualquer modal novo reaproveita a classe `.modal` e já herda esse limite.

---

## Arquitetura

### Stores (padrão de abstração)
Três implementações do mesmo "interface":

- **`LocalStore()`** — `localStorage` (`qualilab:local`). Fallback sem credenciais e sem suporte a File System Access API. Limite 5MB.
- **`createFileStore(fileHandle, isNew)`** — **File System Access API**. Salva um `.qualilab` (JSON) visível no disco. Zero rede, funciona offline/air-gapped. Só Chrome/Edge. O `fileHandle` é persistido no IndexedDB (`IDB.saveHandle`) para reabrir na próxima sessão.
- **`SupabaseStore(sb)`** — Postgres via supabase-js, com RLS. Tem fila de escrita (`withQueue`) via IndexedDB para tolerar falhas de rede; `store.onPendingChange(cb)` notifica o App do contador de pendências; `store.flush()` é chamado ao reconectar (`window.online`).

**Batching (LocalStore e FileStore):** `store.beginBatch()` / `store.endBatch()` suprimem o `save()` por item e gravam **uma vez** no fim. Essencial em importação grande (`.qdpx`): sem isso, cada um dos centenas de inserts re-serializa o banco inteiro no disco/localStorage e a aba trava por segundos. `importQDPX` envolve toda a persistência em `beginBatch()`…`finally{ endBatch() }`. SupabaseStore não tem (inserts são chamadas de rede); o `importQDPX` guarda com `if(store.beginBatch)`.

**`store.onSaveError(cb)`** (`LocalStore`/`createFileStore`, mesmo padrão de `onPendingChange`): `localStorage.setItem`/`fileHandle.createWritable()` podem falhar (quota — geralmente 5-10MB — esgotada, storage desabilitado, permissão de arquivo revogada, disco removido) e isso **sempre passou em silêncio** (`catch(e){}` vazio) — o usuário continuava trabalhando sem saber que nada mais estava sendo persistido, só descobria ao reabrir e ver os dados faltando. Agora `save()` chama `_onSaveError(e)` no catch e `_onSaveError(null)` em todo save bem-sucedido (limpa o aviso quando o problema é resolvido); o `App` assina isso (junto com `onPendingChange`, no mesmo `useEffect`) em `saveError`, e mostra um banner vermelho persistente (sem botão de fechar — só desaparece quando um save volta a funcionar) com atalho pra baixar `.qualilab` na hora.

**Backup automático em pasta** (`LocalStore.enableFolderBackup()`/`disableFolderBackup()`/`onBackupStatus(cb)`, só modo local): espelho redundante do `localStorage` num arquivo `backup-automatico.qualilab` numa pasta escolhida pelo pesquisador (File System Access API — `showDirectoryPicker`, handle persistido no IDB igual ao `fileHandle` do modo arquivo). Não é o modo arquivo (que já é o disco, sempre escreve) — é um extra pra quem está em modo local e quer um arquivo visível também, sem trocar de modo. **Debounce escalado pelo tamanho do JSON** (`backupDebounceMs`: 5s/<5MB, 15s/<20MB, 30s/<50MB, 60s/≥50MB) — escrever o projeto inteiro a cada mudança travaria a aba em projetos grandes; acima de 50MB só acende `warnLarge` no status, continua tentando (sem teto que desliga). Reaproveita o `JSON.stringify(db)` já calculado pro `localStorage`, não serializa de novo. Permissão de pasta pode "expirar" entre sessões (`queryPermission` deixa de ser `'granted'`) — não tenta `requestPermission()` sem gesto do usuário (falharia silenciosamente ou pediria de novo sem contexto); só sinaliza no status pra o usuário reativar manualmente.

Helper `IDB` — wrapper mínimo sobre IndexedDB com dois stores: `write_queue` (fila de escritas pendentes do SupabaseStore) e `file_handles` (persistência do FileSystemFileHandle entre sessões).

O `App` só fala com `store.<método>()`, nunca com Supabase direto. Métodos principais:

```
mode
init(display) · currentUser() · signIn/signUp/signInAnon/signOut
changePassword(pw) · changeDisplayName(name)
createProject(name,display,mode) · joinProject(code,display) · listMyProjects()
myRole(pid) · listMembers(pid) · setMemberRole(pid,uid,role) · removeMember(pid,uid)
renameProject(pid,name) · deleteProject(pid) · setProjectMode(pid,mode,author)
listDocuments · addDocument · deleteDocument · clearProject
listCategories · addCategory · updateCategory · deleteCategory
getDocValues(docId) · setDocValue(pid,doc,cat,val) · setFinalValue(pid,doc,cat,val) · addDocValue(pid,v)
listCodes · addCode · updateCode · deleteCode
listCodings(pid,docId) · addCoding(pid,co) · deleteCoding(id)
listMemos(pid) · setMemo(pid,scope,targetId,content,authorName)
beginBatch() · endBatch()   // só Local/FileStore (suprime save por item)
onSaveError(cb)             // Local/FileStore (avisa falha silenciosa de gravação)
enableFolderBackup() · disableFolderBackup() · onBackupStatus(cb)   // só LocalStore
realtime(pid,onChange)      // só SupabaseStore
```

### App
Um componente Preact grande com todo o estado. Fases: `boot | auth | gate | work`. A "tela" de trabalho é decidida por `mainView`: `codificar | reconciliar | visualizar | graficos | memos | esquema | relatorio`.

### Mapa do arquivo (aproximado, mude com cuidado)
1. `<head>`: `showFatal` (tela de erro pré-JS, usa Georgia fixo), `:root` (variáveis de cor/fonte), classes CSS.
2. Loaders CDN: `getPdfjs/getMammoth/getJSZip/getCreateClient/getSqlJs`.
3. **CONFIG**: `SUPABASE_URL` / `SUPABASE_ANON_KEY` (ver abaixo).
4. `HUES` + `codeColor(hue,depth)` — paleta dos códigos.
5. Constantes de categoria: `CAT_KINDS`, `CAT_HAS_OPTIONS`, `CAT_MULTI_SEP`, `NAO_INFO`, `OUTROS`, `isSpecialOpt`.
6. `extractText`, `buildRuns`, helpers (`hslToHex`, `xmlEsc`, `csv*`, `download`…). **PDF** (`extractText`, via pdf.js): agrupa os itens de texto em linhas por proximidade de `Y` (tolerância ∝ altura média), descarta itens só-espaço (artefato de justificação) e **reflui** linhas no mesmo parágrafo num só texto — quebra de parágrafo só quando o gap vertical passa de ~1.6× a altura **local** das linhas (escala com o tamanho da fonte, pra título grande não virar parágrafos soltos), com tratamento de hifenização de fim de linha. **Não** tenta reconstruir tabelas (tentativa de colunas via `|` foi feita e revertida — atrapalhava mais do que ajudava; tabela real precisaria parsear as bordas vetoriais do `getOperatorList`, fora de escopo por ora).
7. QDPX: `buildCodeXml`, `exportQDPX`, `importQDPX`.
8. `LocalStore`, `SupabaseStore`.
9. `App` (inclui `saveQualilab()` — baixa o `.qualilab` com tudo, inclusive memos).
10. Componentes: `Auth`, `Gate`, `AccountModal`, `ProjectModal`, `CategoriesPanel`, `CategoryEditor`/`DraggableCategoryList`, `CategoryValue`, `Reconcile`, `SchemaCodesView`/`SchemaTreeNode`/`SchemaBulkPanel` (aba Esquema → Códigos), `VizNav`/`VizCodeNode`/`VizExcerpts` (Visualização), `ChartsPanel`+`barRows`, `ReportView`+`REPORT_GROUPS` (Relatório), `CodesPanel`/`TreeNode`/`RenameCode`, `MemoNav`/`MemoEditor` (Memos), `DebInput`, `DateInput`/`parseDate`, `AddPaste`.

---

## Modelo de dados — camadas e papéis (conceito central)

**Camada (`layer`)** existe em `codings` e em `doc_values`:
- `individual` — trabalho de cada pesquisador (gravado com o `created_by`/`set_by` dele).
- `final` — camada consolidada ("gabarito"). Em codings vem da Reconciliação; em doc_values só o admin escreve.

`doc_values` tem unicidade **`(document_id, category_id, set_by, layer)`** — ou seja, um valor por pesquisador por categoria, mais o gabarito.

**Tipo de projeto (`projects.mode`)**:
- `collective` — camadas individuais + tela de Reconciliação + filtro "Ver:".
  - **Gotcha (já corrigido):** `viewCoder==='all'` (no leitor) sobrepunha só as camadas individuais (`indiv`), deixando o gabarito de fora — quem queria ver "todo mundo" não via o que já tinha sido consolidado na Reconciliação. `visibleCodings` agora retorna `codings` (todas as camadas) nesse caso. Note que isso é só pro leitor (`buildRuns`); o equivalente em `CategoriesPanel.valOf` (resposta de categoria pro filtro "Ver:") continua caindo no gabarito sozinho — não tem como "sobrepor" um único valor de categoria como se sobrepõe grifos de texto.
- `individual` — `applyCode` e `setValue` escrevem direto em `layer='final'`; Reconciliação e "Ver:" ficam ocultos. Converter collective→individual é **destrutivo** (RPC `set_project_mode` colapsa codings num único autor e mantém só o gabarito das categorias).
  - **Gotcha (já corrigido):** como o seletor "Ver:" fica oculto aqui, `visibleCodings` **mostra todas as codificações** quando `projectMode==='individual'` (`return codings`), em vez de filtrar por camada. Sem isso, codings importados de `.qdpx` (que entram em `final`, mas podem estar em `individual` por histórico de modo) ficariam **invisíveis** no leitor. `buildRuns` deduplica por posição.
  - **Gotcha (já corrigido):** mesmo problema valia pra `doc_values` em `CategoriesPanel` — uma versão antiga de `valOf` filtrava `v.layer!=='final'` incondicionalmente. Em projeto individual, como `setValue` grava direto em `final`, a aba "Categorias do documento" nunca encontrava o que ela mesma salvou. E uma versão seguinte aceitava `v.set_by==null` como "é minha resposta" — quebrava assim que `addDocValue` passou a gravar `set_by:null` pra preservar vários autores importados (ver `.qualilab` abaixo): mostrava a resposta de **qualquer** autor importado (a primeira encontrada) como se fosse a do usuário logado. A versão atual de `valOf` exige `v.set_by===userId` estrito no caso coletivo.

**Papéis (`members.role` = `admin|member`)**: `is_admin(pid)` gateia esquema de categorias (`categories_write`), gabarito (`doc_values_final`) e as RPCs de gestão. `is_owner` ainda existe mas as permissões migraram para `is_admin`.

**Tipos de categoria** (`categories.kind`): `select` (Texto Fechado), `text` (Texto Aberto), `date`, `single` (Múltipla Escolha — token legado), `checkbox` (Caixa de Seleção). Opções ficam em `options` (jsonb). Os tokens `NAO_INFO`/`OUTROS` são **opções especiais** dentro de `options`, controladas por toggles no editor; multi-valor (checkbox) é juntado com `CAT_MULTI_SEP` (`' | '`). Datas são `DD/MM/AAAA` com partes opcionais (string, não ISO).

---

## Supabase (Auth + SQL)

- **CONFIG**: `SUPABASE_URL` e `SUPABASE_ANON_KEY` estão fixos no `index.html` apontando para o projeto do autor. A anon key é **pública por design** (protegida por RLS). Para um deploy novo, troque por outras credenciais (ou deixe em branco para forçar modo local; o usuário também pode informar pela pílula → Conexão).
- **Auth a habilitar no painel**: Providers → Email; "Allow anonymous sign-ins" (modo visitante); opcional desligar "Confirm email".
- **RPCs** (todas `security definer`): `create_project`, `join_project`, `my_projects` (retorna `mode` e `role`), `is_admin`, `set_member_role`, `remove_member`, `rename_project`, `delete_project`, `set_project_mode`.
- **Realtime**: `codings` e `doc_values` estão na publicação `supabase_realtime`. `store.realtime(pid,onChange)` assina e dispara recarga; há poll de reserva de 20s.
- **Tabela `memos`**: nota única por `(project_id, scope, target_id)`, com RLS por membro (qualquer membro do projeto lê e escreve).

---

## UI — cores e fontes

- **Cores** (variáveis em `:root`): a família `--teal*` guarda o **azul-marinho FGV** (nome "teal" é legado): `--teal #00427A`, `--teal-deep #002B5C`, `--teal-soft #E2ECF5`, e `--sky #1B9DD9` (azul-claro FGV). `--danger #B23A3A` para ações destrutivas. Cores dos códigos vêm de `HUES`/`codeColor` (matiz = família, luminosidade = profundidade) — **não** mexa nelas para branding.
  - `codeColor(hue, depth, hueDeg)` tem saturação **fixa** (58%/55%) — só o matiz varia (automático via `HUES`, ou personalizado via `hueDeg`). Por isso `RenameCode` usa um `<input type="range">` de matiz (0-359) pra cor personalizada de família, não um `<input type="color">`: o retângulo RGB completo deixaria escolher saturação/luminosidade que seriam descartadas, confundindo o usuário. **Cinza/preto personalizados**: `hueDeg===-1` (cinza) e `hueDeg===-2` (preto) são sentinels (reaproveitam a mesma coluna `int`, sem migração) que `codeColor` interpreta como saturação 0 — o preto também zera a luminosidade (`solidL=0`, fixo, **não** varia por profundidade como as outras cores; o cinza continua variando). Botões "cinza"/"preto" em `RenameCode` chamam `onSetColor(code,'gray'|'black')`, e `setCodeColor` (no `App`) converte essas strings mágicas pra `hue_deg:-1`/`-2` antes de salvar. Preto é mais reconhecível como "censurado" que cinza — motivação original de adicionar a opção.
- **Fontes** (Google Fonts via `@import`): `--sans` **Inter** (interface), `--serif` **Newsreader** (leitura de documentos/trechos), `--mono` **JetBrains Mono** (códigos/números).
- **Classes reutilizáveis**: `.card`, `.pill`, `.btn`/`.btn.sm`/`.btn.primary`/`.btn.ghost`, `.icon-btn`, `.opt`/`.opt.on`, `.field`/`.field-label`, `.banner.warn`/`.banner.err`, `.node`/`.node-row`/`.node-row.sel`/`.swatch`/`.caret`/`.count`/`.node-name`, `.reader`, `.modal-bg`/`.modal`, `.meta`, `.author`, `.tree`, `.pane`/`.pane-head`/`.pane-body`, `.split`.

---

## Telas (mainView)

- **codificar** — leitor `.reader` à esquerda (grifos via `buildRuns`; botão direito = menu de contexto p/ aplicar código), painéis `CategoriesPanel` + `CodesPanel` à direita. Filtro "Ver:" (camada/codificador) só em collective+nuvem. `CategoriesPanel` segue o mesmo `viewCoder` (recebido como prop) que `visibleCodings` usa pros grifos — ver `Ana`/`Bruno`/gabarito também troca a resposta de categoria exibida, não só o texto grifado. **Mas `'all'` (Individuais/todos) não significa "minha resposta" aqui**: no leitor, `'all'` sobrepõe os grifos de todo mundo ao mesmo tempo, o que não tem equivalente num campo de categoria (só cabe 1 valor); por isso `'all'` cai no gabarito (se existir) em vez de tentar adivinhar uma resposta. Só é **editável** quando `viewCoder==='mine'` (resposta do próprio usuário, sem ambiguidade) ou em projeto individual; ver a resposta de outro pesquisador, o gabarito, ou `'all'` fica somente leitura (editar ali escreveria sob a identidade de quem está logado, não da pessoa exibida — o gabarito se edita na Reconciliação). `CategoryValue` recebe `readOnly` e desabilita cada controle (`disabled` real no `<select>`/`<input>`/botões `.opt`, não só CSS) mantendo exatamente o mesmo visual de pills da edição.
  - **Borda só com >1 código sobreposto**: `run.codings.length>1` é a condição pro `border-bottom` no leitor — um trecho com 1 código só mostra apenas o fundo tintado (`col.tint`), sem linha embaixo, pra não poluir visualmente. A borda existe só pra sinalizar "tem mais de um código aqui".
  - **Desfazer (Ctrl+Z)** a última codificação aplicada: `undoStackRef` (pilha em `useRef`, até 50 entradas) registra cada `addCoding`; `undoLastCoding()` faz pop e `deleteCoding`. Um `useEffect` escuta `keydown` global, só age com `mainView==='codificar'` e fora de campos de texto (`input`/`textarea`/`select`/`isContentEditable`), e dá `preventDefault()` pra não disparar o undo nativo do navegador. Se o delete falhar, devolve a entrada pra pilha (`undoStackRef.current.push(last)`) em vez de simplesmente descartar.
  - **Remover código direto pelo menu de contexto**, sem precisar selecionar de novo: `onContextMenu` agora também aceita clique num span já grifado (`e.target.closest('[data-c="1"]')`, daí o `data-end` novo em todo `<span>` do leitor, não só `data-start`) — sem seleção de texto nova, `ctxMenu.sel` fica `null` e `ctxMenu.pos`/`ctxMenu.runEnd` guardam a posição clicada. `codingsForCtxMenu(menu)` resolve quais codificações cobrem aquele ponto/seleção (`canRemoveCoding` bloqueia remover coding de outro autor em projeto coletivo na nuvem — exceção: projeto individual, onde tudo é do próprio usuário de fato). O menu mostra uma seção "Remover código" por cima da lista de aplicar (que só aparece se `ctxMenu.sel` existir — clique num grifo sem seleção não oferece "aplicar", só "remover").
- **reconciliar** — `Reconcile`: categorias (gabarito + ✓/✗ por pesquisador, admin define) e códigos (grupos sobrepostos → consolidar na camada final). Só em collective.
- **visualizar** — master-detail: `VizNav` (camada + categorias colapsáveis + árvore de códigos) | `VizExcerpts` (trechos do código em `.card` com `.reader`, agrupados por documento, co-ocorrência opcional).
- **graficos** — `ChartsPanel`: frequência de códigos, distribuição por categoria, heatmap código×categoria, produção/concordância por codificador. Barras em HTML/CSS (`barRows`) + tabela; **sem libs**.
- **memos** — master-detail: `MemoNav` (projeto/documento/código) | `MemoEditor` (nota única por alvo, autosave, compartilhada entre membros).
- **relatorio** — `ReportView`: **montador** de relatório. Barra lateral (`.no-print`) com caixas de seleção agrupadas (`REPORT_GROUPS`: Visão geral / Esquema / Resultados) + a pílula discreta "Creditar QualiLab no resumo"; o relatório se monta ao vivo em `#report-print`. Seções: resumo (com "Codificado por" só em coletivo + crédito opcional **embutido** no parágrafo do resumo), lista de documentos, contagens/listas do esquema (categorias, códigos de Hierarquia 0, sub-códigos), frequência de códigos, distribuição por categoria, trechos por código, códigos não utilizados. **Seletor de camada** (gabarito final / individuais — só em collective) controla codings **e** doc_values usados; sem o fallback automático antigo (camada final vazia agora aparece vazia de propósito, não mascarada com as individuais). **Copiar texto** monta a mesma estrutura em **texto simples** (sem markdown — `•`, sem `#`/`**`/`>`), pensado pra colar em `.docx`/Docs (`navigator.clipboard.writeText`). **Imprimir/PDF** via `window.print()` + CSS `@media print` que isola `#report-print` (`visibility`) e **força tinta escura sobre branco** (redefine `--ink*`/`--surface`/`--paper` no escopo do relatório) pra não sair texto claro quando o app está em tema escuro. Sem libs, sem schema novo.
- **esquema** — tela inteira, sem documento aberto, com sub-abas (`esquemaTab`): `categorias` (reaproveita `CategoryEditor`, sem o trecho de preencher valor do documento que `CategoriesPanel` tem) e `codigos` (componente próprio `SchemaCodesView` — **não** é o `CodesPanel`/`TreeNode` da tela de Codificação, que ficam intocados de propósito). Visão expandida e **aditiva**: o painel lateral de Codificação continua igual, intencionalmente duplicado (decisão consciente: menos mudança de hábito > menos duplicação).

### Reorganização em lote de códigos (`SchemaCodesView`)

Pensada pra quem termina a codificação aberta (grounded theory) com centenas de códigos soltos, todos no mesmo nível. Duas colunas: árvore com checkbox por código (`SchemaTreeNode`, paralelo ao `TreeNode` mas com seleção múltipla — propositalmente um componente separado, não uma flag a mais no `TreeNode`) + um painel de ações que muda conforme a seleção (`schemaSel`, estado local do componente, perdido ao trocar de sub-aba — não precisa persistir):

- **1 código** (clique simples na linha, não no checkbox) → painel com `RenameCode` + botão **"Promover a Hierarquia 0"** (só aparece se `parent_id` não for nulo).
- **2+ marcados** (checkbox) → `SchemaBulkPanel`, com duas ações:
  - **Agrupar** — os marcados continuam separados, só passam a ser filhos de um código (existente, escolhido num `<select>`, ou recém-criado via `onAdd(null, nome)`, que já nasce em Hierarquia 0). Adota a cor (`hue`/`hue_deg`) do pai.
  - **Mesclar** — escolhe um sobrevivente (sugestão = o mais frequente, recalculada a cada mudança de seleção via `useEffect` em `[selectedIds]` — **não** usar `useState(sorted[0])` sozinho pra isso: só roda na 1ª montagem do painel, então marcar um 3º código mais frequente *depois* do painel já estar aberto não atualizaria a sugestão; foi um bug real, pego em teste). Reatribui as codificações dos demais ao sobrevivente e os exclui. Irreversível — confirma antes.
- **`reparentSubtree(codeId, newParentId, newDepth, adoptColor)`**: sempre que um código muda de pai, recalcula a profundidade (e, se `adoptColor`, a cor) de toda a subárvore recursivamente — `code.depth` é lido direto por `codeColor()` pra luminosidade do swatch, então fica errado se não for atualizado junto.
- **Merge preserva filhos**: antes de excluir um código mesclado, os filhos diretos dele são reparentados pro sobrevivente — senão `store.deleteCode` (que já apaga em cascata) destruiria esses filhos sem querer.
- **Sem `updateCoding` nos stores**: mesclar codificações é feito via `addCoding` (pro novo `code_id`) + `deleteCoding` (a original), não uma atualização in-place.
- **Proteção contra ciclo**: ao agrupar, pula qualquer código que seria movido para dentro do seu próprio descendente (`isDescendantOf`).

### Reordenar por arrastar (drag-and-drop nativo, sem lib)

Categorias e códigos só nasciam anexados no fim (`position: lista.length`) — não tinha jeito de reordenar até agora. HTML5 Drag and Drop nativo (`draggable`/`dragstart`/`dragover`/`drop`), sem dependência nova.

- **Categorias**: `DraggableCategoryList` (novo componente, antes do `CategoryEditor`) — envolve cada `CategoryEditor` com um handle `.drag-handle` (⠿) arrastável. Aparece nos **dois lugares** que listam categorias (`CategoriesPanel` → "Gerenciar esquema" e a aba Esquema → Categorias), porque os dois já reaproveitavam o mesmo `CategoryEditor`; não há a mesma separação que existe pra códigos (`SchemaCodesView` vs. `CodesPanel`/`TreeNode`). Estado do arrasto (`dragCatId`/`setDragCatId`) e a função `reorderCategories(draggedId,targetId)` ficam no `App`, passados como prop pros dois — como só 1 dos dois fica visível por vez, reaproveitar o mesmo estado é seguro. `reorderCategories` é flat (categoria não tem hierarquia): pega a lista ordenada por `position`, tira o arrastado do lugar antigo, insere no lugar do alvo, grava `position` de quem mudou.
- **Códigos**: só na aba Esquema (`SchemaTreeNode`/`SchemaCodesView`) — **de propósito não** está em `CodesPanel`/`TreeNode` (tela de Codificação), que ficam intocados pela mesma razão de sempre (menos mudança de hábito). `reorderSiblings(draggedId,targetId)` em `SchemaCodesView` só reordena **entre irmãos** (mesmo `parent_id`) — arrastar pra um código de outro pai é ignorado em silêncio (mudar de pai é o que "Agrupar" já faz, de propósito separado). Não funciona na lista filtrada por busca (`filtered` é plana, sem agrupamento de irmãos visível).
- Em ambos: handle dedicado (`.drag-handle`, `cursor:grab`) em vez do item inteiro ser arrastável — evita conflito com clique-pra-selecionar/inputs de texto dentro da linha. `onDrop` só dispara o reorder se o id de origem ≠ destino; resto é silencioso (sem mensagem de erro pra um drop inválido).
- **Feedback visual do arrasto**: o item sendo arrastado fica translúcido (`opacity:.35`) e o alvo sob o cursor ganha uma linha azul (`box-shadow:0 -3px 0 0 var(--sky)`) no topo, indicando onde vai cair (`overId`/`setOverId` via `onDragOver`/`onDragLeave`, limpo no `onDragEnd`). Em **códigos** o indicador só acende em alvo **irmão válido** (`code.parent_id===dragParentId`, com `dragParentId` calculado no `SchemaCodesView` e propagado pela árvore) — coerente com `reorderSiblings` ignorar drop entre pais diferentes.

A **pílula do projeto** no cabeçalho abre o `ProjectModal` (hub: convite/código de acesso, tipo, membros, renomear/limpar/excluir, conexão). O **nome do usuário** abre `AccountModal` (nome, senha, gestão de todos os projetos, **e "sair da conta"** — chama o mesmo fluxo de logout do botão "sair" do cabeçalho: `store.signOut()` + limpa projeto/usuário ativo e volta pra tela de auth). O botão **"salvar .qualilab"** no cabeçalho chama `saveQualilab()` (download do projeto inteiro em qualquer modo).

### "Usar offline"

Botão extra na tela de login (`Auth`, prop `onLocal`), ao lado de "Continuar como visitante". `enterLocalOffline(display)` troca o store ativo pra `LocalStore()` (sem rede) e cria um projeto local na hora, pulando o fluxo de auth do Supabase inteiramente. Acionado em três situações: clique explícito no botão; `onAnon` detecta `!online` (evento `offline` do browser) **antes** de tentar `signInAnon`; ou `onAnon` tenta `signInAnon` e a chamada falha com a mensagem `"anonymous sign-ins...disabled"` (provedor de Auth do Supabase sem essa opção habilitada) — nesse caso cai pra offline automaticamente em vez de só mostrar o erro pro usuário.

### "Enviar para a nuvem"

Card no `ProjectModal` (`canSendToCloud = wantCloud && store?.mode!=='cloud'` — só aparece quando o projeto ativo é local ou arquivo e existe config de Supabase pra nuvem) que abre `SendToCloudModal`: cria um projeto novo na nuvem e importa o projeto ativo pra ele numa tacada só, sem passar por exportar/importar `.qualilab` manualmente. **Refatoração que viabilizou isso**: `importQualilab(file,...)` agora só faz `JSON.parse` e delega pro núcleo `mergeQualilabDb(db,...)`; `saveQualilab()` da mesma forma delega a montagem do objeto pra `buildQualilabDb()`. O modal é **auto-contido** — usa seu próprio cliente Supabase/`SupabaseStore` (mesma `SUPABASE_URL`/`SUPABASE_ANON_KEY` globais) pra autenticar e criar o projeto, **sem tocar** no `store`/sessão principal do `App`; depois de criado, entrar de fato no projeto continua sendo "trocar projeto", fluxo já existente — evita o risco de troca de store em tempo real no meio de uma sessão ativa.

### Controles de leitura e busca no documento (tela Codificação)

`readerPrefs` (`{scale,width,theme}`, `localStorage:qualilab:reader_prefs`) controla zoom de fonte, largura da coluna (`width-narrow` força `max-width:760px` centralizado) e tema (`light`/`sepia`/`dark`) — aplicados via classes em `.pane-body.scroll.reader-pane` (tema/largura) e `style` inline no `.reader` (zoom, `font-size` calculado). Botões A-/A+/⬍/☀ no `pane-head`.

**Busca** (`searchOpen`/`searchQuery`/`searchIdx`): `searchMatches` é uma lista de `[start,end]` calculada por `indexOf` sucessivo no `activeDoc.content` (case-insensitive). `buildRuns` ganhou um 3º parâmetro `extraPoints` — pontos de corte adicionais (aqui, os limites de cada match) que se somam aos limites das codificações, garantindo que cada run fique inteiramente dentro ou fora de um match. Cada run checa `matchI = searchMatches.findIndex(...)`; se houver match, ganha `data-match={i}` e um destaque (`box-shadow` para os demais, `background` sólido para o atual via classe `current`) — **por cima** do grifo de código existente, sem substituí-lo. Navegação ‹anterior/próxima› e Enter/Shift+Enter fazem `setSearchIdx` com módulo (`((i%n)+n)%n`) pra dar wrap-around nos dois sentidos; um `useEffect` rola o match atual pra vista via `readerRef.current.querySelector('[data-match="i"]')`.

---

## QDPX (import/export) — limitações importantes

- O padrão REFI-QDA **não tem autor em `VariableValue`** → categorias por pesquisador **não** cabem no QDPX (só um valor por atributo por caso). Codificações de trecho **têm** `creatingUser`, então multi-coder funciona para trechos.
- **Import remapeia todos os ids** para uuids novos (evita colisão de PK ao reimportar) e grava codings com **`created_by: null`** para que o agrupamento por codificador use `author_name` (e não o uuid de quem importou).
- **Export** prefere a camada `final` (gabarito) quando existe; senão usa as individuais.
- **Tipo de categoria (interoperabilidade)**: o próprio `exportQDPX` grava `tipo: <kind> | valores: <opções>` na `Description` da `Variable` — uma convenção nossa, não do padrão REFI-QDA. Um `.qdpx` **estrangeiro** (QualCoder, ATLAS.ti etc.) não tem isso, então `importQDPX` cai numa **heurística de cardinalidade**: olha os valores observados nos `Cases` e, se houver entre 2 e 8 valores distintos **com repetição** (`distinct < total`, ou seja, pelo menos uma resposta usada em mais de um documento), importa como Texto Fechado (`select`) com essas opções; senão, Texto Aberto. O resumo do import informa quantas categorias foram detectadas assim (revisar manualmente se necessário).
- **`importQDPX` continua com 1 valor por documento+categoria** (essa é a limitação real do formato REFI-QDA, não dá pra contornar). Já **`importQualilab` preserva múltiplos pesquisadores por categoria** em destino coletivo: usa o `store.addDocValue(pid,v)` (set_by:null + author_name livre, mesmo padrão de `addCoding`/`created_by:null`) para gravar cada resposta `layer='individual'` do arquivo de origem como uma linha própria, em vez de descartar todas menos uma. O gabarito (`layer='final'`) continua único por documento+categoria, escrito por último via `setFinalValue`. Em destino **individual** (sem multi-coder possível), mantém o comportamento antigo: prefere o gabarito de origem, senão a 1ª resposta encontrada. **RLS**: existe uma policy `doc_values_imported` (`supabase/schema.sql`) liberando `set_by is null and layer='individual'` pra qualquer membro — sem ela o insert falha com "new row violates row-level security policy".

### Import de `.qdpx` do ATLAS.ti (PDF) — seleções geométricas e recuperação por pdf.js

`.qdpx` exportado do **ATLAS.ti** (a partir de projeto com PDFs) tem uma estrutura que quebrava o import e exigiu tratamento próprio. **Diagnóstico validado** com um projeto real (66 docs, 1513 códigos, 2864 codings): o import passou de **0 → 93%** das codings recuperadas. As três causas e seus consertos:

1. **As seleções de PDF são `<PDFSelection>` filhas DIRETAS do `<PDFSource>`** (não `PlainTextSelection` dentro da `<Representation>`, que é onde o código olhava antes — ali não havia nenhuma). Cada `PDFSelection` tem **coordenadas geométricas** (`firstX/firstY/secondX/secondY/page`, pontos do PDF, origem embaixo) e o texto grifado no atributo **`name`** — mas só para seleções *inline*; para seleções **retangulares** (o pesquisador desenha um retângulo em volta de um bloco) o `name` vira o **nome do arquivo** (`...pdf`) ou `"L × A"` (região de imagem), **sem texto**. O `.atlasti` nativo (`project.aprx`, AML) guarda exatamente a mesma coisa — o texto do retângulo **não existe em arquivo nenhum**.
2. **Mismatch Unicode NFD×NFC**: o `name` vem em **NFD** (macOS: `c`+cedilha combinante) e o `.txt` da `Representation` em **NFC** (`ç`) → `indexOf` falhava mesmo com o trecho presente. Conserto: `findQuoteSpan`/`buildMatchIndex` normalizam **NFC + colapso de espaços/quebras + lowercase**, com mapa de posições (indexado por unidade UTF-16) pra recuperar o offset real. Há um fallback aproximado (âncora por prefixo+sufixo de palavras) marcado `approx`.
3. **Mojibake (`�`) é da origem**, não nosso: o ATLAS.ti gravou ~36 mil `�` no `.txt` (camada de texto dos PDFs defeituosa pra chinês/símbolos). `pdftotext`/poppler produzem os mesmos `�` — **irrecuperável sem OCR**.

**Recuperação geométrica (`extractPdfTextAndGeometry`, `textInRect`, `reconstructRectText`) é FALLBACK, não o caminho principal.** Para `.qdpx` "normais" (texto fornecido + offsets/`name` bons), o pdf.js **nunca roda**; usa-se a `Representation`/`.txt` como sempre. O fallback só dispara **por documento** quando há `PDFSelection` retangular (nome = arquivo, ou vazio — `precisaGeometria` no branch do `PDFSource`). Aí o **pdf.js vira a fonte única daquele documento**: numa só passada extrai o texto reflowado (= conteúdo exibido, mesma lógica de reflow do `extractText`) **e** os itens posicionados por página. Cada retângulo é reconstruído com `textInRect` (filtra itens pela coordenada, ordem de leitura, espaçamento por lacuna) e localizado no conteúdo via `findQuoteSpan` — **casamento intra-extração** (mesma origem dos dois lados), que é o que faz funcionar: a tentativa anterior de casar texto do pdf.js contra o `.txt` do ATLAS.ti dava só ~56%, porque as duas extrações "erram diferente" no texto defeituoso. Coordenadas: tenta origem-embaixo (PDF/ATLAS.ti) e cai pra origem-no-topo como fallback. Se o pdf.js falhar, mantém o `.txt` (degradação graciosa, sem geometria). O resumo do import conta `trechosGeometricos` e `trechosAproximados` à parte; o que sobra são regiões de **imagem** (sem texto, irrecuperáveis) e casos de borda.

**Filtro "Ver:" por codificador funciona offline/individual.** Projeto local nasce em modo `individual` → as codings importadas entram em `layer='final'` com `created_by:null` + `author_name` variado (o `.qdpx` tem ~20 autores). O seletor "Ver:" (antes só `cloud+collective`) agora também aparece quando `coders.length>1`, e `coders`/`visibleCodings` consideram `author_name` mesmo na camada `final` em projeto individual — permite filtrar por pesquisador sem nuvem. Ver `coders` (useMemo), `visibleCodings` (branch `projectMode==='individual'`) e o render do seletor no `pane-head`.

## Import Taguette (`.sqlite3`) — `importTaguette`

O Taguette **não** usa QDPX para o projeto completo (só o codebook, em `.qdc`); o projeto inteiro é um banco **SQLite** próprio. `importTaguette` lê esse arquivo no navegador via `getSqlJs()` (sql.js, SQLite→WASM, carregado por CDN como os outros loaders).

- **Helper `all(sql)`**: usa `db.prepare(sql)` + `stmt.step()`/`stmt.getAsObject()` — **não** `db.exec(sql)[0].columns`. Em builds via esm.sh, a propriedade `columns` do resultado de `exec()` vem com nome minificado (`lc`) e falha silenciosamente (`undefined.map`); `getAsObject()` não tem esse problema. Se for tocar nessa função, mantenha o padrão `prepare`/`step`.
- **Schema relevante** (`taguette/database/models.py` no upstream): `projects`, `documents.contents` (texto puro), `tags.path` (nome do código, hierarquia opcional via pontuação livre — o Taguette aceita qualquer caractere), `highlights` (`start_offset`/`end_offset`/`snippet`), `highlight_tags` (M:N — um trecho pode ter várias tags ao mesmo tempo, cada uma virando uma `coding` separada com o mesmo span).
- **Hierarquia de código**: aceitamos as duas convenções que o próprio Taguette documenta, `/` e `.`; sem nenhuma das duas, o código fica plano (sem família). Essa lógica está em `splitHierPath`/`buildCodeTreeFromPaths` (funções de topo, reaproveitadas pelo import de `.qdc` — ver abaixo).
- **Sem atributos de documento e sem autor por trecho** — o Taguette não tem esses conceitos. `author_name` fica fixo como `'Taguette'`.
- Se houver mais de um projeto no arquivo, importa o primeiro (sem seletor na UI ainda).

## Import/export `.qdc` (REFI-QDA Codebook) — `importQDC`/`exportQDC`

`.qdc` é só o livro de códigos — sem documentos nem codificações, o formato não tem isso. Usa o mesmo elemento `<Code>` (recursivo, `guid`/`name`/`color`) que o `<Project>` do QDPX, então `exportQDC` reaproveita `buildCodeXml`.

- **Import detecta se há aninhamento real**: `xml.querySelector('Code Code')`. Se houver (MAXQDA, ATLAS.ti, NVivo, o próprio QualiLab), reconstrói a árvore do XML normalmente, incluindo `color` (hex) → `hue_deg` via `hexToHueDeg` (preserva o tom exato; **não** confundir com `hueOf`, que arredonda pro swatch mais próximo da paleta `HUES` e descarta a cor original — `hueOf` existe mas não é usado aqui de propósito).
- **Sem nenhum aninhamento no arquivo inteiro** (ex.: o próprio Taguette exporta assim — tudo num nível, hierarquia embutida no `name` como `"tech.floss"`): cai no mesmo `buildCodeTreeFromPaths` do import do Taguette via `.sqlite3`, usando `name` como o "caminho".
- **Export**: sempre com aninhamento real (`<Code>` dentro de `<Code>`) e `color`, já que vem da nossa própria árvore — não precisa da heurística.

---

## Rodar e testar

Não há build. Sirva o arquivo e abra no navegador:
```bash
python -m http.server 8000   # ou: npx serve .
```
Teste com `examples/QualiLab_demo_artificial_stress_test.qdpx` (16 docs, 90 códigos, 2332 codificações, 7 "usuários" incluindo um "Gabarito experimental"). Não há suíte de testes automatizada — verificação é manual no navegador.

---

## Receitas comuns

- **Nova view**: adicione um botão no seg do cabeçalho (`mainView`), um branch no encadeamento `mainView==='...' ? html\`...\` : ...`, e o componente. Se precisar de dados do projeto inteiro, dispare `loadAll()` no efeito (`mainView` incluso).
- **Novo método de store**: implemente nos **três** stores — `SupabaseStore`, `LocalStore` **e** `createFileStore`. Se for RPC, entregue o SQL e atualize o `schema.sql` + README. (Ex.: `listMemos`/`setMemo` existem nos três.)
- **Coluna nova em tabela**: `alter table ... add column if not exists ...`; deixe a store tolerante se a coluna puder faltar (ver `addCategory` que remove `description` no fallback). Atualize o README.
- **Mudar permissão**: ajuste a policy RLS (ou o `is_admin` na função) — não confie só em esconder o botão; o servidor é a autoridade.

---

## Limitações conhecidas / backlog

- `loadAll()` busca doc a doc em série (lento com muitos documentos). Candidato a `Promise.all` ou RPC única.
- Mudanças de **esquema de categorias/códigos** não propagam por realtime (só `codings`/`doc_values`); o membro vê ao recarregar.
- Sem **import JSON nativo** (o export JSON já carrega `author`/`layer` — fechar o round-trip permitiria categorias por pesquisador fora do QDPX).
- Sem "esqueci minha senha" (reset por e-mail).
- Categorias multi-valor no filtro da Visualização casam por valor individual; refinamentos por parte (ex.: filtrar por ano de uma data) ainda não existem.
- `LocalStore` ainda usa `localStorage` (limite 5-10MB). Candidato a migrar pra IndexedDB — funciona em Safari igual, sem o teto baixo. O banner de `onSaveError` cobre o aviso reativo (avisa quando o save falha); falta um indicador **proativo** de uso (ex.: "X% do limite") pra avisar antes de chegar lá.

---

## Preferências do autor

Luiz Pimenta Filho (LabDados / FGV Direito SP). Projeto pessoal, sem responsabilidade institucional. Licença **MIT**. Inspirações creditadas no README: Taguette, Magnolia, QualCoder. Comunicação em **português**.
