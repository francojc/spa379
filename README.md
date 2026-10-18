# Quarto course website template

Development environment and site scaffolding for course websites built with Quarto. Includes R and radian with Google Sheets, webexercises, and Typst integration. Provides a complete Quarto website structure with listing pages, content directory templates, schedule automation, and Canvas LMS connectivity.

## Start

```bash
nix develop
# Or, with direnv installed and its shell hook enabled:
direnv allow
```

In a Git repository, stage generated files before using the flake. Generate and commit your project `flake.lock` to pin dependencies. Templates intentionally omit locks so new projects select current inputs; review updates with `nix flake update`.

## Customize the environment

Edit `shellPackages` in `flake.nix` for standard tools such as `pkgs.typst` (or `typst` inside `with pkgs;`). Edit `rPackages` for R libraries; both `rWrapper` and `radianWrapper` consume that same list. Libraries live in the Nix store, not `R/Library`. Declare dependencies in the flake instead of relying on `install.packages()` or a personal library.

Optional package-development additions: `devtools` and `roxygen2`. Private flake dependencies such as `gdrive-r` are not required; add them only to projects that need them.

## Course site structure

```
├── _quarto.yml              # Site config: navbar, theme, render rules
├── _variables.yaml          # Course metadata (the primary per-course file)
├── index.qmd                # Syllabus page
├── horario.qmd              # Auto-rendered schedule from Google Sheets
├── {page}.qmd               # Listing pages (planes, diapositivas, etc.)
├── planes/                  # Lesson plan templates + content
├── diapositivas/             # Reveal.js slide templates + content
├── gramatica/               # Grammar articles
├── pronunciacion/           # Pronunciation modules
├── discurso/                # Discourse modules
├── practica/                # Interactive practice apps
├── actividades/             # Web-exercise activities
├── materiales/              # Student handouts & materials
├── _data/                   # Canonical CSV data (schedule)
├── scripts/calendario/      # Schedule sync
├── assets/                  # Images (instructor photo, course banner)
├── include/                 # webexercises CSS/JS
├── _extensions/             # Quarto fontawesome extension
├── dauber/config.toml       # Canvas LMS integration config
└── _anuncios/               # Dated Markdown for Canvas announcements
```

### Getting started with a new course

1. Copy this template into a new repo.
2. Fill `_variables.yaml` with your course info (all values are empty strings).
3. Update `_quarto.yml`: site title, URL, navbar items, description.
4. Write `index.qmd` syllabus content (replace `<!-- Reemplazar -->` comments).
5. Edit `scripts/calendario/schedule-config.R`: set Google Sheets workbook URL and tab names.
6. Create `_data/horario.csv` rows (one per session, see `_data/README.md`).
7. Add content to directories using their `_template.qmd` files.
8. Run `quarto preview` to check the site renders.

### Key patterns

- **`_variables.yaml`** — all course-specific data (instructor, course, Canvas links). Pages reference via `{{< var course.title >}}` shortcodes.
- **`_data/horario.csv`** — canonical schedule. Synced to Google Sheets by `sync-schedule.R`; rendered by `horario.qmd`.
- **Content directories** — each has `_metadata.yml` (Quarto config) + `_template.qmd` (starting point). Root listing pages auto-populate via Quarto's `listing:` feature.

## Publishing

Quarto and Pandoc are global prerequisites when using Quarto, not flake dependencies. Run `quarto --version` and `quarto pandoc --version` to record the actual publishing toolchain; standalone `pandoc --version` may differ. Do not set `QUARTO_PANDOC` unless deliberately selecting and testing another Pandoc.

Use `format: typst` for Quarto PDF documents, or `typst compile document.typ` for native Typst documents. No TeX Live or tinytex is provided. HTML websites and revealjs slides remain HTML workflows; Typst is not a drop-in renderer for LaTeX-specific templates or extensions.

Global publishing tool versions are not pinned by this project's lock. Run Quarto from inside the development shell so it can find project R/Python libraries.
