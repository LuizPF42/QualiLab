<p align="center">
  <a href="https://luizpf42.github.io/QualiLab"><img src="../images/logo.png" alt="QualiLab" width="160"></a>
</p>

# Manual de QualiLab

**Guía completa de uso, desde el primer acceso hasta la publicación de resultados.**

[Português](MANUAL.md) · [English](MANUAL.en.md) · **Español** · [Leer en el navegador](manual.html?lang=es)

> 🤖 **Traducción hecha con IA.** Este texto se tradujo del portugués con inteligencia artificial. Si algo suena extraño o parece incorrecto, la [versión en portugués](MANUAL.md) es la referencia.

Este manual enseña a *usar* QualiLab paso a paso. Para conocer sus funciones y la parte técnica (instalación, Supabase, formatos), consulta el [README](https://github.com/LuizPF42/QualiLab#readme). Para contribuir al código, visita el [repositorio en GitHub](https://github.com/LuizPF42/QualiLab).

> QualiLab funciona por completo en el navegador, en un único archivo. No requiere instalación, inicio de sesión ni servidor propio. Puedes empezar ahora en **[luizpf42.github.io/QualiLab](https://luizpf42.github.io/QualiLab)**. ¿Quieres probar antes de leer? Los **[Primeros 5 minutos](#primeros-5-minutos)** te permiten empezar a codificar de inmediato.

Las capturas compartidas con el manual original muestran la interfaz en portugués; las instrucciones y los nombres de controles de este texto corresponden a la interfaz en español.

---

## Índice

> ⚡ **¿Tienes prisa?** Los [**Primeros 5 minutos**](#primeros-5-minutos), a continuación, te permiten codificar antes de seguir leyendo. Vuelve después para profundizar.

0. [La idea de QualiLab](#0-la-idea-de-qualilab): para qué sirve, qué problemas aborda, cómo planificar su uso
1. [Conceptos fundamentales](#1-conceptos-fundamentales): el modelo conceptual antes de todo
2. [Primeros pasos](#2-primeros-pasos): acceder, elegir dónde guardar, crear un proyecto
3. [La interfaz](#3-la-interfaz): encabezado, barra de estado, paleta de comandos, paneles, teclado y accesibilidad
4. [Documentos](#4-documentos): subir, pegar, renombrar, editar el texto, ver el PDF original y OCR
5. [Codificación de fragmentos](#5-codificación-de-fragmentos): el centro de la herramienta
6. [Categorías (atributos del documento)](#6-categorías-atributos-del-documento)
7. [Esquema](#7-esquema): organizar códigos y categorías en lote y conectarlos entre sí
8. [Reconciliación](#8-reconciliación): consolidar la referencia (proyecto colectivo)
9. [Lectura](#9-lectura): leer el corpus y los fragmentos codificados
10. [Gráficos](#10-gráficos)
11. [Memos](#11-memos): notas analíticas
12. [Informe](#12-informe): el centro de publicación y transparencia
13. [Colaboración](#13-colaboración): equipo, roles, invitaciones, distribución y codificación a ciegas
14. [Mi cuenta](#14-mi-cuenta)
15. [Importar y exportar](#15-importar-y-exportar)
16. [Guardado, copias de seguridad y modos de almacenamiento](#16-guardado-copias-de-seguridad-y-modos-de-almacenamiento)
17. [Codificar y Analizar con IA](#17-codificar-y-analizar-con-ia): Autocodificación, Analizar y Explorar con IA: opcional (BYOK), con activación voluntaria y transparente
18. [Solución de problemas](#18-solución-de-problemas)
19. [Atajos de teclado](#19-atajos-de-teclado)
20. [Glosario](#20-glosario)

---

## Primeros 5 minutos

*¿Quieres probar la herramienta antes de profundizar en el método? Este es el camino más corto hasta tu primer código, sin crear una cuenta ni instalar nada.*

1. Abre **[luizpf42.github.io/QualiLab](https://luizpf42.github.io/QualiLab)** y haz clic en **Solo probar (borrador)**. QualiLab pregunta si el proyecto tendrá **recursos de IA**; para empezar, basta con **Continuar sin IA** (puedes activarlos después). El proyecto se abre de inmediato, solo en este navegador.
2. En la pestaña **Codificación**, haz clic en **pegar texto…** y pega un fragmento: una intervención de una entrevista, un párrafo de una resolución, una noticia (o usa **＋ subir ▾** para un `.txt`, `.pdf` o `.docx`, o **probar con un corpus de ejemplo** para ver resaltados y gráficos ya preparados).
3. **Selecciona** con el mouse una frase que te llame la atención, haz clic con el **botón derecho** y elige **+ Crear nuevo código**. Ponle un nombre al tema (p. ej., *acceso a la justicia*) y haz clic en **Crear y aplicar**. Ya tienes tu primer fragmento codificado.
4. Codifica más fragmentos: **repite el mismo código** donde reaparezca el tema y **crea otros** donde surjan temas nuevos.
5. Abre **Lectura**, ve a **Fragmentos** y haz clic en tu código: todos los fragmentos que marcaste aparecen juntos. Tu análisis empieza a tomar forma.

> Antes de avanzar, decide **dónde guardar** el trabajo (el borrador es efímero, [sección 16](#16-guardado-copias-de-seguridad-y-modos-de-almacenamiento)) y lee la **[sección 0](#0-la-idea-de-qualilab)** para aprovechar la herramienta. El resto del manual profundiza en cada paso.

---

## 0. La idea de QualiLab

*Si acabas de llegar, empieza por esta sección: explica para qué sirve QualiLab, qué problemas aborda y cómo aprovecharlo, para que puedas planificar su uso antes de empezar a hacer clic.*

### En una frase

QualiLab es tu **laboratorio de investigación cualitativa en un único archivo**: abres un documento, seleccionas un fragmento y lo codificas, con un espacio para **experimentar** con el material (leer, visualizar, cruzar, probar ideas) y **transformar** el resultado en algo que otras personas puedan leer y aprovechar.

### El espíritu: un laboratorio, no un archivo muerto

El nombre tiene sentido. En un laboratorio se **experimenta**: planteas una hipótesis, mezclas materiales, pruebas una idea, descartas lo que no se sostiene y conviertes lo que queda en algo útil. QualiLab está hecho para ese ir y venir, para **trabajar** el análisis.

Por eso **Lectura**, **Gráficos** y el **Informe Interactivo (ATI)** forman parte del proceso desde el principio. En **Lectura** relees el documento completo con los resaltados en contexto, o reúnes todos los fragmentos de un código; en **Gráficos** planteas y descartas hipótesis mediante frecuencias, cobertura y coocurrencias; en **Informe** **transformas la exploración en un producto**: un informe listo, una página interactiva o un conjunto de anotaciones. El camino entre explorar y producir es lo bastante corto para recorrerlo cuantas veces necesites.

### Los problemas que aborda

El análisis cualitativo de datos (QDA) suele tener un costo alto en tres sentidos. QualiLab se diseñó para atenderlos:

1. **Costo y barrera de entrada.** Las herramientas de referencia (ATLAS.ti, MAXQDA, NVivo) son costosas, cerradas y tienen una curva de aprendizaje que consume horas *antes* del primer análisis. QualiLab es **gratuito, de código abierto (MIT) y se abre directamente**: sin instalación, servidor propio ni suscripción. Cargas un documento, seleccionas y codificas.

2. **La hoja de cálculo paralela.** Codificación temática en una herramienta; atributos estructurados (año, fuente, tribunal, perfil de la persona entrevistada) en una hoja aparte. QualiLab **integra ambos**: los códigos de **fragmentos** (lo que dice el texto) y las **categorías** del documento (qué es el documento) conviven en el mismo entorno.

3. **La evidencia que queda atrás.** Un argumento cualitativo sólido se fortalece cuando quien lo lee puede **ver el material que lo sostiene**, pero mostrar ese recorrido suele ser laborioso: queda encerrado en herramientas costosas o disperso en archivos. QualiLab acorta ese camino: codificación, categorías, memos y reconciliación quedan **explícitos y exportables**, y pueden publicarse con estándares abiertos (ATI / W3C Web Annotation), **en la medida y el formato que elijas**, sin depender de un proveedor.

### Para qué sirve

Cualquier corpus de **texto** que quieras interpretar de forma sistemática: entrevistas y transcripciones, resoluciones y escritos judiciales, documentos de políticas públicas, noticias, respuestas abiertas de encuestas, actas, informes, literatura. Funciona de forma individual o en equipo, en línea o totalmente sin conexión.

### Qué busca una buena investigación con QualiLab

Piensa en estos puntos como **objetivos** que orientan el uso, como lo que estás construyendo:

- **Afirmaciones fundamentadas.** Cada punto apoyado en fragmentos concretos que puedas mostrar para dar fuerza al argumento.
- **Profundidad interpretativa _y_ comparabilidad estructurada.** Los memos y una codificación rica captan el sentido; las categorías permiten contar, cruzar y comparar. Ambos aspectos de la investigación cualitativa en un mismo lugar.
- **Autoría explícita y acuerdo entre codificadores.** En equipo, cada persona codifica en su capa y el grupo consolida una referencia en Reconciliación: el **desacuerdo se convierte en dato**, en vez de desaparecer del análisis.
- **Control sobre tus datos.** Tú eliges dónde quedan y conoces las implicaciones de cada opción (consulta *Datos sensibles y responsabilidad*, abajo).

### Transparencia al servicio de tu argumento

Aquí la transparencia **no** significa rendición de cuentas ni la promesa de «replicar» un análisis interpretativo: eso mediría la investigación cualitativa con un criterio que no le corresponde. La idea es que **mostrar la evidencia junto a tu lectura de ella fortalece lo que sostienes**. Cuando quien lee puede recorrer los fragmentos que sustentan un hallazgo, tu argumento gana credibilidad sin que tengas que renunciar a tu interpretación.

Siempre con las precauciones que exige la investigación cualitativa: el sentido es situado y construido, no todo puede ni debe exponerse, y la confidencialidad de las fuentes es prioritaria. Por eso la transparencia en QualiLab es **opcional, gradual y tuya**: decides qué mostrar, a quién y cuándo. Los fragmentos marcados como **censura** se enmascaran en los informes de transparencia y en el material enviado a la IA (los archivos de trabajo, como `.qualilab`, QDPX y CSV, contienen el texto completo). La herramienta ofrece los medios; el criterio es tuyo.

### Datos sensibles y responsabilidad

Antes de cargar material, decide **qué partes de la herramienta puedes usar**, porque depende de la **sensibilidad de los datos**. La regla de oro: **el material solo sale de tu dispositivo si lo autorizas**, al trabajar en la **nube** (sincronización mediante Supabase), usar **IA remota** (envío al proveedor que elijas) o **publicar** un informe. En los modos **archivo** y **borrador**, y con **IA local**, nada sale de tu computadora.

> **Regla práctica (safe-by-default):** ante la duda, trata el material como más sensible. Los datos **públicos o sintéticos** permiten todas las funciones; los datos **sensibles** requieren modo archivo y, si usas IA, **tu propia** clave (preferentemente de pago o institucional) con la censura revisada; los datos cuya salida está **prohibida** (por un comité de ética, datos de salud identificables, expedientes reservados) permanecen **sin conexión**, sin nube ni IA remota. La **censura solo enmascara lo que marcaste a mano** (no es anonimización automática) y **anonimizar** al exportar solo omite la autoría. La **matriz de decisión completa** y los límites de la censura están en la [sección 16](#16-guardado-copias-de-seguridad-y-modos-de-almacenamiento). Léela antes de elegir dónde guardar.

> **Aviso legal.** QualiLab es un proyecto **personal**, distribuido con licencia **MIT, sin garantía alguna**. No representa la posición ni implica responsabilidad de ninguna institución (incluida FGV). El autor no se responsabiliza por pérdida de datos, filtraciones ni uso indebido. Úsalo bajo tu responsabilidad, con las precauciones éticas y legales que exija tu investigación.

### Cómo planificar el uso (un recorrido mínimo)

1. **Declara el objetivo** de la investigación en un **memo de proyecto** ([sección 11](#11-memos)). Orienta la codificación. Para orientar a la IA, escribe el **Memo para la IA** (o selecciona el memo del proyecto en ⚙ Configurar Prompt).
2. **Elige dónde quedan los datos** ([sección 16](#16-guardado-copias-de-seguridad-y-modos-de-almacenamiento)) según su sensibilidad y si trabajas en equipo (relee *Datos sensibles y responsabilidad*).
3. **Elige el tipo de proyecto**, individual o colectivo ([sección 2](#2-primeros-pasos)).
4. **Incorpora los documentos** y completa las **categorías** que querrás comparar después ([secciones 4](#4-documentos) y [6](#6-categorías-atributos-del-documento)).
5. **Codifica**, construye códigos de forma inductiva o sigue un esquema previo; registra las decisiones en memos ([sección 5](#5-codificación-de-fragmentos)).
6. **Reconcilia** (en equipo) o revisa (individualmente) ([sección 8](#8-reconciliación)).
7. **Experimenta y publica**: explora en Lectura y Gráficos, y convierte el resultado en un producto mediante Informe ([secciones 9](#9-lectura)–[12](#12-informe)).

### Cómo se hizo QualiLab (y qué esperar)

QualiLab se escribió **en su mayor parte con [Claude Code](https://claude.com/claude-code)** (la IA de programación de Anthropic), **bajo la dirección del autor**, a partir de problemas reales de su práctica de investigación y del diálogo con la comunidad y la literatura de métodos cualitativos. En parte, el proyecto experimenta con esta pregunta: **¿hasta dónde puede convertirse una IA guiada en una herramienta de investigación?**

QualiLab está en desarrollo activo: recibe mejoras constantes y puede presentar errores. Guarda el trabajo con frecuencia ([sección 16](#16-guardado-copias-de-seguridad-y-modos-de-almacenamiento)) y comunica problemas o ideas en [github.com/LuizPF42/QualiLab](https://github.com/LuizPF42/QualiLab/issues). Esa retroalimentación ayuda a desarrollar la herramienta.

### La IA dentro de QualiLab

QualiLab incorpora IA como **asistente, nunca como sustituta del criterio del investigador**, bajo tres reglas. **Activación voluntaria:** la IA está desactivada de forma predeterminada; no se envía nada a un modelo sin que lo pidas, análisis por análisis. **Transparencia:** puedes ver el prompt exacto, la IA devuelve **propuestas** que apruebas o rechazas una por una y recibe instrucciones de **citar la fuente** (fragmento y documento) de cada observación. **Control:** los fragmentos marcados como censura se enmascaran antes de cada envío, y usas **tu propia** clave y modelo (o un modelo local mediante Ollama). La IA acelera la lectura y la organización; la interpretación y la decisión siguen siendo tuyas. Detalles en la [sección 17](#17-codificar-y-analizar-con-ia).

---

## 1. Conceptos fundamentales

Antes de hacer clic, conviene entender estas ideas, que se repiten en todas las pantallas.

### Documento
Un texto para analizar: una entrevista, una resolución judicial, un artículo o una transcripción. Puedes importarlo (`.txt`, `.md`, `.docx`, `.pdf`) o pegar el texto. Cada fila de una hoja de cálculo (`.csv`/`.xlsx`) también puede convertirse en un documento.

### Código
Una etiqueta que aplicas a **fragmentos** del texto («este párrafo habla de *acceso a la justicia*»). Los códigos son **jerárquicos**: pueden contener subcódigos y estos, a su vez, otros. El **color** proviene de la familia (el matiz) y la **tonalidad** indica la profundidad. Es la codificación temática clásica del QDA.

### Código y familia: una sola regla

> **Un código agrupa otros códigos o recibe fragmentos. Nunca ambas cosas.**

El que tiene subcódigos es una **familia**: organiza y no recibe fragmentos directamente. El que no tiene subcódigos recibe fragmentos, ya sea un código de **Jerarquía 0** (en la raíz) o un **subcódigo** dentro de una familia. En el árbol, la familia aparece con el cuadrado de color **vacío**, solo con el contorno; quien recibe fragmentos lo tiene **relleno**. En el Mapa, las burbujas siguen la misma regla.

**Por qué existe esta regla.** Si un código tuviera subcódigos *y* fragmentos propios, los conteos serían ambiguos: cuando una familia muestra «23», ¿son sus fragmentos, los de sus hijos o la suma? La misma duda afecta al análisis: al comparar «Riesgos» con «Adopción», podrías comparar conjuntos de distinto tipo. ATLAS.ti y QualCoder también separan ambas cosas por razones **metodológicas**.

En QualiLab la familia muestra la **suma de sus subcódigos** (el número incluye a los hijos; la ayuda emergente lo indica). Así muestra el peso del tema en el material sin tener fragmentos propios.

**No tienes que decidirlo de antemano.** Crea códigos mientras lees; cada código nuevo nace simple y recibe fragmentos. La familia aparece **cuando decides subdividirlo**: al recibir el primer subcódigo se convierte en familia y, si ya tiene fragmentos, QualiLab pregunta adónde moverlos (consulta [5.1](#51-crear-códigos) y [7.2](#72-códigos-reorganización-en-lote)). Nada se mueve sin que lo veas.

> **Sobre la profundidad.** QualiLab permite tantos niveles como quieras (`Adopción ▸ Beneficios ▸ Aceleración`). La literatura recomienda moderación: Bazeley sugiere unas 10 a 25 familias en la raíz y **2 a 3 niveles** en total. A mayor profundidad, los códigos tienden a duplicarse en los niveles inferiores, dificultando la comparación.

### Categoría (atributo del documento)
La categoría describe el **documento completo**, no un fragmento: «Año», «Tribunal», «Tipo de fuente», «Género de la persona entrevistada». Es lo que normalmente sería una columna en una hoja de cálculo paralela; aquí está integrado. Hay siete tipos: Texto Cerrado, Texto Abierto, Número, Fecha, Sí/No, Opción Múltiple y Casilla de Verificación.

> **Código × Categoría:** el *código* marca una **parte** del texto; la *categoría* responde una pregunta sobre el **documento completo**.

> **Si vienes de otra herramienta, presta atención a «categoría».** Aquí significa **atributo del documento**; en otras herramientas designa un **grupo de códigos**.

| En QualiLab | MAXQDA | NVivo | QualCoder | ATLAS.ti |
|---|---|---|---|---|
| **categoría** (atributo del documento) | variable de documento | atributo (en una clasificación de caso) | atributo | *no existe*; se convierte en **grupo de documentos** |
| **familia** (código con subcódigos) | código y subcódigos | nodo padre y nodos hijos | **categoría** | **categoría** |

ATLAS.ti es el único de los cuatro que no tiene atributos de documento: su manual recomienda usar **grupos de documentos** como atributos o variables. Por eso, al exportar hacia él, cada valor de categoría se convierte en un grupo separado y una categoría de texto libre puede generar un grupo por documento. Es la representación que permite su modelo.

Al **volver**, el recorrido se invierte: al importar un `.qdpx`, cada **grupo de documentos** se convierte en valor de una categoría de tipo *Casilla de Verificación* (un documento puede pertenecer a varios grupos y todos aparecen). Si el nombre tiene el formato `Categoría::Valor`, se reconstruye la categoría original con su nombre. Un **grupo de códigos no se convierte en familia**, porque aquí la familia depende de la jerarquía del código: el resumen de importación enumera los grupos excluidos para que puedas recrearlos como subcódigos.

### Capas y autoría
Cada codificación y cada respuesta de categoría registra **quién** la hizo. Hay dos capas:

- **Individual**: el trabajo separado de cada investigador.
- **Final (referencia)**: la versión consolidada del equipo.

En un **proyecto individual**, todo va directamente a la referencia. En un **proyecto colectivo**, cada persona trabaja en su capa individual y el equipo consolida la referencia en **Reconciliación**.

### Roles (proyecto colectivo)
- **Admin**: define el esquema de categorías, edita la referencia, gestiona miembros, define los colores de familia y la **censura**, edita el **texto** de los documentos, **importa** material y realiza operaciones **estructurales y destructivas**: **eliminar** documentos o códigos y **fusionar** códigos (afectan al trabajo de todo el equipo).
- **Miembro**: codifica en su capa, completa sus respuestas de categoría, **añade documentos**, **crea y renombra** códigos, edita sus **definiciones**, escribe memos y usa los paneles de IA (si el proyecto tiene IA).
- **Solo lectura**: lee el proyecto completo —documentos, códigos, codificaciones del equipo, categorías, gráficos, Reconciliación e Informe— y **escribe memos**. No codifica, no responde categorías, no modifica el esquema, no sube documentos ni importa; no ve las pantallas de IA. Es el rol del **director de tesis**, del **evaluador** o de quien aporta una segunda lectura: su opinión vuelve al equipo mediante memos dentro del proyecto. Las restricciones de **codificación a ciegas** y **distribución** se aplican igual que a un miembro.

> Estos son los valores **predeterminados**. Al crear un proyecto colectivo se decide, punto por punto, qué pueden hacer los roles de miembro y solo lectura, y el diseño del estudio (por ejemplo, la codificación a ciegas): consulta [Qué puede hacer cada rol](#qué-puede-hacer-cada-rol-se-decide-al-crear).

> **Cómo asignarlos:** en **Proyecto ▸ Miembros y administradores**, el admin hace clic en **hacer solo lectura** en la fila de la persona (y en **devolver la codificación** para revertirlo). Se entra con el mismo código de acceso habitual. El proyecto siempre conserva al menos un admin: no permite degradar al último. La **configuración del estudio** —instrucciones de IA, postura, prompts guardados y palabras ignoradas en la nube— se guarda como memo, pero queda a cargo de quien coordina.

> El **servidor** impone estas restricciones: un miembro no puede, ni mediante una llamada directa a la API, escribir en la referencia, eliminar documentos/códigos, editar el texto compartido, quitar la censura ni importar. Estas acciones requieren el rol de admin.

> Dónde se guardan los datos (nube, navegador o archivo en disco) se elige **por separado** del tipo de proyecto. Consulta la [sección 16](#16-guardado-copias-de-seguridad-y-modos-de-almacenamiento).

---

## 2. Primeros pasos

> **Antes de cargar material, decide dónde quedarán tus datos.** Los modos **archivo** y **borrador** permanecen en tu dispositivo; la **nube** sincroniza entre personas y dispositivos, por lo que quien administra la base de datos puede leer el contenido. La matriz completa según la sensibilidad está en la [sección 16](#16-guardado-copias-de-seguridad-y-modos-de-almacenamiento). **Ante la duda, trata el material como más sensible.**

### 2.1. Cómo acceder

| Forma | Cómo | Cuándo usarla |
|---|---|---|
| **En línea** | Abre [luizpf42.github.io/QualiLab](https://luizpf42.github.io/QualiLab) | El camino habitual |
| **Instalado (sin conexión)** | [Instálalo como aplicación](#instalar-como-aplicación-y-abrir-sin-internet); en Windows, **mediante Edge** | Abrir sin internet, ventana propia, doble clic en `.qualilab` |
| **Archivo único** | [Descarga `index.html`](https://github.com/LuizPF42/QualiLab/releases/download/alpha/index.html) y haz doble clic | Sin internet ni instalación; datos sensibles |

El archivo único se abre directamente en el navegador (`file://`), sin servidor ni internet. Solo al usar PDF, DOCX, hojas de cálculo, OCR o búsqueda semántica se descarga la biblioteca correspondiente (el navegador suele conservarla en caché). Si la política del navegador lo bloquea, ejecuta `python -m http.server 8000` en la carpeta del archivo.

> Se recomienda **Chrome o Edge**: solo en ellos funcionan el **modo Archivo local** (guardar un `.qualilab` visible en disco) y la **copia de seguridad automática en carpeta**. Firefox y Safari permiten **nube** o **borrador** (`localStorage`); el modo archivo no está disponible.

### 2.2. La pantalla de entrada

![La pantalla de entrada de QualiLab: los tres caminos (Nuevo en archivo, Entrar en la nube y Solo probar), con Abrir archivo existente y Conectar a mi Supabase debajo.](manual-img/01-welcome.png)

La primera pantalla ofrece tres caminos:

1. **Nuevo en archivo**: crea un proyecto guardado como `.qualilab` en disco (Chrome/Edge): portátil, sin conexión y sin nube. Ideal para datos sensibles.
2. **Entrar en la nube**: abre el **inicio de sesión** (**Continuar con Google**, o correo y contraseña; también puedes **Crear cuenta**, con **nombre para mostrar**, correo y contraseña de al menos 6 caracteres), para trabajo colaborativo y sincronizado. **Olvidé mi contraseña** permite restablecerla por correo. **← Volver** regresa a la entrada. Un aviso recuerda que, en el servidor estándar, el contenido es **visible para quien administra la base de datos**: lee la [sección 16](#16-guardado-copias-de-seguridad-y-modos-de-almacenamiento) antes de subir material sensible.
3. **Solo probar (borrador)**: abre inmediatamente un proyecto de **borrador** en este navegador, sin configuración. Es efímero (desaparece al borrar los datos del sitio), adecuado para probar; puedes migrar a archivo o nube desde la gestión del proyecto.

**¿Creaste una cuenta? El siguiente paso es un código.** QualiLab envía un **código por correo** y abre **Confirma tu registro**: escribe **todos sus números** y pulsa **Confirmar y entrar**. No hay enlace en el correo: los filtros de seguridad corporativos suelen abrirlos automáticamente e invalidarlos antes de que los uses. El código **dura una hora**. Si no llega, revisa el **spam** y usa **Reenviar código**; después solo vale el del correo **más reciente**. Si ya confirmaste la cuenta, **Ya confirmé — quiero entrar** vuelve al inicio de sesión.

Al crear un proyecto (borrador, archivo o nube), QualiLab pregunta por los **recursos de IA**: **Sin IA** (predeterminado: las pantallas de IA no aparecen y Autocodificación conserva solo Repetir Codificación, que no usa IA) o **Activar IA**. Puedes cambiarlo después ([17.7](#177-desactivar-la-ia-en-este-proyecto)).

Cuando el navegador permite instalar, aparece **Instalar QualiLab** (en Windows con Chrome se destaca **Instalar con Edge**): consulta [Instalar como aplicación](#instalar-como-aplicación-y-abrir-sin-internet).

La interfaz sigue el idioma compatible preferido del navegador: portugués, español o inglés; cuando no encuentra uno compatible, usa inglés. Puedes cambiarlo en **Mi cuenta ▸ Idioma** ([sección 14](#idioma-de-la-interfaz)).

El botón violeta **Conectar a mi Supabase** (en la entrada y el inicio de sesión) conecta el app a **tu propio servidor Supabase** antes de iniciar sesión: allí quedarán tus proyectos colectivos.

> Un proyecto en nube o archivo ya abierto **se vuelve a abrir la próxima vez**; si el navegador solicita de nuevo permiso para el archivo, aparece **Reabrir *nombre*.qualilab**. Si el app no tiene nube configurada, **Entrar en la nube** no aparece y empiezas en archivo/borrador.

### 2.3. Elegir o crear un proyecto

Después de iniciar sesión aparece **Mis proyectos**:

- **Abrir uno existente**: haz clic en él o en **abrir**.
- **Crear proyecto**:
  1. Confirma tu **nombre para mostrar**.
  2. Escribe el **nombre del proyecto**.
  3. Elige **Proyecto Individual** (todo va a la referencia, sin reconciliación) o **Proyecto Colectivo** (varios investigadores, con reconciliación).
  4. Decide los **Recursos de IA**: comienza **Sin IA** ([17.7](#177-desactivar-la-ia-en-este-proyecto)).
  5. *(Colectivo)* Elige el **tipo de estudio** (equipo abierto, confiabilidad entre codificadores, dividir el corpus, panel de jueces) y ajusta **Qué puede hacer cada rol** antes de invitar ([sección 13](#qué-puede-hacer-cada-rol-se-decide-al-crear)).
  6. Pulsa **Crear**. En el colectivo, se abre la gestión del proyecto en las invitaciones.
- **Entrar con código**: pega el **código de acceso** o de **invitación** (10 caracteres, p. ej., `9F2A1C7B40`) y pulsa **Entrar**.
- **Archivo local** (Chrome/Edge): **Nuevo archivo…** crea un `.qualilab` en disco; **Abrir archivo…** abre uno existente. Ideal para datos sensibles, sin nube ni red.

> El admin puede cambiar el tipo después. **Colectivo → Individual es irreversible**: reúne todas las codificaciones bajo un único autor y conserva solo la referencia de las categorías.

---

## 3. La interfaz

![Codificación con un proyecto abierto: lector con fragmentos resaltados a la izquierda y paneles de Categorías y Códigos a la derecha. Arriba, el encabezado de dos filas con pestañas e indicador del proyecto.](manual-img/02-codificacao.png)

Con un proyecto abierto, el **encabezado** tiene dos filas:

**Primera fila**
- La marca **QualiLab** y el botón de **tema** de la *interfaz*: alterna **automático** (sigue al sistema; predeterminado) → **claro** → **oscuro**. El tema del *lector* se configura aparte, en la barra del documento.
- Las pestañas principales, **agrupadas por tema** con divisores finos (codificar · leer y organizar · analizar · publicar); la activa aparece subrayada:

| Pestaña | Para qué sirve |
|---|---|
| **Codificación** | Leer el documento y aplicar códigos/categorías |
| **Reconciliación** | *(Solo proyecto colectivo; desaparece con codificación a ciegas y en modo foco)* consolidar la referencia |
| **Lectura** | Leer el documento completo o todos los fragmentos de un código |
| **Memos** | Notas analíticas |
| **Esquema** | Organizar códigos y categorías en lote *(desaparece en modo foco)* |
| **Gráficos** | Frecuencias, nube, coocurrencias, etc. |
| **Autocodificación** | Repetir codificación (sin IA) y, *(opcional, BYOK)*, propuestas de IA para codificar, categorizar, organizar e inducir la definición de una categoría; tú apruebas |
| **Analizar con IA** | *(Opcional, BYOK)* conversación analítica sobre el material seleccionado |
| **Explorar con IA** | *(Opcional, BYOK; **experimental**)* conversación en la que la IA **busca** el material por sí misma |
| **Informe** | Exportar informes y paquetes de transparencia |

> Las tres pantallas de **IA** requieren **activación voluntaria**. Con IA desactivada (predeterminado), no aparecen Analizar ni Explorar con IA, y Autocodificación ofrece solo Repetir Codificación. Ninguna de las tres aparece para el rol de solo lectura. Detalles en la [sección 17](#17-codificar-y-analizar-con-ia).

**Segunda fila**
- El **indicador del proyecto**, p. ej., `borrador · Mi Proyecto · individual ▾`. El prefijo muestra el almacenamiento (`archivo`/`nube`/`nube personal`/`borrador`) y el **color** lo refuerza: neutro = borrador en este navegador; verde = archivo en disco; azul = nube estándar; violeta = tu Supabase; ámbar = nube sin conexión. Pasa el mouse para ver la explicación (en borrador incluye el porcentaje de almacenamiento usado); haz clic para abrir la **gestión del proyecto**. En nube incluye el código de acceso.
- El **indicador de IA**: anillo **verde** cuando está activada; **tachado en rojo** cuando está desactivada o restringida a admins (la ayuda emergente distingue los casos). Solo admins lo cambian, con confirmación; para los demás, el clic explica el estado ([17.7](#177-desactivar-la-ia-en-este-proyecto)).
- Tu **nombre**, **pulsable en todos los modos**, abre Mi cuenta. También permite configurar clave/modelo de IA sin conexión, incluido Ollama local ([sección 17](#17-codificar-y-analizar-con-ia)).
- *(Admin, colectivo)* **admin / ● foco**: oculta Reconciliación, Esquema y el filtro **Ver:** para codificar como miembro; cambia la pantalla, no los permisos.
- *(Miembro con distribución)* el indicador **N documento(s) tuyo(s)**.
- **cambiar proyecto** / **salir** (nube).
- **exportar ▾** (si hay documentos) e **importar ▾** (excepto para solo lectura).

**Barra de estado (pie)**
El estado del sistema se muestra en una barra fina:
- **✓ guardado HH:MM** (archivo/borrador), o estado de nube: `✓ nube al día`, `sin conexión` y **N cambios esperando envío**, pulsable para reintentar ([sección 16](#16-guardado-copias-de-seguridad-y-modos-de-almacenamiento)). Si falla el guardado local: **✕ sin guardar · descargar copia**, también pulsable.
- En borrador, **porcentaje de almacenamiento** (ámbar cerca del límite).
- **comandos** (Ctrl+K) y **atajos** (?).
- A la derecha, la **versión** en uso (p. ej., `v1.0.0`). **Indica ese número al informar de un problema**: el app se actualiza al recargar y es necesario saber qué versión cargó tu navegador. Los cambios están en [`CHANGELOG.md`](../CHANGELOG.md).
- Si ya se descargó una **versión nueva**, aparece `nueva versión disponible · recargar`; un clic la aplica.

Debajo del encabezado pueden aparecer **avisos**: recordatorio ámbar del borrador (con **Guardar como archivo** y **Conectar a la nube**), error rojo, resumen o progreso de importación, fallo al guardar y cambios rechazados por la nube ([sección 16](#16-guardado-copias-de-seguridad-y-modos-de-almacenamiento)).

**Paleta de comandos (Ctrl+K).** Abre una búsqueda para ir directamente a un **documento** (parte del nombre), una **pantalla** o una **acción** (descargar `.qualilab`, buscar en todos los documentos). Resulta especialmente útil con muchos documentos. **?** muestra los atajos ([sección 19](#19-atajos-de-teclado)).

> **La pantalla actual está en la dirección.** Cambiar de pestaña actualiza la URL, incluido el documento y la subpestaña. El botón **Atrás del navegador funciona** y puedes **compartir la dirección**: quien abra el mismo proyecto llegará a la misma pantalla y documento.

### Cambiar el tamaño de los paneles

**Arrastra el divisor** entre un panel lateral y el contenido para ajustar el ancho. **Doble clic** restaura el valor predeterminado. Con teclado, dale foco con **Tab** y usa **← →** para ajustar de 16 en 16 píxeles.

El ancho se aplica a **todas las pantallas del mismo tipo** y **persiste al recargar**, por navegador. Hay tres grupos:

| Panel | Dónde |
|---|---|
| Navegación y filtros (izquierda) | Lectura, Gráficos, Memos, Reconciliación, Informe |
| Panel de trabajo (derecha) | Codificación, Esquema |
| Configuración de IA (izquierda) | Pestañas de Autocodificación y Analizar con IA |

### Teclado y accesibilidad

- **Árboles de códigos** (Codificación, Esquema y Memos): **↑ ↓** recorren, **← →** cierran/abren, **Home/End** van a los extremos y **Enter** activa la fila (selecciona el código o lo aplica si hay un fragmento seleccionado). El foco tiene un anillo azul.
- **Diálogos**: el foco entra al abrirlos; **Tab/Shift+Tab** circulan dentro sin salir a la página; **Esc** cierra; el foco regresa al botón de origen.
- **Pantallas estrechas** (menos de ~720 px): aparece un aviso. Puedes **leer y consultar**, pero lector y paneles no caben cómodamente. En tablet, seleccionar texto por toque abre la barra flotante de códigos. Para trabajar, usa una computadora.

---

## 4. Documentos

### Subir archivos
En **Codificación**, arriba del lector, pulsa **＋ subir ▾ → subir archivo(s)…** y elige uno o varios `.txt`, `.md`, `.docx` o `.pdf`. Se extrae el texto y se muestra para leer.

- **PDF**: el *reflow* geométrico **detecta columnas**, **elimina encabezados, pies y números de página repetidos**, recompone párrafos y corrige palabras partidas por guiones al final de línea. No reconstruye tablas; los PDF **escaneados**, sin capa de texto, necesitan **OCR**.
- **DOCX**: convierte títulos, párrafos, listas (con sangría según nivel) y tablas en texto limpio. El formato enriquecido (negrita, color) no se reproduce como estilo en el lector; se conserva el contenido para codificar.

### Pegar texto
**＋ subir ▾ → pegar texto…** crea un documento a partir de texto copiado, sin archivo. En un proyecto vacío, **pegar texto…** aparece en el centro del lector.

### Cambiar de documento, renombrar y editar el texto
- El **botón con el nombre del documento** abre la lista: **filtra por nombre** (ignora acentos y mayúsculas), **ordena** por nombre u orden de importación y **agrupa** por una categoría ya completada. **↑ ↓** recorren, **Enter** abre, **Esc** cierra. El orden/agrupación queda guardado en este navegador para los siguientes proyectos.
  > El **orden de importación** puede parecer aleatorio: en un `.qdpx` corresponde al orden de entradas del paquete. Por eso la lista se muestra inicialmente **ordenada por nombre**.
- El menú **⋯**, a la derecha de la búsqueda, contiene **OCR**, **editar título y texto** y **eliminar documento**.
- **🗑 eliminar documento** elimina también todas sus codificaciones. No hay Ctrl+Z; con instantáneas automáticas activadas se guarda el proyecto antes de eliminar ([Instantáneas del proyecto](#instantáneas-del-proyecto-punto-de-restauración)). En nube colectiva requiere admin.
- **✏ editar título y texto** permite corregir el **título** y el **texto extraído**, útil para restos de pies de página, palabras unidas o saltos incorrectos. **Guardar** conserva ambos; **Cancelar** descarta.
- Al guardar, **los resaltados se reanclan automáticamente**. Si una codificación cae sobre texto modificado, el app avisa antes de guardar; esos resaltados pueden necesitar revisión.
- La edición sirve para **limpieza local**. Un documento completamente dañado (p. ej., PDF sin espacios) requiere OCR.
- En **nube colectiva**, solo el **admin** edita el texto, porque desplaza los resaltados de todos.

### Ver el PDF original y OCR (documentos escaneados)
Si el documento proviene de un **PDF**, **▤ original** alterna con **≡ texto** y muestra las páginas reales, con zoom y navegación. Los resaltados se dibujan con el color de cada código; seleccionar texto sobre la página permite codificar como en el lector de texto (clic derecho → menú de códigos).

Para un **PDF escaneado**, usa **◎ OCR: leer páginas escaneadas** en **⋯**. Reconstruye el texto página por página, aprovecha el texto nativo existente y usa OCR en las imágenes, localmente en el navegador, con progreso y cancelación. **▭ OCR de área**, en la vista original, permite dibujar un rectángulo; el texto reconocido aparece en un cuadro **editable** para corregirlo antes de aplicar y codificar. La primera ejecución descarga el modelo (~15 MB); tarda varios segundos por página.

> **Calidad de extracción.** Un documento vacío, sin espacios, con glifos dañados `�■□` o OCR de baja confianza recibe **⚠︎** en la lista (la ayuda explica el motivo) y un indicador ámbar **⚠︎ extracción** en el lector. **Revísalo y límpialo** con **✏ editar** o ejecuta **OCR** antes de codificar.

> **Números de página.** QualiLab conserva la correspondencia fragmento ↔ página del PDF: **p. N** acompaña al fragmento en **Lectura**, **Informe**, exportaciones **CSV/JSON** y anotaciones **W3C**. **▤ original** se abre en la página del fragmento seleccionado.

### Importar muchos documentos a la vez
Una hoja `.csv`/`.xlsx` crea **un documento por fila**; una **carpeta de Zotero**, uno por referencia con PDF adjunto. Consulta [Importar y exportar](#15-importar-y-exportar).

---

## 5. Codificación de fragmentos

La pantalla **Codificación** tiene el lector a la izquierda y tres pestañas a la derecha: **⍞ Categorías**, **✎ Codificar** (árbol de códigos) y **▤ Memos**.

### 5.1. Crear códigos
En **✎ Codificar** creas y organizas las etiquetas. Un código nuevo nace en **Jerarquía 0** y recibe fragmentos. Puedes crear subcódigos, renombrar y eliminar, o crear un código **al aplicarlo**.

**Cuándo se convierte en familia.** Al recibir su primer subcódigo. Si todavía no tenía fragmentos, no hace falta decidir nada. Si **ya los tenía**, QualiLab pregunta adónde moverlos, porque una familia no los recibe ([Conceptos](#código-y-familia-una-sola-regla)). Puedes:

- **marcar fragmento por fragmento** los que pertenecen al nuevo subcódigo;
- **no marcar ninguno**: todos irán a un subcódigo de pendientes llamado inicialmente `«Nombre» (general)`.

La segunda opción evita tener que clasificar decenas de fragmentos en medio de una lectura. `(general)` **registra lo pendiente**; puedes distribuirlo después en [Esquema ▸ Dividir en subcódigos](#72-códigos-reorganización-en-lote).

El **clic derecho sobre un código** abre **✎ Editar código** (nombre, color, saturación, censura) y **＋ Subcódigo aquí**. Así editas **sin salir de Codificación**: con texto seleccionado, el clic izquierdo *aplica* el código; el menú o los botones ✎ y ＋ del menú de aplicación permiten editar sin perder la selección.

**La definición del código.** Al seleccionarlo en ✎ Codificar, su memo (qué incluye y excluye) aparece debajo, de solo lectura. Para editarlo, usa ▤ Memos. Consulta la definición antes de seleccionar texto, porque con texto seleccionado el clic aplica el código.

> **Consejo de investigación.** Puedes construir los códigos a partir del material (**inducción**) o aplicar un esquema teórico previo (**deducción**). Ambas son válidas; reconoce cuál usas. Evita crear un código por frase: si una etiqueta aparece solo una vez, considera si es un tema o un detalle. Registra en un **[memo](#11-memos)** qué *incluye y excluye*: ese es tu **libro de códigos** (*codebook*), que mantiene la consistencia entre momentos y personas.

### 5.2. Aplicar un código a un fragmento

![Con texto seleccionado, el clic derecho abre el menú de códigos. Elige uno o Crear nuevo código. La franja azul confirma el fragmento seleccionado.](manual-img/03-codificacao-menu.png)

1. **Selecciona** texto con el mouse.
2. Al soltar, aparece una **barra flotante** con los códigos **recientes** y **aplicar código ▾**, que abre el menú completo. El **clic derecho** sobre la selección abre el mismo menú.
3. Haz clic en un código para aplicarlo. **buscar código...** filtra por la ruta completa; **↑ ↓** recorren y **Enter** aplica. También puedes pulsar el código en **✎ Codificar**.
   - **+ Crear nuevo código** permite escribir un nombre, elegir **(en la raíz)** o **dentro de «…»** y pulsar **Crear y aplicar**. Crear dentro de un código con fragmentos lo transforma en familia (5.1).
   - Con texto seleccionado, **1 a 5** aplican uno de los cinco códigos **recientes** de la sesión; la lista numerada está en ✎ Codificar.

> El resaltado toma el color del código. **Solo aparece una línea inferior cuando varios códigos se superponen**. Con uno solo, el texto queda teñido sin línea.

> **Minimapa.** Una columna fina en el borde derecho muestra **dónde están los resaltados** en todo el documento, con el color de cada código; las coincidencias de búsqueda aparecen en ámbar. Haz clic para saltar a una posición. Ayuda a reconocer lo trabajado y lo pendiente en documentos largos.

> **¿Ya tienes los extractos en una hoja?** Si hay una fila por documento, una columna por tema y una cita en cada celda, usa **importar ▾ → hoja de cálculo (.csv / .xlsx → codificar fragmentos)**. Cada extracto se localiza en el documento y se convierte en resaltado. Consulta [Codificar fragmentos en una hoja](#codificar-fragmentos-en-una-hoja-e-incorporarlos-al-proyecto-paso-a-paso).

### 5.3. Quitar un código de un fragmento
**No necesitas seleccionarlo otra vez**:
1. Haz **clic derecho sobre el resaltado**.
2. En **Quitar código** (para admins de colectivos, **Rechazar / quitar código**), elige el que deseas retirar.

En el mismo menú, **⇄ Cambiar código** sustituye el código sin repetir la selección, y **Anotar fragmento (nota analítica)** abre su nota. Atajo: pulsa el resaltado y **Delete**; aparece un aviso con **deshacer**.

> En nube colectiva solo puedes quitar codificaciones **tuyas**; el admin puede rechazar cualquiera. En un proyecto individual, todo se considera tuyo.

### 5.4. Deshacer (Ctrl+Z)
**Ctrl+Z** deshace la **última codificación aplicada** o eliminada con **Delete**, hasta las últimas 50 de la sesión. Funciona solo en Codificación y fuera de campos de texto. Eliminar documentos, categorías o códigos, fusionar y dividir no tienen Ctrl+Z; con instantáneas automáticas se guarda el proyecto antes y puedes restaurarlo ([Instantáneas](#instantáneas-del-proyecto-punto-de-restauración)).

### 5.5. Censura (enmascarar fragmentos sensibles)
El admin puede marcar un código como **censura** en [Esquema](#7-esquema). Sus fragmentos tienen un **recuadro cerrado** negro en el lector; el borde los distingue de un resaltado normal. Se exportan como `[trecho censurado]` en las **salidas de transparencia** ([Informe](#12-informe)) y en el material enviado a la **IA** ([sección 17](#17-codificar-y-analizar-con-ia)). Este marcador se conserva en portugués por compatibilidad entre artefactos.

**Dónde NO se aplica.** Los formatos de **trabajo y migración** (`.qualilab`, QDPX, QDC, CSV, JSON) se exportan **completos**, con los fragmentos censurados en claro. Permiten trasladar tu material a ATLAS.ti, MAXQDA o NVivo y recuperarlo; enmascararlos destruiría el original y el trabajo de censura. **exportar ▾** lo advierte en ámbar si hay censura. Para compartir fuera del equipo, usa **Informe**.

**Tampoco oculta tu pantalla.** El lector de trabajo muestra el texto completo para que puedas codificarlo. Recuérdalo al compartir computadora, proyectar la pantalla o autorizar a un asistente de IA a **verla**: por ese camino el material aparece íntegro. La máscara se aplica a los **artefactos** de Informe y al material **enviado** desde los paneles de IA.

**Protege lo marcado, no el término.** Marcar «Estudio Ejemplo Abogados» en un párrafo no protege sus otras menciones. **Repetir Codificación** ([Autocodificación](#172-autocodificación-cinco-asistentes-en-pestañas)) muestra otras apariciones **idénticas** para aprobarlas una a una. No encuentra **variantes**, como «Estudio Ejemplo» o «el estudio»: búscalas con [buscar +](#57-buscar-en-el-documento-y-en-todo-el-proyecto). Antes de publicar, consulta [12.4](#124-antes-de-publicar-trabaja-en-el-laboratorio-publica-desde-una-copia).

### 5.6. Controles de lectura
La barra del lector cambia **solo la lectura**, con preferencias guardadas en el navegador:
- **A- / A+**: tamaño de fuente.
- **⬌ / ⬍**: columna estrecha (~65 caracteres, predeterminada) o ancho completo.
- **◔ / ◗ / ◕**: tema claro / sepia / oscuro del lector, independiente de la interfaz.

### 5.7. Buscar (en el documento y en todo el proyecto)
Pulsa **🔍︎ buscar** y escribe un término. Las coincidencias se destacan sobre los resaltados; **‹ anterior / siguiente ›**, **Enter / Shift+Enter** recorren los resultados y vuelven al inicio al llegar al final.

El **+** junto a la lupa abre **buscar +** en **todos los documentos**. Los resultados se agrupan por documento, con contexto; pulsar uno abre el documento en esa posición con la búsqueda activa.

Ambas búsquedas comparten tres opciones:
- **Aa**: distingue mayúsculas. Desactivado, `réu` y `RÉU` coinciden; los acentos sí cuentan: `reu` no encuentra `réu`.
- **ab⃒**: solo **palabras completas**; por ejemplo, `reu` no encuentra `reunião` ni `ocorreu`.
- **`.*`**: interpreta una **expresión regular**. `\d+/\d{4}` encuentra `123/2020`; `réu|ré` busca ambas formas portuguesas. Sin esta opción, `.` y `(` se buscan literalmente. Un patrón inválido se avisa de inmediato.

> Las opciones se comparten: al abrir un resultado de **buscar +**, el lector conserva el patrón y las opciones.

#### Términos parecidos (≈ términos)

En **buscar +**, **≈ términos** ayuda cuando no sabes qué palabras usa tu material para una idea. Escribe una o dos palabras: muestra **términos del propio corpus** cercanos en significado y sus frecuencias.

Para «miedo a perder el empleo», puede sugerir **temor**, **despido**, **inseguridad**, que una búsqueda literal no encontraría a partir de la consulta.

Incluye **expresiones de hasta cinco palabras**: «crisis del Estado» puede recuperar **crisis de la democracia**, **crisis fiscal**, **Estado regulador**. Solo incluye expresiones repetidas, porque una secuencia única suele ser accidental.

**Pulsa las sugerencias útiles.** Se añaden a la búsqueda y sus resultados llevan `≈ palabra`, para reconocer su origen. Pulsar una coincidencia abre el documento con la palabra resaltada.

> **Por qué sugerir términos en vez de fragmentos directamente.** El modelo puede equivocarse, sobre todo con palabras raras o abstractas. Ver y descartar una sugerencia incorrecta cuesta menos que leer muchos fragmentos irrelevantes sin saber por qué aparecieron.

**La primera vez hay que leer el vocabulario**: el botón aparece al activar la opción. Descarga un modelo (~113 MB a ~220 MB según el navegador, una sola vez) y recorre el corpus con progreso y cancelación. Si añades o editas documentos, avisa del cambio y ofrece actualizarlo.

> **Nada sale de tu computadora.** El modelo y el vocabulario son locales, no usan servidor ni clave de API y funcionan sin conexión tras la primera descarga.

### 5.8. Filtro «Ver:» (de quién es lo que aparece)
**Ver:** determina **de quién** son los resaltados y respuestas visibles. Aparece en colectivos o si hay varios codificadores importados. En colectivo ofrece:
- **Individuales (todos)**: superpone todos los resaltados y los de referencia. Lo que apliques sigue siendo tuyo; cada campo de categoría muestra y edita **tu** respuesta, con las de colegas y referencia debajo, de solo lectura.
- **Mías**: solo tu trabajo; la referencia de categoría aparece debajo, de solo lectura.
- **(Nombre de cada investigador)**: trabajo de esa persona, de solo lectura.
- **Final / referencia**: capa consolidada, de solo lectura aquí; se edita en Reconciliación.

En un individual con varios autores importados, ofrece **Todos los codificadores** y cada autor. Con **codificación a ciegas**, el selector desaparece y se muestra el indicador correspondiente.

> **Por qué algunas vistas son de solo lectura.** Editar un valor de otra persona o de la referencia mientras se guarda con tu identidad mostraría un dato y cambiaría otro. En **Individuales (todos)** y **Mías**, el campo siempre es tuyo y es editable.

### 5.9. Filtro de código (solo los resaltados de un código)
**Ver:** elige *de quién*; el filtro de código elige *de qué códigos*. Pulsa el **embudo**, busca por nombre y **marca uno o varios**. Se muestran solo sus resaltados; seleccionar una **familia** incluye sus subcódigos. El número de cada código cuenta sus codificaciones **en el documento abierto**. La lista sigue abierta mientras seleccionas; ciérrala con **Listo**, **Esc** o un clic fuera.

- Con el filtro activo, el embudo se convierte en una **etiqueta** con color y nombre (o «2 códigos», etc.). Púlsala para cambiar; **limpiar** restaura todos. En Lectura también hay **✕** para limpiar directamente.
- El filtro se **comparte** entre Codificación y [Lectura ▸ Documentos](#9-lectura).
- Filtra también el **minimapa** y las opciones de **clic derecho**: no ofrece cambiar o quitar resaltados ocultos.
- **Puedes aplicar un código fuera del filtro**, pero el resaltado queda oculto; el app avisa y ofrece deshacer.
- No modifica el panel de códigos, la vista del PDF original ni **Fragmentos** en Lectura, que tiene su propio selector.

---

## 6. Categorías (atributos del documento)

En **Categorías**, a la derecha de Codificación, respondes los atributos del **documento abierto**.

### Los siete tipos
| Tipo | Cómo se completa |
|---|---|
| **Texto Cerrado** | Lista desplegable, elige **uno** |
| **Texto Abierto** | Campo libre |
| **Número** | Campo numérico: acepta `12,5` y guarda `12.5` |
| **Fecha** | DD / MM / AAAA, partes opcionales (puede ser solo el año) |
| **Sí/No** | Dos botones |
| **Opción Múltiple** | Botones, elige **uno** |
| **Casilla de Verificación** | Botones, elige **varios** |

> **Por qué Número y Sí/No son tipos.** El texto no se ordena ni suma como número y se exporta como texto a MAXQDA/NVivo. Número sale tipado en `.qdpx` (Integer o Float según los valores) y vuelve igual; Sí/No sale como Boolean. Un valor no numérico se rechaza y aparece rojo: así la columna conserva su tipo.

Cada categoría puede tener una **descripción/instrucción** y opciones especiales: **No informado** (todos los tipos) y **Otros** (tipos con lista, con valor libre).

Pulsa su nombre para **contraerla**: sigue mostrando el valor o «—». Si no respondiste y existe referencia, muestra esta **en cursiva**; tu campo permanece vacío.

> **La descripción es la instrucción de codificación.** Acepta varias líneas y conserva sus saltos. Incluye definición, criterios de cada valor, fronteras, desempates y qué ignorar. Es **el mismo texto para ambos evaluadores**: el humano lo lee y la IA lo recibe en el prompt. Si ya respondiste algunos documentos, [Definir Categoría](#1723-definir-categoría-escribir-la-instrucción-a-partir-de-tus-respuestas) puede proponer una definición a partir de esas respuestas.

> **Consejo.** Crea categorías que vayas a **comparar o contar** (año, tribunal, perfil). Alimentan los filtros y [Gráficos](#10-gráficos). Piensa en las **columnas** de una hoja que querrías cruzar con los temas, que son los códigos.

### Quién define y quién completa
- **Definir el esquema**: admin, en **Gestionar esquema de categorías** o **Esquema → Categorías**.
- **Completar**: quien puede codificar según la [matriz del proyecto](#qué-puede-hacer-cada-rol-se-decide-al-crear) responde **su** versión; solo lectura no completa; el admin define la **referencia**.
- La respuesta visible depende de **Ver:**; la de otra persona es de solo lectura.

---

## 7. Esquema

![Esquema, subpestaña Códigos: árbol jerárquico reordenable con ⠿. Seleccionar dos o más casillas habilita Agrupar y Fusionar.](manual-img/04-esquema.png)

**Esquema** ocupa toda la pantalla, sin documento abierto, para organizar el conjunto. Tiene dos subpestañas.

### 7.1. Categorías

![Esquema, Categorías: tarjetas con nombre, tipo, descripción multilínea, valores y opciones especiales. Si hay cambios pendientes aparecen descartar y Guardar; sin cambios, Guardado ✓.](manual-img/04b-esquema-categorias.png)

Permite crear, editar tipos y opciones y **reordenar arrastrando ⠿**. La tarjeta arrastrada queda translúcida y una línea azul indica el destino.

**El nombre y la descripción solo se aplican al pulsar Guardar.** Si hay cambios, el botón se destaca y aparece **descartar**, que restaura ambos campos; si no, muestra **Guardado ✓**. La descripción orienta al equipo y la IA, por lo que un cambio accidental no debe alterar el esquema. El borrador se conserva al cambiar de pantalla y volver; el panel contraído indica si hay cambios pendientes. Tipo, valores y opciones **No informado/Otros** se aplican inmediatamente.

El campo de descripción es **redimensionable**: arrastra su esquina inferior derecha.

### 7.2. Códigos (reorganización en lote)
Pensado para organizar **cientos de códigos sueltos** tras una codificación abierta. El panel derecho depende de la selección en el árbol:

- **Clic en una fila** (no en la casilla): editar nombre y, para admins, color/censura de la familia raíz; **Promover a Jerarquía 0** si es subcódigo; **Conexiones**; **⑃ Dividir en subcódigos** si tiene fragmentos.
- **Marcar dos o más casillas**:
  - **Agrupar**: los seleccionados pasan a ser **hijos** de un código existente o nuevo. Permanecen separados y adoptan el color del padre. Si el padre tiene fragmentos, se pregunta dónde colocarlos antes de convertirlo en familia.
  - **Fusionar**: elige un **sobreviviente** (se sugiere el más frecuente); se le **reasignan** las codificaciones y se eliminan los otros. **Solo admins**. No hay Ctrl+Z; se confirma antes y, con instantáneas automáticas, se guarda el estado previo. Los hijos se conservan bajo el sobreviviente.
- **Reordenar hermanos**: arrastra **⠿** dentro del mismo padre; para cambiar de padre, usa **Agrupar**.

#### Dividir un código en subcódigos

Sirve para un código **demasiado amplio**: distribuye sus fragmentos entre varios subcódigos nuevos de una vez.

Selecciona el código y pulsa **⑃ Dividir en subcódigos**. Encontrarás:

1. **Subcódigos nuevos**, uno por línea, tantos como quieras.
2. **Tabla** con un fragmento por fila y un subcódigo por columna. Un fragmento puede ir a **varios**: el primero conserva el original y su nota; los demás reciben copias.
3. **1 a 9** marcan la columna en la fila activa; **↑↓** recorren filas.
4. **Mutuamente exclusivo** limita cada fragmento a un subcódigo. Úsalo si calculas **concordancia entre codificadores**, cuyo coeficiente presupone exclusividad dentro de un dominio.
5. Lo **no marcado** va a `(general)`, cuyo nombre puedes cambiar.

El código se convierte en familia, sin fragmentos propios, y muestra la suma de sus hijos. **Requiere admin**, porque mueve codificaciones de todos.

> **Nota metodológica.** Dividir «Ganancias de productividad» en «Aceleración de investigación» y «Automatización de tareas» registra una interpretación del material. Escribe en el **memo** de cada subcódigo sus criterios de inclusión y exclusión mientras estén claros.

### 7.3. Ver los códigos como Mapa (pizarra espacial)

![Mapa de códigos: burbujas cuyo tamaño refleja el uso y cuyo color viene de la familia; las líneas unen padres e hijos. El diseño se guarda con el proyecto.](manual-img/13-mapa.png)

**⛼ Árbol / ⊞ Mapa** cambia la lista por una **pizarra espacial** de burbujas (tamaño por número de fragmentos, color de familia) y líneas jerárquicas. Permite ver y reorganizar el mismo esquema.

- **Arrastra** burbujas; la disposición **se guarda**. **⤢ ajustar** encuadra todo; **↻ redistribuir** recalcula posiciones y sobrescribe la disposición; **☑ líneas** muestra/oculta la jerarquía.
- **Seleccionar**: clic; **Ctrl+clic** o **lazo ▚** sobre el vacío para varias. **✜** desplaza la vista; la **rueda** hace zoom.
- El **clic derecho** usa la burbuja como **destino**: crear subcódigo, **mover** la selección dentro, **fusionarla** allí (el destino sobrevive), **promover**, **agrupar** bajo un padre nuevo o **eliminar**. Son las mismas operaciones y protecciones del Árbol.

### 7.4. Colores y censura (admin)
El admin puede:
- Elegir el **color de familia** mediante **matiz** (0–359), **saturación** o **negro**, propagado a los subcódigos.
- Marcar **censura**, que fuerza el negro ([5.5](#55-censura-enmascarar-fragmentos-sensibles)).

**La censura acompaña la posición en el árbol.** Un subcódigo creado, movido o agrupado dentro de una familia censurada queda censurado junto con sus descendientes. QualiLab avisa cuántos códigos y fragmentos se enmascararán; en colectivo requiere admin. Sacarlo de la familia **no** elimina la censura: hay que desmarcarla expresamente en el código. Si **fusionas** un código censurado en uno normal, sus fragmentos dejan de enmascararse; se advierte y se pide confirmación.

> El panel de Códigos de **Codificación** sigue existiendo. La reorganización masiva se concentra en Esquema.

### 7.5. Conexiones: relacionar códigos entre sí
La codificación crea **conjuntos** de fragmentos. Una conexión registra una afirmación **entre** conjuntos: *Activismo judicial* **contradice** *Deferencia al legislador*; *Daño moral colectivo* **es parte de** *Responsabilidad civil*; *Fundamentación económica* **está asociada a** la categoría *Resultado del juicio*.

**Dónde.** Con un código seleccionado, **Conexiones** aparece bajo su editor. Para categorías está dentro de su tarjeta en **Esquema ▸ Categorías**, contraída; allí solo la ve el admin.

**Crear.** Pulsa **+ conectar** y elige la **relación**, el **otro extremo** (código o categoría) y, opcionalmente, un **comentario**. Se registra tu nombre.

**Evidencia opcional.** Si el código de origen tiene fragmentos, puedes elegir **uno como evidencia**. La lista muestra los primeros; para citar otro, usa el comentario. El anclaje se conserva en `.qualilab`, pero no cabe en `.qdpx`, como advierte la exportación.

**Leer la lista.** Las flechas se interpretan desde el elemento actual:

| Flecha | Significado |
|---|---|
| `→` | Desde aquí hacia el otro |
| `←` | Desde el otro hacia aquí |
| `↔` | En ambos sentidos |
| `·` | Sin dirección (asociación) |

**Las relaciones son el vocabulario del estudio.** Hay seis iniciales: *está asociado a*, *es parte de*, *es causa de*, *contradice*, *es un(a)*, *es propiedad de*. Puedes crear otras con **nueva relación…**, darles nombre (*depende de*, *precede*, *justifica*) y definir si tienen una dirección, ambas o ninguna. En **gestionar relaciones…**, debajo de **+ conectar**, el admin renombra (afecta a todas las conexiones; rechaza nombres repetidos) o elimina relaciones sin uso. Las seis iniciales aparecen siempre en el selector; se incorporan a la lista guardada al primer uso. Sus nombres canónicos pueden conservar el idioma del proyecto original.

> ⚠️ **Una conexión es una anotación, no una medida.** Registra lo que **tú** observas o supones, con tu nombre; no cuenta ni prueba asociación. **Coocurrencia** y **Código × atributo** en [Gráficos](#10-gráficos) miden patrones. La divergencia entre tu afirmación y los datos puede ser un hallazgo.

**Límites.** Un código no se conecta consigo mismo; una conexión no se duplica (sin dirección, A→B y B→A son equivalentes). Los **códigos de censura no pueden conectarse**: ocultan información y no son categorías analíticas.

**Al modificar el esquema.** Eliminar un código o categoría elimina sus conexiones, con aviso del número. **Fusionar** las traslada al sobreviviente, descartando duplicados o autorrelaciones; se informa cuántas.

**Permisos.** Todos los integrantes leen las conexiones de código. Crear y eliminar sigue el permiso de **crear y editar códigos** ([13](#13-colaboración)). Renombrar/eliminar una **relación** requiere admin.

**Archivos.** `.qualilab` conserva las conexiones completas. `.qdpx` las exporta como `<Link>` de REFI-QDA y también se leen las de otras herramientas. Quedan fuera la evidencia vinculada a una conexión (el estándar no ofrece ese anclaje) y, al importar, las conexiones **entre fragmentos**, aún no implementadas; el aviso lo explica.

---

## 8. Reconciliación

![Reconciliación, pestaña Códigos: cada grupo reúne codificaciones superpuestas de un código, con su ruta, autoría y fragmento. Los grupos consolidados permiten quitar del final; los pendientes ofrecen Consolidar en final.](manual-img/14-reconciliacao.png)

*Solo en proyectos colectivos y fuera de la codificación a ciegas. En un individual, continúa en la [sección 9](#9-lectura).* Aquí el equipo consolida la **referencia** a partir del trabajo individual. La columna izquierda tiene **Categorías** y **Códigos**; cada sección incluye listas contraíbles de **Documentos** (uno o **Todos los documentos**) y **Categorías/Códigos** (uno en todos los documentos). Empiezan contraídas y muestran la selección junto al título. Elegir un elemento abre su sección.

**Categorías.** Para cada documento y categoría se ve la **Referencia**, definida por el admin, y las respuestas individuales con **✓** (igual), **✗** (diferente) o **·** (sin referencia). Sin referencia, se indica si las respuestas **coinciden** o **divergen**; los campos vacíos no cuentan. **Tu respuesta** permite a cada codificador registrar o cambiar la suya sin modificar la referencia. En Todos los documentos se elige una categoría y se consolida documento por documento.

**Códigos.** Cada **grupo** reúne las codificaciones **superpuestas** del mismo código. **N de M · consenso** indica cuántos codificadores lo marcaron; si todos coinciden, la tarjeta se destaca. **Consolidar en la final →** pasa el grupo a la capa final; si ya está, puedes **quitarlo del final**.

- **De acuerdo** registra que **tú** aplicarías ese código al fragmento. Crea una codificación en tu **capa individual**, sin modificar la referencia: cualquier persona con permiso para codificar puede hacerlo, mientras que consolidar corresponde al admin. El conteo cambia de inmediato y **deshacer** quita el acuerdo. Si ya tienes una codificación, aparece **codificación tuya**.
  - Se guarda **marcada como acuerdo**, distinta de la codificación independiente: aquí decides **viendo las respuestas ajenas**. Sirve para reconciliar, pero no equivale a dos codificaciones independientes. **Deshacer** elimina solo el acuerdo, nunca tu trabajo original.
  - El mismo gesto está en el **clic derecho** de [Lectura ▸ Documentos](#9-lectura); guarda el fragmento del grupo y Reconciliación lo reconoce.
- **Discrepo** registra que el código **no** corresponde, sin borrar codificaciones. Está junto al acuerdo y en Lectura; ambos guardan el mismo veredicto. Aparece **✗ discrepas**, con **deshacer**, y se muestra **quiénes discrepan**. No se señala consenso mientras haya desacuerdos: «2 de 3» deja de ocultar si la tercera persona rechazó el código o todavía no lo revisó.
- **Consolidar en lote** (admin): **Consolidar todo lo hecho por mí (N)** y **Consolidar todo (N)** actúan sobre los grupos pendientes del documento, o del proyecto en Todos los documentos; si se eligió un código, solo sobre él. Es irreversible y requiere confirmación.
- **Desde el lector**: el admin puede usar **clic derecho → Aceptar en la referencia** en Codificación.

La capa **Final** resultante se usa en informes y gráficos al elegir la referencia.

---

## 9. Lectura

Permite **releer lo codificado**, desde el material o desde el esquema, en **▤ Documentos** y **✎ Fragmentos**. Abre inicialmente en Documentos; un clic en [Gráficos](#10-gráficos) abre los Fragmentos del código elegido. [**Ver:**](#58-filtro-ver-de-quién-es-lo-que-aparece) se aplica a ambos modos.

> Hasta la versión 1.4.6 se llamaba **Visualización**. Se renombró para distinguirla de Gráficos y reflejar su función de lectura.

### ▤ Documentos — lectura del material

![Lectura, Documentos: corpus agrupado por categoría a la izquierda, con conteos; a la derecha, el documento completo con resaltados.](manual-img/05b-visualizacao-documentos.png)

Elige un documento para leerlo **completo**, con los resaltados en contexto. Es la lectura que el [Informe Interactivo](#12-informe) ofrece al evaluar la investigación, disponible mientras trabajas.

- **Pasar el mouse** muestra código, autor y comienzo de la nota; **hacer clic** abre una franja con ruta, capa y **nota analítica**, más un enlace a Codificación.
- **resaltados** permite ocultarlos todos para leer el texto limpio.
- **código** (embudo) muestra solo los de **uno o varios códigos**, mediante el [filtro compartido](#59-filtro-de-código-solo-los-resaltados-de-un-código). Los conteos de la lista también se limitan a esos códigos y muestran en qué documentos aparecen.
- La lista permite filtrar, ordenar y agrupar, y muestra el **número de fragmentos**, útil para identificar documentos pendientes. Agrupar por categoría ofrece una primera organización similar a carpetas.
- Al entrar se muestra el documento de Codificación; elegir otro aquí no lo cambia allí. **codificar →** abre el documento actual en Codificación.

Aquí no se aplica un código seleccionando texto. En **colectivos**, la excepción es **emitir un veredicto** sobre codificaciones ajenas. El **clic derecho** ofrece:

- **De acuerdo**: igual que en [Reconciliación](#8-reconciliación), crea tu codificación individual sobre el fragmento del grupo.
- **Discrepo**: registra que el código no corresponde. No borra nada ni se incluye en conteos, gráficos o exportaciones de codificación; es un registro aparte que viaja en `.qualilab`.

Tras decidir, aparece el veredicto con **deshacer**; para cambiarlo, deshaz primero. Si ya hay codificación tuya, se indica y no se ofrece votar. Estos gestos no aparecen en individuales, a ciegas ni para quien no puede codificar según la [matriz de roles](#qué-puede-hacer-cada-rol-se-decide-al-crear).

**Para revisar un documento completo**, la barra cuenta los resaltados ajenos con y sin tu veredicto (p. ej., «97 de 113 · faltan 16»). **siguiente pendiente ↓** lleva al próximo y abre su nota. Los revisados se atenúan; los pendientes conservan su color. Se respetan **Ver:** y el [filtro de código](#59-filtro-de-código-solo-los-resaltados-de-un-código). Para las demás operaciones, usa Codificación.

### ✎ Fragmentos — lectura del esquema

![Lectura, Fragmentos: filtros y árbol de códigos con conteos a la izquierda; fragmentos del código elegido, agrupados por documento y con autoría y capa, a la derecha.](manual-img/05-visualizacao.png)

Elige un código para leer **todos sus fragmentos en el proyecto**, agrupados por documento. Responde a «¿qué llamé X?».

> **Dos conteos, dos preguntas.** En colectivos, el mismo texto puede tener marcas de varias personas y de la referencia. El encabezado cuenta **fragmentos** distintos y, si hay varias marcas, también **codificaciones**: «2 fragmentos · 6 codificaciones». El árbol y Gráficos cuentan codificaciones. Fragmentos con límites diferentes cuentan por separado.

Funciones:
- **Fragmentos idénticos, una tarjeta**: el mismo texto y código se muestra una vez, con una **etiqueta por autor**. Cada una tiene **×** para eliminar esa marca específica.
- **Nota analítica (●)**: pulsa el punto de una etiqueta para **leer la nota allí**. Se escribe desde el clic derecho de Codificación o desde Memos.
- **Abrir en el documento**: pulsa el texto o el nombre del documento para abrir Documentos y desplazarte al resaltado, que parpadea; además, todo el fragmento recibe un **subrayado ondulado** que muestra dónde empieza y dónde termina, incluso cuando otros códigos lo parten por dentro, y desaparece junto con el parpadeo. Desde allí, **abrir en Codificación →**. Si desactivaste **resaltados**, se abre al principio.
- **Filtro por categoría**: limita documentos por atributos.
- **Coocurrencia con:** muestra solo superposiciones con otro código (o dos más mediante **y también…**).
- **Aceptar en la referencia** *(admin, colectivo)* consolida directamente en la capa final.

---

## 10. Gráficos

![Gráficos, Frecuencia: usos de cada código, filtros e Ignorar censura a la izquierda; otras pestañas y exportación SVG/PNG arriba.](manual-img/06-graficos.png)

**Gráficos** ofrece filtros a la izquierda y un gráfico a la derecha. Todos se dibujan en SVG, sin bibliotecas, y se **exportan en SVG o PNG**.

### Pestañas disponibles
| Pestaña | Qué muestra |
|---|---|
| **Frecuencia** | Cuántas veces se usó cada código |
| **Nube** | Palabras de fragmentos codificados, con el color del código predominante |
| **Coocurrencia** | Matriz de pares de códigos superpuestos |
| **Cobertura** | Porcentaje del corpus cubierto por cada código |
| **Código × atributo** | Cruce con una categoría, como mapa de calor |
| **Tiempo** | Distribución temporal, si hay categoría de fecha |
| **Codificadores** | Producción y concordancia, solo en colectivos |

### Filtros (columna izquierda)
- **Por categoría**: limita **todos** los gráficos («X de Y documentos en el filtro»).
- **Ignorar censura**: activado de forma predeterminada; excluye fragmentos de códigos censurados.
- **Texturas en las barras**: añade tramas para distinguir colores; útil para daltonismo. Se conserva al exportar SVG/PNG.
- **Nube**: el árbol selecciona códigos y subárboles de donde obtener palabras; debajo está la lista de **palabras ignoradas**.
- **Coocurrencia**: selectores de ejes **X** (columnas) e **Y** (filas); vacío = los 12 más frecuentes.

Arriba están **Ver:** y **Top:** (10/25/50/Todos; en Nube, **Palabras:**).

> **Del gráfico al texto.** Pulsa una **barra** (Frecuencia, Cobertura, Concordancia) o **celda** (Coocurrencia, Código × atributo) para abrir Lectura en ese código. Se conservan los filtros de categorías y **Ver:**, de modo que los fragmentos correspondan al conteo.

### Palabras ignoradas en la nube

![Nube de palabras: tamaño proporcional a la frecuencia y color del código predominante. A la izquierda, palabras ignoradas, campo para añadirlas, limpiar lista y Usar la lista estándar (portugués).](manual-img/06b-graficos-nuvem.png)

La lista incorporada descarta palabras funcionales **del portugués** (*que*, *para*, *com*...). En una entrevista pueden dominar «entrevistado», «investigador», «moderador» o nombres. **Palabras ignoradas** permite quitarlas:

- **Pulsa una palabra de la nube** para añadirla; **✕** la devuelve al conteo.
- **Termina con `*`** para incluir variantes: `entrevistad*` cubre *entrevistado*, *entrevistada*, *entrevistados*. No hay lematización: se cuentan formas.
- La lista **pertenece al proyecto**, viaja en `.qualilab` y se comparte con el equipo.
- Puedes desactivar **Usar la lista estándar (portugués)** para corpus en otro idioma o estudios de palabras funcionales. El idioma de la interfaz no cambia esta lista; para un corpus español, añade las exclusiones que requiera tu estudio.

Solo cambia lo que la nube cuenta y dibuja; **no modifica codificaciones**.

---

## 11. Memos

![Memos: destinos de las notas a la izquierda; memo del proyecto en edición, con guardado automático, a la derecha.](manual-img/07-memos.png)

**Memos** guarda **notas analíticas** de texto libre vinculadas a elementos del proyecto, compartidas y con guardado automático. Aquí registras el sentido de un código, hipótesis o dudas. Escribir memos desde el comienzo y con frecuencia ayuda a desarrollar la interpretación. La navegación ofrece:

- **Memo del proyecto**: nota general, como borrador libre (consulta la distinción con IA abajo).
- **Documentos**: una nota por documento.
- **Códigos**: una nota por código (definición, reglas de aplicación).
- **Fragmentos anotados**: nota de un **resaltado** específico, creada con **clic derecho → Anotar fragmento (nota analítica)** o aquí. En colectivo es **compartida**: puedes anotar cualquier resaltado visible y el equipo lee/edita la misma nota. A ciegas no ves resaltados ni notas ajenos. El resaltado no recibe marca especial en el lector; la nota aparece al pasar el mouse, al pulsarlo en Lectura ▸ Documentos, en esta sección y en el [Informe Interactivo](#121-informe-interactivo-ati).

En el [Informe Interactivo (ATI)](#121-informe-interactivo-ati), la **nota del fragmento** aparece al pulsar el resaltado y la **nota del código** en la leyenda jerárquica.

**Secciones de IA.** **Memo para la IA** y **Prompts guardados** desaparecen con IA desactivada; **Conversaciones guardadas** y **Memoria del proyecto** permanecen como registro.

- **Memo para la IA**: contexto escrito **para la IA**, incluido de forma predeterminada. El *Memo del proyecto* común **ya no se envía automáticamente**: si quieres comunicar el objetivo de investigación, escríbelo aquí.
- **Prompts guardados**: biblioteca creada en [Analizar con IA](#173-analizar-con-ia-lectura-asistida-del-material); permite abrir, renombrar y eliminar.
- **Conversaciones guardadas**: conversaciones de [Analizar con IA](#173-analizar-con-ia-lectura-asistida-del-material), abiertas completas al pulsarlas.
- **Memoria del proyecto**: diario de ideas de IA, con hechos/decisiones breves usados entre sesiones; añades entradas manualmente o apruebas sugerencias y activas/desactivas cuáles usar.

### 11.1. Historial del proyecto (registro de auditoría)

La última entrada, fuera de IA, es **Historial del proyecto**. Enumera los cambios de más reciente a más antiguo, con fecha y autor: importaciones y combinaciones de archivos; fusiones/divisiones de códigos; eliminaciones de documentos, códigos, categorías o contenido; edición de texto y reanclaje; aplicaciones en lote de Repetir Codificación e IA; consolidaciones; cambios de tipo/configuración; creación/restauración de instantáneas; renombrado; entradas, salidas y cambios de rol en nube; y exportaciones. Hay **filtro por operación**, **búsqueda por texto** y **Exportar CSV** de la lista completa, con descripción y detalle JSON.

El historial **no deshace**, **no guarda contenido eliminado** (solo nombres y conteos, sin fragmentos del corpus) ni registra lectura/navegación. Las codificaciones individuales ya tienen autor y fecha propios y no se duplican en él.

**Viaja en `.qualilab`**, **sobrevive a Vaciar contenido** y no se duplica al reimportar. En nube es **solo de adición**: ni el admin puede editar o borrar filas mediante la API. Respeta la [codificación a ciegas](#13-colaboración): cada investigador ve sus eventos y los del equipo; el admin ve todos. Empieza con el primer evento registrado después de 1.4.51; la primera línea avisa que no se registró lo anterior. Su resumen aparece en [Informe](#126-historial-del-proceso).

---

## 12. Informe

![Informe: salidas Interactivo/ATI, Estándar y Web Annotation/W3C, y ocultar autoría a la izquierda; vista previa interactiva a la derecha.](manual-img/08-relatorio.png)

**Informe** reúne tres salidas de publicación. En colectivo, el Estándar sigue **Ver:**; ATI y W3C usan la referencia cuando existe y, si no, las capas individuales. Todas enmascaran la **censura**. ATI y W3C ofrecen **Ocultar autoría (revisión a ciegas)** para omitir nombres de codificadores. *Eso no anonimiza el contenido: consulta [Datos sensibles](#datos-sensibles-y-responsabilidad).*

### 12.1. Informe Interactivo (ATI)
Una **página HTML autónoma**, sin servidor, con documentos y resaltados pulsables. Un **resaltado** abre la **nota del fragmento** en un panel lateral ([sección 11](#11-memos)); si no tiene, indica «sin nota». Los **títulos de documentos** y **códigos de la leyenda** abren sus memos. La **leyenda jerárquica**, igual que [Esquema](#7-esquema), se puede contraer y filtrar; los documentos aparecen contraídos. Equivale a la capa de **Annotation for Transparent Inquiry (ATI)** del QDR, pero puedes alojarla tú, por ejemplo en GitHub Pages o como adjunto en Dataverse.

### 12.2. Informe Estándar
Selecciona secciones y el informe se construye en vivo: resumen, documentos, conteos/listas del esquema, frecuencia, distribución por categoría, fragmentos por código y códigos no utilizados. Después puedes:
- **Copiar texto** para Word/Google Docs.
- **Imprimir / PDF**, con tinta oscura sobre blanco incluso en tema oscuro.
- Incluir **crédito a QualiLab** en el resumen.

### 12.3. Web Annotation (W3C)
Exporta en **[W3C Web Annotation Data Model](https://www.w3.org/TR/annotation-model/)** (JSON-LD): una anotación por fragmento con selector de posición/cita y nota analítica. Es un formato compartido por ATI, [hypothes.is](https://web.hypothes.is/), Anno-REP y Dataverse, sin depender de una herramienta.

### 12.4. Antes de publicar: trabaja en el laboratorio, publica desde una copia

Este flujo atiende un problema que ninguna herramienta resuelve por sí sola.

**El problema.** La censura protege **lo marcado dentro del texto**. No modifica tres elementos que pueden viajar en las salidas, incluso ATI y W3C:

- **título del documento**, usado como encabezado;
- **valores de categoría**, como cargo, ciudad, estudio u organismo;
- **memos**, donde pueden quedar nombres propios.

Por ejemplo, el texto puede ocultar un nombre mientras el título conserva «ENT-01 — Persona Ejemplo, socia fundadora (Estudio Ejemplo, ciudad)». La máscara del cuerpo no resuelve esa exposición.

**El flujo.** Mantén **dos proyectos**:

1. El **laboratorio**, donde trabajas con el material original y sus identificadores.
2. La **copia de publicación**, destinada a salir del equipo.

Para crearla, **exportar ▾ → .qualilab**, crea otro proyecto (nube: **cambiar proyecto → Crear proyecto**; archivo: indicador del proyecto → **Salir de este archivo → Nuevo en archivo**) e **importa el .qualilab**. Limpia la copia:

- **Renombra documentos** con etiquetas sin identidad (`ENT-01`, `GF-02`); la correspondencia con personas queda **fuera** de QualiLab.
- Revisa **categorías** y sustituye datos identificables por los niveles de generalidad apropiados para tu estudio.
- Relee **memos** para detectar nombres.
- Comprueba toda la **censura** del cuerpo.

Exporta desde **Informe**. Las vistas previas de ATI y W3C son **en vivo** y reflejan lo que sale; úsalas para la revisión final.

**Por qué una copia.** Un «modo publicación» necesitaría versiones originales/publicables de cada título, valor y memo y exportaría una transformación menos visible. Su correspondencia sería además un dato muy sensible. Con una copia, **lo que ves es lo que sale**.

> **Prevenir cuesta menos.** Nombrar documentos `ENT-01` **desde el principio** evita limpiarlos después. No hay renombrado masivo: hay que corregir cada título.

QualiLab **no anonimiza** automáticamente: enmascara lo marcado en transparencia y en envíos a IA. Las demás decisiones metodológicas se aplican a la copia de publicación.

### 12.5. Declaración sobre uso de IA

**Incluir información sobre uso de IA** está **activado de forma predeterminada** para las tres salidas. Añade un bloque con **lo registrado por el proyecto**.

El bloque distingue:

- Si los recursos de IA **estuvieron disponibles** y, si hoy están restringidos, para quién.
- **Cuántas conversaciones y memorias de IA** hay registradas.

Activar IA sin usarla se describe como disponibilidad sin conversaciones, no como uso. Un proyecto que nunca la activó lo declara así, sin inventar una fecha ni prometer ausencia de uso externo.

El bloque expresa su límite: describe **lo que pasó por QualiLab**, sin garantizar que nadie haya llevado material a otra herramienta.

Al desmarcarlo, no se incluye y el app no insiste. Omitir una declaración cuando hubo uso es una decisión de quien informa la investigación; la herramienta facilita la transparencia por defecto.

Para desactivar la IA del proyecto, consulta [17.7](#177-desactivar-la-ia-en-este-proyecto).

### 12.6. Historial del proceso

**Incluir el historial del proceso** también está **activado por defecto**. Las tres salidas reciben un resumen del [historial](#111-historial-del-proyecto-registro-de-auditoría): cuántas operaciones, desde cuándo y de qué tipos, incluidas aplicaciones masivas y cuántas fueron por IA. Permite entender **cómo** se llegó al estado publicado.

Declara sus límites: registra operaciones de QualiLab, no lectura/navegación ni contenido eliminado. Puedes omitirlo desmarcando la casilla.

### 12.7. Diseño del estudio

Si se declara que **las categorías son metadatos del diseño** ([codificación a ciegas](#13-colaboración)), las tres salidas incorporan **Diseño del estudio**: explica que la referencia de categorías fue visible bajo ciego, mientras la de fragmentos permaneció oculta, y si el ciego está activo al generar el informe. **No se puede ocultar ese bloque**: el método debe describir el diseño realmente aplicado. Con la opción de metadatos desactivada, el bloque no existe.

---

## 13. Colaboración

*(Proyecto colectivo, modo nube.)*

### Invitar personas
Abre el **indicador del proyecto** y comparte el **código de acceso**. Se usa en **Mis proyectos → Entrar con código**. También aparece en el indicador (`nube · Proyecto · CÓDIGO · colectivo ▾`). Quien entra con él recibe siempre el rol de **miembro**.

#### Invitación con rol fijo
*(Solo admin, nube.)* Para incorporar a alguien como **admin** o **solo lectura**, usa **Invitación con rol fijo** debajo del código de acceso. Elige el rol, pulsa **Generar invitación** y comparte el código; el rol se asigna al entrar.

- **Correo opcional**: restringe el código a esa cuenta. Otra cuenta recibe «código inválido» sin revelar el destinatario.
- La tarjeta muestra los permisos del rol, derivados de la [matriz](#qué-puede-hacer-cada-rol-se-decide-al-crear); son los mismos incluidos en el mensaje.
- **QualiLab no envía correos de invitación.** Tú compartes el código. **abrir correo** prepara un mensaje con código y rol en **tu programa de correo**; no lo envía por el servidor.
- Por defecto es de **un solo uso**. **Reutilizable** permite varias personas con el mismo rol.
- La lista muestra rol, destinatario y usos. **Revocar** invalida el código para quienes aún no entraron.

### Gestionar miembros y proyecto
Desde el indicador, el admin puede consultar miembros, cambiar roles (**admin**, **miembro**, **solo lectura**, conservando siempre un admin), **renombrar**, **vaciar contenido**, **eliminar** el proyecto, cambiar su **tipo** y ajustar la **conexión Supabase**.

### Qué puede hacer cada rol (se decide al crear)
Al crear un colectivo en nube, el formulario solicita el **tipo de estudio** y ofrece una matriz con dos partes. **Roles** define si miembros y solo lectura pueden comentar, codificar/responder categorías, añadir documentos, crear/editar códigos, editar sus definiciones y usar IA; marcado significa permitido. Admins pueden todo. **Diseño del estudio** activa codificación a ciegas, distribución restrictiva y categorías como metadatos. Los cuatro tipos (**equipo abierto**, **confiabilidad entre codificadores**, **dividir el corpus**, **panel de jueces**) rellenan la matriz, que sigue siendo editable. Debajo aparecen contraídas las facultades reservadas a administración: esquema, referencia, eliminaciones, importación, equipo e instantáneas.

Se decide al crear porque **lo ya visto no puede dejar de haberse visto**: activar el ciego después de un comienzo abierto no revierte la exposición. Así, la invitación incorpora reglas ya vigentes. Cada línea se aplica en el **servidor**, no solo ocultando botones. Puedes cambiarla después en **Distribución y confidencialidad → Distribuir documentos… → Cómo controla el acceso este proyecto**; queda registrado en el historial. Sin cambios, el miembro tiene los permisos habituales y solo lectura lee/comenta.

Desmarcar **Edita la definición de los códigos** para ambos roles deja la definición bajo control exclusivo del admin; sigue siendo legible y aparece el indicador **definición bloqueada**. Activar/desactivar queda en el historial. **Usa los paneles de IA** está inhabilitado si el proyecto no permite IA o la restringe a admins.

### Distribuir documentos y codificación a ciegas
*(Solo admin, colectivo en nube.)* **Distribución y confidencialidad → Distribuir documentos…** abre la matriz **documentos × investigadores**. Marca quién trabaja cada documento; **C** indica quién **ya codificó**. La **asignación automática por turnos** distribuye con una o más personas por documento. La matriz sola es un **plan**; se vuelve restrictiva mediante dos decisiones **independientes** en Diseño del estudio:

- **Distribución restrictiva**: cada persona solo **ve** sus documentos asignados. Sirve para dividir el corpus. Los no asignados quedan visibles solo para admins; desactivada, todos ven el corpus completo.
- **Codificación a ciegas (*true blind*)**: cada persona solo **ve sus propias** codificaciones y respuestas. Para concordancia, asigna el **mismo documento a dos personas**. La referencia también queda oculta a miembros; desactiva el ciego para reconciliar juntos. Admins siguen viendo todo.
  - **Categorías como metadatos del diseño**: disponible con ciego activo. Úsalo si las categorías describen el material (plataforma, perfil sorteado, tema, línea de atención) y no son respuestas del codificador. Permite ver la **referencia de categorías** a miembros bajo ciego; las codificaciones de fragmentos y notas ajenas **siguen ocultas**. Considera el posible sesgo y ten presente que el [Informe](#127-diseño-del-estudio) declara la decisión.

> El **servidor** impide acceder por API a lo oculto, incluidos texto, PDF y notas de fragmentos no visibles. Bajo ciego desaparecen **Ver:** y **Reconciliación** para miembros. Los cambios de asignación requieren **recargar**. Es una función exclusiva de **nube colectiva** y **no viaja en `.qualilab`**.

### Enviar a la nube
Desde un **borrador** o **archivo**, **Enviar a la nube** crea un nuevo proyecto y copia documentos, categorías, códigos, codificaciones y memos sin exportar/importar a mano. Solicita tipo de proyecto y, si es colectivo, la matriz de roles. Solo sube los **PDF originales** si marcas **Enviar también los PDFs originales**.

### Tiempo real (y sus límites)
**Codificaciones** y **respuestas de categoría** se sincronizan en vivo. Para ver cambios del **esquema de categorías** o del **árbol de códigos**, las demás personas deben **recargar**.

---

## 14. Mi cuenta

![Mi cuenta: nombre para mostrar y configuración de IA con proveedor, clave de API y modelo.](manual-img/11-conta.png)

Pulsa **tu nombre** en cualquier modo para abrir **Mi cuenta**:
- Cambiar el **nombre para mostrar** en codificaciones.
- Cambiar la **contraseña**, solo para cuentas por correo; no aparece en borrador/archivo.
- Ver **todos tus proyectos**, abrirlos, renombrarlos (admin), salir o eliminarlos (admin).
- Configurar **clave/modelo de IA** (BYOK), incluido **Ollama local** ([17](#17-codificar-y-analizar-con-ia)).
- Elegir **idioma**: automático, portugués, inglés o español.
- **Salir de la cuenta**, en nube.

### Idioma de la interfaz

QualiLab tiene interfaz en **portugués, inglés y español**. Usa la primera preferencia compatible del navegador y, si no encuentra ninguna, inglés. **Mi cuenta → Idioma** permite elegir explícitamente o volver a automático. El cambio **recarga la página**.

- La elección es **personal y queda en este navegador**; no viaja con el proyecto. Un equipo puede trabajar sobre el mismo proyecto en idiomas distintos.
- **Números y fechas siguen el idioma**; en inglés, por ejemplo, `1.234` se presenta como `1,234`.
- **El contenido que escribiste no se traduce**: documentos, códigos, categorías, valores y memos son datos de investigación. **Sí/No**, **No informado** y **Otros** tienen etiquetas traducidas sin modificar el valor guardado; siguen siendo la misma respuesta al comparar codificadores.

Los **prompts enviados a la IA** permanecen en portugués, al igual que sus instrucciones de respuesta. El marcador **`[trecho censurado]`** se conserva en los artefactos exportados para mantener la compatibilidad. El **apéndice de transparencia** sí sigue el idioma de la interfaz. La lista predeterminada de palabras ignoradas sigue siendo portuguesa; puedes desactivarla y definir la del proyecto. Los correos de acceso dependen de las plantillas del servidor Supabase y no cambian al elegir español.

> Mi cuenta permite configurar IA en **cualquier modo**, incluso sin conexión para usar **Ollama local**.

> Para recuperar la contraseña usa **Olvidé mi contraseña** sin iniciar sesión ([18](#18-solución-de-problemas)). El **correo de la cuenta** no se cambia dentro del app.

---

## 15. Importar y exportar

Los menús están en el encabezado. **exportar ▾** aparece si hay documentos; **importar ▾**, salvo para solo lectura. Las opciones de hojas que actualizan categorías o codifican fragmentos requieren documentos existentes.

### Exportar (menú «exportar ▾»)
| Opción | Contenido |
|---|---|
| **.qualilab (proyecto completo, nativo)** | Documentos y PDF originales, categorías, valores, códigos, codificaciones, memos, conexiones, desacuerdos, conversaciones/memorias de IA e historial. Copia completa para reabrir |
| **JSON (proyecto)** | Documentos, categorías/valores, códigos y codificaciones con capa, autor y página. No incluye memos, IA, historial ni conexiones; usa `.qualilab` como respaldo |
| **CSV (fragmentos codificados)** | Un fragmento por fila: documento, código, capa, autor |
| **CSV (atributos por documento)** | Una fila por documento con categorías; puede completarse y [reimportarse](#completar-categorías-en-una-hoja-y-recuperarlas-paso-a-paso) |
| **QDPX (ATLAS.ti / MAXQDA / NVivo)** | REFI-QDA; prefiere la capa final si está consolidada |
| **QDC (libro de códigos REFI-QDA)** | Solo el libro de códigos |

> **Categorías en QDPX.** REFI-QDA admite **un valor por documento y atributo**, sin autor ni tipos enriquecidos. Exporta la **referencia**; las respuestas individuales quedan en `.qualilab`. **Número**, **Sí/No** y **Fecha** salen como Integer/Float, Boolean y Date solo si **todos** los valores caben en el tipo: un «No informado» o una fecha incompleta hace que la categoría entera salga como texto, para no generar paquetes rechazados por importadores estrictos. Los demás tipos salen como texto, con una descripción que QualiLab puede recuperar. Varios valores de Casilla de Verificación se unen como `a | b`, porque MAXQDA/NVivo no tienen atributos multivalor. `.qualilab` conserva todo sin pérdida.

> **Varios códigos en el mismo fragmento.** Si **tú** aplicaste dos códigos al mismo texto, QDPX crea **una cita con ambos**, conservando la nota. Mantiene citas separadas si pertenecen a **personas distintas** (para preservar autoría) o si **dos códigos tienen notas propias** (solo cabe una nota por cita).

> Antes de exportar QDPX, QualiLab enumera las limitaciones presentes en tu proyecto y pide confirmación: codificaciones individuales cuando hay referencia, respuestas de varias personas, multiselección, historial, evidencia de conexiones y desacuerdos. Las conexiones entre códigos/categorías se exportan como `<Link>`.

> **Todos estos formatos salen completos, sin enmascarar**, incluidos fragmentos de **censura**. Son formatos de trabajo y migración; ocultar texto causaría pérdida irreversible. Las salidas de **transparencia** en **Informe** (ATI/W3C) sí enmascaran. Antes de compartir, consulta [12.4](#124-antes-de-publicar-trabaja-en-el-laboratorio-publica-desde-una-copia).

### Importar (menú «importar ▾»)
| Opción | Qué incorpora |
|---|---|
| **.qualilab** | Combina un proyecto. En destino colectivo conserva respuestas de cada investigador y la referencia. El historial no se duplica al reimportar |
| **QDPX** | Proyecto REFI-QDA. Respeta tipos declarados; infiere los declarados como texto, que conviene revisar. Lee valores en documentos o en casos vinculados y avisa si una categoría queda sin valores. Incluye PDF y conexiones `<Link>` de ATLAS.ti |
| **.sqlite3 (Taguette)** | Documentos, etiquetas jerárquicas por `/` o `.` y fragmentos; sin atributos ni autor por fragmento |
| **.qdc (libro de códigos REFI-QDA)** | Solo el libro de códigos |
| **hoja de cálculo (.csv / .xlsx → documentos + categorías)** | Crea un documento por fila |
| **hoja de cálculo (.csv / .xlsx → actualizar categorías)** | Completa categorías de documentos existentes por nombre; no crea documentos |
| **hoja de cálculo (.csv / .xlsx → codificar fragmentos)** | Cada columna es un código y cada celda un extracto a localizar en documentos existentes |
| **carpeta de Zotero (Zotero RDF)** | Una referencia con PDF se convierte en documento, metadatos en categorías y referencia en memo |

> En **nube colectiva**, importar requiere **admin**, porque puede crear datos compartidos y referencia. En borrador, archivo o individual puede importar cualquier usuario.

> Al importar un `.qualilab` **colectivo** en **borrador/individual**, se combinan las capas: cada codificador individual conserva su codificación y nota, aunque coincidan en el mismo fragmento; la referencia solo se incorpora donde no hay codificación individual. El resumen cuenta lo **realmente guardado** y cuántas marcas se combinaron.

#### Importar una colección de Zotero (paso a paso)
1. **Zotero**: clic derecho en colección → **Exportar colección…** → **Zotero RDF**, con **Exportar archivos**. Se crea una carpeta con `.rdf` y `files/`.
2. **QualiLab**: **importar ▾ → carpeta de Zotero**; selecciona **toda la carpeta**, no solo el RDF.
3. En el mapeo decide:
   - **Metadatos como categorías**: tipo, año, autores, publicación y palabras clave vienen seleccionados; idioma, DOI, URL y páginas no. Solo aparecen campos con datos. Puedes cambiar tipos o excluirlos.
   - **Nombre**: «Autor (año) · título» o solo título. La primera forma ordena como bibliografía en la lista alfabética.
   - Si se conserva el **PDF original**, necesario para vista original, páginas y OCR.
4. Revisa **Lo que no se importará**: referencias sin PDF, con página web guardada o con archivo ausente.

- Se extrae como en **＋ subir**. Un **PDF escaneado entra vacío deliberadamente**: abre **⋯ → OCR: leer páginas escaneadas**, si conservaste el original.
- **Referencia completa, resumen y notas de Zotero** van al **memo del documento**, no a categorías.
- El **año** se convierte en **Fecha**, habilitando Tiempo en Gráficos. Si la fecha es ambigua, se conserva **solo el año** sin adivinar el día.
- No se importan códigos ni fragmentos codificados: la biblioteca bibliográfica no los contiene y las marcas del lector PDF de Zotero no se incluyen en esa exportación.

#### Importar una hoja de cálculo (paso a paso)
1. **importar ▾ → hoja de cálculo (.csv / .xlsx → documentos + categorías)**.
2. Asigna a cada columna: **(ignorar)**, **Texto (contenido del documento)**, **Nombre del documento**, **Memo del documento** o **Categoría · tipo**.
3. Debe haber **exactamente una** columna Texto.
4. Para categorías cerradas se deducen opciones de los valores. Pulsa **Importar**.
- Se omiten filas sin contenido y se informa cuántas. CSV detecta `,`, `;` o tabulador; Excel usa la **primera hoja**.

> **Columnas como memos.** «Observaciones», «Dictamen» o «Resumen del caso» pueden ser notas sobre la fuente. Selecciona **Memo del documento**. Puedes elegir **varias columnas**: se unen en orden, con sus encabezados como títulos (puedes desactivarlos), y se muestra una **vista previa**. Las celdas vacías no generan bloques ni se crean memos vacíos.

#### Completar categorías en una hoja y recuperarlas (paso a paso)

Este es el camino de vuelta del CSV de atributos, útil para completar centenares de documentos en una hoja. El formato de ida y vuelta es el mismo.

1. **exportar ▾ → CSV (atributos por documento)**.
2. Completa celdas en Excel/LibreOffice. Conserva la columna **`documento`**, que identifica cada fila; el encabezado de intercambio no se traduce.
3. **importar ▾ → hoja de cálculo (.csv / .xlsx → actualizar categorías)**.
4. Revisa **antes de guardar**: respuestas nuevas, cambiadas (valor anterior y nuevo), iguales y filas sin documento. Pulsa **Aplicar**.

- **No crea, renombra ni elimina documentos**; para crearlos usa la otra opción.
- Empareja por **nombre**, ignorando acentos, mayúsculas y espacios extra. Nombres ausentes o **duplicados** se omiten y enumeran. Si renombraste documentos, exporta nuevamente.
- **Vacío no borra**, salvo que marques **Celda en blanco borra la respuesta**.
- **Valores nuevos de categorías cerradas** se añaden a las opciones; revísalos para evitar convertir errores de escritura en opciones.
- Columnas sin categoría coincidente empiezan ignoradas (como `n_trechos`, calculada); puedes convertirlas en **categorías nuevas** eligiendo tipo.
- **Fechas** aceptadas: `04/07/2013`, `2013-07-04`, `07/2013`, `2013`. Las no interpretables se rechazan y se informan.
- En **colectivo**, elige entre **referencia** (admin) y **tu respuesta**.

#### Codificar fragmentos en una hoja e incorporarlos al proyecto (paso a paso)

Si tienes **una fila por documento** y **una columna por tema** con citas, puedes importarla sin convertirla en una lista de una fila por fragmento.

1. **importar ▾ → hoja de cálculo (.csv / .xlsx → codificar fragmentos)**.
2. En **Importar fragmentos desde una hoja**, asigna cada columna:
   - **Nombre del documento (emparejar)**: se sugiere la que coincide con más nombres existentes.
   - **Código · nombre**: cada celda es un extracto para ese código.
   - **Crear código nuevo (usa el título de la columna)**.
   - **(ignorar)**, valor inicial salvo en la columna identificadora.
3. Revisa filas emparejadas, **fragmentos por codificar**, códigos nuevos, textos **no encontrados** y documentos ausentes. La lista detalla documento, código y cita.
4. Pulsa **Importar**.

- **No crea documentos**. Los empareja por nombre, ignorando acentos, mayúsculas y espacios adicionales. Si no existe o es ambiguo, se omite con el motivo.
- **Busca el extracto dentro del documento y lo ancla**, mediante el mismo mecanismo de QDPX y sugerencias de IA.
- Lo que **no coincide** se excluye y se informa con fila y columna; no se inventa una ubicación para un resumen. Si la localización fue **aproximada**, aparece **≈**: compruébala, especialmente en OCR.
- **Celdas vacías no hacen nada**; se rechazan fragmentos de menos de tres caracteres.
- **Reimportar no duplica**: compara documento + código + posición; también detecta duplicados dentro de la misma importación. Puedes añadir filas y repetir.
- Un fragmento admite **varios códigos**, y un documento tantos fragmentos como haya en la hoja: las codificaciones **se acumulan**, a diferencia del valor único de categoría.
- **Códigos de censura no aparecen** como destinos; se aplican revisando el texto en el lector.
- En **colectivo**, elige **referencia** (admin) o **tu capa**.

> El mapeo permite conservar la forma original de la hoja y evita perder o desalinear citas al reorganizarla manualmente.

> Después de importar de otra herramienta, revisa los tipos del esquema de categorías: pueden haber sido inferidos.

---

## 16. Guardado, copias de seguridad y modos de almacenamiento

![Gestión del proyecto: tipo, renombrar/vaciar/eliminar y opciones de almacenamiento, copia automática en carpeta, guardar como .qualilab y enviar a la nube.](manual-img/12-projeto.png)

QualiLab **guarda automáticamente** después de cada acción. El lugar depende del modo:

| Modo | Dónde | Indicador | Cuándo usarlo |
|---|---|---|---|
| **Archivo local** | `.qualilab` en disco | `archivo ·` | Datos sensibles, sin conexión |
| **Borrador** | `localStorage` del navegador | `borrador ·` | Pruebas rápidas, efímero |
| **Nube** | Supabase | `nube ·` | Equipos y varios dispositivos |

### Instalar como aplicación (y abrir sin internet)

> **En Windows, se recomienda instalar mediante Edge.** Chrome permite instalar, pero puede mostrar los `.qualilab` con el icono genérico del Explorador. Edge registra nombre de tipo e icono propios.

**Qué significa.** El navegador puede guardar QualiLab como una **PWA** (*Progressive Web App*), sin tienda ni instalador aparte. Es el mismo app del sitio, con los mismos datos de ese navegador, pero tiene ventana propia sin pestañas ni barra de direcciones, icono en Inicio/dock y presencia en la barra de tareas.

**Ventajas:**

- **Abre sin internet** con la copia guardada. Con conexión busca actualizaciones. Las bibliotecas de PDF, Word, hojas y OCR se conservan tras su primer uso.
- **Doble clic en `.qualilab`** puede abrir el proyecto en la aplicación instalada.
- Para proyectos locales con contenido, solicita **almacenamiento persistente**, reduciendo el riesgo de que el navegador elimine borrador/PDF por falta de espacio.
- **Continúa actualizándose**: `nueva versión disponible · recargar` aplica la actualización sin perder lo guardado.
- **Desinstalar** desde el menú ⋯ no elimina tus archivos `.qualilab`.

**Cómo instalar.** Usa **Instalar QualiLab** en la entrada. En Chrome para Windows, **Instalar con Edge** abre la misma dirección en Edge; **Instalar aquí** permite seguir en Chrome. La franja solo aparece cuando el navegador ofrece esa instalación y desaparece tras instalar. También puedes usar el icono de instalación junto a la URL o, en Edge, **⋯ → Aplicaciones → Instalar este sitio como una aplicación**. Edge registra el tipo e icono de `.qualilab`; Chrome en Windows puede dejar el icono genérico. En macOS no se espera ese mismo problema. Puedes seguir navegando normalmente con Chrome aunque instales QualiLab mediante Edge; sus almacenamientos de navegador son separados.

Instalar **no cambia el modo de almacenamiento**. Archivo continúa en disco y nube continúa en Supabase. **No es obligatorio**: las funciones del manual también se usan en una pestaña.

### Sensibilidad de los datos: qué habilitar
Decide qué funciones puedes usar según la **sensibilidad del material**. Estos son los destinos:

- **Archivo / Borrador**: permanecen **en tu dispositivo**.
- **Nube**: van a un **servidor externo Supabase** para sincronizar; quedan sujetos a su operación y términos.
- **IA remota**: el material elegido va al **proveedor**, con los fragmentos marcados como **censura** enmascarados por defecto ([17](#17-codificar-y-analizar-con-ia)).
- **Publicación**: lo que publiques como ATI/W3C queda accesible al público al que lo compartas. Comprueba la censura antes.

La regla es **ante la duda, tratarlo como más sensible**:

| Nivel | Ejemplo | Nube (Supabase) | IA remota | IA local | Publicar (ATI/W3C) |
|---|---|---|---|---|---|
| **Público / sintético** | Resoluciones públicas, datos abiertos, ejemplos | OK | OK | OK | OK |
| **Sensible con transmisión permitida** | Entrevistas sin prohibición formal | Con conocimiento de las implicaciones | Preferir **clave propia**, de pago/institucional, y revisar material y censura | Preferible | Caso por caso, con censura revisada |
| **Salida prohibida** | Prohibición ética, salud identificable, expediente reservado | **No** | **No** | Solo si es **realmente local**, con modelo en la máquina y sin conexión | **No** |

> **Privacidad total y todas las funciones no coexisten** en una aplicación de navegador. El material cuya salida está prohibida exige **archivo/sin conexión** y, si corresponde, **IA local**. Es una restricción real.

**Qué no hacen la censura y la anonimización.** QualiLab **no identifica ni enmascara automáticamente datos personales** (nombres, documentos de identidad, salud). La **censura** solo protege los fragmentos **marcados por ti**; **ocultar autoría** solo elimina nombres de codificadores. Debes revisar todos los identificadores **antes de cada envío**; depender de una revisión manual perfecta no equivale a un control automático de seguridad. Anonimizar, obtener consentimiento y elegir almacenamiento adecuado son responsabilidades del investigador. **Repetir Codificación** encuentra otras menciones idénticas ([5.5](#55-censura-enmascarar-fragmentos-sensibles)); la **copia de publicación** permite limpiar títulos, categorías y memos ([12.4](#124-antes-de-publicar-trabaja-en-el-laboratorio-publica-desde-una-copia)).

### Modo archivo (Chrome/Edge)
El proyecto es un `.qualilab` **visible en el sistema de archivos**, en una carpeta, disco externo o volumen cifrado. El archivo es el almacenamiento principal del corpus y no requiere nube. Inicia con **Nuevo en archivo** o **Abrir archivo existente**, o desde **Mis proyectos → Nuevo archivo… / Abrir archivo…**. La siguiente sesión reabre el último archivo, con permiso del navegador. Las preferencias de interfaz y el permiso del archivo pueden seguir almacenados en el navegador.

### Modo nube (Supabase): qué es y qué protege
La nube guarda el proyecto en una base en línea para **sincronizar** personas y dispositivos. Supabase proporciona base de datos y autenticación; QualiLab se conecta a un proyecto de ese servicio.

La pregunta central es **quién administra ese Supabase**:

- **Servidor estándar**: el Supabase del autor. El propietario **tiene acceso técnico** al contenido. Usarlo implica confiar en un proyecto personal sin garantía institucional ([aviso legal](#0-la-idea-de-qualilab)). No es el destino recomendado para datos sensibles.
- **Tu Supabase**, indicador violeta **nube personal**: conectas tu propio proyecto (puede crearse en el plan gratuito). Tú administras sus claves y permisos, aunque Supabase sigue alojándolo. Configura **Conectar a mi Supabase** en la entrada/inicio de sesión o **Conexión (Supabase)** desde la gestión de un proyecto local.

**Protecciones:**
- **Inicio de sesión** por correo/contraseña o Google mediante Supabase Auth.
- **Aislamiento entre usuarios** (*Row Level Security*): cada cuenta solo accede a proyectos de los que es miembro; no puede ver otros proyectos de sus colegas.
- **HTTPS** durante el tránsito y **cifrado en reposo** en la infraestructura Supabase.

**Límites:**
- **No es cifrado de extremo a extremo en esta versión.** Quien administra la base puede leer los datos: autor en el servidor estándar, tú en el personal y Supabase como proveedor. RLS protege frente a otros usuarios, no frente al administrador de la base.
- **Eliminar un proyecto es definitivo**; exporta antes. Para eliminar documentos, códigos, categorías o vaciar contenido, hay [instantánea](#instantáneas-del-proyecto-punto-de-restauración) previa si está activada.
- **No sustituye el modo archivo sin conexión**. Desde 1.4.7, las escrituras habituales pueden quedar en cola, pero abrir documentos no cargados o cambiar de proyecto requiere red.

> **Si falla la nube, el trabajo habitual queda en cola.** Ante fallos temporales, el cambio **se conserva en el navegador y en pantalla**, y se envía al recuperarse la conexión. La barra indica cuántos esperan y permite reintentar. **Cerrar la pestaña no elimina la cola**: se recupera con **la misma cuenta**, separada de otras cuentas del dispositivo. Incluye codificaciones, categorías, desacuerdos, notas, conversaciones/memorias de IA e historial. Las operaciones **estructurales** (crear/eliminar documentos, cambiar códigos, gestión e importación) avisan inmediatamente si fallan: repetirlas más tarde podría causar cambios inesperados. Si el servidor **rechaza definitivamente** una escritura por permisos o porque se eliminó su destino, aparece un aviso y un enlace para descargar `.qualilab` antes de rehacerla.

Usar nube implica **confiar en su administrador**. Para material sensible, prefiere tu Supabase o almacenamiento local. Esto también se aplica con IA: tu clave permite que el navegador contacte directamente al proveedor ([17.1](#171-cómo-funciona-la-ia-aquí)); ese **proveedor** sí ve lo enviado ([17.5](#175-adónde-van-tus-datos-proveedores-y-configuración)).

> **PDF original en nube.** Subir sus bytes es **opcional y requiere consentimiento explícito**: el administrador podría leer el **PDF completo**, no solo el texto codificado. Sin esa opción suben texto y codificación. Para datos sensibles, conserva el PDF en **modo archivo**.

### Instantáneas del proyecto (punto de restauración)
Una **instantánea** guarda el estado del proyecto —documentos, categorías, códigos, codificaciones, memos, conexiones, desacuerdos, conversaciones y memorias— para restaurarlo. Está en **indicador del proyecto → Copias espejo del proyecto**.

- **Hacer copia espejo ahora**, con etiqueta opcional, crea una manual que permanece hasta eliminarla.
- **Automáticas**: antes de vaciar contenido, eliminar documento/código/categoría, fusionar/dividir códigos o editar texto, como máximo una cada 10 minutos. Antes de **restaurar**, siempre se crea otra, incluso con el automático desactivado. Se conservan las **cinco** automáticas más recientes.
- El **interruptor automático** está activado por defecto. Cada instantánea copia texto y análisis, sin PDF; con cinco, el tamaño puede rondar 1,5 veces el proyecto. En modo archivo aumenta el propio `.qualilab`. Desactivarlo es decisión del admin y queda en el historial; las manuales siguen disponibles.
- **Restaurar** reemplaza el proyecto por el estado guardado, previa instantánea del actual. El **historial no se restaura**: registra que hubo una restauración. Requiere admin.
- **No incluye PDF originales ni historial**. Un PDF eliminado no vuelve, aunque sí su texto y análisis. No modifica la declaración de disponibilidad de IA, el equipo ni la distribución.
- **Ubicación**: almacenamiento del navegador fuera de `localStorage` en borrador; dentro del `.qualilab` en archivo; tabla/bucket propios en nube, gestionados por admins.
- **No es un respaldo externo**: si pierdes el almacenamiento del proyecto, pierdes ambas cosas. Exporta `.qualilab` aparte.

### Copia automática en carpeta (borrador, Chrome/Edge)
Mantiene actualizado `backup-automatico.qualilab` en una carpeta propia. Actívala en **indicador del proyecto → Copia de seguridad automática en carpeta → Elegir carpeta…**.

### Guardar o descargar manualmente
**exportar ▾ → .qualilab (proyecto completo, nativo)** descarga todo en cualquier modo. Sirve para versiones y copias externas; es el mismo archivo ofrecido cuando falla el guardado automático.

### Cuando falla el guardado
Si `localStorage` se llena, se revoca un permiso o se desconecta un disco, aparece una **franja roja persistente** indicando que los últimos cambios **no se guardaron**, con acceso a **descargar .qualilab**. Desaparece solo cuando vuelve a funcionar. **Descarga una copia antes de continuar.**

### Modo nube sin conexión
El indicador se vuelve ámbar y la barra muestra **sin conexión** o los **cambios pendientes**. Puedes seguir codificando: las escrituras habituales quedan localmente y se envían al volver la nube, incluso tras cerrar y reabrir la pestaña.

No puedes leer material que no se haya cargado ni cambiar de proyecto. Para una sesión prolongada sin internet, usa **modo archivo** y descarga previamente un `.qualilab` como respaldo.

---

## 17. Codificar y Analizar con IA

> Las pantallas de IA requieren **activación voluntaria**. Se aplican los principios de la [sección 0](#0-la-idea-de-qualilab): transparencia y decisión humana. No se envía material a un proveedor sin configurar una clave y solicitar el análisis.

La IA no escribe en el proyecto sin permiso. **Autocodificación** propone cambios revisables por elemento; **Analizar con IA** interpreta una selección; **Explorar con IA** busca el material por sí misma ([17.6](#176-explorar-con-ia-la-ia-solicita-el-material-en-vez-de-recibirlo)). El resultado siempre es una **propuesta o texto para revisar**. Aplicar cambios es una decisión tuya.

Mapa del capítulo:

| Sección | Contenido |
|---|---|
| [17.1](#171-cómo-funciona-la-ia-aquí) | Rutas de envío, clave, prompt visible, límites y costo |
| [17.2](#172-autocodificación-cinco-asistentes-en-pestañas) | Los cinco asistentes de Autocodificación |
| [17.3](#173-analizar-con-ia-lectura-asistida-del-material) | Conversación sobre una selección de material |
| [17.4](#174-configurar-tu-clave-opcional) | Configurar la clave |
| [17.5](#175-adónde-van-tus-datos-proveedores-y-configuración) | Destino de los datos y proveedores |
| [17.6](#176-explorar-con-ia-la-ia-solicita-el-material-en-vez-de-recibirlo) | La IA solicita material mediante herramientas |
| [17.7](#177-desactivar-la-ia-en-este-proyecto) | Desactivar IA en el proyecto |

> Si no usarás IA, consulta [17.7](#177-desactivar-la-ia-en-este-proyecto). El resto del manual funciona sin este capítulo.

### 17.1 Cómo funciona la IA aquí

- **Ruta de la llamada.** Con **tu clave**, el **navegador contacta directamente al proveedor**; el material no pasa por servidores de QualiLab. **Ollama local** contacta tu máquina. Un endpoint **Personalizado/Azure** que no permita llamadas desde navegador por CORS puede hacer que se **reintente** mediante la función Supabase `ai-ask`, que entonces ve el material. **Mi cuenta** indica la ruta de tu configuración. Consulta [17.5](#175-adónde-van-tus-datos-proveedores-y-configuración).
- **Clave propia (BYOK).** Configura clave y modelo en **Mi cuenta** (17.4). Quedan **en este navegador**; la clave se utiliza en las solicitudes y no se guarda como configuración del proyecto en el servidor. Una instalación propia puede configurar una **clave de servidor** y usar `ai-ask`; la versión pública no tiene esa clave compartida.
- **Ver/configurar el prompt (⚙).** Los cuatro asistentes con IA y Analizar ofrecen **⚙ Configurar Prompt**: vista previa del envío por secciones (rol, memos, memoria, material, reglas, tarea), modelo, conteos, **tokens/costo estimados (≈ R$)** y **copiar prompt**. Allí ajustas instrucciones, memos y memoria; Analizar también ofrece **postura** ([17.3](#173-analizar-con-ia-lectura-asistida-del-material)). La vista previa corresponde al material que enviará la acción. Explorar no tiene una selección anticipada: lista cada llamada de lectura ([17.6](#176-explorar-con-ia-la-ia-solicita-el-material-en-vez-de-recibirlo)).
- **Proveedores admitidos**: **Gemini, OpenAI, Anthropic, Azure OpenAI, Personalizado** (API compatible con OpenAI `/chat/completions`, como DeepSeek, Mistral, Qwen alojado o servidor propio Ollama/vLLM) y **Ollama local**, directo desde el navegador.
- **Censura antes del envío.** Los fragmentos marcados se sustituyen por `[trecho censurado]`; en Explorar, por bloques `█` de igual longitud para conservar posiciones. En **Analizar** puedes incluir explícitamente un código de censura en esa ejecución.
- **Respuestas enfocadas.** La configuración busca consistencia para análisis; no requiere ajustar creatividad.
- **Tamaño y cortes.** Aproximadamente **400.000 caracteres (~133 páginas) por documento** y **600.000 (~200 páginas) en total**. Si se supera:
  - En una selección que excede el total, **los últimos elementos se excluyen completos**; no reciben sugerencias. En Organizar, **la lista de códigos permanece completa** y se reduce la muestra de fragmentos.
  - Un documento que supera su límite aporta **solo el comienzo (~133 páginas)**. Para analizarlo entero, **divídelo en documentos menores**; elegir menos documentos no resuelve ese límite individual.

  Una **franja amarilla** informa del corte, los documentos omitidos o incluidos parcialmente. El configurador muestra páginas y marca el corte en el texto. Comprueba el aviso para no interpretar un resultado parcial como completo.
- **Costo estimado.** Antes del envío se muestra **≈ R$** y tokens. Analizar también presenta el costo estimado de cada respuesta y el total. Son **estimaciones superiores sin descuento de caché**; la previa presupone un tamaño de salida. Para varias llamadas —evaluación a ciegas y Definir Categoría— suma **todas** e indica cuántas; la barra de material muestra la **mayor**, que determina el riesgo de corte. Probar la definición en casos reservados es otra acción con estimación propia. Ajusta cambio y tarifas en Mi cuenta. **Ollama local** tiene costo de API cero.

> ⚠️ **La IA puede equivocarse e inventar.** Contrasta cada resultado con su fuente. La IA propone; tú decides.

### 17.2 Autocodificación: cinco asistentes en pestañas

![Autocodificación: asistentes arriba, selección de documentos y códigos a la izquierda, Configurar Prompt con tokens y costo estimado.](manual-img/09-ia-codificar.png)

Incluye **Sugerir Codificación** (inicial), **Repetir Codificación**, **Sugerir Categorización**, **Definir Categoría** y **Organizar Códigos**. El asistente **propone**, tú **apruebas/rechazas por elemento** y **confirmas antes de guardar**.

> **Repetir Codificación no usa IA** ([17.2.5](#1725-repetir-codificación-sin-ia)): es mecánica, funciona sin clave ni conexión y permanece con IA desactivada. Por eso la pantalla se llama Autocodificación (antes de 1.4.37, Codificar Automáticamente). Las otras cuatro usan proveedor, memos/memoria como contexto y censura enmascarada. Si la respuesta llega truncada, se recuperan los elementos completos y se descarta el último incompleto.

**⚙ Configurar Prompt** muestra arriba **Instrucciones propias para la IA** (compartidas con Analizar), **Memos inyectados** (por defecto Memo para la IA) y **Memoria del proyecto**. Debajo presenta la **vista previa exacta** con modelo, páginas, códigos de censura enmascarados, tokens/costo y secciones del prompt, incluidos los marcadores de corte. **copiar prompt** copia el conjunto.

![Configurar Prompt en Autocodificación: instrucciones, memos y memoria arriba; modelo, material, censura, costo y secciones del prompt debajo.](manual-img/15-ia-configurar-prompt.png)

#### 17.2.1 Sugerir Codificación: la segunda codificadora

Lee documentos y propone **fragmentos para códigos existentes que pudieron pasar inadvertidos**. **No crea códigos**. Selecciona documentos y códigos permitidos.

La IA copia una cita y QualiLab **la localiza y ancla** en el documento. Cada propuesta muestra texto, código y **nuevo** o **≈ localización aproximada**. No vuelve a proponer marcas del mismo código que ya existen, pues ve la codificación actual; descarta y cuenta lo no localizable. No aplica censura mediante IA. Al aprobar/aplicar, se crea una codificación en tu capa. Revísala en el lector.

#### 17.2.2 Sugerir Categorización: completar categorías existentes

La IA **no crea categorías**: propone valores para las ya definidas. Selecciona categorías y documentos; para tipos cerrados debe usar las opciones válidas.

Las categorías aparecen primero porque alimentan **sin valor (N)**: selecciona documentos con al menos una categoría elegida vacía. Cada documento indica pendientes o **completo**.

En modo normal, recibe valores **ya completados** y devuelve **diferencias o vacíos**; si coincide, no propone nada. Las propuestas distinguen valor existente → sugerido y campo vacío. Aplica las aprobadas a tu capa de respuestas, o a la referencia en individual, como si las hubieras escrito.

**Evaluación a ciegas cambia el propósito.** Ver las respuestas sirve para revisar, pero no para medir. Al activar la casilla, la IA responde **sin ver ninguna respuesta tuya** y el app compara después. Hace **una llamada por documento** para no alterar el contexto por posición en una lista; el progreso cuenta documentos.

El resultado separa **coincide**, **diverge**, **la IA no respondió** y **sin referencia**. Solo las dos primeras entran en el cálculo. Fallos de red/formato o valores inválidos se separan de desacuerdos; sin referencia no hay comparación y las respuestas aparecen como sugerencias de completado.

Mide **concordancia con tu referencia**, no exactitud absoluta: pueden estar incompletas la definición o tus propias respuestas. Con pocos casos no distingue diferencias pequeñas; interprétalo como orden de magnitud. **No hay conversación de seguimiento** en ciego: se refina la definición y se vuelve a medir. Cambiar de modo **limpia la conversación**.

En ciego, el prompt **omite Memo para la IA y memoria del proyecto**: podrían contener respuestas o sugerencias de ejecuciones previas con acceso a la referencia. La vista previa declara ambas omisiones.

#### 17.2.3 Definir Categoría: escribir la instrucción a partir de tus respuestas

Tus respuestas contienen la regla que aplicaste; esta pestaña ayuda a escribirla. Lee una muestra ya respondida y propone la **descripción/instrucción** del [Esquema](#7-esquema), usada tanto por personas como por IA. Resulta útil al empezar sin definición.

1. **Elige la categoría.** Indica cuántos documentos están respondidos. Requiere al menos **seis**: menos casos producirían conjeturas con apariencia de criterio.
2. **Define la muestra** de **entrenamiento** y **reservados**. Los reservados se separan **antes de llamar al modelo** y no entran en el prompt de inducción. Se equilibra por valor para que una clase mayoritaria no monopolice los ejemplos; una tarjeta muestra la distribución real.
3. **Proponer definición** hace primero **localización**, una llamada por caso de entrenamiento que copia la evidencia literal de tu respuesta sin juzgarla, y luego induce la definición. Así cabe material largo.
4. **Edita y aplica.** El texto es editable; **Aplicar a la categoría** requiere **admin**, por modificar el esquema.

Junto a la definición aparecen:

- **Casos que la regla no explica**: el modelo debe aplicar su regla y señalar respuestas diferentes de las tuyas, sin forzar el ajuste a todo. Puede revelar inconsistencia o criterios implícitos. Una lista vacía merece revisión: explicar todos los ejemplos puede ser memorización.
- **Puntos que los ejemplos no resuelven**: quedan abiertos en vez de inventar un criterio plausible; tú decides.
- **Casos sin evidencia textual de la respuesta**: detectados al localizar, pueden indicar información externa, error al completar o extracción defectuosa.

**Prueba y repetición.** **Probar la definición** responde los reservados a ciegas y compara, con el **mismo motor y marcador** de la pestaña anterior. Prueba **el texto del campo**, aún sin guardar, y avisa si lo editas después. Los desacuerdos muestran ambas respuestas y permiten **repetir la inducción incluyendo esos casos**. Pasan a entrenamiento; los nuevos reservados se eligen solo entre documentos **nunca enviados a un prompt** durante esta sesión.

Límites:

- Requiere **clave propia**; la salida estructurada por herramienta va directa al proveedor.
- Tras varias vueltas, la estimación puede ser **optimista** porque tus elecciones dependen de resultados vistos. Para una medida independiente, reserva documentos que nunca entren en esas vueltas.
- El registro de documentos vistos dura **la sesión**; cambiar de categoría o salir reinicia el control.

Las **cinco reglas de inducción** —escribir instrucciones, servir para el caso siguiente, usar criterios sustentados, declarar fallos y estructurar la definición— aparecen en Configurar Prompt. Puedes editarlas para tu estudio; el cambio dura **la sesión**, no se guarda en el proyecto.

#### 17.2.4 Organizar Códigos: ordenar el libro de códigos

Para reorganizar decenas o centenares de códigos tras una lectura abierta, la IA recibe **todos los códigos**, su jerarquía y conteos, y opcionalmente **hasta tres fragmentos por código**. Propone operaciones justificadas:

| Operación | Efecto |
|---|---|
| **Fusionar** | Unir códigos redundantes |
| **Agrupar** | Reunir bajo una familia nueva o existente |
| **Mover** | Cambiar de padre |
| **Renombrar** | Proponer otro nombre |
| **Promover** | Llevar a Jerarquía 0 |

Aparecen dentro de la conversación con aprobar/rechazar. Aplica las aprobadas o solicita ajustes. Los códigos de **censura quedan excluidos**, pues no son categorías analíticas.

#### 17.2.5 Repetir Codificación (sin IA)

![Repetir Codificación: códigos y opciones de comparación a la izquierda; coincidencias con contexto y aprobación/rechazo a la derecha; Aplicar al pie.](manual-img/17-ia-repetir.png)

**No usa IA**, clave ni red; produce resultados deterministas. Toma fragmentos **ya asociados a un código** y busca otras apariciones **idénticas** en todo el corpus.

Selecciona códigos y pulsa **Buscar ocurrencias**. Revisa documento, fragmento y contexto, aprueba/rechaza y pulsa **Aplicar**. Lo ya aplicado sale del conteo y no se duplica.

- **Palabra completa** viene activada para evitar encontrar «Tal» dentro de «Total». Los controles son **Aa**, **ab⃒** y **`.*`**, igual que en la búsqueda.
- Las coincidencias con **ese mismo código** ya aplicado se omiten y cuentan aparte. Otro código sobre el fragmento no impide la propuesta.
- Encuentra **texto idéntico, no variantes**. «Estudio Ejemplo Abogados» no encuentra «Estudio Ejemplo» ni «el estudio»; usa [buscar +](#57-buscar-en-el-documento-y-en-todo-el-proyecto).
- Funciona con **cualquier código** y es útil para nombres y expresiones recurrentes. Las frases largas rara vez se repiten literalmente.

**Por qué existe.** Marcar un nombre una vez puede dejar otras menciones expuestas. Esta herramienta ofrece propuestas para revisar; no promete que un resultado vacío equivalga a anonimización completa, porque también se identifica a personas por combinaciones de pistas.

### 17.3 Analizar con IA: lectura asistida del material

![Analizar con IA: Material y Configurar Prompt arriba, selección a la izquierda, tarea y conversación a la derecha.](manual-img/10-ia-analisar.png)

Ayuda a **interpretar** con instrucciones de **citar fuentes**, mediante una **conversación**. Eliges el **alcance** y escribes la **tarea**. Puedes **guardar conversaciones** en **Memos → Conversaciones guardadas**.

La barra superior incluye Configurar Prompt y Material; a la izquierda seleccionas documentos o códigos y controlas la censura. A la derecha están la Tarea contraíble, conversación y caja de mensaje fija abajo. Las respuestas admiten títulos/listas y un indicador muestra que el modelo está trabajando. La primera vez, un aviso invita a revisar el prompt.

**La Tarea.** Es **texto libre**: los resultados dependen de tu pregunta y tu modo de formularla. No hay una tarea única predeterminada para toda investigación.

**biblioteca de prompts ▾** contiene ejemplos y **tus prompts guardados**. Insertar uno sustituye el campo como **punto de partida editable**. **✦ guardar** permite construir tu biblioteca; puedes renombrar/eliminar en **Memos → Prompts guardados**. Los ejemplos dependen del alcance:

- **Documentos**: *Temas candidatos*, *Capa latente*, *Síntesis analítica*, *Lo inesperado*, *Diferencias entre casos*, *Variación por categoría*.
- **Fragmentos + Código**: *Qué hay en el código*, *Coherencia y saturación*, *Código vs. definición*, *Diferencias entre casos*, *Memo analítico*.
- **Documentos + Fragmentos + Código**: *Qué códigos complementarían el análisis*, *Qué códigos desafían el análisis*, *Validación en contexto*, *Fragmento en contexto*, *Síntesis contextualizada*, *Variación por categoría*.

**Configurar el prompt (⚙)** permite ajustar la perspectiva y comprobar el envío:

![Configurador de Analizar: postura, instrucciones, memos, memoria, categorías y vista previa de las secciones.](manual-img/16-ia-analisar-prompt.png)

- **Postura**: *Estándar* (sin privilegiar enfoque), *Inductivo* (construye desde el material), *Deductivo* (evalúa frente al esquema), *Abductivo* (busca explicaciones, incluidas las de hallazgos inesperados) o *Personalizado*. El texto de la postura se muestra y entra en el prompt; los textos incorporados siguen en portugués.
- **Instrucciones propias para la IA**: guías para **todos** los prompts, compartidas con Autocodificación.
- **Memos inyectados**: por defecto **Memo para la IA**; puedes incluir otros de proyecto, documento, código o fragmento.
- **Memoria del proyecto**: elige qué entradas se incluyen.
- **Categorías como metadatos**: añade opcionalmente atributos de cada documento; desactivado por defecto.
- **Vista previa y procedencia**: bajo los controles aparecen secciones, modelo, páginas, tokens/costo y **copiar prompt**. Los cortes se avisan y se marcan ([17.1](#171-cómo-funciona-la-ia-aquí)).

**Paso a paso:**
1. Abre **Analizar con IA**.
2. Elige el **alcance** y **material**; hay filtro contraíble por categorías y árbol de códigos.
3. Escribe la **Tarea** o adapta un ejemplo de la biblioteca. Revisa postura y vista previa en **⚙ Configurar Prompt**.
4. Pulsa **Iniciar análisis** y continúa con mensajes de seguimiento. **Analizar de nuevo** reinicia con la selección actual; **Limpiar conversación** la vacía.
5. **Guardar conversación (Memos)** conserva el intercambio completo en **Memos → Conversaciones guardadas**.

La IA recibe los **memos de los códigos** y, si activas categorías como metadatos, los **atributos completados**, para situar observaciones en documento, autor y capa.

> **Sugerir memorias** solicita hechos o decisiones breves para la **Memoria del proyecto**. Puedes aprobar, editar o rechazar antes de guardarlos.

### 17.4 Configurar tu clave (opcional)

En **Mi cuenta → IA: tu clave y modelo**:
1. Elige **proveedor**.
2. Para Azure, Personalizado u Ollama, indica **URL base**; Ollama propone `http://localhost:11434/v1`.
3. Pega **clave de API**: obligatoria en proveedores de catálogo y Azure; en Personalizado, si el servidor la exige; Ollama local no la necesita. Al **cambiar de proveedor**, se limpian clave/modelo/URL; volver al proveedor guardado restaura su configuración. Se avisa si una clave parece pertenecer a otro proveedor.
4. Elige **modelo**, *deployment* en Azure o modelo descargado en Ollama (p. ej., `qwen2.5:14b`). Los modelos mayores suelen requerir más tiempo/costo.
5. **guardar** conserva; **limpiar** elimina la clave.

**Costo estimado (calculadora)** permite ajustar **US$→R$** y tarifas por millón de tokens para Personalizado/Azure, usadas en [17.1](#171-cómo-funciona-la-ia-aquí).

> La configuración de la clave queda **solo en este navegador**. Se utiliza para autenticar las solicitudes; en el fallback descrito abajo, la función intermediaria participa en ese envío.

### 17.5 Adónde van tus datos: proveedores y configuración

Con clave propia, el navegador envía material **directamente al proveedor elegido**. La confianza se deposita en quien lo procesa. Las excepciones son **Ollama local**, donde no sale a internet, y endpoints **Personalizado/Azure** que rechazan llamadas de navegador: se reintentan mediante Supabase `ai-ask`, que ve el material sin guardar allí la clave como configuración.

**Retención y entrenamiento.** No puedes auditar desde QualiLab lo que un proveedor hace con el material; dependes de sus políticas y condiciones, que cambian. No entrenar no implica no retener.

> **Regla práctica:** si no enviarías un dato en un chat de ChatGPT/Gemini/Claude, aun con el uso para entrenamiento desactivado, no lo envíes por API sin evaluar sus condiciones. La API cambia condiciones, pero el dato sigue saliendo a un tercero.

Si no puedes confiar ese material, considera condiciones institucionales de **retención cero contractual** o un **modelo local**, donde no se envía fuera.

Como orientación del manual original, las capas gratuitas/de consumo pueden usar contenido para entrenamiento; las API comerciales pueden excluirlo por defecto pero retener datos por otros motivos. **Comprueba las condiciones vigentes del producto y plan concretos** antes de elegir: no uses una afirmación general sobre el proveedor como garantía para datos sensibles.

**Ollama local.** Autoriza la **origen del app** mediante `OLLAMA_ORIGINS`. Desde HTTPS, algunos navegadores pueden bloquear `http://localhost`; el camino más fiable es ejecutar **QualiLab localmente**, desde el archivo descargado o `python -m http.server 8000`. Consulta la parte técnica en el [README público](https://github.com/LuizPF42/QualiLab#readme).

> Para datos cuya salida está prohibida, usa **Ollama y el app locales, sin conexión**. Los modelos pequeños pueden ser menos precisos; en tareas de formato estricto, QualiLab utiliza salida estructurada.

### 17.6 Explorar con IA: la IA solicita el material en vez de recibirlo

> Hasta 1.4.37 esta pantalla se llamaba **MCP/RAG**; cambió el nombre, no la función.

![Explorar con IA: indicador experimental, llamadas get_project, list_documents y get_document_content con argumentos/resultados y respuesta con nombres censurados como bloques negros.](manual-img/19-mcp-rag.png)

> Es **experimental**. No modifica el proyecto, pero herramientas y formatos pueden cambiar. No la uses como único registro: guarda lo relevante en memos o informes.

En otras pantallas eliges la selección antes de preguntar. Aquí **la IA busca el material** mediante herramientas de lectura: documentos, búsquedas, fragmentos por código, memos. **Cada solicitud aparece** con herramienta, argumentos y resumen del resultado.

Puedes preguntar por el corpus completo sin saber dónde está la respuesta:

- «¿Qué documentos hablan de plazos y cómo aparece el tema?»
- «Compara cómo los codificadores usaron la familia Riesgos».
- «Busca fragmentos que contradigan mi memo del proyecto».

**Solo lectura.** Ninguna herramienta crea, modifica ni elimina. La censura conserva la longitud mediante bloques, manteniendo posiciones válidas. La pantalla muestra **las llamadas reales**, lo que permite comprobar si la respuesta se apoya en material efectivamente leído.

Requiere **clave propia** ([17.4](#174-configurar-tu-clave-opcional)) y puede consumir más: cada pregunta genera varias llamadas. Hay límites automáticos de pasos y material; al alcanzarlos, la pantalla avisa.

Si ya delimitaste el material, **Analizar con IA** es más directo y económico. Explorar ayuda cuando **encontrar el material es parte del problema**.

#### Las mismas herramientas en el asistente que ya usas

Esta pantalla factura con **tu clave de API**, por tokens. Si tu suscripción a un asistente admite complementos, puedes usar su cuota incluida para leer el corpus desde allí, según las condiciones de ese servicio.

Una **suscripción de chat no es una credencial de API**: son accesos y facturaciones separados. La alternativa es llevar el corpus al asistente.

El complemento **[LuizPF42/QualiLab-plugin](https://github.com/LuizPF42/QualiLab-plugin)** tiene instrucciones por cliente. Es un programa **separado de QualiLab**, que lee `.qualilab` exportados ([15](#15-importar-y-exportar)) desde una **carpeta** que indiques.

Usa **el mismo código de herramientas**, con las mismas reglas de **solo lectura** y censura.

> **El límite depende del cliente.** Si el complemento es el único acceso al corpus, su máscara delimita lo servido. Un asistente con **herramientas propias de archivos** puede abrir el `.qualilab` por fuera y leer el texto **crudo**. En ese caso, la censura del complemento no impide ese otro acceso.

### 17.7 Desactivar la IA en este proyecto

Puede servir para una investigación que necesita declarar su relación con IA o para evitar que codificaciones de modelo se presenten como juicios humanos, alterando concordancia o saturación. El control permite elegir el **alcance**.

![Proyecto nuevo: Recursos de IA, con Sin IA seleccionado y Activar IA como opción; Continuar sin IA al pie.](manual-img/18-ativar-ia.png)

**Se pregunta al crear**, en nube, archivo o borrador. **Sin IA viene seleccionado**; salir sin responder la mantiene desactivada. El indicador **IA** entre proyecto y nombre muestra verde si está activa y rojo tachado si está desactivada o restringida. El admin puede cambiarlo con confirmación o desde **Proyecto → Recursos de IA**:

| Opción | Quién accede a las pantallas de IA |
|---|---|
| **Activados** | Quienes tengan permiso según el rol |
| **Solo para administradores** | Administración |
| **Desactivados** | Nadie, incluido el admin |

Desactivados incluye al coordinador para aplicar la misma decisión a todos.

La [matriz de roles](#qué-puede-hacer-cada-rol-se-decide-al-crear), en **Usa los paneles de IA**, puede restringir a miembros aun si el proyecto la activa. **Solo lectura** no tiene estas pantallas ni Repetir Codificación, porque no codifica.

**Qué desaparece y qué permanece.** Desaparecen **Analizar**, **Explorar**, **Memo para la IA** y **Prompts guardados**. **Autocodificación** conserva **Repetir Codificación**, que no usa IA y ayuda a revisar menciones censuradas; un aviso explica las otras ausencias. Hasta 1.4.64 se ocultaba toda la pantalla. **Conversaciones guardadas y memoria** permanecen como registro que el informe puede contar.

**La decisión viaja con el proyecto** en `.qualilab`, al guardar, reabrir o enviar a nube. Importar material desde un proyecto sin IA **no cambia** el ajuste del destino, pero se informa su origen. Las conversaciones de IA **no se importan** en un destino con IA desactivada; el resumen indica cuántas quedaron fuera.

El informe describe el estado y registro según [12.5](#125-declaración-sobre-uso-de-ia).

> **No es un bloqueo técnico frente a herramientas externas.** Una persona puede copiar texto a otro servicio. El control elimina la aplicación masiva de IA dentro del app; no certifica «100 % manual». Con paneles disponibles queda más registro del uso; con ellos cerrados, un uso externo puede ser indistinguible del trabajo manual.

---

## 18. Solución de problemas

**El app no carga o queda en blanco al abrir el archivo.**
El núcleo abre sin internet; bibliotecas de PDF, DOCX, hojas, OCR, búsqueda semántica y nube necesitan red al primer uso. Si el navegador bloquea `file://`, ejecuta `python -m http.server 8000` en la carpeta de `index.html`.

**La aplicación instalada abre una ventana del navegador al cambiar de pantalla.**
Reinstala o, en Edge, abre `edge://apps` → QualiLab → Detalles y desactiva el tratamiento de enlaces.

**No se pudo cargar una hoja `.xlsx`.**
La biblioteca se descarga del fabricante al primer uso. Conéctate y reintenta o guarda como `.csv`, que no depende de ella.

**Lectura, Gráficos o Informe tardan o agotan el tiempo en proyectos grandes.**
Reintenta. Si persiste, puede ser el tamaño del proyecto para esa pantalla.

**No aparecen Nuevo archivo ni copia en carpeta.**
Requieren File System Access API de **Chrome/Edge**. Usa nube/borrador en Firefox/Safari.

**Aviso rojo: últimos cambios sin guardar.**
Descarga **.qualilab** de inmediato. Libera espacio (borrador: ~5 MB) o migra a archivo/nube.

**Un colega no ve códigos o categorías nuevas.**
Debe **recargar**: el esquema y árbol no se sincronizan en vivo, a diferencia de codificaciones y respuestas.

**QDPX importó categorías con tipo incorrecto.**
Los tipos no declarados pueden inferirse. Revisa **Esquema → Categorías**.

**Las respuestas de categoría de QDPX aparecen a mi nombre.**
REFI-QDA no conserva la autoría de atributos, solo la de fragmentos. Usa `.qualilab` para preservar respuestas por investigador.

**Eliminé un código, categoría o documento por error.**
Busca una instantánea previa en **Proyecto → Copias espejo del proyecto** y **Restaura**; los PDF eliminados no vuelven. Si no hay, recupera un `.qualilab` externo. Ctrl+Z solo deshace codificaciones de fragmentos.

**No puedo confirmar la cuenta o se rechaza el código.**
Escribe **todos los números** del correo en **Confirma tu registro**. El código dura una hora; tras reenviar, solo sirve el **último**. Revisa spam. Si ya confirmaste, usa **Ya confirmé — quiero entrar**.

**Olvidé la contraseña.**
En el acceso a nube, pulsa **Olvidé mi contraseña**, indica correo y envía. El enlace abre la pantalla de **nueva contraseña**; después inicia sesión. Es temporal y de un solo uso: si caducó, solicita otro. Revisa spam. La respuesta en pantalla es igual exista o no esa cuenta.

Si se agotó el **límite horario de correos del servidor**, espera y reintenta; afecta a confirmaciones y recuperaciones, no solo a tu cuenta. Si persiste, informa al administrador, que puede configurar SMTP propio.

**La IA omitió documentos o partes de uno.**
Revisa la **franja amarilla**: distingue documentos excluidos y documentos incluidos solo por sus primeras ~133 páginas. Para el límite total, selecciona menos; para el individual, divide el documento. Consulta [17.1](#171-cómo-funciona-la-ia-aquí).

**Texto desordenado tras importar PDF.**
Los PDF visuales o escaneados pueden extraerse mal; las tablas no se reconstruyen. Prefiere `.docx`/`.txt`, pega texto limpio o usa OCR según el caso.

---

## 19. Atajos de teclado

| Atajo | Dónde | Acción |
|---|---|---|
| **Clic derecho** en selección | Codificación | Aplicar/crear código, igual que la barra flotante |
| **Clic derecho** en resaltado | Codificación | Quitar/cambiar código, anotar |
| **Clic derecho** en resaltado ajeno | Lectura ▸ Documentos, colectivo | Acuerdo/desacuerdo o deshacer |
| **↑ ↓ / Enter** | Menú contextual | Elegir/aplicar código |
| **Ctrl+K** | Cualquier pantalla | Paleta de documentos, pantallas y acciones |
| **?** | Fuera de campos de texto | Mapa de atajos |
| **1 … 5** | Codificación con selección | Aplicar un código reciente |
| **Ctrl+Z** | Codificación | Deshacer aplicación o eliminación de codificación |
| **Enter / Shift+Enter** | Búsqueda | Siguiente/anterior coincidencia |
| **Enter / Esc** | Renombrar documento | Confirmar/cancelar |
| **Delete / Backspace** | Codificación | Eliminar el resaltado con foco |
| **↑ ↓** | Árbol de códigos | Recorrer |
| **← →** | Árbol | Cerrar/abrir nodo |
| **Home / End** | Árbol | Primer/último código visible |
| **Enter / Espacio** | Árbol | Seleccionar o aplicar si hay texto seleccionado |
| **Tab / Shift+Tab** | Diálogo | Recorrer controles sin salir |
| **Esc** | Cualquier pantalla | Cerrar menú, búsqueda, paleta, filtro o diálogo; restaurar foco |
| **← →** | Barra de pantallas | Pantalla anterior/siguiente |
| **← →** | Divisor de panel | Ajustar ancho de 16 en 16 px |
| **Doble clic** | Divisor de panel | Restaurar ancho |

---

## 20. Glosario

- **Código**: etiqueta aplicada a un fragmento, organizada jerárquicamente.
- **Categoría / atributo**: propiedad del documento completo; siete tipos de campo.
- **Codificación**: aplicación de un código a un fragmento, con autor y capa.
- **Capa**: *individual* o *final* consolidada.
- **Referencia**: capa final consolidada por el equipo.
- **Reconciliación**: pantalla para consolidar la referencia en colectivos.
- **Memo**: nota analítica de proyecto, documento, código o fragmento.
- **Censura**: código para enmascarar fragmentos en transparencia e IA; los formatos de trabajo salen completos ([5.5](#55-censura-enmascarar-fragmentos-sensibles)).
- **Historial del proyecto**: operaciones con fecha y autor; no deshace ni guarda contenido eliminado ([11.1](#111-historial-del-proyecto-registro-de-auditoría)).
- **Coocurrencia**: códigos aplicados al mismo texto o a fragmentos superpuestos.
- **Conexión**: relación nombrada entre códigos o código/categoría; anotación, no medida ([7.5](#75-conexiones-relacionar-códigos-entre-sí)).
- **Desacuerdo**: veredicto sobre un código ajeno, sin borrar ni sumar al conteo ([9](#9-lectura)).
- **Instantánea**: estado del proyecto que puede restaurarse ([16](#instantáneas-del-proyecto-punto-de-restauración)).
- **Modo de almacenamiento**: archivo, borrador o nube.
- **Tipo de proyecto**: individual o colectivo.
- **Rol**: admin, miembro o solo lectura, con permisos ajustables en la matriz ([13](#qué-puede-hacer-cada-rol-se-decide-al-crear)).
- **REFI-QDA / QDPX / QDC**: estándar abierto de intercambio entre herramientas QDA.
- **ATI**: *Annotation for Transparent Inquiry*, método del QDR.
- **W3C Web Annotation**: estándar abierto para datos de anotación.
- **Opt-in**: activación voluntaria de una función inicialmente desactivada.
- **BYO-key** (*bring your own key*): usar tu propia clave de API, guardada en el navegador.
- **Explorar con IA**: pantalla experimental, antes MCP/RAG, donde el modelo solicita material mediante llamadas visibles ([17.6](#176-explorar-con-ia-la-ia-solicita-el-material-en-vez-de-recibirlo)).
- **Proveedor / LLM**: servicio de modelo de lenguaje: Gemini, OpenAI, Anthropic, Azure, compatible con OpenAI u Ollama local.
- **Ollama local**: modelo en tu máquina mediante [Ollama](https://ollama.com/), llamado directamente desde el navegador; el material no sale de la computadora.

---

<p align="center"><sub>QualiLab, tu laboratorio de investigación cualitativa. Desarrollado por <a href="https://orcid.org/0000-0002-5165-6232">Luiz Pimenta Filho</a> (LabDados / FGV Direito SP). Licencia MIT.</sub></p>
