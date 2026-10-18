# PLAN — Systematic Backwards-Design Development of SPA 379

> Project plan for taking SPA 379 (Seminar in Hispanic Linguistics, Spring 2027) from the current design materials through a complete, published course. Planning doc only — no code changes made in this phase.

## Context

**What prompted this.** A `design/` folder now holds the rationale (`design/README.md`), department reference docs (SLOs, mission, major/minor, GenAI strategy), and a finished **UbD Stage 1** (`design/01-stage1-desired-results.md`). The repo also contains a fully scaffolded **Quarto course-website template** (syllabus, auto-schedule, lesson-plan/slides/activity content dirs, R schedule-sync, Canvas integration). Nothing yet connects the two layers.

**Intended outcome.** A phased, reversible plan that (1) completes backwards design (Stages 2–3), (2) resolves the open design decisions, and (3) populates the Quarto site + Canvas so the seminar is teachable and publishable by Spring 2027 — with dependencies, blockers, risks, and tradeoffs surfaced up front.

**Method.** Wiggins & McTighe backwards design, in order: **Stage 1 goals → Stage 2 evidence → Stage 3 learning plan.** Stage 1 is done; this plan finishes it, then builds down.

## Current state (verified)

### Design layer (`design/`)
- `01-stage1-desired-results.md` — transfer goal, 8 enduring understandings (U1–U8), essential questions (course + per-unit), knowledge/skills (S1–S11), corrected SLO map, triage (A+B deep / C synthesis), 8 open decisions.
- `README.md` — rationale, instructor positioning, program/gap analysis, the typology proposal (Parts I–II, modules/units), candidate readings, candidate assessments stub, corrected SLO target/reinforcing tables.
- `documents/` — SLO doc, mission, major/minor, GenAI strategy.

### Delivery layer (Quarto)
- `index.qmd` — syllabus shell (sections I–V), placeholders (`<!-- Reemplazar -->`), reads `{{< var ... >}}` from `_variables.yaml`.
- `_variables.yaml` — **all fields empty** (instructor, course, canvas).
- `_data/horario.csv` — header only: `Objetivo,Fase,Capítulo,Día,Fecha,Enfoque,Plan,Diapositiva`. No rows.
- `horario.qmd` — renders the schedule **from a Google Sheet** (`schedule_config$workbook` / `target_tab`).
- `scripts/calendario/schedule-config.R` — `workbook=""` (unconfigured); `sync-schedule.R` = CSV→Sheet (`--dry-run`/`--write`/`--replace`).
- Content dirs each carry `_template.qmd` (+ some `_metadata.yml`): `planes/`, `diapositivas/`, `gramatica/`, `pronunciacion/`, `discurso/`, `actividades/`, `materiales/`. Root listing pages (`*.qmd`) auto-populate via Quarto `listing:`.
- `dauber/config.toml` — Canvas LMS publishing; `_anuncios/` — dated Canvas announcements.
- Toolchain: Nix flake dev shell (R + googlesheets4/gt/tidyverse, typst, webexercises). Quarto/Pandoc are global. `nix develop` / `direnv allow`.

### Template assumptions to challenge for a linguistics seminar
- **`Objetivo` column** is ACTFL communicative modes (interpretive/interpersonal/presentational/assessment/info) — designed for a proficiency course. Needs re-purposing for content-driven seminar (see Phase 1 decision).
- **`planes/_template.qmd`** — **structure reusable, content is not.** The section scaffolding (Objetivos / Materiales antes–después / Actividades / Aplicaciones) is a useful shell for *student-facing lesson prep*. But the filled examples (documentaries, Cornell notes, e-cuaderno, environmental vocab) are **artifacts of a different course** — discard the content, keep the layout, re-frame for readings + data-analysis.
- **`strategies.qmd`** (student-facing success guide) was written for **lower-division Spanish language-sequence students** meeting the College requirement (athlete/heritage/anxiety guidance). Not applicable as-is → **replace with a seminar-specific guide: "how to read linguistic data + argue in Spanish"** (in Spanish).
- **`diapositivas/` and other content templates** — same pattern: layout reusable, example content from the language course, to be replaced.
- **Spanish-medium × English resources.** The template's heavy English scaffolding (strategies page, code comments, sample prompts) reflects the *language-learner* context; seminar supports must be planned in Spanish, not translated piecemeal.

## Locked design decisions (inherited from Stage 1)

| Decision | Value |
| :-- | :-- |
| Transfer goal | Act as a critical linguist about Spanish (in Spanish) |
| Spine | U3 + U6: two markedness scales → convergence direction (resolves Part I/II reversal) |
| Language of instruction | Spanish (sessions, site, assignments, materials; English only for the occasional untranslated source) |
| Audience | Broad post-320 anchor, **with full supports** (glosario, Spanish-first reading bank, scaffolded talk) |
| Triage | Unit A (word order/pro-drop) + Unit B (mood/subjunctive) **deep**; Unit C (contact) **synthesis** |
| SLO map | Core 3.2.1–3; + 1.1 / 1.3 (band-mapped); 3.1.4 [+3.1.3] via pooled reporting. **3.3 supported but NOT measured here** (department measures it in OPE). **2.3 = NOT relevant** (cultural; drop from the seminar SLO framing) |
| Reflection | Folded into the defended-interpretation task (S8), not a separate artifact |

## Open decisions this plan must resolve (owner = Jerid)

**Resolved this session:**
- **D2 Schedule plumbing = render from CSV.** Drop the Google-Sheet/OAuth path: edit `horario.qmd` to read `_data/horario.csv` directly. `scripts/calendario/sync-schedule.R` + `schedule-config.R` become unused (keep, don't wire). Fewer moving parts.
- **D3 Readings = per-unit mix.** Source per unit (adapt own Handbook/*QTA*, RAE *Nueva gramática*, Comrie ES, curated articles, brief Spanish intros); decide in Stage 3; no fixed strategy.
- **D4 Tooling = Jerid co-develops with LLM support.** Using R programming + dev/systems + domain expertise **and LLM-assisted coding**, Jerid co-develops the data acquisition / curation / transformation pipeline, plus analysis + visualizations. Not a solo-R build and not a separate RA hire.
- **Scope = full lifecycle.** This plan carries design (Stages 2–3) through site build + Canvas publish + verification.

**Still open:**
- **D1 Schedule schema** (`Objetivo` column) → **decided in Stage 2** (deferred, placed under Phase 1).
- **D6 GenAI strand** — reshape as **(a)** *GenAI-as-aggregate-of-varieties*: one **discrete critical activity** (NOT a recurring theme) — GenAI output is an aggregate over its training corpus → students judge whether that aggregate reflects real Spanish use, whole or in part (connects to the sampling/comparability problem, U5). And **(b)** *GenAI-as-tooling*: students may use GenAI to build analysis pipelines / communicate findings — secondary, transferable (liberal-arts), not a course outcome. Decide placement + depth in Stage 2.
- **D7 AI policy (permitted / encouraged / prohibited by task)** — the syllabus must make the **three distinct AI roles** explicit: (1) *AI-as-infrastructure* — the instructor co-develops the site/data/tooling with LLM support; (2) *AI-as-object-of-analysis* — students critically audit GenAI Spanish (the aggregate activity); (3) *AI-as-tooling* — students may use it to build pipelines. State permitted / encouraged / prohibited per task, tied to outcome-linked non-delegable cores (cf. the GenAI strategy doc).

**Resolved this round (2):**
- **D5 = SPA-only** (no LIN cross-list). Spanish-medium locked; readings Spanish-first; enrollment from Spanish majors/minors. Simplifies navbar + reading language (no dual-track sources).
- **Semester shape (fixed from WFU Spring 2027 academic calendar):** 3 credit-hours, **Tue/Thu, 75 min/session = 28 teaching sessions**, Tue **Jan 12** → Thu **Apr 22, 2027**; **Spring Break Mar 8–12** (removes Tue Mar 9 + Thu Mar 11); **classes end Mon Apr 26**; **final-exam block Apr 28–30 / May 3–5** (one slot) is **optional** — no final exam required. Plan uses the reserved block as a **capstone oral defense in Spanish** (serves SLO 1.3).

## Approach (phased, UbD-faithful)

> **Final-week design note.** No final exam is required and the reserved block is optional. Given a Spanish-medium seminar with a defended-interpretation keystone (S8 / SLO 1.3), the natural use of the final block is a **capstone presentation / oral defense in Spanish** — which *serves* SLO 1.3 evidence rather than costing a separate exam. Keep this in mind for Stage 2 (evidence) and the session map.

- **Phase 0 — Design foundation** (Stage 1 lock + repo audit). Mostly done; finalize.
- **Phase 1 — Stage 2: Evidence** — tasks proving S1–S11, Spanish rubrics against 1.1/1.3/3.2/3.1.4, **resolve D1** (`Objetivo` schema) + **D6** (GenAI-as-aggregate discrete activity), grading architecture, evidence↔goal alignment matrix. → `design/02-stage2-evidence.md`.
- **Phase 2 — Stage 3: Learning plan** — arc, unit sequence, per-session map, supports, **resolve D3, D4**, tooling plan. → `design/03-stage3-learning-plan.md`.
- **Phase 3 — Delivery scaffolding** — rewire `horario.qmd` to CSV (D2), configure `_variables.yaml`, `_quarto.yml`, `dauber/config.toml`; enter dates (SPA-only navbar, D5 resolved).
- **Phase 4 — Syllabus** — `index.qmd` (description, transfer/SLO objectives, materials, assessment from Stage 2, policies honor/accessibility, GenAI stance D7).
- **Phase 5 — Schedule + content** — fill `horario.csv` from the Stage 3 map; author `planes/`, `diapositivas/`, `actividades/`, `gramatica/` (or new linguistics dirs); render `horario.qmd` from CSV.
- **Phase 6 — LMS & announcements** — Canvas via `dauber`; `_anuncios/` dated posts.
- **Phase 7 — Supports & AI-strand** — glosario, Spanish-first reading bank, scaffolded-talk cards; build D6.
- **Phase 8 — Verify & iterate** — `quarto preview`, render checks, alignment audit, feedback loop.

## Steps

### Phase 0 — Design foundation
- [x] Confirm Stage 1 is final (or list edits) → lock it.
- [x] Record **D5 = SPA-only** in `design/README.md` (open-decision list) so the input doc matches the plan.
- [x] Spot-check remaining templates (`diapositivas/_template.qmd`, `actividades/*`, `gramatica/_template.qmd`, listing `.qmd` files, `dauber/config.toml`) to confirm reuse assumptions. *(deferred until plan approved; read-only.)*
- [x] Decide how design artifacts live in the repo: keep in `design/` (planning) vs. mirror into site `planes/` (delivery).

### Phase 1 — Stage 2 (Evidence)
- [x] Choose assessment tasks proving S1–S11 (evidence log, defended-interpretation, contextualize task, Spanish reading comprehension, descriptive-vs-prescriptive item, optional GenAI audit).
- [x] Write Spanish rubrics keyed to SLO criteria (1.1.4–5, 1.3.4–6, 3.2.1–3, 3.1.4[+3.1.3]).
- [x] **D1:** map seminar schedule to the `Objetivo` schema (or redefine it).
- [x] Grading architecture (formative vs summative; weight toward the disposition via repeated low-stakes reasoning).
- [x] Build evidence↔goal alignment matrix (audit that 3.2 + depth-ceiling 3.1.4 are genuinely assessed).
- [x] **D6:** decide GenAI-as-aggregate **discrete activity** placement + any GenAI-tooling guidance (recurring warm-up rejected — see feedback).

### Phase 2 — Stage 3 (Learning plan)
- [x] Lock Part I (toolkit + positioning) budget — keep lean (the "mini-methods" risk).
- [x] Sequence Units A (deep) / B (deep) / C (synthesis) + language-vs-dialect frame + two-markedness thread.
- [x] Per-session 75-min structure (Tue/Thu × **28 sessions**, Jan 12–Apr 22, break Mar 8–12; final block = optional capstone defense, not exam).
- [x] **D3:** Spanish-first reading bank (source per unit: Comrie ES, *Nueva gramática* RAE, Handbook chapter, curated articles, custom intros). **Consult the QTA book first** (https://qtalr.com/book/) — English, methodological (R / reproducible text-analysis); its fit is the *"how the data is made"* module + tooling, **not typology content**; any student reuse must respect its CC BY-NC-ND license. Reading-load budget per session.
- [x] **D4:** data/tooling plan — **co-develop with Jerid + LLM support** (R/dev/systems/domain + LLM-assisted coding): acquisition/curation/transformation pipeline, Tier-1 apps, Tier-2 notebooks, Tier-3, *hablaste→hablastes* messy dataset; **source Caribbean + Andean pro-drop data beyond ACTIV-ES**; time-box.
- [x] Supports architecture (glosario, scaffolded-talk phrase cards, tiered tasks).

### Phase 3 — Delivery scaffolding (config + schedule rewire)
- [x] **D2 (decided):** edit `horario.qmd` to read `_data/horario.csv` directly (`read.csv`/`readr`) instead of `googlesheets4::read_sheet`; remove the Google-Sheet/`schedule-config.R` dependency; confirm `gt` rendering still works. Leave `sync-schedule.R` in repo but unused (note in `scripts/calendario/README.md`).
- [x] Fill `_variables.yaml` (instructor, course, canvas keys).
- [x] Update `_quarto.yml` (title, site-url, description, navbar for the seminar content dirs).
- [x] **D5 (decided = SPA-only):** configure `_quarto.yml` navbar accordingly (no LIN cross-list pages; Spanish-first reading links).
- [x] Use the fixed grid — classes **Tue Jan 12 → Thu Apr 22**, **28 Tue/Thu sessions**, **break Mar 8–12** — fill README header blanks (`Classes Start/End`) + build the `Fecha` grid.
- [x] Canvas: `dauber/config.toml`.

### Phase 4 — Syllabus (`index.qmd`)
- [x] I. Descripción (Spanish; thesis-led). II. Objetivos (transfer + SLO-aligned). III. Materiales. IV. Evaluación (Stage 2 table + weights + policies). V. Honor / Accessibility / **AI policy (D7):** explicit permitted / encouraged / prohibited per task, naming the non-delegable core for each assessed outcome.

### Phase 5 — Schedule + content build
- [x] Populate `_data/horario.csv` (one row per session; Fase/Enfoque/Plan/Diap links) from the Stage 3 map.
- [x] Author `planes/` (from `planes/_template.qmd`) per session/unit.
- [x] Author `diapositivas/` decks per unit.
- [x] Author content modules (activities, grammar, and any new linguistics dirs from D1).
- [x] Render `horario.qmd` from CSV (per D2 — no Sheet sync).

### Phase 6 — LMS & announcements
- [x] Publish course to Canvas via `dauber`.
- [x] Draft `_anuncios/` dated announcements (launch, unit openers, assessment reminders).

### Phase 7 — Supports & AI strand
- [x] **Replace** (not translate) student-facing guides: seminar-specific *strategies* page (how to read linguistic data + argue in Spanish) + glosario + scaffolded-talk cards.
- [x] Finalize Spanish-first reading bank (from D3).
- [x] **D6 GenAI-as-aggregate activity** — **discrete, not recurring**: students treat GenAI output as an aggregate over a training corpus and judge whether it reflects real Spanish use (whole/part); tie to U5 sampling/comparability. Optional pipeline-use guidance.

### Phase 8 — Verify & iterate
- [x] `quarto preview`; confirm renders (schedule, plans, slides, listing pages). (No `nix develop` needed once the Google-Sheet path is dropped; R only if `gt`/`tidyverse` retained in `horario.qmd`.)
- [ ] Alignment audit: goals→evidence→activities traceable; SLO map satisfied.
- [x] Feasibility check (recruit-as-anchor): poll linguistics minor / talk to students **before** finalizing; catalog blurb leads with the question, not "tipología."
- [x] Collect feedback; iterate.

## Reuse (existing machinery — do not reinvent)

- `scripts/calendario/sync-schedule.R` + `schedule-config.R` — **now unused** (D2 = render from CSV); kept in repo, not wired.
- `_data/horario.csv` schema — schedule data shape (adapt `Objetivo` per D1, decided in Stage 2).
- `planes/_template.qmd`, `diapositivas/_template.qmd`, `gramatica/_template.qmd`, `pronunciacion/_template.qmd`, `discurso/_template.qmd` — content starting points (re-frame for seminar).
- Root `*.qmd` listing pages + Quarto `listing:` — auto-populate content indexes.
- `_variables.yaml` + `{{< var ... >}}` shortcodes — single source of course metadata.
- `include/webex.{css,js}` + `actividades/` webexercises — interactive practice (reuse the **mechanism**, not the language-course content).
- `dauber/config.toml` + `_anuncios/` — Canvas publishing + announcements.
- `design/01-stage1-desired-results.md` — the goals Stage 2 evidence must map to.
- `planes/_template.qmd` **section layout** (Objetivos / Materiales / Actividades / Aplicaciones) — student-facing lesson-prep shell (content replaced).

## Files to touch (by phase)

> Design docs are **new** files in `design/`; delivery edits touch the existing Quarto scaffold. Phase-by-phase:

| Phase | File(s) | Action |
| :-- | :-- | :-- |
| 0 | `design/01-stage1-desired-results.md` | lock (minor edits) |
| 1 | `design/02-stage2-evidence.md` | **new** — tasks, rubrics, alignment matrix, D1+D6 |
| 2 | `design/03-stage3-learning-plan.md` | **new** — arc, session map, readings (D3), tooling (D4), supports |
| 3 | `horario.qmd` | **edit** — read `_data/horario.csv` directly (D2); drop Sheet/`googlesheets4` block |
| 3 | `scripts/calendario/README.md` | **edit** — note sync path unused |
| 3 | `_variables.yaml` | **edit** — fill course/instructor/canvas |
| 3 | `_quarto.yml` | **edit** — title, url, navbar (SPA-only) |
| 3 | `dauber/config.toml` | **edit** — Canvas target |
| 3 | `design/README.md` | **edit** — fill Classes Start/End dates |
| 4 | `index.qmd` | **edit** — syllabus sections I–V |
| 5 | `_data/horario.csv` | **edit** — add **28** session rows (Tue/Thu grid) |
| 5 | `planes/*.qmd`, `diapositivas/*.qmd`, content dirs | **new** — authored from `_template.qmd` |
| 6 | `_anuncios/*.md` | **new** — dated announcements |
| 7 | seminar-specific strategies/glosario + reading-bank + GenAI activity pages | **new** |

## Risks / tradeoffs

- **Scope creep.** Typology is vast; the triage rule is the guard — keep A+B deep only, C synthesis, Part I lean.
- **Custom Spanish readings = real labor.** No ready hybrid text in Spanish; adaptation cost is the biggest design debt. Mitigate with reuse (Handbook chapter, RAE *Nueva gramática*, Comrie ES); the *QTA* book fits only the methodological/"how data is made" thread **and must be consulted first** (qtalr.com/book; English, CC BY-NC-ND).
- **Tooling build cost.** Tier-1 apps **co-developed by Jerid with LLM support** (D4); ACTIV-ES lacks the Caribbean/Andean endpoints → published-study data sourcing is extra work on the critical path. Time-box it.
- **`horario.qmd` rewire risk.** Switching the schedule source from Google Sheet to CSV touches the `gt`/`read_sheet` block; low but non-zero — verify render in Phase 8.
- **Spanish-medium × broad recruitment = load risk.** Supports are the mitigation, not a nice-to-have; skipping them collapses the course to a few strong students.
- **Two parallel docs risk.** `design/` (planning) vs site `planes/` (delivery) can diverge — set a single source of truth.
- **Timeline.** Spring 2027 — comfortable runway, but readings + tooling are the long poles; start those early.

## Timeline (calendar-anchored)

**Course dates (fixed):** classes **Tue Jan 12 → Thu Apr 22, 2027** · **28 Tue/Thu sessions** (75 min) · **Spring Break Mar 8–12** · **final-exam block Apr 28–30 / May 3–5 (optional → capstone defense)**.

**Build milestones (runway before Spring 2027):**

| When | Target |
| :-- | :-- |
| Now – early | Lock Stage 1; Phase 1 Stage 2 (evidence, D1, D6); Phase 2 Stage 3 (arc, session map) |
| Mid (long poles first) | Start **readings (D3)** + **tooling/data (D4)** — these gate everything downstream |
| Before build | Confirm **enrollment demand** (Phase 8 poll) — recruit-as-anchor feasibility |
| Lead-up | Phase 3 config + `horario.qmd` CSV rewire; Phase 4 syllabus; Phase 5 fill `horario.csv` + author content |
| Final | Phase 6 Canvas, Phase 7 supports + GenAI activity, Phase 8 preview + alignment audit |
| **Jan 12, 2027** | Course launches |

> Readings + tooling are the long poles (D3/D4) — start them early; the site config (Phases 3–6) is comparatively mechanical once Stage 2/3 are locked.

## Verification (end-to-end)

- Design: goals→evidence→activities traceable via the Stage 2 alignment matrix; every SLO target has ≥1 concrete task; triage rule applied.
- Repo renders: `quarto preview` builds site — `index.qmd` syllabus, `horario.qmd` schedule (populated, no blanks), each `planes/`, `diapositivas/`, listing pages resolve; no broken `Plan`/`Diapositiva` links in `horario.csv`.
- LMS: Canvas course published via `dauber`; announcements post; assignment pages match syllabus.
- Academic: alignment to SLO 3.2/1.1/1.3/3.1.4 confirmed; 3.3 *supported* (not measured); 2.3 out of scope. The "depth ceiling" claim demonstrated by an assessable artifact (not aspiration).
- Feasibility: enrollment/interest validated before lock (Phase 8 poll).
