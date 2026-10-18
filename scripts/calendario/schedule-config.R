# Shared Google Sheets configuration for course schedule tools and renders.
#
# Keep workbook and worksheet names here. The source CSV remains canonical;
# `scripts/calendario/sync-schedule.R` is the only supported CSV → Google Sheet writer.

schedule_config <- list(
  workbook = "", # Google Sheets URL with edit access
  source_tab = "dates-template", # Existing tab to clone from (formatting source)
  target_tab = "dates-current" # Tab that `horario.qmd` reads
)
