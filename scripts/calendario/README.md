# Schedule (`scripts/calendario/`)

Automation for the course schedule.

## Workflow

1. Edit `_data/horario.csv` (canonical schedule data).
2. Sync to Google Sheets (formatting source for `horario.qmd`):

```bash
Rscript scripts/calendario/sync-schedule.R --dry-run
Rscript scripts/calendario/sync-schedule.R --write
# Subsequent updates:
Rscript scripts/calendario/sync-schedule.R --write --replace
```

## Configuration

All workbook URLs and tab names live in `schedule-config.R`. Edit that file once per course.

## Prerequisites

- Google Sheets shared publicly (read) or OAuth cached (write).
- Run inside `nix develop` for R packages (`googlesheets4`, `gt`, `tidyverse`, `cli`, `glue`, `fontawesome`).
