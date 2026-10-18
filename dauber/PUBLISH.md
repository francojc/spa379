# Canvas publish — readiness & deferred action

> **Step 29 = prepared, NOT executed.** Publishing to a live Canvas course is an
> irreversible external action that requires credentials, network, and a real
> `canvas_course_id`. It is gated on Jerid. This checklist makes the go-button safe.

## Blocking prerequisites (fill before publishing)
- [ ] `dauber/config.toml` → `canvas_course_id = <real numeric ID>` (currently `0`).
- [ ] Dauber/Canvas credentials available to the runner (do not commit secrets).
- [ ] Confirm term/year map to the actual Canvas term (`Spring` / `2027`).
- [ ] Syllabus, plans, schedule render cleanly locally first (Phase 8, `quarto preview`).

## Ready (done in this plan)
- [x] `dauber/config.toml` populated: `course_code = SPA-379-A`, `term = Spring`, `year = 2027`,
      `level = undergraduate`, `feedback_language = Spanish`, `language_learning = false`, `anonymize = true`.
- [x] `_anuncios/*.md` drafted (see Phase 6).

## When ready to publish (user-run)
1. `nix develop` → run the `dauber` publish command for the site.
2. Verify assignment pages match syllabus §IV; announcements posted to correct dates.
3. Spot-check that no student data is exposed (`anonymize = true`).

> Do not push/publish from an agent session. This step is intentionally left for the instructor.
