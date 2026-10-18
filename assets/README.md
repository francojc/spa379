# Site assets (`assets/`)

Static images and files referenced from `_variables.yaml`.

## Required files

| Path | Referenced by | Description |
|------|--------------|-------------|
| `instructor.png` | `{{< var instructor.photo >}}` in `index.qmd` | Instructor headshot (~150px display) |
| `course-sticker.png` | `{{< var course.sticker >}}` | Course banner/sticker image |

## Optional files

| Path | Description |
|------|-------------|
| `favicon-32x32.png` | Browser tab icon (place at repo root) |
| `diapositivas/images/` | Background images used in reveal.js slides |

Replace the placeholder paths in `_variables.yaml` (`instructor.photo`, `course.sticker`) with the actual filenames you add here.
