# Política de segurança

O QualiLab lida com material de pesquisa que costuma ser sensível: entrevistas, processos, prontuários, documentos sob sigilo. Esta política diz **como relatar** um problema de segurança, **o que está no escopo**, e — igualmente importante — **o que o software deliberadamente não protege**, para que ninguém confie em uma garantia que não existe.

> ⚠️ **Não houve auditoria de segurança independente.** O QualiLab é um projeto pessoal, mantido por uma pessoa, distribuído sob licença MIT **sem qualquer garantia**. As verificações descritas aqui são as que o próprio projeto executa; elas não substituem uma auditoria.

---

## Como relatar

**Use o canal privado do GitHub:** aba **Security** do repositório → **Report a vulnerability**. O relato fica visível apenas para você e para o mantenedor, e permite discutir a correção antes de qualquer divulgação.

**Por favor, não abra uma *issue* pública** para relatar vulnerabilidade. *Issue* é o canal certo para bug comum; para falha de segurança ela expõe o problema a todos antes que exista correção.

Um bom relato traz: o que acontece, como reproduzir (passo a passo, ou um projeto de exemplo com dado sintético), qual o impacto na prática, e a versão do QualiLab (canto direito do cabeçalho, ou rodapé da tela de entrada).

**Não envie dado de pesquisa real para demonstrar uma falha.** Reproduza com material sintético. Se a falha só aparecer com um arquivo específico, descreva a característica dele em vez de anexá-lo.

## O que esperar

Mantenedor único, sem financiamento e sem equipe de plantão: não há SLA. O compromisso é de melhor esforço, e explícito quanto ao que se pode esperar:

- **Confirmação de recebimento**: em até 7 dias.
- **Avaliação inicial** (é vulnerabilidade? qual o alcance?): em até 30 dias.
- **Correção**: sem prazo garantido. Quando a falha expuser dado de pesquisa, ela entra à frente de qualquer outro trabalho.
- **Crédito**: quem relatar é creditado no `CHANGELOG.md`, salvo pedido em contrário.

Se o relato não tiver resposta em 30 dias, entenda como falha do canal e não como desinteresse: reabra pelo mesmo caminho.

## Versões cobertas

Só a **versão publicada mais recente**. O QualiLab é um único arquivo HTML servido pelo GitHub Pages: não há linha de manutenção paralela nem *backport*. Quem usa uma cópia baixada corrige recarregando a versão atual.

---

## Escopo

### Está no escopo

- **Execução de conteúdo de terceiros** (XSS e afins) a partir de material importado. O app renderiza documentos, memos, nomes de código e relatórios vindos de arquivos que o pesquisador recebeu de outras pessoas (`.qdpx`, `.qualilab`, `.qdc`, planilha, Zotero RDF, `.docx`, `.pdf`).
- **Falha de isolamento entre projetos ou entre membros** no modo nuvem: qualquer caminho que devolva a um usuário dado de projeto do qual ele não participa, ou que fure os papéis de administrador e membro. A autoridade é o servidor (RLS do Postgres), não a interface.
- **Falha da distribuição de documentos ou da codificação cega**: material ou codificação alheia chegando a quem o estudo determinou que não deve vê-los.
- **Falha da máscara de censura nas superfícies que prometem mascarar**: o prompt enviado à IA, o Relatório Interativo (ATI), a exportação W3C e as ferramentas de leitura por agente. Texto marcado como censura chegando íntegro a qualquer uma delas é vulnerabilidade, não bug cosmético.
- **Vazamento da chave de IA do pesquisador** (BYOK), que fica no navegador dele e não deve sair para lugar nenhum além do provedor que ele escolheu.
- **Arquivo malformado ou hostil** que trave o navegador, corrompa o projeto aberto ou escape do processamento pretendido.
- **Qualquer coisa que grave, apague ou altere dado sem ação do pesquisador.**

### Não está no escopo (é assim por decisão, e está documentado)

- **O QualiLab não anonimiza.** Ele não detecta nome, CPF, dado de saúde ou qualquer informação sensível. A censura mascara **apenas** os trechos que o pesquisador marcou à mão. Material não marcado que apareça em qualquer saída não é falha do software.
- **Formatos de trabalho saem com o texto cru.** `.qualilab`, QDPX, QDC, CSV e JSON exportam o conteúdo sem máscara, de propósito: são formatos de ida e volta, e mascará-los destruiria dado de forma irreversível. Mascarar é o comportamento das saídas de *transparência* (ATI, W3C) e do prompt da IA.
- **A chave anônima do Supabase é pública por desenho.** Ela vai no arquivo servido, como manda o modelo do Supabase; quem protege os dados é a RLS. Encontrá-la no código não é achado.
- **Dados enviados ao provedor de IA que o próprio pesquisador configurou.** Em BYOK o navegador chama o provedor direto e o material passa a estar sujeito à política dele. Isso é o modo de funcionamento, anunciado na interface e no README.
- **Limites do provedor de nuvem** (cota, disponibilidade, retenção do Supabase) e vulnerabilidades das bibliotecas de terceiros: relate-as ao projeto de origem. Se houver caminho de exploração **através** do QualiLab, aí sim é relato para cá.
- **Ataque que exige acesso físico à máquina, ou o navegador do pesquisador já comprometido.** O app roda no navegador dele; nesse cenário não há o que defender.
- Falta de cabeçalho de segurança no GitHub Pages, ausência de rate limit em recurso público, e relatos gerados por varredura automática sem impacto demonstrado.

---

## O que o projeto verifica hoje

Não é auditoria, e é melhor do que nada:

- **Regras de acesso do banco testadas como contrato** — as políticas de RLS, os papéis, a distribuição de documentos e a codificação cega são exercitados por testes pgTAP versionados em [`supabase/tests/database/`](supabase/tests/database/), incluindo o caso em que a nota analítica de um trecho alheio não pode ser servida sob codificação cega.
- **Censura coberta por testes de propriedade e de âncora**, e falhando para o lado seguro: quando a âncora de um trecho não confere com o documento, a saída mascara o documento inteiro em vez de arriscar mascarar o lugar errado.
- **Dependências de CDN fixadas por hash** (Subresource Integrity, via import map), com verificação automatizada. Duas ressalvas honestas: o hash cobre o módulo de topo, e o *worker* do PDF e o WebAssembly do SQLite não são alcançados por esse mecanismo.
- **Integração contínua** a cada mudança: verificação de sintaxe, testes de unidade e suítes que dirigem a interface real em navegador.

## Divulgação

Falha corrigida é anunciada no [`CHANGELOG.md`](CHANGELOG.md), em linguagem de usuário, dizendo o que estava exposto e o que fazer. Quando o impacto for sobre dados de pesquisa já produzidos, o aviso diz isso com todas as letras, mesmo que seja constrangedor.
