# -*- coding: utf-8 -*-
"""
Gerador do exemplo de demonstracao QualiLab_synthetic_realistic_legal_ai_3.qualilab

Melhora o _2:
- Nomes VISIVELMENTE artificiais (nomes-fantasia obvios: Fulana de Tal, Beltrano, Sicrano,
  Joana das Couves, Ze Ninguem, ... ; escritorios "Tal, Qual & Associados" e "Banca Exemplo").
- ENT-01 (doc-1) recebe TODOS os codigos (mostra na primeira tela o que a ferramenta faz).
- Codigos e categorias bem mais populados -> visualizacoes ricas (frequencia, co-ocorrencia,
  cobertura, nuvem, tempo, codificadores), gabarito (camada final) robusto, memos de trecho.

Offsets dos codings sao SEMPRE computados (content.index), nunca digitados a mao.
Roda com o python real: py examples/gen_example_3.py
"""
import json, sys, io

# ---------------------------------------------------------------- documentos
DOCS = {}

DOCS["doc-1"] = ("ENT-01 — Dra. Fulana de Tal, sócia fundadora (Tal, Qual & Associados, São Paulo)",
"""ENT-01 — Dra. Fulana de Tal, sócia fundadora (Tal, Qual & Associados, São Paulo)

Entrevistadora: Para começar, como a senhora descreveria a chegada da IA generativa aqui no escritório?

Fulana de Tal: Vou ser honesta: eu resisti no começo. Hoje eu diria que já me rendi, mas cercada de regra por todo lado. A verdade é que a gente não tinha escolha. Foi a pressão do mercado que abriu a porta, não foi convicção minha: os próprios clientes começaram a perguntar se usávamos inteligência artificial e por que ainda cobrávamos tantas horas por uma pesquisa que a máquina faz em minutos.

Entrevistadora: E quais ganhos a senhora enxerga no dia a dia?

Fulana de Tal: Produtividade, sem dúvida. O que mudou a vida da equipe foi a velocidade. Uma pesquisa de jurisprudência que levava uma tarde inteira hoje sai num café. E as tarefas repetitivas — formatar contrato, revisar cláusula padrão, montar minuta de petição simples — isso a ferramenta despacha sozinha. Sobra tempo para o que é realmente advocacia.

Entrevistadora: A senhora mesma usa?

Fulana de Tal: Uso, mas quase escondido, como experimento pessoal. Eu testo em casa, no meu computador, antes de liberar para a equipe. Ninguém me ensinou — fui aprendendo no tatear.

Entrevistadora: E os riscos?

Fulana de Tal: Aí mora o meu medo. Eu já vi um colega citar uma jurisprudência que simplesmente não existia: a máquina inventou o acórdão, com número e tudo. Isso me apavora. Mais grave ainda é a confidencialidade: eu jamais jogaria os dados de um caso de M&A do meu cliente numa ferramenta dessas, não sei onde isso vai parar. E tem a questão de quem responde se der errado: o advogado assina a peça, a responsabilidade é dele, não da máquina.

Entrevistadora: Há resistência interna?

Fulana de Tal: Há, e ela tem idade. Os sócios mais seniores torcem o nariz — alguns acham que é moda passageira, outros se sentem ameaçados. É uma divisão geracional clara: os associados júnior já chegam usando, os sócios de cabelo branco desconfiam. Eu fico no meio.

Entrevistadora: O escritório tem alguma regra formal?

Fulana de Tal: Tem. Criamos uma política interna de uso no ano passado. Está tudo escrito: o que pode, o que não pode, e que nenhum dado de cliente entra na ferramenta sem anonimizar. Foi a forma que encontramos de dormir tranquila.

Entrevistadora: E o impacto no negócio em si?

Fulana de Tal: Esse é o elefante na sala. Se a pesquisa que eu cobrava seis horas agora leva trinta minutos, como eu cobro? O modelo de honorário por hora está com os dias contados, isso é fato. E me preocupa o futuro dos mais novos: se a máquina faz o trabalho do estagiário, para que serve o estagiário? Vamos ter que reinventar como se forma advogado.

Entrevistadora: Para fechar, uma frase que resuma seu sentimento?

Fulana de Tal: Não dá para colocar o gênio de volta na lâmpada — mas dá para ensinar o gênio a respeitar o sigilo. É isso.
""")

DOCS["doc-2"] = ("ENT-02 — Beltrano de Souza, associado júnior (Tal, Qual & Associados, São Paulo)",
"""ENT-02 — Beltrano de Souza, associado júnior (Tal, Qual & Associados, São Paulo)

Entrevistadora: Você usa IA generativa no trabalho?

Beltrano de Souza: Uso o tempo todo, é quase um corretor ortográfico para mim. Aprendi na faculdade, então para a minha geração isso é natural. Os sócios é que estranham — tem aquela divisão clara: a gente, mais novo, já chegou usando; eles ainda desconfiam.

Entrevistadora: Em que tarefas?

Beltrano de Souza: Principalmente pesquisa. Antes eu passava a madrugada caçando precedente; agora a busca de jurisprudência sai em minutos. Também uso para automatizar coisa repetitiva, tipo padronizar contrato e revisar cláusula. É um ganho de produtividade absurdo.

Entrevistadora: E treinamento, o escritório ofereceu?

Beltrano de Souza: Nenhum. Ninguém me ensinou, eu fui na tentativa e erro. Acho isso arriscado, porque mesmo gostando eu não me sinto totalmente seguro. Já vi a ferramenta inventar um acórdão que não existia — se eu não conferisse, ia parar na petição.

Entrevistadora: Preocupa o futuro da carreira?

Beltrano de Souza: Preocupa. Se a máquina faz o trabalho braçal do júnior, sobra o quê para quem está começando? E o modelo de cobrar por hora não se sustenta mais. Acho que vão contratar menos estagiário por causa disso.
""")

DOCS["doc-3"] = ("ENT-03 — Dr. Sicrano Modelo, sócio (Banca Exemplo Advogados, Rio de Janeiro)",
"""ENT-03 — Dr. Sicrano Modelo, sócio (Banca Exemplo Advogados, Rio de Janeiro)

Entrevistadora: Qual a sua posição sobre IA generativa na advocacia?

Sicrano Modelo: Sou cético, e não tenho vergonha de dizer. Vejo muito modismo. O sócio que assina a peça é o responsável, ponto — não vou terceirizar isso para um robô que inventa jurisprudência. Já me mostraram um caso de acórdão fabricado pela máquina; aquilo me bastou.

Entrevistadora: E a confidencialidade?

Sicrano Modelo: Esse é o ponto que ninguém leva a sério o suficiente. Os dados dos nossos clientes são sagrados. Colocar informação de um cliente numa ferramenta na nuvem é, para mim, quebra de sigilo. Enquanto não houver garantia, eu proíbo na minha equipe.

Entrevistadora: O senhor percebe pressão para mudar?

Sicrano Modelo: Percebo, e ela vem dos clientes, que comparam preço e velocidade com escritórios que já usam. Mas resisto. Sei que sou parte da turma mais antiga que segura o freio. Os jovens daqui reclamam disso.

Entrevistadora: Há política interna?

Sicrano Modelo: Aqui na Banca Exemplo não há nada escrito, e acho isso um problema. Cada um faz como quer. Sem regra clara, é terra de ninguém.
""")

DOCS["doc-4"] = ("ENT-04 — Joana das Couves, estagiária (Banca Exemplo Advogados, Rio de Janeiro)",
"""ENT-04 — Joana das Couves, estagiária (Banca Exemplo Advogados, Rio de Janeiro)

Entrevistadora: Como estagiária, você usa essas ferramentas?

Joana das Couves: Uso, mas meio escondido, porque o Dr. Sicrano não gosta. É experimentação minha mesmo, em casa. Ajuda muito a resumir decisão longa e a achar precedente rápido.

Entrevistadora: Recebeu algum treinamento?

Joana das Couves: Que nada. Ninguém ensina. A gente aprende sozinha, trocando dica entre os estagiários. Por isso fico insegura: já vi a ferramenta errar e ter uma confiança enorme no erro.

Entrevistadora: Você teme pela sua vaga?

Joana das Couves: Bastante. Se a máquina faz a pesquisa que era a minha função, fico pensando se vão precisar de estagiário daqui a pouco. É assustador começar a carreira assim.
""")

DOCS["doc-5"] = ("ENT-05 — Dra. Maria Exemplo, sócia (Tal, Qual & Associados, filial Brasília)",
"""ENT-05 — Dra. Maria Exemplo, sócia (Tal, Qual & Associados, filial Brasília)

Entrevistadora: A senhora é favorável ao uso?

Maria Exemplo: Favorável, com método. Não adianta proibir nem liberar geral. Aqui na filial de Brasília eu puxei a fila do treinamento: montei oficinas para a equipe aprender a usar com responsabilidade.

Entrevistadora: O que mudou com isso?

Maria Exemplo: A produtividade subiu, claro — a redação de peças e a revisão contratual ficaram muito mais rápidas. Mas o ganho de verdade foi cultural: as pessoas pararam de usar escondido e passaram a discutir abertamente o que a ferramenta erra.

Entrevistadora: E a política institucional?

Maria Exemplo: Foi essencial. A política interna que adotamos deixou claro que nenhum dado de cliente entra sem anonimização. Isso resolveu metade do medo de confidencialidade. A responsabilidade final continua do advogado, e a política reforça isso.

Entrevistadora: Há resistência?

Maria Exemplo: Alguma, dos sócios mais antigos, mas vai cedendo conforme veem resultado. A divisão de gerações existe, mas treinamento aproxima.
""")

DOCS["doc-6"] = ("ENT-06 — Zé Ninguém, associado sênior (Banca Exemplo Advogados, Rio de Janeiro)",
"""ENT-06 — Zé Ninguém, associado sênior (Banca Exemplo Advogados, Rio de Janeiro)

Entrevistadora: Qual sua visão?

Zé Ninguém: Ambivalente, sinceramente. Reconheço o ganho de produtividade — automatizar a parte repetitiva de contrato me devolveu horas da semana. Mas convivo com o receio do erro.

Entrevistadora: Que tipo de erro?

Zé Ninguém: A alucinação. A ferramenta afirma com toda a certeza uma coisa falsa. Em pesquisa de jurisprudência isso é veneno. Então uso, mas confiro tudo, o que às vezes anula o ganho de tempo.

Entrevistadora: E a pressão do mercado?

Zé Ninguém: Existe. Cliente hoje pergunta por que a conta é tão alta se a IA faz. A cobrança por hora está mesmo ameaçada. Como sênior, eu fico entre o sócio que resiste e o júnior que abraça.

Entrevistadora: O escritório treina?

Zé Ninguém: Pouco. Falta política e falta capacitação. Acabo sendo autodidata.
""")

DOCS["doc-7"] = ("ENT-07 — Dr. João da Silva Fictício, sócio de gestão e inovação (Tal, Qual & Associados, São Paulo)",
"""ENT-07 — Dr. João da Silva Fictício, sócio de gestão e inovação (Tal, Qual & Associados, São Paulo)

Entrevistadora: O senhor lidera a inovação no escritório. Como conduz isso?

João da Silva Fictício: Com governança. Fui eu que escrevi a política interna de uso de IA. A regra de ouro é simples: produtividade sim, sigilo do cliente sempre. Nenhum dado identificável entra na ferramenta.

Entrevistadora: Quais ganhos o senhor mede?

João da Silva Fictício: Medimos tempo. A pesquisa jurídica que tomava um dia caiu para uma hora. A automação de minutas repetitivas liberou os associados para trabalho estratégico. É produtividade pura.

Entrevistadora: E o modelo de negócio?

João da Silva Fictício: Aí está a revolução de verdade. A cobrança por hora não sobrevive a isso — estamos migrando para honorário por valor entregue. E repensando a formação: o estagiário não vai mais aprender copiando precedente, vai ter que pensar desde cedo. Isso muda a pirâmide do escritório.

Entrevistadora: Resistência?

João da Silva Fictício: Muita, dos sócios da velha guarda. É uma divisão geracional clássica. Por isso aposto em treinamento contínuo: oficina, manual, gente acompanhando. Sem capacitação, a política vira letra morta.

Entrevistadora: Uma frase de fecho?

João da Silva Fictício: Escritório que não governar a IA vai ser governado por ela.
""")

DOCS["doc-8"] = ("GF-01 — Grupo focal com associados de diferentes escritórios (São Paulo)",
"""GF-01 — Grupo focal com associados de diferentes escritórios (São Paulo)

Moderadora: Vamos abrir: a IA generativa ajuda ou atrapalha?

Participante 1: Ajuda demais na produtividade. A pesquisa jurídica virou questão de minutos.

Participante 2: Mas é perigosa. Já vi alucinação séria — acórdão inventado com número falso. Não dá para confiar cego.

Participante 3: O problema maior, para mim, é confidencialidade. A gente lida com dado sensível de cliente; jogar isso na nuvem é temerário.

Participante 1: Concordo, mas com política clara dá. No meu escritório a política interna resolveu muita coisa.

Participante 4: No meu não tem política nenhuma, é cada um por si. E ninguém treina ninguém.

Participante 2: E tem o racha de geração: sócio sênior trava, júnior abraça. Vira queda de braço.

Participante 3: Sem falar na cobrança. Se a máquina faz rápido, como justificar a hora? O modelo de negócio inteiro está em xeque.

Participante 4: E o estagiário? Estou com medo de não ter mais espaço para quem começa.
""")

DOCS["doc-9"] = ("DOC-01 — Política interna de uso de IA generativa (Tal, Qual & Associados)",
"""DOC-01 — Política interna de uso de IA generativa (Tal, Qual & Associados)

1. Objetivo. Esta política estabelece regras para o uso de ferramentas de IA generativa pelos profissionais de Tal, Qual & Associados, conciliando ganho de produtividade e proteção do cliente.

2. Confidencialidade. É vedado inserir em qualquer ferramenta dado que identifique cliente, parte ou caso sem anonimização prévia. O sigilo profissional é inegociável.

3. Responsabilidade. A revisão e a assinatura de toda peça permanecem do advogado responsável. A ferramenta é apoio, nunca autor.

4. Verificação. Toda informação jurídica gerada — especialmente jurisprudência e citações — deve ser conferida na fonte oficial, dado o risco de alucinação.

5. Capacitação. O escritório oferecerá treinamento periódico obrigatório sobre uso responsável.

6. Usos permitidos. Pesquisa jurídica, automação de minutas repetitivas, revisão contratual e resumo de decisões, observadas as regras acima.

Aprovada pela sócia fundadora Dra. Fulana de Tal e pelo sócio de gestão Dr. João da Silva Fictício, São Paulo.
""")

# ---------------------------------------------------------------- codigos
# (id, parent, depth, name, hue_idx, hue_deg, is_redaction)
CODES = [
    ("code-a0",  None,      0, "Adoção e motivação",              0, 210, False),
    ("code-a1",  "code-a0", 1, "Ganhos de produtividade",          0, 210, False),
    ("code-a1a", "code-a1", 2, "Aceleração de pesquisa jurídica", 0, 210, False),
    ("code-a1b", "code-a1", 2, "Automação de tarefas repetitivas", 0, 210, False),
    ("code-a2",  "code-a0", 1, "Pressão competitiva do mercado",   0, 210, False),
    ("code-a3",  "code-a0", 1, "Experimentação individual",        0, 210, False),
    ("code-b0",  None,      0, "Riscos e resistência",              1, 350, False),
    ("code-b1",  "code-b0", 1, "Medo de alucinação/erro",          1, 350, False),
    ("code-b2",  "code-b0", 1, "Resistência de sócios seniores",   1, 350, False),
    ("code-b3",  "code-b0", 1, "Confidencialidade do cliente",     1, 350, False),
    ("code-b4",  "code-b0", 1, "Responsabilidade profissional",    1, 350, False),
    ("code-c0",  None,      0, "Mudança cultural e governança",    2, 140, False),
    ("code-c1",  "code-c0", 1, "Divisão geracional",                2, 140, False),
    ("code-c2",  "code-c0", 1, "Treinamento e capacitação",        2, 140, False),
    ("code-c3",  "code-c0", 1, "Política institucional de uso",     2, 140, False),
    ("code-f0",  None,      0, "Impacto no modelo de negócio",      3,  40, False),
    ("code-f1",  "code-f0", 1, "Cobrança por hora ameaçada",        3,  40, False),
    ("code-f2",  "code-f0", 1, "Futuro de júnior e estagiário",     3,  40, False),
    ("code-d0",  None,      0, "Citação emblemática",              4, 275, False),
    ("code-e0",  None,      0, "Censura",                          5,  -2, True),
    ("code-e1",  "code-e0", 1, "Nomes",                            5,  -2, True),
    ("code-e2",  "code-e0", 1, "Localização/empresa",              5,  -2, True),
]

# ---------------------------------------------------------------- categorias
CATEGORIES = [
    ("cat-tipo",       "Tipo de documento", "select",
        ["Entrevista","Grupo focal","Documento institucional","Não informado"],
        "Distingue a natureza da fonte (kind=select).", 0),
    ("cat-cargo",      "Cargo/função", "select",
        ["Sócio(a)","Associado(a) sênior","Associado(a) júnior","Estagiário(a)","Não se aplica","Não informado"],
        "Posição hierárquica do entrevistado (kind=select).", 1),
    ("cat-escritorio", "Escritório", "select",
        ["Tal, Qual & Associados","Banca Exemplo Advogados","Misto / vários","Não informado"],
        "Organização de origem (kind=select).", 2),
    ("cat-data",       "Data de coleta", "date", [],
        "Data da entrevista/coleta (kind=date, DD/MM/AAAA).", 3),
    ("cat-posicao",    "Posição sobre uso de IA", "single",
        ["Favorável","Cético","Ambivalente","Outros","Não informado"],
        "Atitude predominante (kind=single, com Outros).", 4),
    ("cat-areas",      "Áreas de aplicação citadas", "checkbox",
        ["Pesquisa jurídica","Redação de peças","Revisão contratual","Resumo de decisões","Organização/gestão","Atendimento ao cliente","Outros","Não informado"],
        "Usos mencionados (kind=checkbox, multi-valor).", 5),
    ("cat-resumo",     "Resumo analítico", "text", [],
        "Síntese livre do conteúdo (kind=text).", 6),
]

# ---------------------------------------------------------------- doc_values
# por doc: {cat: valor_final}; e disagreements individuais opcionais.
FINAL_VALS = {
 "doc-1": {"cat-tipo":"Entrevista","cat-cargo":"Sócio(a)","cat-escritorio":"Tal, Qual & Associados",
           "cat-data":"12/02/2026","cat-posicao":"Ambivalente",
           "cat-areas":"Pesquisa jurídica | Redação de peças | Revisão contratual",
           "cat-resumo":"Sócia fundadora que resistiu e hoje adota com cautela. Reconhece produtividade, mas seu freio real é a confidencialidade de clientes de M&A. Defende política interna e teme o fim da cobrança por hora."},
 "doc-2": {"cat-tipo":"Entrevista","cat-cargo":"Associado(a) júnior","cat-escritorio":"Tal, Qual & Associados",
           "cat-data":"14/02/2026","cat-posicao":"Favorável",
           "cat-areas":"Pesquisa jurídica | Revisão contratual",
           "cat-resumo":"Associado júnior entusiasta, usa como rotina; aprendeu sozinho. Aponta falta de treinamento, medo de alucinação e insegurança sobre o futuro do júnior."},
 "doc-3": {"cat-tipo":"Entrevista","cat-cargo":"Sócio(a)","cat-escritorio":"Banca Exemplo Advogados",
           "cat-data":"18/02/2026","cat-posicao":"Cético",
           "cat-areas":"Pesquisa jurídica",
           "cat-resumo":"Sócio cético que proíbe o uso por confidencialidade e responsabilidade. Assume ser parte da resistência sênior; critica a ausência de política na Banca Exemplo."},
 "doc-4": {"cat-tipo":"Entrevista","cat-cargo":"Estagiário(a)","cat-escritorio":"Banca Exemplo Advogados",
           "cat-data":"20/02/2026","cat-posicao":"Ambivalente",
           "cat-areas":"Pesquisa jurídica | Resumo de decisões",
           "cat-resumo":"Estagiária que usa escondido do sócio. Sem treinamento, insegura com o erro da ferramenta e com medo concreto de perder espaço na carreira."},
 "doc-5": {"cat-tipo":"Entrevista","cat-cargo":"Sócio(a)","cat-escritorio":"Tal, Qual & Associados",
           "cat-data":"25/02/2026","cat-posicao":"Favorável",
           "cat-areas":"Redação de peças | Revisão contratual | Organização/gestão",
           "cat-resumo":"Sócia favorável com método: lidera treinamento na filial. Mostra como política e capacitação reduzem o medo de confidencialidade e aproximam as gerações."},
 "doc-6": {"cat-tipo":"Entrevista","cat-cargo":"Associado(a) sênior","cat-escritorio":"Banca Exemplo Advogados",
           "cat-data":"28/02/2026","cat-posicao":"Ambivalente",
           "cat-areas":"Pesquisa jurídica | Revisão contratual",
           "cat-resumo":"Associado sênior dividido: usa pela produtividade, mas confere tudo por medo de alucinação. Sente a pressão de preço do cliente e a falta de política e capacitação."},
 "doc-7": {"cat-tipo":"Entrevista","cat-cargo":"Sócio(a)","cat-escritorio":"Tal, Qual & Associados",
           "cat-data":"03/03/2026","cat-posicao":"Favorável",
           "cat-areas":"Pesquisa jurídica | Redação de peças | Organização/gestão",
           "cat-resumo":"Sócio de inovação que governa o uso por política. Vê a maior ruptura no modelo de negócio (fim da hora) e na formação do júnior; aposta em treinamento contínuo."},
 "doc-8": {"cat-tipo":"Grupo focal","cat-cargo":"Não se aplica","cat-escritorio":"Misto / vários",
           "cat-data":"06/03/2026","cat-posicao":"Outros",
           "cat-areas":"Pesquisa jurídica | Atendimento ao cliente",
           "cat-resumo":"Grupo focal que sintetiza os eixos: produtividade x alucinação, confidencialidade, racha geracional, ausência de política/treinamento e ameaça ao modelo de negócio."},
 "doc-9": {"cat-tipo":"Documento institucional","cat-cargo":"Não se aplica","cat-escritorio":"Tal, Qual & Associados",
           "cat-data":"10/03/2026","cat-posicao":"Não informado",
           "cat-areas":"Pesquisa jurídica | Redação de peças | Revisão contratual | Resumo de decisões",
           "cat-resumo":"Política interna que opera os achados: confidencialidade com anonimização, responsabilidade do advogado, verificação contra alucinação, capacitação e usos permitidos."},
}

# disagreements individuais (camada individual por pesquisador): doc -> cat -> {coder: valor}
INDIV_VALS = {
 "doc-1": {"cat-posicao": {"Marina":"Cético","Rafael":"Ambivalente","Júlia":"Ambivalente"},
           "cat-areas":   {"Marina":"Pesquisa jurídica | Revisão contratual",
                           "Rafael":"Pesquisa jurídica | Redação de peças | Revisão contratual",
                           "Júlia":"Pesquisa jurídica | Redação de peças | Revisão contratual"}},
 "doc-2": {"cat-posicao": {"Marina":"Favorável","Rafael":"Favorável"}},
 "doc-3": {"cat-posicao": {"Marina":"Cético","Júlia":"Cético"}},
 "doc-4": {"cat-posicao": {"Rafael":"Ambivalente","Júlia":"Favorável"}},
 "doc-6": {"cat-posicao": {"Rafael":"Ambivalente","Júlia":"Cético"}},
 "doc-8": {"cat-posicao": {"Rafael":"Outros","Júlia":"Ambivalente"}},
}

# ---------------------------------------------------------------- codings tematicos
# (doc, code, quote, coders=[..], in_final=bool)  -- offsets computados depois.
# coders = pesquisadores que aplicaram (camada individual). in_final => entra no gabarito.
T = []
def t(doc, code, quote, coders, final=True):
    T.append((doc, code, quote, coders, final))

# ENV: codings "envelope" (span largo via ancoras inicio..fim) que ENGLOBAM trechos menores
# -> geram sobreposicao (co-ocorrencia) pai x filhos e entre familias. start=index(a), end=index(b)+len(b).
ENV = []
def env(doc, code, a, b, coders, final=True):
    ENV.append((doc, code, a, b, coders, final))

# ---- doc-1 : TODOS OS CODIGOS (showcase). multi-coder + gabarito completo + sobreposicoes.
# Pais como ENVELOPES (englobam os filhos -> co-ocorrencia densa na 1a tela).
env("doc-1","code-a0","eu resisti no começo","faz em minutos.",["Marina","Rafael"])
env("doc-1","code-a1","Produtividade, sem dúvida.","despacha sozinha.",["Marina","Júlia"])
env("doc-1","code-b0","Aí mora o meu medo.","não da máquina.",["Marina"])
env("doc-1","code-c0","Há, e ela tem idade.","Eu fico no meio.",["Rafael"])
env("doc-1","code-f0","Esse é o elefante na sala.","se forma advogado.",["Júlia"])
# filhos (ficam DENTRO dos envelopes acima -> sobreposicao)
t("doc-1","code-a2","Foi a pressão do mercado que abriu a porta, não foi convicção minha",["Marina","Rafael","Júlia"])
t("doc-1","code-a1a","Uma pesquisa de jurisprudência que levava uma tarde inteira hoje sai num café",["Marina","Rafael","Júlia"])
t("doc-1","code-a1b","formatar contrato, revisar cláusula padrão, montar minuta de petição simples — isso a ferramenta despacha sozinha",["Marina","Júlia"])
t("doc-1","code-a3","Eu testo em casa, no meu computador, antes de liberar para a equipe",["Rafael","Júlia"])
t("doc-1","code-b1","a máquina inventou o acórdão, com número e tudo",["Marina","Rafael","Júlia"])
t("doc-1","code-b3","eu jamais jogaria os dados de um caso de M&A do meu cliente numa ferramenta dessas",["Marina","Rafael","Júlia"])
t("doc-1","code-b4","o advogado assina a peça, a responsabilidade é dele, não da máquina",["Marina","Rafael"])
t("doc-1","code-b2","Os sócios mais seniores torcem o nariz",["Marina","Júlia"])
t("doc-1","code-c1","os associados júnior já chegam usando, os sócios de cabelo branco desconfiam",["Marina","Rafael","Júlia"])
t("doc-1","code-c3","Criamos uma política interna de uso no ano passado",["Marina","Rafael","Júlia"])
t("doc-1","code-c2","Ninguém me ensinou — fui aprendendo no tatear",["Rafael","Júlia"])
t("doc-1","code-f1","O modelo de honorário por hora está com os dias contados",["Marina","Rafael","Júlia"])
t("doc-1","code-f2","se a máquina faz o trabalho do estagiário, para que serve o estagiário?",["Marina","Rafael","Júlia"])
t("doc-1","code-d0","Não dá para colocar o gênio de volta na lâmpada — mas dá para ensinar o gênio a respeitar o sigilo",["Marina","Júlia"])

# ---- doc-2
t("doc-2","code-a1","É um ganho de produtividade absurdo",["Marina","Rafael"])
t("doc-2","code-c1","a gente, mais novo, já chegou usando; eles ainda desconfiam",["Marina","Rafael"])
t("doc-2","code-a1a","agora a busca de jurisprudência sai em minutos",["Marina","Rafael"])
t("doc-2","code-a1b","automatizar coisa repetitiva, tipo padronizar contrato e revisar cláusula",["Marina"])
t("doc-2","code-c2","Ninguém me ensinou, eu fui na tentativa e erro",["Marina","Rafael"])
t("doc-2","code-b1","Já vi a ferramenta inventar um acórdão que não existia",["Marina","Rafael"])
t("doc-2","code-f1","o modelo de cobrar por hora não se sustenta mais",["Marina","Rafael"])
t("doc-2","code-f2","vão contratar menos estagiário por causa disso",["Marina","Rafael"])

# ---- doc-3
env("doc-3","code-b0","Sou cético","aquilo me bastou.",["Marina","Júlia"])  # engloba b2,b4,b1
t("doc-3","code-b2","Sou cético, e não tenho vergonha de dizer",["Marina","Júlia"])
t("doc-3","code-b4","O sócio que assina a peça é o responsável, ponto",["Marina","Júlia"])
t("doc-3","code-b1","um caso de acórdão fabricado pela máquina",["Marina","Júlia"])
t("doc-3","code-b3","Colocar informação de um cliente numa ferramenta na nuvem é, para mim, quebra de sigilo",["Marina","Júlia"])
t("doc-3","code-a2","ela vem dos clientes, que comparam preço e velocidade com escritórios que já usam",["Marina","Júlia"])
t("doc-3","code-c1","Os jovens daqui reclamam disso",["Marina"])
t("doc-3","code-c3","Aqui na Banca Exemplo não há nada escrito, e acho isso um problema",["Marina","Júlia"])

# ---- doc-4
t("doc-4","code-a3","É experimentação minha mesmo, em casa",["Rafael","Júlia"])
t("doc-4","code-a1a","Ajuda muito a resumir decisão longa e a achar precedente rápido",["Rafael","Júlia"])
t("doc-4","code-c2","Que nada. Ninguém ensina",["Rafael","Júlia"])
t("doc-4","code-b1","já vi a ferramenta errar e ter uma confiança enorme no erro",["Rafael"])
t("doc-4","code-f2","fico pensando se vão precisar de estagiário daqui a pouco",["Rafael","Júlia"])

# ---- doc-5
t("doc-5","code-c2","eu puxei a fila do treinamento: montei oficinas para a equipe aprender a usar com responsabilidade",["Marina","Júlia"])
t("doc-5","code-a1","A produtividade subiu, claro",["Marina","Júlia"])
t("doc-5","code-a1b","a redação de peças e a revisão contratual ficaram muito mais rápidas",["Marina"])
t("doc-5","code-c3","A política interna que adotamos deixou claro que nenhum dado de cliente entra sem anonimização",["Marina","Júlia"])
t("doc-5","code-b3","nenhum dado de cliente entra sem anonimização",["Marina","Júlia"])  # DENTRO do c3 -> co-oc c3xb3
t("doc-5","code-b3","Isso resolveu metade do medo de confidencialidade",["Júlia"])
t("doc-5","code-b4","A responsabilidade final continua do advogado",["Marina"])
t("doc-5","code-c1","A divisão de gerações existe, mas treinamento aproxima",["Marina","Júlia"])

# ---- doc-6
t("doc-6","code-a1","Reconheço o ganho de produtividade",["Rafael","Júlia"])
t("doc-6","code-a1b","automatizar a parte repetitiva de contrato me devolveu horas da semana",["Rafael"])
env("doc-6","code-b1","A alucinação.","isso é veneno.",["Rafael","Júlia"])  # engloba a pesquisa abaixo
t("doc-6","code-a1a","Em pesquisa de jurisprudência",["Rafael"])  # DENTRO do b1 -> co-oc produtividade x medo
t("doc-6","code-a2","Cliente hoje pergunta por que a conta é tão alta se a IA faz",["Rafael","Júlia"])
t("doc-6","code-f1","A cobrança por hora está mesmo ameaçada",["Rafael","Júlia"])
t("doc-6","code-c1","eu fico entre o sócio que resiste e o júnior que abraça",["Rafael"])
t("doc-6","code-c2","Falta política e falta capacitação",["Rafael","Júlia"])
t("doc-6","code-c3","Falta política e falta capacitação",["Júlia"])

# ---- doc-7
env("doc-7","code-c3","Com governança.","entra na ferramenta.",["Marina","Júlia"])  # engloba b3
t("doc-7","code-b3","sigilo do cliente sempre. Nenhum dado identificável entra na ferramenta",["Marina","Júlia"])
t("doc-7","code-a1a","A pesquisa jurídica que tomava um dia caiu para uma hora",["Marina","Júlia"])
t("doc-7","code-a1b","A automação de minutas repetitivas liberou os associados para trabalho estratégico",["Marina"])
env("doc-7","code-f0","Aí está a revolução de verdade.","pirâmide do escritório.",["Marina","Júlia"])  # engloba f1,f2
t("doc-7","code-f1","A cobrança por hora não sobrevive a isso",["Marina","Júlia"])
t("doc-7","code-f2","o estagiário não vai mais aprender copiando precedente, vai ter que pensar desde cedo",["Marina","Júlia"])
t("doc-7","code-b2","Muita, dos sócios da velha guarda",["Marina"])
t("doc-7","code-c1","É uma divisão geracional clássica",["Marina","Júlia"])
t("doc-7","code-c2","aposto em treinamento contínuo: oficina, manual, gente acompanhando",["Marina","Júlia"])
t("doc-7","code-d0","Escritório que não governar a IA vai ser governado por ela",["Marina","Júlia"])

# ---- doc-8 (grupo focal)
t("doc-8","code-a1","Ajuda demais na produtividade",["Rafael"])
t("doc-8","code-a1a","A pesquisa jurídica virou questão de minutos",["Rafael"])
t("doc-8","code-b1","acórdão inventado com número falso",["Rafael"])
t("doc-8","code-b3","A gente lida com dado sensível de cliente; jogar isso na nuvem é temerário",["Rafael"])
t("doc-8","code-c3","No meu escritório a política interna resolveu muita coisa",["Rafael"])
t("doc-8","code-c2","E ninguém treina ninguém",["Rafael"])
t("doc-8","code-c1","sócio sênior trava, júnior abraça",["Rafael"])
t("doc-8","code-f1","O modelo de negócio inteiro está em xeque",["Rafael"])
t("doc-8","code-f2","Estou com medo de não ter mais espaço para quem começa",["Rafael"])

# ---- doc-9 (politica interna)
t("doc-9","code-c3","Esta política estabelece regras para o uso de ferramentas de IA generativa",["Marina"])
t("doc-9","code-b3","É vedado inserir em qualquer ferramenta dado que identifique cliente, parte ou caso sem anonimização prévia",["Marina"])
t("doc-9","code-b4","A revisão e a assinatura de toda peça permanecem do advogado responsável",["Marina"])
t("doc-9","code-b1","deve ser conferida na fonte oficial, dado o risco de alucinação",["Marina"])
t("doc-9","code-c2","O escritório oferecerá treinamento periódico obrigatório sobre uso responsável",["Marina"])
t("doc-9","code-a1b","automação de minutas repetitivas",["Marina"])

# ---------------------------------------------------------------- censura (todas as ocorrencias)
# por doc: lista de (code, termo). Geramos uma coding por ocorrencia. Camada final (gabarito), autor Admin.
REDACT = {
 "doc-1": [("code-e1","Fulana de Tal")],
 "doc-2": [("code-e1","Beltrano de Souza")],
 "doc-3": [("code-e1","Sicrano Modelo")],
 "doc-4": [("code-e1","Joana das Couves"),("code-e1","Dr. Sicrano")],
 "doc-5": [("code-e1","Maria Exemplo")],
 "doc-6": [("code-e1","Zé Ninguém")],
 "doc-7": [("code-e1","João da Silva Fictício")],
 "doc-9": [("code-e1","Dra. Fulana de Tal"),("code-e1","Dr. João da Silva Fictício")],
}
# localizacao/empresa
REDACT_E2 = {
 "doc-1": ["Tal, Qual & Associados","São Paulo"],
 "doc-2": ["Tal, Qual & Associados","São Paulo"],
 "doc-3": ["Banca Exemplo Advogados","Rio de Janeiro"],
 "doc-4": ["Banca Exemplo Advogados","Rio de Janeiro"],
 "doc-5": ["Tal, Qual & Associados","Brasília"],
 "doc-6": ["Banca Exemplo Advogados","Rio de Janeiro"],
 "doc-7": ["Tal, Qual & Associados","São Paulo"],
 "doc-8": ["São Paulo"],
 "doc-9": ["Tal, Qual & Associados","São Paulo"],
}

# ---------------------------------------------------------------- montagem
def find_span(content, quote, used):
    """acha a 1a ocorrencia de quote nao consumida (used = set de starts)."""
    start = 0
    while True:
        i = content.find(quote, start)
        if i < 0:
            raise SystemExit("QUOTE NAO ENCONTRADO em doc: %r" % quote[:50])
        if i not in used:
            return i
        start = i + 1

def all_spans(content, quote):
    out=[]; start=0
    while True:
        i = content.find(quote, start)
        if i<0: break
        out.append(i); start=i+len(quote)
    return out

documents = [{"id":k,"name":v[0],"content":v[1]} for k,v in DOCS.items()]
content_of = {k:v[1] for k,v in DOCS.items()}

categories=[]
for cid,name,kind,opts,desc,pos in CATEGORIES:
    categories.append({"id":cid,"name":name,"kind":kind,"options":opts,
                       "description":desc,"color":pos,"position":pos})

codes=[]
for i,(cid,parent,depth,name,hue,hdeg,red) in enumerate(CODES):
    c={"id":cid,"parent_id":parent,"name":name,"hue":hue,"depth":depth,
       "position":i,"hue_deg":hdeg}
    if red: c["is_redaction"]=True
    codes.append(c)

# doc_values
doc_values=[]; vid=0
def addv(doc,cat,val,set_by,author,layer):
    global vid; vid+=1
    doc_values.append({"id":"v%d"%vid,"document_id":doc,"category_id":cat,
                       "value":val,"set_by":set_by,"author_name":author,"layer":layer})
for doc,vals in FINAL_VALS.items():
    for cat,val in vals.items():
        addv(doc,cat,val,"user-admin","Admin","final")
for doc,cats in INDIV_VALS.items():
    for cat,perc in cats.items():
        for coder,val in perc.items():
            addv(doc,cat,val,None,coder,"individual")

# codings
codings=[]; cid=0
used_by_doc={d:set() for d in DOCS}
span_cache={}  # (doc,quote)->start : mesmo quote reusado = mesmo trecho (co-ocorrencia)
def addc(doc,code,start,end,quote,layer,author):
    global cid; cid+=1
    codings.append({"id":"c%d"%cid,"document_id":doc,"code_id":code,
                    "span_start":start,"span_end":end,"quote":quote,
                    "layer":layer,"author_name":author})

# tematicos -> individuais (cada coder) + final (gabarito) quando final=True
coding_ref={}  # (doc,code,quote)->final coding id (para ancorar memos de trecho)
for doc,code,quote,coders,final in T:
    cont=content_of[doc]
    if (doc,quote) in span_cache:
        base=span_cache[(doc,quote)]           # co-ocorrencia no mesmo trecho
    else:
        base=find_span(cont,quote,used_by_doc[doc])
        used_by_doc[doc].add(base); span_cache[(doc,quote)]=base
    end=base+len(quote)
    for coder in coders:
        addc(doc,code,base,end,quote,"individual",coder)
    if final:
        addc(doc,code,base,end,quote,"final","Admin")
        coding_ref[(doc,code)]="c%d"%cid

# envelopes (spans largos): co-ocorrencia pai x filhos e entre familias
for doc,code,a,b,coders,final in ENV:
    cont=content_of[doc]
    ia=cont.find(a); ib=cont.find(b)
    if ia<0 or ib<0: raise SystemExit("ANCORA ENV nao encontrada em %s: %r / %r"%(doc,a,b))
    start=ia; end=ib+len(b); quote=cont[start:end]
    for coder in coders:
        addc(doc,code,start,end,quote,"individual",coder)
    if final:
        addc(doc,code,start,end,quote,"final","Admin")
        coding_ref[(doc,code)]="c%d"%cid

# censura -> todas as ocorrencias (camada final, Admin)
for doc,items in REDACT.items():
    cont=content_of[doc]
    for code,term in items:
        for s in all_spans(cont,term):
            addc(doc,code,s,s+len(term),term,"final","Admin")
for doc,terms in REDACT_E2.items():
    cont=content_of[doc]
    for term in terms:
        for s in all_spans(cont,term):
            addc(doc,"code-e2",s,s+len(term),term,"final","Admin")

# ---------------------------------------------------------------- memos
memos=[]
def memo(scope,target,author,content):
    memos.append({"scope":scope,"target_id":target,"author_name":author,"content":content})

memo("project","file-project","Admin",
"Anotações gerais do projeto (DADOS FICTÍCIOS — demonstração do QualiLab).\n\n"
"A pergunta que guia a pesquisa é: por que alguns escritórios abraçam a IA generativa e outros travam? "
"No começo a hipótese era pura questão de geração; as entrevistas mostram algo mais complexo — confidencialidade do cliente, "
"pressão de preço e o grau de governança de cada banca.\n\n"
"Corpus: sete entrevistas (ENT-01 a ENT-07), um grupo focal (GF-01) e a política interna (DOC-01), de fevereiro a março de 2026. "
"Dois escritórios fictícios: Tal, Qual & Associados (São Paulo / Brasília) e Banca Exemplo Advogados (Rio). "
"Marina, Rafael e Júlia codificaram em separado; o gabarito foi fechado na Reconciliação.\n\n"
"Todos os nomes de pessoas e escritórios são claramente fantásticos (Fulana de Tal, Beltrano, Sicrano, Banca Exemplo...) "
"justamente para deixar evidente que NADA aqui é dado real — é material de demonstração.")

DOC_MEMOS={
 "doc-1":("Marina","Entrevista-chave da demo: foi codificada com TODOS os códigos, de propósito, para a primeira tela já mostrar como os grifos coloridos, a sobreposição e a censura aparecem. A Fulana de Tal resume bem a tensão central: rendeu-se à produtividade, mas trava na confidencialidade de M&A."),
 "doc-2":("Rafael","Contraponto geracional puro: o Beltrano já chegou usando, trata como corretor ortográfico. Mesmo entusiasmado, admite zero treinamento e medo de alucinação — nem quem gosta se sente seguro."),
 "doc-3":("Júlia","O cético da amostra. Útil para a Reconciliação porque proíbe o uso por dois motivos distintos (confidencialidade e responsabilidade), que às vezes a gente codificava junto e às vezes separado."),
 "doc-4":("Rafael","Visão de quem está na base da pirâmide: usa escondido do sócio, sem treinamento, e com medo concreto de a vaga sumir. Bom para o código Futuro de júnior e estagiário."),
 "doc-5":("Marina","Caso 'modelo': mostra que política + treinamento dissolvem boa parte do medo. Liga bem Treinamento e capacitação com Confidencialidade do cliente."),
 "doc-6":("Júlia","O ambivalente típico: usa pela produtividade mas confere tudo, ao ponto de anular o ganho de tempo. Ótimo exemplo de co-ocorrência Produtividade x Medo de alucinação."),
 "doc-7":("Marina","O sócio de inovação costura quase todos os eixos: governança, negócio, formação. Útil para a aba Co-ocorrência por concentrar muitos códigos diferentes no mesmo documento."),
 "doc-8":("Rafael","Grupo focal funciona como síntese: cada participante puxa um eixo. Bom para mostrar vários códigos num documento só sem nome de pessoa para censurar."),
 "doc-9":("Júlia","A política interna é o documento institucional que 'responde' às entrevistas: cada cláusula corresponde a um achado (confidencialidade, responsabilidade, verificação, capacitação)."),
}
for d,(a,c) in DOC_MEMOS.items(): memo("document",d,a,c)

CODE_MEMOS={
 "code-a0":"Família sobre o que leva (ou não) à adoção. Usar nos trechos que falam da decisão de adotar, não nos ganhos concretos (esses vão em Ganhos de produtividade).",
 "code-a1":"Ganho de eficiência em geral. Quando dá para especificar, prefira os filhos Aceleração de pesquisa jurídica ou Automação de tarefas repetitivas.",
 "code-a2":"Pressão externa, sobretudo de clientes comparando preço e velocidade. Não confundir com a pressão interna entre gerações (Divisão geracional).",
 "code-b1":"Alucinação = a ferramenta afirma com confiança algo falso (acórdão inventado). Aparece quase sempre junto de Ganhos de produtividade — daí a co-ocorrência forte.",
 "code-b3":"Confidencialidade do cliente é o freio mais citado pelos sêniores. Costuma co-ocorrer com Política institucional de uso (a regra que tenta resolver o medo).",
 "code-c1":"Divisão geracional: sênior trava, júnior abraça. Marcar mesmo quando aparece de forma implícita ('a gente' x 'os sócios').",
 "code-c3":"Política institucional de uso: tanto a existência quanto a AUSÊNCIA de regra escrita. Os dois casos importam para o argumento sobre governança.",
 "code-f1":"Cobrança por hora ameaçada: o núcleo do impacto no negócio. Tende a co-ocorrer com Aceleração de pesquisa (a tarefa que encolheu).",
 "code-d0":"Reservado para frases-síntese citaveis no relatório. Não abusar: só a 'frase de fecho' de cada entrevistado.",
 "code-e0":"Censura/anonimização. Os filhos Nomes e Localização/empresa marcam tudo que identifica pessoa ou banca — demonstram o mascaramento na exportação e no leitor publicado.",
}
for cid_,c in CODE_MEMOS.items(): memo("code",cid_,"Admin",c)

# OBS: NAO existe memo de trecho (scope='coding'). A tabela memos na nuvem tem
# check constraint scope in ('project','document','code') -> 'coding' quebra o import.
# O modelo de memo so ancora em projeto/documento/codigo (ver backlog no CLAUDE.md).
# Insights de trecho viram conteudo dentro do memo de documento/codigo correspondente.

# ---------------------------------------------------------------- saida
db={
 "_meta":{"id":"file-project",
          "name":"IA generativa na advocacia — corpus de demonstração (fictício)",
          "code":"DEMO3","mode":"collective","displayName":"Admin"},
 "documents":documents,
 "categories":categories,
 "doc_values":doc_values,
 "codes":codes,
 "codings":codings,
 "memos":memos,
}

# validacao de offsets
bad=0
for c in codings:
    cont=content_of[c["document_id"]]
    if cont[c["span_start"]:c["span_end"]]!=c["quote"]:
        bad+=1; print("MISMATCH",c["document_id"],repr(c["quote"][:40]))
if bad: raise SystemExit("ABORT: %d offsets invalidos"%bad)

out="QualiLab_synthetic_realistic_legal_ai_3.qualilab"
with io.open(out,"w",encoding="utf-8") as f:
    f.write(json.dumps(db,ensure_ascii=False,indent=2))

# relatorio
from collections import Counter
print("OK ->",out)
print("documentos:",len(documents))
print("categorias:",len(categories))
print("codigos:",len(codes),"(censura:",sum(1 for c in codes if c.get("is_redaction")),")")
print("codings:",len(codings),Counter(c["layer"] for c in codings))
print("  por autor:",Counter(c["author_name"] for c in codings))
print("doc_values:",len(doc_values),Counter(v["layer"] for v in doc_values))
print("memos:",len(memos),Counter(m["scope"] for m in memos))
# codigos aplicados em doc-1
d1=set(c["code_id"] for c in codings if c["document_id"]=="doc-1")
allcodes=set(c["id"] for c in codes)
print("codigos em doc-1:",len(d1),"de",len(allcodes),"-> faltam:",sorted(allcodes-d1))
