// SPA 379 Promotional Flyer — Concept A1 (Typological Atlas) v2
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
#let muted = rgb("#4A5568")

#let qr-placeholder() = {
  box(
    width: 68pt,
    height: 68pt,
    fill: white,
    stroke: 1.5pt + gold,
    radius: 5pt,
    inset: 5pt,
    place(center + horizon, {
      let s = 6.8pt
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

#let badge(label, bg: navy-light, fg: gold-bright, border: gold, size: 8.5pt) = {
  box(
    fill: bg,
    stroke: 0.8pt + border,
    radius: 3.5pt,
    inset: (x: 8pt, y: 4.5pt),
    text(font: "JetBrains Mono", size: size, weight: "bold", fill: fg, tracking: 0.6pt, label)
  )
}

#let pin(x, y, color, label, sublabel, align-right: false) = {
  place(left + top, dx: x, dy: y, {
    place(center + horizon, circle(radius: 10pt, fill: color.transparentize(72%), stroke: none))
    place(center + horizon, circle(radius: 6pt, fill: color.transparentize(45%), stroke: none))
    circle(radius: 4pt, fill: color, stroke: 1.2pt + white)
  })
  let tag-x = if align-right { x - 145pt } else { x + 11pt }
  place(left + top, dx: tag-x, dy: y - 11pt,
    box(
      fill: rgb("#162235").transparentize(8%),
      stroke: 0.85pt + color,
      radius: 4.5pt,
      inset: (x: 7pt, y: 4pt),
      stack(
        spacing: 2.5pt,
        text(font: "JetBrains Mono", size: 7.5pt, weight: "bold", fill: color, label),
        text(font: "Avenir Next", size: 8.2pt, weight: "medium", fill: white, sublabel)
      )
    )
  )
}

#let atlas-graphic = {
  box(width: 100%, height: 100%, {
    // Subtle lat/lon grid lines
    for i in range(1, 12) {
      place(left + top, dx: i * 48pt, dy: 0pt,
        line(start: (0pt, 0pt), end: (0pt, 185pt), stroke: 0.4pt + rgb("#1E2D45"))
      )
    }
    for j in range(1, 6) {
      place(left + top, dx: 0pt, dy: j * 33pt,
        line(start: (0pt, 0pt), end: (560pt, 0pt), stroke: 0.4pt + rgb("#1E2D45"))
      )
    }

    // Stylized continental landmass silhouettes
    // North & Central America
    place(left + top, dx: 40pt, dy: 18pt,
      polygon(
        fill: rgb("#1D2D44"), stroke: 0.8pt + rgb("#2E4668"),
        (0pt, 12pt), (58pt, 5pt), (88pt, 26pt), (72pt, 56pt), (96pt, 72pt), (64pt, 68pt), (36pt, 45pt), (10pt, 30pt)
      )
    )
    // South America
    place(left + top, dx: 118pt, dy: 86pt,
      polygon(
        fill: rgb("#1D2D44"), stroke: 0.8pt + rgb("#2E4668"),
        (10pt, 0pt), (48pt, 6pt), (72pt, 30pt), (55pt, 66pt), (30pt, 88pt), (16pt, 68pt), (6pt, 30pt)
      )
    )
    // Iberia / Europe
    place(left + top, dx: 268pt, dy: 20pt,
      polygon(
        fill: rgb("#1D2D44"), stroke: 0.8pt + rgb("#2E4668"),
        (8pt, 15pt), (50pt, 5pt), (76pt, 18pt), (60pt, 42pt), (15pt, 46pt), (4pt, 32pt)
      )
    )
    // Africa
    place(left + top, dx: 276pt, dy: 70pt,
      polygon(
        fill: rgb("#1D2D44"), stroke: 0.8pt + rgb("#2E4668"),
        (12pt, 4pt), (58pt, 2pt), (86pt, 28pt), (72pt, 82pt), (44pt, 94pt), (26pt, 54pt), (4pt, 34pt)
      )
    )

    // Background typological scatter dots (WALS style)
    let bg-dots = (
      (60pt, 32pt, teal), (92pt, 42pt, gold), (318pt, 32pt, teal),
      (345pt, 44pt, coral), (340pt, 90pt, teal), (360pt, 122pt, gold),
      (415pt, 52pt, teal), (450pt, 68pt, coral), (475pt, 44pt, gold),
      (495pt, 102pt, teal), (435pt, 118pt, gold), (168pt, 114pt, teal)
    )
    for d in bg-dots {
      place(left + top, dx: d.at(0), dy: d.at(1),
        circle(radius: 2.5pt, fill: d.at(2).transparentize(40%), stroke: none)
      )
    }

    // Connecting arcs between Spanish nodes
    place(left + top,
      curve(
        stroke: (paint: gold.transparentize(40%), thickness: 1.1pt, dash: "dashed"),
        curve.move((102pt, 56pt)),
        curve.quad((195pt, 20pt), (282pt, 54pt)),
      )
    )
    place(left + top,
      curve(
        stroke: (paint: coral.transparentize(40%), thickness: 1.1pt, dash: "dashed"),
        curve.move((130pt, 78pt)),
        curve.quad((128pt, 108pt), (136pt, 134pt)),
      )
    )
    place(left + top,
      curve(
        stroke: (paint: teal.transparentize(40%), thickness: 1.1pt, dash: "dashed"),
        curve.move((282pt, 54pt)),
        curve.quad((305pt, 90pt), (312pt, 122pt)),
      )
    )

    // Highlighted Pins + Enlarged Callouts
    pin(72pt, 46pt, teal, "U.S. & HERITAGE", "English contact · mood shift")
    pin(118pt, 78pt, coral, "CARIBBEAN", "\"¿Qué tú dices?\" · overt tú/yo")
    pin(124pt, 134pt, gold-bright, "ANDEAN & PARAGUAYAN", "Quechua & Guaraní contact")
    pin(255pt, 46pt, gold-bright, "IBERIA", "Vosotros · leísmo · ser/estar")
    pin(292pt, 122pt, coral, "EQUATORIAL GUINEA", "Bantu/Pichi contact · mood")

    // Top-right Legend Overlay Card
    place(right + top, dx: -10pt, dy: 10pt,
      box(
        width: 146pt,
        fill: rgb("#131D2E").transparentize(6%),
        stroke: 0.8pt + rgb("#334155"),
        radius: 5pt,
        inset: 8pt,
        stack(
          spacing: 5pt,
          text(font: "JetBrains Mono", size: 7.2pt, weight: "bold", fill: gold-bright, "TYPOLOGICAL ATLAS LENS"),
          stack(dir: ltr, spacing: 6pt, circle(radius: 3.5pt, fill: gold-bright), text(size: 7.6pt, fill: rgb("#E2E8F0"), "Global rarity (ser/estar, null S)")),
          stack(dir: ltr, spacing: 6pt, circle(radius: 3.5pt, fill: coral), text(size: 7.6pt, fill: rgb("#E2E8F0"), "Internal shift (order, mood)")),
          stack(dir: ltr, spacing: 6pt, circle(radius: 3.5pt, fill: teal), text(size: 7.6pt, fill: rgb("#E2E8F0"), "Contact restructuring"))
        )
      )
    )
  })
}

#set page(
  paper: "us-letter",
  margin: 0pt,
  fill: paper,
)
#set text(font: "Avenir Next", fill: ink, size: 11pt)

#grid(
  columns: (100%),
  rows: (386pt, 1fr, 92pt),

  // ZONE 1 & 2: HERO BANNER + VISUAL CENTERPIECE
  box(
    width: 100%,
    height: 100%,
    fill: navy,
    inset: (x: 34pt, top: 22pt, bottom: 20pt),
    {
      // Top metadata bar
      grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        stack(
          dir: ltr,
          spacing: 8pt,
          badge("SPA 379", bg: gold, fg: navy, border: gold, size: 9pt),
          badge("SPRING 2027", size: 8.5pt),
          badge("SEMINAR IN HISPANIC LINGUISTICS", bg: rgb("#1A2639"), fg: rgb("#CBD5E1"), border: rgb("#334155"), size: 8.5pt),
        ),
        text(font: "JetBrains Mono", size: 8pt, weight: "medium", fill: rgb("#94A3B8"), tracking: 0.6pt, "TAUGHT IN SPANISH")
      )

      v(12pt)

      // Hook Question (Enlarged for 2-3 ft readability)
      text(
        font: "Canela Text",
        size: 24.5pt,
        weight: "bold",
        fill: white,
        hyphenate: false,
        [What makes Spanish #text(fill: gold-bright, style: "italic")[ordinary] – and #text(fill: coral, style: "italic")[extraordinary] – among the world's languages?]
      )

      v(9pt)

      // Course Title + Subtitle (Enlarged)
      stack(
        dir: ltr,
        spacing: 10pt,
        text(font: "Avenir Next", size: 15.2pt, weight: "bold", fill: gold-bright, "THE MANY SPANISHES:"),
        text(font: "Avenir Next", size: 14.8pt, weight: "medium", fill: rgb("#E2E8F0"), "What Spanish Variation Reveals About Language Itself")
      )

      v(12pt)

      // Visual Centerpiece Box
      box(
        width: 100%,
        height: 180pt,
        fill: rgb("#0F1724"),
        stroke: 0.9pt + rgb("#2D3F5E"),
        radius: 8pt,
        clip: true,
        atlas-graphic
      )
    }
  ),

  // ZONE 4 & 5: BODY CONTENT (No Zone 3 paragraph — larger, punchier cards)
  box(
    width: 100%,
    height: 100%,
    inset: (x: 34pt, top: 20pt, bottom: 20pt),
    grid(
      columns: (1.32fr, 1fr),
      column-gutter: 20pt,

      // Left Column: Zone 4 (What We'll Explore)
      stack(
        dir: ttb,
        spacing: 11pt,
        text(font: "JetBrains Mono", size: 10pt, weight: "bold", fill: coral, tracking: 1.4pt, "WHAT WE'LL EXPLORE"),

        // Pillar 1
        box(
          width: 100%,
          fill: white,
          stroke: 0.8pt + rgb("#E2DDD3"),
          radius: 7pt,
          inset: (x: 13pt, y: 11pt),
          grid(
            columns: (30pt, 1fr),
            column-gutter: 10pt,
            box(
              width: 28pt, height: 28pt, radius: 14pt, fill: rgb("#FDF3D7"),
              align(center + horizon, text(font: "JetBrains Mono", weight: "bold", size: 11pt, fill: gold, "01"))
            ),
            stack(
              spacing: 4pt,
              text(weight: "bold", size: 12.2pt, fill: navy, "Spanish's Global Surprises"),
              par(leading: 0.48em, text(size: 10.2pt, fill: muted, [Most of the world's languages have no subjunctive mood, don't drop subject pronouns, and don't split "to be" into #emph[ser] and #emph[estar]. Discover where Spanish stands on the global map.]))
            )
          )
        ),

        // Pillar 2
        box(
          width: 100%,
          fill: white,
          stroke: 0.8pt + rgb("#E2DDD3"),
          radius: 7pt,
          inset: (x: 13pt, y: 11pt),
          grid(
            columns: (30pt, 1fr),
            column-gutter: 10pt,
            box(
              width: 28pt, height: 28pt, radius: 14pt, fill: rgb("#FCEAE7"),
              align(center + horizon, text(font: "JetBrains Mono", weight: "bold", size: 11pt, fill: coral, "02"))
            ),
            stack(
              spacing: 4pt,
              text(weight: "bold", size: 12.2pt, fill: navy, "One Language, Many Systems"),
              par(leading: 0.48em, text(size: 10.2pt, fill: muted, [Why do Caribbean speakers say #emph["¿Qué tú quieres?"] while Andean speakers drop pronouns almost entirely? Trace how grammar adapts across communities.]))
            )
          )
        ),

        // Pillar 3
        box(
          width: 100%,
          fill: white,
          stroke: 0.8pt + rgb("#E2DDD3"),
          radius: 7pt,
          inset: (x: 13pt, y: 11pt),
          grid(
            columns: (30pt, 1fr),
            column-gutter: 10pt,
            box(
              width: 28pt, height: 28pt, radius: 14pt, fill: rgb("#E3F4F2"),
              align(center + horizon, text(font: "JetBrains Mono", weight: "bold", size: 11pt, fill: teal, "03"))
            ),
            stack(
              spacing: 4pt,
              text(weight: "bold", size: 12.2pt, fill: navy, "Worlds in Contact"),
              par(leading: 0.48em, text(size: 10.2pt, fill: muted, [What happens when Spanish lives alongside Quechua, Guaraní, English in the U.S., or African languages in Equatorial Guinea? Explore how contact reshapes a language.]))
            )
          )
        )
      ),

      // Right Column: Zone 5 (Inside the Seminar)
      box(
        width: 100%,
        fill: card-bg,
        stroke: 1pt + rgb("#DFD7C8"),
        radius: 8pt,
        inset: (x: 15pt, y: 13pt),
        stack(
          dir: ttb,
          spacing: 10.5pt,
          text(font: "JetBrains Mono", size: 10pt, weight: "bold", fill: navy, tracking: 1.4pt, "INSIDE THE SEMINAR"),

          // Item 1: Interactive Maps & Visual Discovery (folds in subtle AI check)
          stack(
            spacing: 4pt,
            stack(
              dir: ltr, spacing: 7pt,
              box(width: 8pt, height: 8pt, radius: 4pt, fill: teal, baseline: -1pt),
              text(weight: "bold", size: 11.4pt, fill: navy, "Interactive Maps & Visual Tools")
            ),
            par(leading: 0.46em, text(size: 9.9pt, fill: ink, "Explore real patterns across the Spanish-speaking world using interactive atlases, visual apps, and critical checks on how AI handles variation."))
          ),

          line(length: 100%, stroke: 0.6pt + rgb("#D5CBB8")),

          // Item 2: Think Like a Field Linguist
          stack(
            spacing: 4pt,
            stack(
              dir: ltr, spacing: 7pt,
              box(width: 8pt, height: 8pt, radius: 4pt, fill: coral, baseline: -1pt),
              text(weight: "bold", size: 11.4pt, fill: navy, "Think Like a Linguist")
            ),
            par(leading: 0.46em, text(size: 9.9pt, fill: ink, "Move beyond textbook rules to uncover why every variety of Spanish has its own internal logic, structure, and history."))
          ),

          line(length: 100%, stroke: 0.6pt + rgb("#D5CBB8")),

          // Item 3: Hands-On Discovery, Not Memorization
          stack(
            spacing: 4pt,
            stack(
              dir: ltr, spacing: 7pt,
              box(width: 8pt, height: 8pt, radius: 4pt, fill: gold, baseline: -1pt),
              text(weight: "bold", size: 11.4pt, fill: navy, "Hands-On Discovery")
            ),
            par(leading: 0.46em, text(size: 9.9pt, fill: ink, "Learn by doing: investigate real-world case studies, test competing ideas with evidence, and build your own capstone showcase."))
          ),

          v(2pt),
          box(
            width: 100%,
            fill: navy,
            radius: 6pt,
            inset: (x: 10pt, y: 8pt),
            align(center, text(font: "JetBrains Mono", size: 8pt, fill: gold-bright, weight: "bold", tracking: 0.4pt, "COUNTS FOR SPANISH MAJOR & MINOR\nLANGUAGE / LINGUISTICS SEMINAR"))
          )
        )
      )
    )
  ),

  // ZONE 6: LOGISTICS FOOTER
  box(
    width: 100%,
    height: 100%,
    fill: navy,
    stroke: (top: 3.5pt + gold),
    inset: (x: 34pt, y: 12pt),
    grid(
      columns: (1fr, auto),
      align: (left + horizon, right + horizon),
      stack(
        spacing: 5.5pt,
        stack(
          dir: ltr,
          spacing: 12pt,
          text(font: "Avenir Next", weight: "bold", size: 12pt, fill: white, "Prof. Jerid Francom"),
          text(font: "JetBrains Mono", size: 9.8pt, weight: "bold", fill: gold-bright, "Spring 2027 · Tue / Thu (75 min)"),
        ),
        text(size: 9.8pt, fill: rgb("#CBD5E1"), "Department of Spanish · Wake Forest University"),
        badge("PREREQUISITE: SPA 320", bg: rgb("#1E2C42"), fg: white, border: teal, size: 8.5pt)
      ),
      stack(
        dir: ltr,
        spacing: 12pt,
        align(right + horizon, stack(
          spacing: 3.5pt,
          text(font: "JetBrains Mono", size: 9pt, weight: "bold", fill: gold-bright, "EXPLORE THE COURSE"),
          text(size: 8.8pt, fill: rgb("#CBD5E1"), "Scan for syllabus,\ntopics & preview")
        )),
        qr-placeholder()
      )
    )
  )
)
