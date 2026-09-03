<p align="center">
  <a href="https://luizpf42.github.io/QualiLab"><img src="images/logo.png" alt="QualiLab" width="180"></a>
</p>

<p align="center"><a href="README.md"><img src="https://flagcdn.com/br.svg" width="16" alt="BR"> Português</a> · <b><img src="https://flagcdn.com/gb.svg" width="16" alt="GB"> English</b></p>

# QualiLab

**o seu laboratório de pesquisa qualitativa / your own lab for qualitative research**

[![DOI](https://zenodo.org/badge/1274527946.svg)](https://doi.org/10.5281/zenodo.21935682)

> 🌐 **A note on language:** since v1.4.48 the **application interface exists in English**, and it follows your browser — a browser set to Portuguese opens in Portuguese, any other language opens in English, and the picker in **My account** overrides that. What stays in Portuguese is deliberate: the requests QualiLab makes to the AI (translating them changes the model's behaviour, and that has to be measured first) and the redacted-passage marker inside exported files (so the same file does not change content depending on who exported it). Interface labels below sometimes give the Portuguese wording in quotes: the **screenshots are still of the Portuguese interface**, so those quotes are there to match the images, not because the tool is Portuguese-only. The [`CHANGELOG.md`](CHANGELOG.md) remains in Portuguese, as does the contributor guide, which lives in the development repository.

QualiLab is a **free and open-source** tool for qualitative data analysis. It runs entirely in a single `index.html` file — no installation, no server of its own, no subscription.

> Inspired by **[Taguette](https://www.taguette.org/about.html)**, **[Magnolia](https://www.caledavis.eu/magnolia.html)**, **[QualCoder](https://github.com/ccbogel/qualcoder)** and **[OpenQDA](https://openqda.org/)** — projects that deserve your support; credits are [at the end](#credits-reference-and-license).

Use the tool **[here](https://luizpf42.github.io/QualiLab)** / Install it as an app **[here](docs/MANUAL.en.md#install-as-an-app-and-open-without-internet)** — it opens without internet, gets its own window and icon, and double-clicking a `.qualilab` starts opening in QualiLab; **on Windows, install through Edge**.

📖 **New here?** Start with the **[user manual](https://luizpf42.github.io/QualiLab/manual.html)** *(Portuguese)*, or the [English manual](docs/MANUAL.en.md): a complete, step-by-step guide to every screen. · 📝 **What changed in each version:** [`CHANGELOG.md`](CHANGELOG.md) *(Portuguese)*

*The **version in use** is shown in the app's own header and footer. Quote that number when reporting a problem: without it there is no way to know which build your browser loaded.*

> ⚠️ **Read this before using it with real data.** QualiLab is a **personal, experimental** project, under the **MIT license, WITHOUT ANY WARRANTY**, which **has not undergone a security audit**; **bugs are to be expected**. And it does **not anonymize** your material: redaction masks only what **you** marked by hand, and only in some outputs. Where each mode of use sends your data is covered in **[Where your data lives](#where-your-data-lives)**; what the tool does not do for you, in **[Limits and responsibility](#limits-and-responsibility)**.
>
> **Disclaimer.** QualiLab is a personal project by **[Luiz Pimenta Filho](https://orcid.org/0000-0002-5165-6232)**, within **[LabDados / FGV Direito SP](https://direitosp.fgv.br/nucleos-de-pesquisa/laboratorio-dados-pesquisa-empirica-direito-labdados)**. **It does not represent the position of, nor imply any responsibility of, any institution (including FGV).** The author **accepts no liability** for data loss, leakage, misuse, or any consequences of using the software. Use it at your own risk, with the ethical and legal precautions your research requires.

---

## Why it exists

A systematic survey of 28 qualitative data analysis tools, published in 2025 by Jan Küster and Karsten D. Wolf (University of Bremen), concludes that **"the current state of CAQDAS is insufficient to fully support open science qualitative research practices"**. Among the findings: the field is dominated by proprietary software (13 of the 28 tools examined), with licenses ranging from **€95 to €430 per user/year**; real-time collaboration exists in **5** of the 28; an audit trail of the analysis process, in **7**; a public security policy, in **2**; and, of the 9 tools with integrated AI, **none reveals the *system prompt*** that precedes its calls to the user, while only **2** allow using a local or self-hosted model. The authors also note that the veteran tools "have evolved into large, complex, heavyweight applications, with at times confusing interfaces".

To those findings QualiLab adds a complaint from practice that the survey does not measure: support for **closed attributes** (structured attributes per document) is poor in the big tools, which forces the researcher to keep parallel spreadsheets for what should be integrated into the analysis.

QualiLab tries to be as intuitive as possible: you load a document, select a passage, and you are already coding — no prior configuration. At the same time, it offers a native attribute scheme (closed text, open text, number, date, yes/no, multiple choice, checkbox) that coexists with passage coding in an integrated way, in the same environment. Whoever needs to reconcile thematic analysis with structured attribute collection no longer has to switch between tools.

The tools available, paid or free, also do not have collaboration and collective research as their primary goals. QualiLab aims for a good middle ground, being developed for individual and collective needs alike: per-researcher coding layers, reconciliation, admin and member roles, all native, with no parallel spreadsheet or third-party tool needed to coordinate the team.

> Küster, J.; Wolf, K. D. **The Current State of CAQDAS is Insufficient for Open Science Qualitative Research.** *Electronic Communications of the EASST*, v. 85 (deRSE25), 2025. DOI [10.14279/eceasst.v85.2709](https://doi.org/10.14279/eceasst.v85.2709), CC-BY 4.0 license. The authors develop [OpenQDA](https://openqda.org/), which is part of the examined sample. The numbers above describe the 28 tools **they** examined (QualiLab was not among them) and hold for the 2025 survey.

### Where QualiLab stands on that yardstick

A direct comparison with the findings of Küster & Wolf (2025) on 28 qualitative analysis tools. The middle number is how many of the 28 meet the criterion, according to their survey.

| Criterion | Survey (n=28) | QualiLab |
|---|---|---|
| Free license | 12 free, 13 proprietary, 3 unlicensed | ✅ MIT |
| Cost per user/year | €95 to €430 among the proprietary ones | ✅ €0 |
| Runs without technical skill to install | singled out as **the** bottleneck of the field's open software | ✅ it is a URL — no installation, no build |
| Windows · macOS · Linux · Web | 13 · 12 · 7 · 18 | ✅ all four |
| Full REFI-QDA interoperability | 9 (7 of them proprietary) | ✅ QDPX + QDC, validated against the official `Project.xsd` |
| Real-time collaboration | 5 | ✅ |
| No mandatory server | 20 offer some form of *on-premise* | ✅ File mode has no server at all; the cloud can be your own |
| Lossless export for review | "data loss on export makes reproduction impossible" | ✅ the `.qualilab` file is a complete *round-trip* |
| **AI `system prompt` visible to the user** | **0** | ✅ the entire prompt is shown before sending |
| **Editable `system prompt`** | 0 | ✅ stance, instructions, and injected memos |
| Local or self-hosted AI model | 2 | ✅ local Ollama, custom endpoint, Azure |
| AI analysis without passing through the vendor's server | 0 among the proprietary ones | ✅ BYOK — the browser calls the provider directly |
| Code text · PDF | 26 · 6 | ✅ both (in PDF, text **and** region) |
| Code audio · video · image · spreadsheet | 11 · 12 · 11 · 2 | ❌ out of scope (below) |
| **Audit trail of the process** | 7 | ✅ since 1.4.51: the project's operation history (Memos ▸ History), append-only in the cloud, exportable as CSV, summarized in the Report |
| Citation metadata (`CITATION.cff`) | 3 | ✅ |
| Public security policy | 2 | ✅ [`SECURITY.md`](SECURITY.md) |
| Archived with a DOI (Zenodo) | 4 | ✅ [`10.5281/zenodo.21935682`](https://doi.org/10.5281/zenodo.21935682) |
| Plugin architecture · scripts | 1 · 3 | ❌ by decision (below) |

**What is left out by scope, not by accident.** QualiLab is a **text and PDF** tool. Audio, video and image require annotation over a timeline or over pixels, which is another product, not one more feature. For those, see [ELAN](https://archive.mpi.nl/tla/elan/), [Transana](https://www.transana.com/), [dicto](https://dictoapp.github.io/dicto/) or [QualCoder](https://github.com/ccbogel/qualcoder).

**Extensibility through data, not plugins.** QualiLab has no plugin architecture, and does not intend to have one: it clashes head-on with the single-file design that lets the app run with no installation and no build. What it offers instead are three open surfaces: the **`.qualilab`** format (lossless, documented), export to **REFI-QDA** and **W3C Web Annotation**, and a **read-only MCP server** that lets any assistant read the corpus with redaction already applied.

---

## What it does

One line per feature: this is the inventory. The **step by step** for each one is in the [user manual](docs/MANUAL.en.md).

### Material

| Feature | What it is |
|---|---|
| **Input formats** | `.txt`, `.md`, `.docx`, `.pdf` and pasted text. Spreadsheet (`.csv`/`.xlsx`): each row becomes a document. **Zotero** folder (RDF): each reference with a PDF becomes a document, its metadata become attributes and the reference becomes a memo |
| **PDF reflow** | detects **columns** (a two-column article stops coming out scrambled), removes repeated headers, footers and page numbers, reassembles paragraphs regardless of line spacing, fixes end-of-line hyphenation and de-duplicates over-printing |
| **Clean `.docx`** | headings, lists and tables become clean text through line breaks and indentation, **with no injected markers** (which would become codable content) |
| **Original PDF** | the real page, with your highlights drawn over it; you can select and code right there |
| **In-browser OCR** | the whole page or **by area** (drag a rectangle, review the recognized text, code it). Offline, no server |
| **Passage page** | the passage ↔ page correspondence survives the round-trip and shows up in Reading, in the Report and in the exports (CSV/JSON/W3C) |
| **Edit the extracted text** | fix the extraction and it **automatically re-anchors the highlights** already made |
| **Quality signal** | warns when a document probably came out badly extracted (empty, no spaces between words, broken glyphs, low-confidence OCR) |

### Coding and scheme

| Feature | What it is |
|---|---|
| **Code passages** | select and apply with the right-click menu; **Ctrl+Z** undoes the last one |
| **Hierarchical codes** | color per family and shade per depth; customizable hue and saturation, propagated to the subtree |
| **Family × code** | one rule only: whatever has subcodes **groups** and receives no passages; the family count sums its children |
| **Document attributes** | seven types (closed text, open text, number, date, yes/no, multiple choice, checkbox). Each one's description is the **coding instruction** — the same text a person reads and that goes into the AI prompt |
| **Bulk scheme edits** | group, merge, promote to top level, **split** a code into subcodes, and a spatial **map** of the codes |
| **Search** | literal (regular expression, case, whole word) and global across the whole corpus |
| **Redaction** | a code flagged 🚫 masks its passages in the transparency outputs and in what goes to the AI |

**Semantic search (`≈ termos`), no key and no server.** You describe the *meaning* you are looking for and the app suggests **words and expressions from your own corpus** close to it; clicking fires the **literal** search for them. It runs with [transformers.js](https://github.com/huggingface/transformers.js) and the [`paraphrase-multilingual-MiniLM-L12-v2`](https://huggingface.co/Xenova/paraphrase-multilingual-MiniLM-L12-v2) model **inside the browser**: the model comes to the data, not the other way around — which is why it is available in file and draft modes without breaking their privacy promise. Cost: a one-time download (~113 MB on the WASM path, ~224 MB on WebGPU) and ~10 s on the first query of the session. The index is a local cache, rebuilt when the corpus changes, and does **not travel** in the `.qualilab` file.

### Screens

| Screen | What for |
|---|---|
| **Coding** ("Codificação") | the reader with the highlights, plus the attribute and code panels |
| **Reconciliation** ("Reconciliação") | *(collective)* groups overlapping codings, shows who agrees and consolidates the reference layer |
| **Reading** ("Leitura") | re-read the result: the whole document with highlights in context, or every passage of one code |
| **Charts** ("Gráficos") | frequency, word cloud, co-occurrence, coverage, code × attribute, time, and inter-coder agreement. Clicking a bar opens Reading at that code. Optional **bar textures** (hatching) to tell similar colors apart — useful for color blindness, and exported along in the SVG/PNG |
| **Memos** | analytic note per project, document, code **or passage**, shared and co-editable |
| **Scheme** ("Esquema") | organize codes and attributes in bulk |
| **Report** ("Relatório") | the publication hub (below) |

### Team and project

| Feature | What it is |
|---|---|
| **Layers** | each researcher codes in their own (`individual`); the team consolidates a reference layer (`final`) in Reconciliation. Also applies to attribute answers |
| **Roles** | admin, member and read-only, **enforced by the server** (RLS), not hidden in the interface: deleting a document or code, editing shared text, merging codes and importing require admin. A read-only member can still **comment**: they write memos, which is the reviewer's gesture |
| **Document assignment** | a documents × researchers matrix, with rotation: each person only **sees** what was assigned to them |
| **Blind coding** | each person only sees their **own** work (the reference layer disappears too). With the same document given to two people, the study becomes double-blind |
| **Locked definitions** | only admins edit what each code means, so the instrument does not change mid-round in a calibration study. Reading stays open |
| **Project types** | individual (everything goes straight to the reference layer) or collective |
| **Real time** | codings and attribute answers sync live; the code scheme and attributes require a reload |
| **Where the data lives** | a file on disk, a draft in the browser, or the cloud — switching between them is one click in the project hub, no manual export/import |
| **Your own cloud** | point the app at a **Supabase project of yours**, from the entry screen or the hub |

### AI: off by default, and with your own key

**It ships off, and turning it on is a deliberate act.** Every new project — in the cloud, in a file or in the draft — asks whether the AI features should be available, and the option **pre-selected is "No AI"**: enabling requires changing the choice, and closing without answering keeps it off. The choice has three scopes (**nobody** · **admins only** · **everyone**), is **enforced in the database** rather than merely hidden in the interface, and **travels inside the `.qualilab`** file.

A badge in the header shows the state at all times — **✔︎** enabled, **~~IA~~** off — and it is also how you change it. With AI off the screens disappear; with it on, **nothing is sent to any model unless you ask**: every call is a click of yours.

**The default is the browser calling the provider directly**: with your key (stored only in the browser), **no QualiLab server sees the material** under analysis. The `ai-ask` Edge Function covers only two cases: a *Custom*/*Azure* endpoint that does not allow browser calls (CORS) and an eventual server key — which the public instance does not have.

| Feature | What it is |
|---|---|
| **Auto-coding** ("Auto-codificação") | five assistants: **Suggest Coding** (a second coder, recall) · **Suggest Attributes** (fills existing attributes) · **Define Attribute** (writes the instruction from the answers you already gave) · **Organize Codes** · **Repeat Coding** (this one **without AI**: finds exact occurrences). In all of them: the AI **proposes**, you approve or reject **item by item**, nothing is saved without confirmation |
| **Analyze with AI** ("Analisar com IA") | a conversation about the material you select (documents, passages by code, or both), citing sources, with a selectable methodological stance and saved prompts |
| **Explore with AI** ("Explorar com IA") *(experimental)* | the AI **asks for** the material instead of receiving a pre-cut selection, through read-only tools; **each call is shown on screen**, read from the data and not from the model's narration |
| **Visible, editable prompt** | **⚙ Configure Prompt** ("Configurar Prompt") shows what will be sent, section by section, with the active model, the token estimate and the **cost** — before sending |
| **Blind mode** | the AI answers **without seeing** your reference layer and the panel returns an agreement score: it stops being a checker and becomes a measuring stick |
| **Project memory** | an insights journal across sessions; the AI proposes, you approve, and each entry has a usage switch |
| **Providers** | Gemini, OpenAI, Anthropic, Azure OpenAI, any API in the classic OpenAI format (DeepSeek, Mistral, Qwen, vLLM) and **local Ollama** — the only one where nothing leaves your machine |
| **Material cuts are announced** | there is a cap per document and per send; whenever something is cut, a banner says **how many documents were left out** and how many made it in only partially |

> **Honest caveat:** turning AI off is **not a technical barrier** — anyone can copy a passage and paste it into another tool. What the switch removes from the application is **bulk** work, which is what actually shifts an analysis. That is why the Report **reports** what went through QualiLab, instead of promising that nothing went around it.

### Publication and transparency

| Output | What it is |
|---|---|
| **Interactive Report (ATI)** | a **self-contained** HTML page (no server) with the highlighted passages clickable; clicking opens the analytic note in a side panel. Equivalent to the QDR's **Annotation for Transparent Inquiry** *overlay*, hostable by you |
| **Standard Report** | a section-based builder, with live preview, **copy text** and **print / PDF** |
| **Web Annotation (W3C)** | the annotations in the [W3C open standard](https://www.w3.org/TR/annotation-model/) (JSON-LD), the same data language under ATI, [hypothes.is](https://web.hypothes.is/), Anno-REP and Dataverse |

In a collective project all three respect the chosen layer; in all of them, **redacted** passages come out masked, and ATI and W3C additionally offer **author anonymization**.

### Audit trail and mirrors

QualiLab keeps a **project history**: a list, in time order, of what **changed** the project, with date and author. It works like this:

- **What goes in is an operation, not every click.** Importing a file, merging or splitting a code, deleting a document, a code or an attribute, clearing the content, editing a document's text, applying a batch (Repeat Coding and the AI screens), consolidating in Reconciliation, changing the project's type or settings, joining and leaving the team, exporting, mirroring and restoring. Each line keeps **names and counts** ("Deleted document X: 12 codings deleted with it"), never the corpus text.
- **What stays out, on purpose.** Coding one passage at a time does not become a line: the coding itself already keeps author, date and origin (manual or suggested by AI). Reading, navigating and screen time stay out too: the history records what changed the project, not people's behaviour.
- **Where it is read.** In **Memos ▸ Project history**, with a filter by operation type and a text search (type a code's name to see what has already happened to it), and to export as CSV. In the **Report**, a checkbox on by default adds to the three outputs a summary of the process: how many imports, merges, deletions, batch applications, consolidations and exports, since when.
- **It undoes nothing.** It is a record, not a time machine: it says *what* happened, not *how things were*. What brings a state back is the **mirror** (below).
- **In the cloud it is append-only**: not even the administrator edits or deletes a line through the database interface. Under blind coding, each person sees their own events and the team ones; the administrator sees everything. Joining, leaving and role changes are written by the server itself, in the same transaction, so not even an outdated client skips the record.
- **It travels in the `.qualilab`** and survives "Clear content"; re-importing the same file does not duplicate it. QDPX has nowhere to keep it, and the export menu says so. It is not forensic proof: whoever operates the server, or owns the file, can always alter it. The history starts at version 1.4.51; what came before was not recorded, and the first line says so.

The **mirror** is the other half: a snapshot of the whole project (documents, attributes, codes, codings, memos, AI conversations and memories) that can be **restored**. You create one by hand, with a label, from the project pill; and QualiLab creates one on its own **before** clearing, deleting, merging, splitting, editing text and restoring (at most one every 10 minutes; the 5 most recent automatic ones are kept, and the automatic mirror has a switch, on by default, because each mirror is a copy of the text and the analysis). Restoring mirrors the current state first, brings the project back to the snapshot and **records the restoration in the history, which is never restored**. A mirror keeps neither the original PDFs nor is it an external backup: it lives where the project lives.

### Pointing your assistant at the corpus

*Experimental, and not part of the app: it lives in its own repository, from which anyone can install it.*

If you already pay for a Claude or ChatGPT subscription, you can put it to work: instead of QualiLab talking to the model through your key, **the client you already use** reaches the corpus. [**LuizPF42/QualiLab-plugin**](https://github.com/LuizPF42/QualiLab-plugin) packages a **read-only MCP server**. The assistant gets the **same tools** as the Explore with AI screen (the MCP/RAG screen up to v1.4.37) — literally the same code, extracted from the `index.html` — with the same vocabulary and the same rules of conduct.

You point it at a **folder**, not a file: the assistant lists the projects in it and opens the one you ask for. **No tool writes.** Redaction applies just the same, with one honest caveat: in the Claude chat the mask is a real boundary, because the server is the only path to the corpus; in an **agentic** client with file tools of its own, the `.qualilab` carries the raw text, so there the mask is a respected convention, not a lock.

---

## Where your data lives

This is the question that decides how much of the tool you can use, and the answer depends on the mode. The golden rule: **the material only leaves your device if you let it.**

- **File / Draft**: they stay **on your device** and do not leave it.
- **Cloud**: they are sent to a **third-party server** (Supabase), become subject to that provider's terms and leave your direct control.
- **AI**: it **ships off** — every project is born without it, and enabling it is a deliberate act ([above](#ai-off-by-default-and-with-your-own-key)). Once enabled, the passages you **ask** to have analyzed are sent to the **AI provider** you use (Gemini/OpenAI/Anthropic/Azure…), under its policy; **local Ollama** is the exception (it runs on your machine, nothing leaves it). Redaction is masked before sending.
- **Publication** (Interactive Report / Web Annotation): whatever you publish becomes **public**.

QualiLab operates in three modes, chosen on the **entry screen** (or reopened automatically):

| Mode | Storage | Indicator | When to use |
|---|---|---|---|
| **File** | a `.qualilab` file on disk | `arquivo ·` | Serious solo work, sensitive data, offline use |
| **Cloud** | Supabase (Postgres + Auth) | `nuvem ·` | Collaborative teams, multiple devices |
| **Draft** | the browser's `localStorage` | `rascunho ·` | Quick trials, no commitment (ephemeral) |

File and cloud are the real working options; the **draft** is the frictionless entrance (one click, zero configuration), but **ephemeral**: the data stays only in that browser and vanishes if you clear the site data. That is why a discreet notice below the header suggests, at any time, **saving as a file** or **connecting to the cloud** (the migration is one click in the project hub, no export/import). A file once opened **reopens by itself** in the next session (with the browser's permission); "Leave this file" ("Sair deste arquivo") in the hub returns to the entry screen.

### File mode: for sensitive data

In file mode, the project is saved as a `.qualilab` file (JSON) **visible in the file system**: in any folder, external drive, encrypted volume or institutional server. Zero network traffic. Zero localStorage. Works fully offline.

- Available in **Chrome and Edge** (File System Access API). Firefox and Safari fall back to local mode.
- On the entry screen, click **"New file…"** ("Novo arquivo…") or **"Open file…"** ("Abrir arquivo…") to get started.
- The app automatically reopens the last file in the next session (with the browser's permission).
- Ideal for clinical interviews, judicial data, research under ethics-board approval that requires an air-gapped environment.

### Draft mode: automatic folder backup

In draft mode (`localStorage`, a 5–10 MB limit), you can enable an **automatic backup**: the app keeps a `backup-automatico.qualilab` file always up to date in a folder on your computer — for example the same folder as the `index.html`. It is a redundant mirror, **not** the same as file mode (which writes straight to disk as primary storage): it keeps saving to the browser normally, and also writes that file in the background on every change (with a small pause before writing, larger in big projects, so as not to freeze the tab). To become true file mode (green pill), use **"Save as file"** ("Salvar como arquivo") in the project hub.

- Enable it via **project pill → Automatic folder backup → Choose folder…** (available in Chrome and Edge).
- If the app fails to actually save (`localStorage` full, unsupported browser), a red warning appears on screen with a shortcut to download the project right away; this does not depend on the automatic backup being on.

### Cloud mode: connection status

- The header shows an amber `offline` indicator when the connection drops.
- **A write that fails for a transient reason enters a queue and is retried on its own** (since v1.4.7). This covers day-to-day work: codings, attribute answers, notes, saved AI conversations and memories. The change stays visible on screen while it waits, the header shows how many are pending (click to retry immediately) and **closing the tab does not lose the queue** — it comes back when the project is reopened.
- **Structural** changes stay out of the queue on purpose and fail loudly right away: creating/deleting documents, changing the code scheme, project management and imports. In collective research, replaying that kind of change minutes later would produce a state nobody asked for.
- If the cloud **definitively rejects** a change (your role in the project changed, or someone deleted the target), it does not disappear silently: a notice shows what was rejected, with a shortcut to download a `.qualilab` before redoing it.

**QualiLab does NOT anonymize or detect personal data** (names, ID numbers, health data) in document content. **Redaction** masks only the passages **you** marked by hand, does **not** detect on its own what is sensitive, and does **not** cover the exports (QDPX/CSV/JSON come out with the raw text). **There is no automatic safety net.**

---

## Running locally

There is no build step. Just open the file:

**Simplest option:** use it directly at:
```
https://luizpf42.github.io/QualiLab
```

**Installable as an app (PWA):** "Install QualiLab" in the address bar gives it its own window and an icon in the start menu/dock. Once installed, the app **opens without internet from the very first visit** (the offline copy is stored at install time; with a network, you always get the newest version, and the status bar tells you when there is an update) and **double-clicking a `.qualilab` opens it in QualiLab**, like a `.docx` opens in Word. **On Windows, install through Edge**: it is Edge that registers `.qualilab` with the system with its own type name and icon — installing through Chrome works, but the `.qualilab` icons come out **broken** — the Explorer's generic blank sheet (a Chrome-on-Windows limitation, not QualiLab's). What a PWA is, why install it and the step by step are in the manual, under **[Install as an app](docs/MANUAL.en.md#install-as-an-app-and-open-without-internet)**.

**To use it offline:** download the `index.html` and double-click to open it straight in the browser (`file://`), **no server needed**: it only imports external libraries via `https://` URLs (never by local file path), so it does not hit the classic ES-module-over-`file://` block. In Chrome/Edge you can even use **local File** mode, which saves the project as a `.qualilab` visible on disk, next to the `index.html`.

**If something still fails to load** (a security extension, corporate browser policy, or another browser with a stricter `file://` block), serve it from a local server as an alternative:
```bash
python -m http.server 8000   # or: npx serve .
```

The **front-end core (Preact + htm) comes embedded** in the `index.html` itself, so the app opens and reaches the entry screen **even with no network**. The remaining libraries (pdf.js, mammoth, JSZip, sql.js, XLSX, tesseract.js, transformers.js and supabase-js) are loaded **from CDNs, on demand**: each one is only fetched when you use the feature that depends on it, and a missing network takes down **that feature**, with a message, instead of the whole app.

---

## Cloud setup (Supabase)

Enabling collective mode requires a free **Supabase** project.

### 1. Credentials

At the top of the `index.html`, fill in:

```js
let SUPABASE_URL  = "https://YOUR-PROJECT.supabase.co";
let SUPABASE_ANON_KEY = "YOUR_ANON_KEY";
```

The `anon key` is public by design and is protected by the RLS policies. You can also provide it at runtime through the project pill → Connection.

### 2. Database

Open the Supabase **SQL Editor**, paste the contents of [`supabase/schema.sql`](supabase/schema.sql) and click **Run**. The script is idempotent (it can run more than once) and creates all the tables, functions (RPCs), RLS policies and the realtime configuration. **Updating an existing project?** Just run `schema.sql` again. Being idempotent, it adds whatever is missing (e.g. the `ia_memory` table for the AI project memory) without touching existing data.

### 3. Authentication

Under **Authentication → Providers**:
- Enable **Email** for e-mail and password login. **Password recovery** ("Forgot my password") already works with that: the app sends the reset link back to the app's own URL, which needs to be under **Auth → URL Configuration → Redirect URLs** (the same `.../**` entry used by Google login covers it). ⚠️ **Beware Supabase's built-in SMTP: it is ~2 e-mails per hour, and the quota belongs to the project** (measured in Jul/2026), **shared between signup confirmation and password recovery**. In other words: two people using it in the same hour and the third receives nothing. For real use, **configure your own SMTP** under `Authentication > Emails > SMTP Settings`: the limit then starts at 30/hour and becomes adjustable under `Authentication > Rate Limits`. Any SMTP service works (Brevo, Resend, AWS SES, Postmark, SendGrid, ZeptoMail); **Brevo** does not require your own domain, as it verifies an individual sender.
- Do **not** enable *Allow anonymous sign-ins*: QualiLab no longer uses a guest mode. The three flows are **file** (on disk), **cloud** (with login) and **draft** (local, temporary).
- **Signup confirmation is by TYPED CODE, not by link** (v1.4.19). The app opens a screen asking for the number that arrives by e-mail, so the **Authentication → Emails → Confirm signup** template must send `{{ .Token }}`, and **not** `{{ .ConfirmationURL }}`. This exists because corporate-mailbox link scanners (Safe Links and the like) **open the link on their own** and burn it before the person clicks, which produced "invalid or expired link" for people who had never clicked. ⚠️ **Supabase only unlocks template editing once your own SMTP is configured**: without it, their default template applies, and it sends a link — so **configure SMTP before the template**, or the app's screen will ask for a number the e-mail does not carry. The code length is a project setting (**Authentication → Providers → Email**, 6 to 10 digits); the app accepts any of them and promises no specific count.
- Alternative: disable **Confirm email** and signups go straight in, with no code at all.

### 4. AI (`ai-ask` Edge Function: optional — server key and CORS fallback only)

The **default is BYOK**: each researcher brings their own key and the **browser calls the provider directly**, passing through no server at all. On that path the function **is not used**. Deploy it only if you are going to (a) offer a **server key** (kept out of the public HTML) or (b) support *Custom*/*Azure* endpoints that do not allow browser calls (CORS) — in which case the function acts as the proxy. **Local Ollama** never uses it (Supabase's server cannot reach the researcher's `localhost`).

1. **(Optional, only if offering a server key)** Generate a provider key: [Gemini](https://aistudio.google.com/apikey) (free), [OpenAI](https://platform.openai.com/api-keys) or [Anthropic](https://console.anthropic.com/settings/keys). Skip this step if each researcher will use their own key (BYOK).
2. **Secrets** → under *Edge Functions → Secrets*, add `GEMINI_API_KEY` and/or `OPENAI_API_KEY` and/or `ANTHROPIC_API_KEY` (configure only the one(s) you will use). Optional: `GEMINI_MODEL`/`OPENAI_MODEL`/`ANTHROPIC_MODEL` to change each one's default model (`gemini-3.1-flash-lite`/`gpt-5.4`/`claude-sonnet-4-6`) without re-editing the code.
3. **Deploy** → under *Edge Functions*, create/edit the `ai-ask` function, paste the contents of [`supabase/functions/ai-ask/index.ts`](supabase/functions/ai-ask/index.ts) and click **Deploy**. (No CLI needed.)

With no key configured, the AI screens return a clear error; the rest of the app works normally.

**Personal key (BYOK)**: under **My Account** ("Minha Conta"), each researcher can enter their own key (for any of the three providers) and choose the model. It is saved only in their browser (never on the server) and applies to their analyses — which go **directly** from the browser to the provider. The **Azure** and **Custom** providers are pure BYOK (they never use a server key) and are the only ones that may fall back to the Edge Function, when the endpoint does not allow the browser. **Local Ollama** requires none of this server setup (see "AI analysis" above).

---

## Formats and interoperability

Nothing you produce here is locked in here. This section gathers what goes in, what comes out, and what each format preserves or loses.

### Import and export

| Format | Imports | Exports | Notes |
|---|:---:|:---:|---|
| **`.qualilab`** (native) | ✅ | ✅ | The whole project, lossless, in any mode. When importing into a collective project, it **preserves each source researcher's answers**. An open, documented format ([below](#the-qualilab-is-not-a-magic-format)) |
| **QDPX** (REFI-QDA) | ✅ | ✅ | Interchange with ATLAS.ti, MAXQDA, NVivo, Quirkos, QualCoder. The generated package is **validated against the official `Project.xsd` (v1.0)** by a round-trip harness kept in the development repository — which is an **attempt at intercompatibility, not a guarantee**. Imports ATLAS.ti `.qdpx` files with their PDFs |
| **QDC** (REFI-QDA codebook) | ✅ | ✅ | Only the codebook (which is all the format holds). Compatible with Taguette's codebook |
| **`.sqlite3`** (Taguette) | ✅ | ✕ | Taguette's native project read straight in the browser, via [sql.js](https://github.com/sql-js/sql.js): documents, tags with hierarchy, and passages |
| **Zotero RDF** (folder) | ✅ | ✕ | A collection exported with files. You choose which metadata become attributes and what gets listed, by name, before anything enters |
| **Spreadsheet** (`.csv`/`.xlsx`) | ✅ | ✅ | One row per document on the way in; and the **attributes CSV has a way back** — fill it in the spreadsheet and re-import, with a preview of what changes before saving |
| **Web Annotation (W3C)** · **ATI reader** | ✕ | ✅ | On the Report tab. Redaction masked |
| **Passages CSV** · **JSON** | ✕ | ✅ | One passage per row (document, code, layer, author); or the complete project with layers and authors |

> The **work and migration** formats come out **raw, redaction included**: they are how you take your material to another tool and bring it back, and masking there would be irreversible loss. The **transparency** outputs are the ones that mask. The export menu says so at the moment of export.

### The `.qualilab` is not a magic format

The native format is **deliberately machine-readable**, and that is a direct answer to the survey's complaint about closed project formats that become data silos. There is no proprietary binary, no secret schema, and **you do not need QualiLab to read a `.qualilab`**.

There are two shapes, chosen by content:

- **No PDFs: pure JSON.** A text-only project opens in any text editor. The files in [`examples/`](examples/) are like this.
- **With PDFs: a zip** with `project.json`, `pdfs/<docId>.pdf` (stored without recompression) and `pdfindex/<docId>.json` (the passage ↔ page ↔ rectangle correspondence, which is what makes "view original", the page number and OCR survive the round-trip).

Reading decides by the **first byte** (`PK` = zip), so old files, from before the container, still open. The `project.json` has nine top-level keys: `_meta`, `documents`, `attributes`, `doc_values`, `codes`, `codings`, `memos`, `ia_results` and `ia_memory`.

Reading it is this, with no dependency beyond the standard library:

```python
import json, zipfile

def open_project(path):
    with open(path, "rb") as f:
        zipped = f.read(2) == b"PK"
    if zipped:
        with zipfile.ZipFile(path) as z:
            return json.loads(z.read("project.json"))
    with open(path, encoding="utf-8") as f:
        return json.load(f)

db = open_project("my_project.qualilab")
name = {c["id"]: c["name"] for c in db["codes"]}
text = {d["id"]: d["content"] for d in db["documents"]}

for t in db["codings"]:
    print(name[t["code_id"]], "|", t["layer"], "|", t["author_name"], "|", t["quote"])
```

**Everything anchors on character positions.** Each passage is `(document_id, span_start, span_end)` over the document's `content`, which is plain text. Which means you can slice it yourself and **check the promise**:

```python
assert all(t["quote"] == text[t["document_id"]][t["span_start"]:t["span_end"]]
           for t in db["codings"])
```

In the repository's examples this holds for every passage. It is the same invariant the MCP server and the redaction tests verify, and it is what lets you reprocess the corpus outside the app without depending on anything of ours.

Two things that are **not** in the file, and it is good to know: the **document assignment** (it depends on user identifiers that only exist in the cloud) and the **derived caches**, such as the semantic search index, which is rebuilt when the corpus changes. And one that **is**: the `.qualilab` is a **work** format, so it carries the text **raw, redaction included** — masking here would destroy data irreversibly. The masking happens in the transparency outputs (ATI, W3C) and in the AI prompt.

### Interchange format

The **QDPX** (full project) and **QDC** (codebook) formats are defined by the **[REFI-QDA Standard](https://www.qdasoftware.org/)**, the open standard created by the *Rotterdam Exchange Format Initiative (REFI)* to allow exchanging projects between qualitative analysis tools. QualiLab's import and export of these formats follow that specification; all credit for the format belongs to the REFI-QDA initiative. Learn about and support the standard at [qdasoftware.org](https://www.qdasoftware.org/).

**Conformance statement** (version 1.0 of the standard, §6, asks software to state which parts it claims conformance to): QualiLab **imports and exports both** — *Project exchange* (`.qdpx`) and *Codebook exchange* (`.qdc`). The generated packages are validated against the official `Project.xsd` (v1.0) by a round-trip harness kept in the development repository. Two honest caveats, because schema conformance is not compatibility: the standard has nowhere to store per-researcher attribute authorship or coding layers, so the `.qdpx` always loses something relative to the `.qualilab` (the app says what, at the moment you export); and a valid schema is no substitute for testing in the actual destination tool.

### Active transparency (DA-RT / QDR / ATI)

Beyond interchange between QDA tools, QualiLab targets the **qualitative research transparency** ecosystem tied to the **DA-RT** movement (*Data Access and Research Transparency*) and to the **[Qualitative Data Repository (QDR)](https://qdr.syr.edu/)**. The QDR's current method is **Annotation for Transparent Inquiry (ATI)**: annotating passages of a text with analytic notes, excerpts and links to the sources behind each claim.

The technical layer under ATI (and under [hypothes.is](https://web.hypothes.is/), Anno-REP and the Dataverse repository) is the **[W3C Web Annotation Data Model](https://www.w3.org/TR/annotation-model/)**, an open W3C recommendation. QualiLab **targets that standard**, not any particular tool: the **Report** tab generates both the **Interactive Report (ATI)** (a self-contained HTML page equivalent to the ATI *overlay*, hostable by you) and the **Web Annotation (W3C)** export in JSON-LD, interoperable with any tool that speaks the standard. This turns the "analytic note" of each passage (and of codes, documents and the project) into a publishable transparency appendix, with no vendor dependency.

---

## How it is built, and how it is verified

No build, no bundler, no heavyweight framework.

- **UI**: [Preact](https://preactjs.com/) + [htm](https://github.com/developit/htm), **embedded in the `index.html`** (UMD, ~17 KB) — which is what makes the app render without depending on the network
- **PDF**: [pdf.js](https://github.com/mozilla/pdf.js)
- **DOCX**: [mammoth](https://github.com/mwilliamson/mammoth.js)
- **QDPX**: [JSZip](https://stuk.github.io/jszip/)
- **Taguette import (`.sqlite3`)**: [sql.js](https://github.com/sql-js/sql.js) (SQLite compiled to WASM)
- **Semantic search**: [transformers.js](https://github.com/huggingface/transformers.js) + the [`paraphrase-multilingual-MiniLM-L12-v2`](https://huggingface.co/Xenova/paraphrase-multilingual-MiniLM-L12-v2) *embeddings* model (ONNX, downloaded on demand and executed **in the browser**; no key, no call to any AI server)
- **Local storage**: File System Access API + IndexedDB (native to the browser)
- **Cloud** (optional): [Supabase](https://supabase.com/)
- **Dependency delivery**: an import map with **SRI** (`integrity` per URL), served from **jsdelivr** with `esm.sh` as the reserve. The hash covers the top-level module; pdf.js's *worker* and sql.js's `.wasm` are not *module scripts* and are declaredly out. It is defense in depth, not a guarantee.

```
QualiLab/
├── docs/index.html   # the app, published by GitHub Pages
├── docs/MANUAL.md    # user manual (and manual.html, which renders it)
├── scripts/          # the checks that run here (invariants, SRI)
├── supabase/
│   ├── schema.sql              # backend: tables, RPCs, RLS policies, realtime
│   └── functions/ai-ask/       # Edge Function: fallback proxy (server key / CORS)
├── examples/         # sample projects (.qualilab, .qdpx)
├── CHANGELOG.md      # what changed in each version
├── CITATION.cff      # how to cite it
├── SECURITY.md       # security policy
└── LICENSE           # MIT
```

The `docs/index.html` in this repository is the **published artifact**: a single file, with no
bundler, no npm and no compile step on your side. It is **generated** from a modular source
(dozens of fragments concatenated byte-for-byte, with no transformation at all) kept in the
development repository.

The [Sustainability](#the-qualilab-is-not-a-magic-format) section says there is verification on every change. **In this repository** it runs on every push, and you can inspect the `ci.yml`:

| Check | What it proves |
|---|---|
| `scripts/check_index.py` + `node --check` | the single-file invariants (one single `<script type="module">`, no typographic quotes in attributes, no literal `</script>` inside the module) and the module syntax |
| `scripts/sri.py` + `sri_selftest.py` | the CDN dependencies match the hash declared in the import map |
| credentials check | the published app points at the **public** Supabase project, and no other |

The rest of the battery runs in the development repository, on every push, over the modular source: pure-function tests (redaction, passage anchors, offsets, format parsing), **23 browser suites** verifying that every screen renders and that the rules which fail **silently** still hold (blind mode not leaking the reference layer, induction not seeing the held-out documents, the confirmation code not dropping digits, **zero external requests at boot**), **pgTAP** over the RLS policies (roles, blind coding, assignment, AI access) and the round-trip harness that validates the generated `.qdpx` against the official `Project.xsd`.

---

## Limits and responsibility

A project under active development. Know the limits before adopting it for important work.

- **Local File mode only in Chromium.** The File System Access API behind it only exists in Chrome and Edge; Firefox and Safari fall back to the draft (`localStorage`, ~5 MB).
- **Not everything syncs live.** Only codings and attribute answers. Changing the code scheme, the attributes or the document assignment requires reloading the page.
- **The write queue is not an offline mode.** It stores and resends what you *write* when the cloud fails, but **reading** still requires a network: with no connection, opening a not-yet-loaded document or switching projects does not work. To work without a network, use File mode.
- **Supabase free-tier capacity** (on the order of 500 MB of database, subject to change — check [supabase.com/pricing](https://supabase.com/pricing)). Very large projects may require a paid plan or File mode, which has no such ceiling.
- **QualiLab does NOT anonymize.** Redaction masks **only the passages you marked by hand**, and only in the transparency outputs and the AI prompt: it does not detect what is sensitive, does not cover the work exports (QDPX/CSV/JSON come out raw) and does not reach **document titles, attribute values or memos**. The manual carries the [publication workflow](docs/MANUAL.en.md) that takes care of those three.
- **The audit trail records operations, not rows, and does not undo.** The project history (Memos ▸ History) lists imports, code merges and splits, deletions, text edits, bulk applications, consolidations and exports, with author and date, but keeps no content of what was deleted: **Ctrl+Z** still undoes only the session's last coding. What brings content back is the **mirror** (since 1.4.52): a snapshot of the whole project, taken by hand or on its own before clearing, deleting, merging, splitting, editing text or restoring, restored from the project pill — without the original PDFs and without the history, which records the restoration instead of going back. It starts at the first event after 1.4.51 (nothing is rebuilt backwards), and in the cloud it is append-only through the API, not forensic proof: whoever operates the server, or owns the file, can always alter it.
- **QDPX loses what the format does not model**: individual layers and per-researcher attribute authorship (a REFI-QDA limit, not ours). And the type of attributes coming from another tool is **inferred** when that tool does not declare it — the import summary says how many, and it is worth reviewing them in the scheme.
- **Round-trip fidelity is measured, not presumed** (a harness kept in the development repository, with an adversarial corpus and a survives/degrades/is-lost matrix). Even so, **schema validity is no substitute for testing in the actual destination tool**, which may read the standard differently.
- **Original PDFs in the cloud are opt-in**, with explicit consent on upload: whoever administers the database becomes able to open the whole file, not just the coded text. For sensitive data, keep PDFs in File mode.
- **Assignment and blind coding only exist in the collective cloud** (they depend on multiple researcher accounts) and do **not** travel in the `.qualilab`.
- **No approval stage for the codebook**: any member creates and renames codes (necessary for team coding); deleting, merging and touching redaction are admin-only. There is no intermediate state before a new code becomes visible to everyone.
- **The account e-mail cannot be changed** in the app; display name and password can.
- **Audio, video, image and spreadsheets are not codable material** — declared scope, not a pending item (see above).

**Responsibility for data handling is entirely yours.** When working with personal, confidential or protected data (data-protection law such as the LGPD, ethics-board/IRB approval, sealed court records, health data), it falls to you to anonymize, obtain consent and choose the appropriate mode. **For sensitive material, use local File mode, offline, and do not put it in the cloud.**

**Sustainability, frankly.** QualiLab is maintained by one person, unfunded, and **most of the code was written by a language model** ([Claude Code](https://claude.com/claude-code)), under the author's direction and review. Weigh that before adopting the tool for an important project. In its favor: a project of this size would not exist otherwise; every design decision is recorded in writing, because documenting it is part of the working method and not an extra; and there are automated tests and checks running in CI on every change. Against: the code has **not** been peer-reviewed nor independently security-audited. Note that the survey cited above excluded code quality from its scope, as it would require deep inspection — meaning that aspect was measured in none of the 28 compared tools, nor in this one.

The risk of abandonment is mitigated by design, not by a promise: an MIT license, an HTML file that runs offline, and all data exportable at any time in open formats (`.qualilab`, REFI-QDA, W3C, CSV, JSON). If the project stops tomorrow, your material is not trapped in it.

---

## Backlog

The full backlog is kept in the development repository, with the reasoning behind each item and also what was **considered and discarded**, with the why. Today's declared priorities:

- **Backend without a buried credential**: a named cloud catalog in the configuration, "use my own cloud" as a first-class path, and invitation links with a confirmation screen.
- **Named relations** between codes and between passages ("X contradicts Y", "X causes Y"), created from the context menu.
- **Trail and audit**: a log of project operations (imports, merges, deletions, bulk applications) and bulk undo — the criterion where we sit below the field's median.
- **End-to-end encryption** with passkeys, for live collaboration without the server operator being able to read the corpus: design ready, nothing decided.

---

## Credits, reference and license

QualiLab was developed by **[Luiz Pimenta Filho](https://orcid.org/0000-0002-5165-6232)** within **[LabDados / FGV Direito SP](https://direitosp.fgv.br/nucleos-de-pesquisa/laboratorio-dados-pesquisa-empirica-direito-labdados)** as a personal project. It does not represent FGV's institutional position, and FGV bears no responsibility for the software.

Most of this project's code was written with the assistance of [Claude Code](https://claude.com/claude-code) (Anthropic).

The main inspirations were:

- **[Taguette](https://www.taguette.org/about.html)**: an open QDA tool, a pioneer in simplicity and online operation, with support for multiple document import formats and codebook export in REFI-QDA (`.qdc`).
- **[Magnolia](https://www.caledavis.eu/magnolia.html)**: a QDA focused on power and intuitiveness, with audio/video transcription and survey analysis. An impressive, fully free project that deserves your attention.
- **[QualCoder](https://github.com/ccbogel/qualcoder)**: a mature, complete QDA (text, image, audio and video coding; reports and agreement measures), free and open source. A robust reference for anyone needing a full-featured desktop tool.
- **[OpenQDA](https://openqda.org/)** ([code](https://github.com/openqda/openqda), AGPL-3.0): an open, collaborative QDA, made at the University of Bremen, with an architecture designed from the start to receive community extensions. It is the project of Jan Küster and Karsten D. Wolf, the authors of the survey that frames this README's [motivation](#why-it-exists): the critique that opens the text comes from people who are also building an answer to it.

All of them show that it is possible to make quality tools without charging the people who need them most, and that they are worth supporting.

### Reference

The framing of the [motivation](#why-it-exists) and the table [Where QualiLab stands on that yardstick](#where-qualilab-stands-on-that-yardstick) rest on:

> Küster, J.; Wolf, K. D. *The Current State of CAQDAS is Insufficient for Open Science Qualitative Research.* **Electronic Communications of the EASST**, v. 85 (deRSE25: Selected Contributions of the 5th Conference for Research Software Engineering in Germany), 2025. DOI [10.14279/eceasst.v85.2709](https://doi.org/10.14279/eceasst.v85.2709). CC-BY 4.0 license.

The survey's data are published in the public domain (CC-0) on Zenodo and the Harvard Dataverse, and the methodology is maintained in the [zemki/state-of-caqdas](https://github.com/zemki/state-of-caqdas) repository, which accepts community contributions.

### License

MIT License: free to use, modify and distribute, with or without commercial purposes, as long as the copyright notice is kept.

```
Copyright (c) 2026 Luiz Pimenta Filho
```

### Third-party licenses

QualiLab being MIT does not change what the licenses of the libraries it uses ask for — and the two
things coexist without conflict. The full list, with who is who, is in
**[`THIRD-PARTY-NOTICES.md`](THIRD-PARTY-NOTICES.md)**.

What decides obligation is a single distinction: **what is embedded in the `docs/index.html` is
redistributed by us; what comes from a CDN is not** (there QualiLab only points at a URL, and it is
the researcher's browser that fetches the file). That is why the notices for the embedded
components — htm, under Apache-2.0, and the three fonts, under the SIL Open Font License 1.1 —
**travel inside the file itself**, and not merely in a repository file: the copy a person
downloads is the `index.html` alone, and the OFL asks for the notice in *each copy*. Both notices
are an **invariant of the file**, and the check runs **in this repository**, on every push:
[`scripts/check_index.py`](scripts/check_index.py) rejects a `docs/index.html` from which either
of them has gone missing.
