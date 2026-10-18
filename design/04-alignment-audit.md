# SPA 379 — Alignment Audit (goals → evidence → activities → files)

> UbD Stage-2/3 traceability check + render verification. Confirms every SLO target has concrete, *built* evidence, and surfaces residual gaps honestly.

## 1. Goal → evidence → activity → artifact

| Goal / SLO | Evidence (Stage 2) | Session(s) (Stage 3) | Built artifact(s) |
| :-- | :-- | :-- | :-- |
| **Transfer: explain w/ testable account (not verdict)** | T3 defense | S26–S28 + final block | `planes/plan-27-defensa.qmd`, `diapositivas/diap-27-capstone.qmd`, syllabus §IV |
| **Transfer: interrogate categories** | T5, T6 | S20, S23 | `planes/plan-23-genai.qmd`, `materiales/genai-audit.qmd` |
| **Transfer: reflect (variety as data)** *(folded S10)* | T3 close, T1 | S27, S02…S26 | phrase cards: `materiales/frases-para-discutir.qmd` |
| **3.2.1** terminology, contrast | T2, T1 | S11, S18 | `planes/plan-11…`, `…plan-18…`, R-T2 rubric |
| **3.2.2** form → speaker trait | T2 | S11, S18, S22 | planes A/C, `gramatica/pro-drop.qmd` |
| **3.2.3** contact / typologically-frequent / marginalized | T2, T6 | S18, S25 | `gramatica/contacto-reestructuracion.qmd` |
| **3.1.4** descriptive vs. prescriptive *(depth ceiling)* | T5 | S20 | rubric R-T5; `gramatica/subjuntivo-modo.qmd`; syllabus |
| **3.1.3** syntactic function on data *(pooled)* | T2A | S11 | `planes/plan-11-sujeto-datos.qmd` |
| **1.1.4–5** interpret Spanish text | T4 | S04, S09, S16 | planes T4 lines; `materiales/lecturas.qmd` |
| **1.3.4–6** defend in Spanish | T3 | S27–S28 + final | capstone plane/deck; R-T3 |
| **U3/U6 spine** two scales + direction | T1, T2, T3 | S06, S11, S20, S25 | `planes/plan-06-escalas.qmd`, `gramatica/pro-drop.qmd`, webex `act-marcado-tipologico.qmd` |

**Skills S1–S11:** all mapped (see Stage 2 coverage check); every one has ≥1 built evidence site.

## 2. SLO report set — satisfied

- **Mapped to band (required):** 1.1 (T4) ✓ · 1.3 (T3) ✓ · 3.2 (T2 core) ✓
- **Pooled addition (depth ceiling):** 3.1.4 (T5) ✓ · 3.1.3 (T2A) ✓
- **Supported, not measured:** 3.3 ✓ (positionality folded into T3/T1; explicitly *not* reported — measured in OPE)
- **Not relevant:** 2.3 ✓ (removed from SLO framing; no artifact claims it)

## 3. Triage respected

- Deep showcases: **A** (S07–S13) and **B** (S14–S20) — both carry data tasks (T2A/T2B).
- **C** = synthesis (S21–S25), not a fourth deep dive ✓.
- Part I = **6 sessions**, method via **one** micro-example (S04) — the "mini-methods" risk contained ✓.
- Generative-syntax/mood depth **cut** (kept conceptual) ✓.

## 4. Render verification (this session)

- `quarto render .` → **exit 0**, all pages built: 8 `planes`, 5 `diapositivas` (revealjs), 3 `gramatica`, 4 `materiales`, 1 `actividades` webex, `index` syllabus, `horario`.
- `horario.qmd` renders **from CSV** (D2), 28 rows grouped by `Fase`, D1 icons present (`análisis/lectura/debate/presentacional`).
- Fixed template bug uncovered by render: root `webexercises.qmd` used `fitb()` without `library(webexercises)` → added one-line load.
- Remaining WARNs are **empty template dirs** (`discurso/`, `pronunciacion/`, `gramatica/_template`) not in the seminar — harmless; see cleanup note below.

## 5. Residual gaps / to resolve before launch (honest)

1. **Readings not yet attached.** `materiales/lecturas.qmd` lists sources; the actual **Spanish-first texts/excerpts** (esp. the custom micro-intro for S04, and the Unit A/B data-intros) are **not drafted**. Long pole (D3). *Bibliography entries are provisional — verify.*
2. **Data apps not built.** Tier-1 pro-drop app + subjunctive dataset are referenced but **not implemented** (D4, Jerid + LLM). **Caribbean/Andean pro-drop counts** must be sourced from published studies (ACTIV-ES gap) — the honest sampling-problem teaching point, but the numbers don't exist in-repo yet.
3. **14–20 of 28 `planes`** and **most `diapositivas`** remain to be authored (exemplars cover the spine + both data showcases + GenAI + capstone). The session map + templates make the rest mechanical.
4. **Rubrics are single-point drafts** — R-T2/R-T3 etc. live in `02-stage2-evidence.md`; a student-facing rubric page per deliverable would help (Phase 7 extension).
5. **Canvas publish** deferred by design (credentials/irreversible) — see `dauber/PUBLISH.md`.
6. **Cleanup (optional):** decide whether to delete unused template dirs (`pronunciacion/`, `discurso/`, `practica`) or repurpose; currently unlinked but rendered.

## 6. Verdict

The backwards-design spine is **complete and internally consistent**: Stage 1 (locked) → Stage 2 (tasks+rubrics+D1/D6+grading+matrix) → Stage 3 (arc+session map+D3/D4/supports), and the **site renders** with the join (`horario.csv`) wired. Depth-ceiling (3.1.4/3.1.3) and Spanish-oral (1.3) claims are now **assessed**, not aspirational. Remaining work is **content authoring + data tooling** (the known long poles), not design ambiguity.
