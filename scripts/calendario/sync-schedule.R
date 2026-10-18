#!/usr/bin/env Rscript

# Synchronize canonical schedule CSV to the target tab in Google Sheets.
#
# Usage:
#   Rscript scripts/calendario/sync-schedule.R --dry-run
#   Rscript scripts/calendario/sync-schedule.R --write
#   Rscript scripts/calendario/sync-schedule.R --write --replace
#
# `--write` clones the source tab to the target tab once, preserving formatting.
# Later updates require `--replace`; the script clears values, retains formatting,
# writes current CSV values, and verifies the round trip.

suppressPackageStartupMessages({
  library(cli)
  library(googlesheets4)
  library(readr)
  library(stringr)
})

usage <- paste(
  "Usage:",
  "  Rscript scripts/calendario/sync-schedule.R --dry-run",
  "  Rscript scripts/calendario/sync-schedule.R --write [--replace]",
  "",
  "Options:",
  "  --dry-run  Validate _data/horario.csv and report planned Sheet action.",
  "  --write    Authenticate and create or update the target tab in Google Sheets.",
  "  --replace  Permit overwriting an existing target tab. Requires --write.",
  "  --help     Print this message.",
  sep = "\n"
)

abort <- function(message, ...) {
  cli_abort(message, ...)
}

script_path <- sub(
  "^--file=",
  "",
  grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
)

if (length(script_path) != 1) {
  abort(
    "Run this script with Rscript, for example: `Rscript scripts/calendario/sync-schedule.R --dry-run`."
  )
}

repo_root <- normalizePath(
  file.path(dirname(script_path), "..", ".."),
  mustWork = TRUE
)
setwd(repo_root)
source("scripts/calendario/schedule-config.R")

args <- commandArgs(trailingOnly = TRUE)
valid_args <- c("--dry-run", "--write", "--replace", "--help")
unknown_args <- setdiff(args, valid_args)

if (length(unknown_args) > 0) {
  abort(c("Unknown option{?s}: {unknown_args}", "i" = usage))
}

if ("--help" %in% args) {
  cat(usage, "\n")
  quit(status = 0)
}

write_mode <- "--write" %in% args
replace_mode <- "--replace" %in% args

if ("--dry-run" %in% args && write_mode) {
  abort(c("Choose exactly one action: `--dry-run` or `--write`.", "i" = usage))
}

if (replace_mode && !write_mode) {
  abort(c("`--replace` requires `--write`.", "i" = usage))
}

if (!write_mode && !"--dry-run" %in% args) {
  abort(c("Choose `--dry-run` or `--write`.", "i" = usage))
}

expected_columns <- c(
  "Objetivo",
  "Fase",
  "Capítulo",
  "Día",
  "Fecha",
  "Enfoque",
  "Plan",
  "Diapositiva",
)

schedule_path <- "_data/horario.csv"
schedule <- read_csv(
  schedule_path,
  col_types = cols(
    .default = col_character(),
    Día = col_integer(),
    Fecha = col_date(format = "%Y-%m-%d")
  ),
  na = c("", "NA"),
  show_col_types = FALSE
)
parse_problems <- problems(schedule)
if (nrow(parse_problems) > 0) {
  abort(c(
    "CSV parsing failed for `{schedule_path}`.",
    "i" = "Each row must contain exactly {length(expected_columns)} columns.",
    "i" = "{format(parse_problems)}"
  ))
}

validate_schedule <- function(data) {
  errors <- character()

  if (!identical(names(data), expected_columns)) {
    errors <- c(
      errors,
      glue::glue(
        "Expected columns: {toString(expected_columns)}. Found: {toString(names(data))}."
      )
    )
  }

  if (nrow(data) == 0) {
    errors <- c(errors, "Schedule CSV is empty.")
  }

  if (anyNA(data$Día) || !identical(data$Día, seq_len(nrow(data)))) {
    errors <- c(errors, "`Día` must be consecutive integers beginning at 1.")
  }

  required_columns <- setdiff(expected_columns)
  missing_required <- vapply(
    data[required_columns],
    function(column) any(is.na(column) | (is.character(column) & column == "")),
    logical(1)
  )
  if (any(missing_required)) {
    errors <- c(
      errors,
      glue::glue(
        "Required columns contain blank values: {toString(names(missing_required)[missing_required])}."
      )
    )
  }

  if (anyDuplicated(data$Fecha)) {
    errors <- c(errors, "`Fecha` contains duplicate dates.")
  }

  if (length(errors) > 0) {
    abort(c(
      "Schedule validation failed:",
      setNames(errors, rep("x", length(errors)))
    ))
  }

  invisible(data)
}

validate_schedule(schedule)

# Public metadata access is sufficient for a dry run. Writing requires OAuth.
gs4_deauth()
properties <- sheet_properties(schedule_config$workbook)
tab_names <- properties$name
source_exists <- schedule_config$source_tab %in% tab_names
target_exists <- schedule_config$target_tab %in% tab_names

if (!source_exists) {
  abort(
    "Source tab `{schedule_config$source_tab}` does not exist in configured workbook."
  )
}

if (!write_mode) {
  action <- if (target_exists) {
    "replace existing target tab"
  } else {
    "clone source tab and create target tab"
  }

  cli_h1("Schedule sync: dry run")
  cli_inform(c(
    "i" = "Canonical CSV: `{schedule_path}` ({nrow(schedule)} rows)",
    "i" = "Workbook: `{schedule_config$workbook}`",
    "i" = "Source tab: `{schedule_config$source_tab}`",
    "i" = "Target tab: `{schedule_config$target_tab}`",
    "i" = "Planned action: {action}",
    "v" = "Validation passed. No Google Sheet changes made."
  ))
  quit(status = 0)
}

if (target_exists && !replace_mode) {
  abort(c(
    "Target tab `{schedule_config$target_tab}` already exists.",
    "i" = "Review with `--dry-run`, then use `--write --replace` to update it."
  ))
}

# A cached OAuth token is required. Create one once in an interactive R session:
# googlesheets4::gs4_auth()
tryCatch(
  gs4_auth(),
  error = function(error) {
    abort(c(
      "Google Sheet write requires cached OAuth credentials.",
      "i" = "In an interactive R session, run `googlesheets4::gs4_auth()` and complete browser authorization once.",
      "i" = "Then rerun `Rscript scripts/calendario/sync-schedule.R --write`.",
      "x" = conditionMessage(error)
    ))
  }
)

# Re-check after OAuth in case another editor changed worksheet names.
properties <- sheet_properties(schedule_config$workbook)
target_exists <- schedule_config$target_tab %in% properties$name

if (!target_exists) {
  cli_inform(
    "Cloning `{schedule_config$source_tab}` to `{schedule_config$target_tab}`."
  )
  sheet_copy(
    from_ss = schedule_config$workbook,
    from_sheet = schedule_config$source_tab,
    to_ss = schedule_config$workbook,
    to_sheet = schedule_config$target_tab
  )
} else if (!replace_mode) {
  abort(
    "Target tab `{schedule_config$target_tab}` appeared during sync. Re-run with `--write --replace` after review."
  )
}

# Clear all copied values but retain worksheet formatting, row/column sizing, and filters.
range_clear(
  ss = schedule_config$workbook,
  sheet = schedule_config$target_tab,
  range = "A:AA",
  reformat = FALSE
)
range_write(
  ss = schedule_config$workbook,
  data = schedule,
  sheet = schedule_config$target_tab,
  range = "A1",
  reformat = FALSE
)

round_trip <- read_sheet(
  ss = schedule_config$workbook,
  sheet = schedule_config$target_tab,
  range = "A:I",
  col_types = "ccciDcccc"
)
round_trip$Fecha <- as.Date(round_trip$Fecha)
round_trip <- round_trip[expected_columns]

round_trip_check <- all.equal(round_trip, schedule, check.attributes = FALSE)
if (!isTRUE(round_trip_check)) {
  abort(c(
    "Google Sheet verification failed: downloaded data differs from `_data/horario.csv`.",
    "i" = "{round_trip_check}"
  ))
}

cli_h1("Schedule synced")
cli_inform(c(
  "v" = "Updated `{schedule_config$target_tab}` from `{schedule_path}`.",
  "i" = "Render `horario.qmd` or run `quarto render` to publish current tab."
))
