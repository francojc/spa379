// Shared template for SPA 379 Promotional Flyers
#let navy = rgb("#141E2E")
#let navy-mid = rgb("#1E2C42")
#let navy-light = rgb("#283A56")
#let paper = rgb("#FAF7F2")
#let card-bg = rgb("#F1ECE1")
#let gold = rgb("#C59B27")
#let gold-bright = rgb("#E5B83B")
#let coral = rgb("#E05A47")
#let teal = rgb("#2A9D8F")
#let ink = rgb("#1A212B")
#let muted = rgb("#5A6578")

#let qr-placeholder() = {
  box(
    width: 62pt,
    height: 62pt,
    fill: white,
    stroke: 1.5pt + gold,
    radius: 5pt,
    inset: 5pt,
    place(center + horizon, {
      let s = 6.2pt
      let grid-data = (
        (1,1,1,1,1,0,1,1,1),
        (1,0,0,0,1,0,1,0,1),
        (1,0,1,0,1,0,1,1,1),
        (1,0,0,0,1,0,0,0,0),
        (1,1,1,1,1,0,1,0,1),
        (0,0,0,0,0,0,1,1,0),
        (1,1,1,0,1,1,1,0,1),
        (1,0,1,0,1,0,0,1,0),
        (1,1,1,0,1,1,0,1,1),
      )
      stack(
        dir: ttb,
        spacing: 0pt,
        ..grid-data.map(row =>
          stack(
            dir: ltr,
            spacing: 0pt,
            ..row.map(cell =>
              rect(
                width: s,
                height: s,
                fill: if cell == 1 { navy } else { white },
                stroke: none,
              )
            )
          )
        )
      )
    })
  )
}

#let badge(label, bg: navy-light, fg: gold-bright, border: gold) = {
  box(
    fill: bg,
    stroke: 0.75pt + border,
    radius: 3pt,
    inset: (x: 7pt, y: 4pt),
    text(font: "JetBrains Mono", size: 7.5pt, weight: "bold", fill: fg, tracking: 0.6pt, label)
  )
}

#let render-flyer(concept-tag: "", hero-graphic: none) = {
  set page(
    paper: "us-letter",
    margin: 0pt,
    fill: paper,
  )
  set text(font: "Avenir Next", fill: ink, size: 9.8pt)

  grid(
    columns: (100%),
    rows: (338pt, 1fr, 84pt),

    // ZONE 1 & 2: HERO BANNER + VISUAL CENTERPIECE
    box(
      width: 100%,
      height: 100%,
      fill: navy,
      inset: (x: 34pt, top: 24pt, bottom: 18pt),
      {
        // Top metadata bar
        grid(
          columns: (1fr, auto),
          align: (left + horizon, right + horizon),
          stack(
            dir: ltr,
            spacing: 8pt,
            badge("SPA 379", bg: gold, fg: navy, border: gold),
            badge("SPRING 2027"),
            badge("SEMINAR IN HISPANIC LINGUISTICS", bg: rgb("#1A2639"), fg: rgb("#CBD5E1"), border: rgb("#334155")),
          ),
          text(font: "JetBrains Mono", size: 7.5pt, fill: rgb("#94A3B8"), tracking: 0.5pt, "TAUGHT IN SPANISH")
        )

        v(12pt)

        // Hook Question
        text(
          font: "Canela Text",
          size: 21.5pt,
          weight: "bold",
          fill: white,
          hyphenate: false,
          [What makes Spanish #text(fill: gold-bright, style: "italic")[ordinary] – and #text(fill: coral, style: "italic")[extraordinary] – among the world's languages?]
        )

        v(8pt)

        // Course Title + Subtitle
        stack(
          dir: ltr,
          spacing: 10pt,
          text(font: "Avenir Next", size: 13.5pt, weight: "bold", fill: gold-bright, "THE MANY SPANISHES:"),
          text(font: "Avenir Next", size: 13.5pt, weight: "medium", fill: rgb("#E2E8F0"), "What Spanish Variation Reveals About Language Itself")
        )

        v(10pt)

        // Visual Centerpiece Box
        box(
          width: 100%,
          height: 170pt,
          fill: rgb("#0F1724"),
          stroke: 0.8pt + rgb("#2D3F5E"),
          radius: 8pt,
          clip: true,
          hero-graphic
        )
      }
    ),

    // ZONE 3, 4, 5: BODY CONTENT
    box(
      width: 100%,
      height: 100%,
      inset: (x: 34pt, top: 20pt, bottom: 16pt),
      {
        // Zone 3: Core Pitch
        box(
          width: 100%,
          inset: (left: 12pt, y: 2pt),
          stroke: (left: 3pt + coral),
          par(leading: 0.58em, text(
            font: "Charter",
            size: 10.8pt,
            fill: navy,
            [From the Andes to the Caribbean, and from Madrid to Los Angeles and Equatorial Guinea, Spanish takes on fascinating shapes. In this seminar, we use the world's languages as a lens to explore why Spanish varies, what features make it globally unique, and what happens when it comes into contact with Quechua, Guaraní, English, and African languages.]
          ))
        )

        v(16pt)

        // Two-Column Asymmetric Split
        grid(
          columns: (1.35fr, 1fr),
          column-gutter: 22pt,

          // Left Column: Zone 4 (What We'll Explore)
          stack(
            dir: ttb,
            spacing: 11pt,
            text(font: "JetBrains Mono", size: 8.5pt, weight: "bold", fill: coral, tracking: 1.2pt, "WHAT WE'LL EXPLORE"),

            // Pillar 1
            box(
              width: 100%,
              fill: white,
              stroke: 0.6pt + rgb("#E2DDD3"),
              radius: 6pt,
              inset: 11pt,
              grid(
                columns: (26pt, 1fr),
                column-gutter: 8pt,
                box(
                  width: 24pt, height: 24pt, radius: 12pt, fill: rgb("#FDF3D7"),
                  align(center + horizon, text(font: "JetBrains Mono", weight: "bold", size: 10pt, fill: gold, "01"))
                ),
                stack(
                  spacing: 4pt,
                  text(weight: "bold", size: 10.5pt, fill: navy, "Spanish's Global Surprises"),
                  par(leading: 0.5em, text(size: 9.2pt, fill: muted, [Did you know most languages in the world don't have a subjunctive mood, don't drop subject pronouns, and don't split "to be" into #emph[ser] and #emph[estar]? Discover where Spanish stands on the world map.]))
                )
              )
            ),

            // Pillar 2
            box(
              width: 100%,
              fill: white,
              stroke: 0.6pt + rgb("#E2DDD3"),
              radius: 6pt,
              inset: 11pt,
              grid(
                columns: (26pt, 1fr),
                column-gutter: 8pt,
                box(
                  width: 24pt, height: 24pt, radius: 12pt, fill: rgb("#FCEAE7"),
                  align(center + horizon, text(font: "JetBrains Mono", weight: "bold", size: 10pt, fill: coral, "02"))
                ),
                stack(
                  spacing: 4pt,
                  text(weight: "bold", size: 10.5pt, fill: navy, "One Language, Many Systems"),
                  par(leading: 0.5em, text(size: 9.2pt, fill: muted, [Why do Caribbean speakers say #emph["¿Qué tú quieres?"] while Andean speakers drop pronouns almost entirely? Trace how grammar adapts across communities.]))
                )
              )
            ),

            // Pillar 3
            box(
              width: 100%,
              fill: white,
              stroke: 0.6pt + rgb("#E2DDD3"),
              radius: 6pt,
              inset: 11pt,
              grid(
                columns: (26pt, 1fr),
                column-gutter: 8pt,
                box(
                  width: 24pt, height: 24pt, radius: 12pt, fill: rgb("#E3F4F2"),
                  align(center + horizon, text(font: "JetBrains Mono", weight: "bold", size: 10pt, fill: teal, "03"))
                ),
                stack(
                  spacing: 4pt,
                  text(weight: "bold", size: 10.5pt, fill: navy, "Worlds in Contact"),
                  par(leading: 0.5em, text(size: 9.2pt, fill: muted, [What happens when Spanish lives alongside Quechua, Guaraní, English in the U.S., or African languages in Equatorial Guinea? Explore how contact reshapes a language.]))
                )
              )
            )
          ),

          // Right Column: Zone 5 (How We'll Work)
          box(
            width: 100%,
            fill: card-bg,
            stroke: 1pt + rgb("#DFD7C8"),
            radius: 8pt,
            inset: 14pt,
            stack(
              dir: ttb,
              spacing: 12pt,
              text(font: "JetBrains Mono", size: 8.5pt, weight: "bold", fill: navy, tracking: 1.2pt, "INSIDE THE SEMINAR"),

              // Perk 1
              stack(
                spacing: 3.5pt,
                stack(
                  dir: ltr, spacing: 6pt,
                  box(width: 7pt, height: 7pt, radius: 3.5pt, fill: teal, baseline: -1pt),
                  text(weight: "bold", size: 10pt, fill: navy, "Interactive Maps & Visual Tools")
                ),
                par(leading: 0.48em, text(size: 8.9pt, fill: ink, "Explore real patterns across the Spanish-speaking world through intuitive, visual apps and global language atlases."))
              ),

              line(length: 100%, stroke: 0.5pt + rgb("#D5CBB8")),

              // Perk 2
              stack(
                spacing: 3.5pt,
                stack(
                  dir: ltr, spacing: 6pt,
                  box(width: 7pt, height: 7pt, radius: 3.5pt, fill: coral, baseline: -1pt),
                  text(weight: "bold", size: 10pt, fill: navy, "Put AI to the Test")
                ),
                par(leading: 0.48em, text(size: 8.9pt, fill: ink, "Audit ChatGPT and modern AI models – which varieties of Spanish do they recognize, and which communities do they erase?"))
              ),

              line(length: 100%, stroke: 0.5pt + rgb("#D5CBB8")),

              // Perk 3
              stack(
                spacing: 3.5pt,
                stack(
                  dir: ltr, spacing: 6pt,
                  box(width: 7pt, height: 7pt, radius: 3.5pt, fill: gold, baseline: -1pt),
                  text(weight: "bold", size: 10pt, fill: navy, "No Textbook · No Written Final")
                ),
                par(leading: 0.48em, text(size: 8.9pt, fill: ink, "Learn through curated readings, step-by-step guided analyses, and an interactive capstone showcase."))
              ),

              v(2pt),
              box(
                width: 100%,
                fill: navy,
                radius: 5pt,
                inset: (x: 10pt, y: 8pt),
                align(center, text(font: "JetBrains Mono", size: 7.8pt, fill: gold-bright, weight: "medium", "COUNTS FOR MAJOR & MINOR\nLANGUAGE / LINGUISTICS SEMINAR"))
              )
            )
          )
        )
      }
    ),

    // ZONE 6: LOGISTICS FOOTER
    box(
      width: 100%,
      height: 100%,
      fill: navy,
      stroke: (top: 3pt + gold),
      inset: (x: 34pt, y: 11pt),
      grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        stack(
          spacing: 5pt,
          stack(
            dir: ltr,
            spacing: 12pt,
            text(font: "Avenir Next", weight: "bold", size: 10.5pt, fill: white, "Prof. Jerid Francom"),
            text(font: "JetBrains Mono", size: 8.5pt, fill: gold-bright, "Spring 2027 · Tue / Thu (75 min)"),
          ),
          text(size: 8.8pt, fill: rgb("#CBD5E1"), "Department of Spanish · Wake Forest University"),
          stack(
            dir: ltr,
            spacing: 8pt,
            badge("PREREQUISITE: SPA 320", bg: rgb("#1E2C42"), fg: white, border: teal),
            text(font: "JetBrains Mono", size: 7.8pt, fill: rgb("#94A3B8"), baseline: 3pt, concept-tag)
          )
        ),
        stack(
          dir: ltr,
          spacing: 10pt,
          align(right + horizon, stack(
            spacing: 3pt,
            text(font: "JetBrains Mono", size: 8pt, weight: "bold", fill: gold-bright, "EXPLORE THE COURSE"),
            text(size: 7.8pt, fill: rgb("#CBD5E1"), "Scan for syllabus,\ntopics & preview")
          )),
          qr-placeholder()
        )
      )
    )
  )
}
