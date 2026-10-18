# Course data (`_data/`)

Canonical data files consumed by scripts and rendered pages.

## Files

| Path | Purpose | Populated by |
|------|---------|-------------|
| `horario.csv` | Class schedule (one row per session) | Manual edit; synced to Google Sheets by `scripts/calendario/sync-schedule.R` |


## `horario.csv` columns


| Column | Description | Required |
|--------|-------------|----------|
| Objetivo | Activity type: `interpretive`, `interpersonal`, `presentational`, `assessment`, `info`, `administración` | Yes |
| Fase | Unit/phase name (shown as row group in schedule table) | Yes |
| Capítulo | Chapter or topic short name | Yes |
| Día | Consecutive session number (integer) | Yes |
| Fecha | ISO date (`YYYY-MM-DD`) | Yes |
| Enfoque | One-line focus description | Yes |
| Plan | Relative path to rendered plan (e.g., `./planes/plan-01.html`) | Yes |
| Diapositiva | Relative path to rendered slide deck | Yes |
