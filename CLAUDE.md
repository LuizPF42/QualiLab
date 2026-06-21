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

2. **htm, não JSX.** Sintaxe: `` html`<div class="x">${valor}</div>` ``. Componentes: `` html`<${Componente} prop=${v} />` ``. Listas com `key=${...}`. Não existe `className`; é `class`.

3. **Reaproveite as classes CSS existentes** (definidas no `<style>` do `<head>`) em vez de reinventar inline. Copiar o visual de um componente que já funciona (ex.: `TreeNode` → `VizCodeNode`) é mais seguro do que estilizar do zero.

4. **Mudou o banco? Entregue o SQL ao usuário e atualize `supabase/schema.sql`.** Eu não rodo SQL no Supabase dele. Forneço o bloco para colar no **SQL Editor → Run**. Tudo idempotente (`if not exists`, `create or replace`, `drop policy if exists`). **Trocar a assinatura de retorno** de uma função exige `drop function if exists ...()` antes do `create`. A fonte da verdade é [`supabase/schema.sql`](supabase/schema.sql) — mantenha-o completo; atualize o `README.md` se a doc de usuário também mudar.

5. **Não quebre o modo local.** Toda funcionalidade de store tem implementação em `LocalStore` **e** `SupabaseStore`. Métodos novos precisam de stub no LocalStore.

---

## Arquitetura

### Stores (padrão de abstração)
Três implementações do mesmo "interface":

- **`LocalStore()`** — `localStorage` (`lastro:local`). Fallback sem credenciais e sem suporte a File System Access API. Limite 5MB.
- **`createFileStore(fileHandle, isNew)`** — **File System Access API**. Salva um `.qualilab` (JSON) visível no disco. Zero rede, funciona offline/air-gapped. Só Chrome/Edge. O `fileHandle` é persistido no IndexedDB (`IDB.saveHandle`) para reabrir na próxima sessão.
- **`SupabaseStore(sb)`** — Postgres via supabase-js, com RLS. Tem fila de escrita (`withQueue`) via IndexedDB para tolerar falhas de rede; `store.onPendingChange(cb)` notifica o App do contador de pendências; `store.flush()` é chamado ao reconectar (`window.online`).

**Batching (LocalStore e FileStore):** `store.beginBatch()` / `store.endBatch()` suprimem o `save()` por item e gravam **uma vez** no fim. Essencial em importação grande (`.qdpx`): sem isso, cada um dos centenas de inserts re-serializa o banco inteiro no disco/localStorage e a aba trava por segundos. `importQDPX` envolve toda a persistência em `beginBatch()`…`finally{ endBatch() }`. SupabaseStore não tem (inserts são chamadas de rede); o `importQDPX` guarda com `if(store.beginBatch)`.

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
realtime(pid,onChange)      // só SupabaseStore
```

### App
Um componente Preact grande com todo o estado. Fases: `boot | auth | gate | work`. A "tela" de trabalho é decidida por `mainView`: `codificar | reconciliar | visualizar | graficos | memos`.

### Mapa do arquivo (aproximado, mude com cuidado)
1. `<head>`: `showFatal` (tela de erro pré-JS, usa Georgia fixo), `:root` (variáveis de cor/fonte), classes CSS.
2. Loaders CDN: `getPdfjs/getMammoth/getJSZip/getCreateClient/getSqlJs`.
3. **CONFIG**: `SUPABASE_URL` / `SUPABASE_ANON_KEY` (ver abaixo).
4. `HUES` + `codeColor(hue,depth)` — paleta dos códigos.
5. Constantes de categoria: `CAT_KINDS`, `CAT_HAS_OPTIONS`, `CAT_MULTI_SEP`, `NAO_INFO`, `OUTROS`, `isSpecialOpt`.
6. `extractText`, `buildRuns`, helpers (`hslToHex`, `xmlEsc`, `csv*`, `download`…).
7. QDPX: `buildCodeXml`, `exportQDPX`, `importQDPX`.
8. `LocalStore`, `SupabaseStore`.
9. `App` (inclui `saveQualilab()` — baixa o `.qualilab` com tudo, inclusive memos).
10. Componentes: `Auth`, `Gate`, `AccountModal`, `ProjectModal`, `CategoriesPanel`, `CategoryEditor`, `CategoryValue`, `Reconcile`, `VizNav`/`VizCodeNode`/`VizExcerpts` (Visualização), `ChartsPanel`+`barRows`, `CodesPanel`/`TreeNode`/`RenameCode`, `MemoNav`/`MemoEditor` (Memos), `DebInput`, `DateInput`/`parseDate`, `AddPaste`.

---

## Modelo de dados — camadas e papéis (conceito central)

**Camada (`layer`)** existe em `codings` e em `doc_values`:
- `individual` — trabalho de cada pesquisador (gravado com o `created_by`/`set_by` dele).
- `final` — camada consolidada ("gabarito"). Em codings vem da Reconciliação; em doc_values só o admin escreve.

`doc_values` tem unicidade **`(document_id, category_id, set_by, layer)`** — ou seja, um valor por pesquisador por categoria, mais o gabarito.

**Tipo de projeto (`projects.mode`)**:
- `collective` — camadas individuais + tela de Reconciliação + filtro "Ver:".
- `individual` — `applyCode` e `setValue` escrevem direto em `layer='final'`; Reconciliação e "Ver:" ficam ocultos. Converter collective→individual é **destrutivo** (RPC `set_project_mode` colapsa codings num único autor e mantém só o gabarito das categorias).
  - **Gotcha (já corrigido):** como o seletor "Ver:" fica oculto aqui, `visibleCodings` **mostra todas as codificações** quando `projectMode==='individual'` (`return codings`), em vez de filtrar por camada. Sem isso, codings importados de `.qdpx` (que entram em `final`, mas podem estar em `individual` por histórico de modo) ficariam **invisíveis** no leitor. `buildRuns` deduplica por posição.

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
- **Fontes** (Google Fonts via `@import`): `--sans` **Inter** (interface), `--serif` **Newsreader** (leitura de documentos/trechos), `--mono` **JetBrains Mono** (códigos/números).
- **Classes reutilizáveis**: `.card`, `.pill`, `.btn`/`.btn.sm`/`.btn.primary`/`.btn.ghost`, `.icon-btn`, `.opt`/`.opt.on`, `.field`/`.field-label`, `.banner.warn`/`.banner.err`, `.node`/`.node-row`/`.node-row.sel`/`.swatch`/`.caret`/`.count`/`.node-name`, `.reader`, `.modal-bg`/`.modal`, `.meta`, `.author`, `.tree`, `.pane`/`.pane-head`/`.pane-body`, `.split`.

---

## Telas (mainView)

- **codificar** — leitor `.reader` à esquerda (grifos via `buildRuns`; botão direito = menu de contexto p/ aplicar código), painéis `CategoriesPanel` + `CodesPanel` à direita. Filtro "Ver:" (camada/codificador) só em collective+nuvem.
- **reconciliar** — `Reconcile`: categorias (gabarito + ✓/✗ por pesquisador, admin define) e códigos (grupos sobrepostos → consolidar na camada final). Só em collective.
- **visualizar** — master-detail: `VizNav` (camada + categorias colapsáveis + árvore de códigos) | `VizExcerpts` (trechos do código em `.card` com `.reader`, agrupados por documento, co-ocorrência opcional).
- **graficos** — `ChartsPanel`: frequência de códigos, distribuição por categoria, heatmap código×categoria, produção/concordância por codificador. Barras em HTML/CSS (`barRows`) + tabela; **sem libs**.
- **memos** — master-detail: `MemoNav` (projeto/documento/código) | `MemoEditor` (nota única por alvo, autosave, compartilhada entre membros).
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

A **pílula do projeto** no cabeçalho abre o `ProjectModal` (hub: convite/código de acesso, tipo, membros, renomear/limpar/excluir, conexão). O **nome do usuário** abre `AccountModal` (nome, senha, gestão de todos os projetos). O botão **"salvar .qualilab"** no cabeçalho chama `saveQualilab()` (download do projeto inteiro em qualquer modo).

---

## QDPX (import/export) — limitações importantes

- O padrão REFI-QDA **não tem autor em `VariableValue`** → categorias por pesquisador **não** cabem no QDPX (só um valor por atributo por caso). Codificações de trecho **têm** `creatingUser`, então multi-coder funciona para trechos.
- **Import remapeia todos os ids** para uuids novos (evita colisão de PK ao reimportar) e grava codings com **`created_by: null`** para que o agrupamento por codificador use `author_name` (e não o uuid de quem importou).
- **Export** prefere a camada `final` (gabarito) quando existe; senão usa as individuais.
- **Tipo de categoria (interoperabilidade)**: o próprio `exportQDPX` grava `tipo: <kind> | valores: <opções>` na `Description` da `Variable` — uma convenção nossa, não do padrão REFI-QDA. Um `.qdpx` **estrangeiro** (QualCoder, ATLAS.ti etc.) não tem isso, então `importQDPX` cai numa **heurística de cardinalidade**: olha os valores observados nos `Cases` e, se houver entre 2 e 8 valores distintos **com repetição** (`distinct < total`, ou seja, pelo menos uma resposta usada em mais de um documento), importa como Texto Fechado (`select`) com essas opções; senão, Texto Aberto. O resumo do import informa quantas categorias foram detectadas assim (revisar manualmente se necessário).
- **`importQDPX` continua com 1 valor por documento+categoria** (essa é a limitação real do formato REFI-QDA, não dá pra contornar). Já **`importQualilab` preserva múltiplos pesquisadores por categoria** em destino coletivo: usa o `store.addDocValue(pid,v)` (set_by:null + author_name livre, mesmo padrão de `addCoding`/`created_by:null`) para gravar cada resposta `layer='individual'` do arquivo de origem como uma linha própria, em vez de descartar todas menos uma. O gabarito (`layer='final'`) continua único por documento+categoria, escrito por último via `setFinalValue`. Em destino **individual** (sem multi-coder possível), mantém o comportamento antigo: prefere o gabarito de origem, senão a 1ª resposta encontrada. **RLS**: existe uma policy `doc_values_imported` (`supabase/schema.sql`) liberando `set_by is null and layer='individual'` pra qualquer membro — sem ela o insert falha com "new row violates row-level security policy".

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

---

## Preferências do autor

Luiz Pimenta Filho (LabDados / FGV Direito SP). Projeto pessoal, sem responsabilidade institucional. Licença **MIT**. Inspirações creditadas no README: Taguette, Magnolia, QualCoder. Comunicação em **português**.
