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

#let qr-code() = {
  box(
    width: 68pt,
    height: 68pt,
    fill: white,
    stroke: 1.5pt + gold,
    radius: 5pt,
    inset: 3.5pt,
    image("qr-spa379.svg", width: 100%, height: 100%)
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

// Map Pin with 3-tier format:
// 1. REGION/LOCATION
// 2. "Language example in quotes" · brief variation label
#let pin(x, y, color, region, example, label, dx-tag: 12pt, dy-tag: -12pt) = {
  place(left + top, dx: x, dy: y, {
    place(center + horizon, circle(radius: 11pt, fill: color.transparentize(72%), stroke: none))
    place(center + horizon, circle(radius: 6.5pt, fill: color.transparentize(45%), stroke: none))
    circle(radius: 4.2pt, fill: color, stroke: 1.2pt + white)
  })
  place(left + top, dx: x + dx-tag, dy: y + dy-tag,
    box(
      fill: rgb("#152033").transparentize(5%),
      stroke: 0.9pt + color,
      radius: 4.5pt,
      inset: (x: 8pt, y: 4.5pt),
      stack(
        spacing: 2.5pt,
        text(font: "JetBrains Mono", size: 7.4pt, weight: "bold", fill: color, tracking: 0.3pt, region),
        text(font: "Avenir Next", size: 8.2pt, fill: white, [
          #text(weight: "semibold", style: "italic", example)
          #text(fill: rgb("#94A3B8"))[ · ]
          #text(fill: rgb("#CBD5E1"), label)
        ])
      )
    )
  )
}

#let atlas-graphic = {
  box(width: 100%, height: 100%, {
    // Subtle lat/lon grid lines (for 276pt height)
    for i in range(1, 12) {
      place(left + top, dx: i * 48pt, dy: 0pt,
        line(start: (0pt, 0pt), end: (0pt, 276pt), stroke: 0.4pt + rgb("#1E2D45"))
      )
    }
    for j in range(1, 6) {
      place(left + top, dx: 0pt, dy: j * 46pt,
        line(start: (0pt, 0pt), end: (560pt, 0pt), stroke: 0.4pt + rgb("#1E2D45"))
      )
    }

    // Stylized continental landmass silhouettes (scaled up for 276pt height)
    // North & Central America
    place(left + top, dx: 22pt, dy: 16pt,
      polygon(
        fill: rgb("#1D2D44"), stroke: 0.85pt + rgb("#2E4668"),
        (0pt, 14pt), (68pt, 6pt), (104pt, 32pt), (84pt, 74pt), (112pt, 98pt), (74pt, 94pt), (42pt, 62pt), (12pt, 40pt)
      )
    )
    // South America (extended down to Southern Cone / Argentina)
    place(left + top, dx: 104pt, dy: 112pt,
      polygon(
        fill: rgb("#1D2D44"), stroke: 0.85pt + rgb("#2E4668"),
        (12pt, 0pt), (60pt, 8pt), (88pt, 46pt), (66pt, 102pt), (38pt, 146pt), (20pt, 114pt), (6pt, 46pt)
      )
    )
    // Iberia / Europe
    place(left + top, dx: 206pt, dy: 18pt,
      polygon(
        fill: rgb("#1D2D44"), stroke: 0.85pt + rgb("#2E4668"),
        (8pt, 18pt), (58pt, 6pt), (88pt, 24pt), (68pt, 54pt), (16pt, 60pt), (4pt, 40pt)
      )
    )
    // Africa
    place(left + top, dx: 228pt, dy: 88pt,
      polygon(
        fill: rgb("#1D2D44"), stroke: 0.85pt + rgb("#2E4668"),
        (14pt, 4pt), (68pt, 2pt), (102pt, 36pt), (84pt, 118pt), (50pt, 138pt), (28pt, 80pt), (4pt, 48pt)
      )
    )

    // Background typological scatter dots (WALS style)
    let bg-dots = (
      (42pt, 32pt, teal), (78pt, 42pt, gold-bright), (290pt, 28pt, coral),
      (322pt, 98pt, teal), (340pt, 138pt, gold-bright), (168pt, 142pt, teal),
      (362pt, 88pt, gold-bright)
    )
    for d in bg-dots {
      place(left + top, dx: d.at(0), dy: d.at(1),
        circle(radius: 2.8pt, fill: d.at(2).transparentize(38%), stroke: none)
      )
    }

    // Connecting arcs between Spanish nodes
    place(left + top,
      curve(
        stroke: (paint: coral.transparentize(40%), thickness: 1.2pt, dash: "dashed"),
        curve.move((112pt, 98pt)),
        curve.quad((162pt, 60pt), (210pt, 48pt)),
      )
    )
    place(left + top,
      curve(
        stroke: (paint: coral.transparentize(40%), thickness: 1.2pt, dash: "dashed"),
        curve.move((112pt, 98pt)),
        curve.quad((135pt, 165pt), (138pt, 232pt)),
      )
    )
    place(left + top,
      curve(
        stroke: (paint: teal.transparentize(40%), thickness: 1.2pt, dash: "dashed"),
        curve.move((56pt, 48pt)),
        curve.quad((82pt, 118pt), (114pt, 168pt)),
      )
    )
    place(left + top,
      curve(
        stroke: (paint: teal.transparentize(40%), thickness: 1.2pt, dash: "dashed"),
        curve.move((210pt, 48pt)),
        curve.quad((242pt, 102pt), (258pt, 134pt)),
      )
    )

    // PINS ON MAP:
    // Color encoding:
    // - CORAL/RED = Internal shift (within Spanish varieties)
    // - TEAL/GREEN = Contact restructuring (bilingual/substrate ecologies)

    // 1. U.S. & Heritage (Teal — Contact restructuring)
    pin(56pt, 48pt, teal, "U.S. & HERITAGE", "\"Espero que vienes\"", "mood shift", dx-tag: 11pt, dy-tag: -18pt)

    // 2. Caribbean (Coral — Internal shift)
    pin(112pt, 98pt, coral, "CARIBBEAN", "\"¿Qué tú dices?\"", "overt tú/yo", dx-tag: 11pt, dy-tag: -12pt)

    // 3. Andean & Paraguayan (Teal — Contact restructuring)
    pin(114pt, 168pt, teal, "ANDEAN & PARAGUAYAN", "\"De mi mamá su casa\"", "Quechua / Guaraní contact", dx-tag: 11pt, dy-tag: -12pt)

    // 4. Argentina (Coral — Internal shift)
    pin(138pt, 232pt, coral, "ARGENTINA", "\"¿Qué decís?\"", "voseo", dx-tag: 11pt, dy-tag: -12pt)

    // 5. Iberia (Coral — Internal shift)
    pin(210pt, 48pt, coral, "IBERIA", "\"A Juan le vi ayer\"", "leísmo", dx-tag: 11pt, dy-tag: -12pt)

    // 6. Equatorial Guinea (Teal — Contact restructuring)
    pin(258pt, 134pt, teal, "EQUATORIAL GUINEA", "\"Yo duerme\"", "Bantu / Pichi contact", dx-tag: 11pt, dy-tag: -12pt)

    // TOP-RIGHT: Typological Color Legend
    place(right + top, dx: -12pt, dy: 10pt,
      box(
        width: 162pt,
        fill: rgb("#131D2E").transparentize(4%),
        stroke: 0.85pt + rgb("#334155"),
        radius: 5.5pt,
        inset: (x: 9pt, y: 8pt),
        stack(
          spacing: 5pt,
          text(font: "JetBrains Mono", size: 7.3pt, weight: "bold", fill: white, tracking: 0.5pt, "TYPOLOGICAL ATLAS LENS"),
          stack(dir: ltr, spacing: 6pt, circle(radius: 3.5pt, fill: gold-bright), text(size: 7.8pt, fill: gold-bright, weight: "semibold", "Global rarity (Spanish vs. world)")),
          stack(dir: ltr, spacing: 6pt, circle(radius: 3.5pt, fill: coral), text(size: 7.8pt, fill: rgb("#E2E8F0"), "Internal shift (across varieties)")),
          stack(dir: ltr, spacing: 6pt, circle(radius: 3.5pt, fill: teal), text(size: 7.8pt, fill: rgb("#E2E8F0"), "Contact restructuring"))
        )
      )
    )

    // BOTTOM-RIGHT FLOATING BUBBLE: Global Rarities (Yellow/Gold — Not attached to a single map pin!)
    place(right + bottom, dx: -12pt, dy: -10pt,
      box(
        width: 162pt,
        fill: rgb("#1C2533").transparentize(3%),
        stroke: (left: 3pt + gold-bright, rest: 0.95pt + gold-bright),
        radius: 5.5pt,
        inset: (x: 9pt, y: 7.5pt),
        stack(
          spacing: 4pt,
          stack(
            dir: ltr,
            spacing: 5pt,
            circle(radius: 3.5pt, fill: gold-bright),
            text(font: "JetBrains Mono", size: 7.1pt, weight: "bold", fill: gold-bright, tracking: 0.2pt, "GLOBAL RARITIES (SPANISH)")
          ),
          text(font: "Avenir Next", size: 7.9pt, fill: white, [
            #text(weight: "semibold", style: "italic")["Es listo / Está listo"] #text(fill: rgb("#CBD5E1"))[· dual "to be"]
          ]),
          text(font: "Avenir Next", size: 7.9pt, fill: white, [
            #text(weight: "semibold", style: "italic")["Llueve / Hablo"] #text(fill: rgb("#CBD5E1"))[· null subject]
          ]),
          text(font: "Avenir Next", size: 7.9pt, fill: white, [
            #text(weight: "semibold", style: "italic")["Busco quien tenga…"] #text(fill: rgb("#CBD5E1"))[· subjunctive]
          ])
        )
      )
    )
  })
}

#set page(
  paper: "us-letter",
  margin: 0pt,
  fill: paper,
  background: place(
    top + left,
    // Navy header background stops at 252pt so the larger Atlas card hangs over onto the warm paper
    rect(
      width: 100%,
      height: 252pt,
      fill: navy,
      stroke: (bottom: 2.5pt + gold.transparentize(35%))
    )
  )
)
#set text(font: "Avenir Next", fill: ink, size: 11pt)

#grid(
  columns: (100%),
  rows: (412pt, 1fr, 88pt),

  // ZONE 1 & 2: HERO BANNER + OVERHANGING ATLAS CENTERPIECE
  box(
    width: 100%,
    height: 100%,
    inset: (x: 34pt, top: 15pt, bottom: 0pt),
    {
      // Top metadata bar: Left-aligned SPRING 2027, SEMINAR IN HISPANIC LINGUISTICS, TAUGHT IN SPANISH
      stack(
        dir: ltr,
        spacing: 8pt,
        badge("SPRING 2027", size: 8.5pt),
        badge("SEMINAR IN HISPANIC LINGUISTICS", bg: rgb("#1A2639"), fg: rgb("#CBD5E1"), border: rgb("#334155"), size: 8.5pt),
        badge("TAUGHT IN SPANISH", bg: rgb("#1A2639"), fg: teal, border: teal.transparentize(30%), size: 8.5pt),
      )

      // Tightened spacing between top header line and Hook
      v(1pt)

      // Hook Question (Enlarged for 2-3 ft readability)
      par(
        leading: 0.4em,
        text(
          font: "Canela Text",
          size: 24.5pt,
          weight: "bold",
          fill: white,
          hyphenate: false,
          [What makes Spanish #text(fill: gold-bright, style: "italic")[ordinary] – and #text(fill: coral, style: "italic")[extraordinary] – among the world's languages?]
        )
      )

      // Tightened spacing between Hook and Title/Subtitle
      v(2pt)

      // Course Title + Subtitle
      stack(
        dir: ltr,
        spacing: 10pt,
        text(font: "Avenir Next", size: 15.2pt, weight: "bold", fill: gold-bright, "THE MANY SPANISHES:"),
        text(font: "Avenir Next", size: 14.8pt, weight: "medium", fill: rgb("#E2E8F0"), "What Spanish Variation Reveals About Language Itself")
      )

      v(7pt)

      // Enlarged Visual Centerpiece Box (276pt tall!) filling the upper hero zone
      box(
        width: 100%,
        height: 276pt,
        {
          // Subtle warm shadow on the paper half
          place(left + top, dx: 0pt, dy: 5pt,
            rect(width: 100%, height: 100%, radius: 9pt, fill: rgb("#141E2E").transparentize(82%), stroke: none)
          )
          box(
            width: 100%,
            height: 100%,
            fill: rgb("#0F1724"),
            stroke: 1.2pt + rgb("#33496B"),
            radius: 9pt,
            clip: true,
            atlas-graphic
          )
        }
      )
    }
  ),

  // ZONE 4 & 5: BODY CONTENT
  box(
    width: 100%,
    height: 100%,
    inset: (x: 34pt, top: 8pt, bottom: 14pt),
    grid(
      columns: (1.32fr, 1fr),
      column-gutter: 20pt,

      // Left Column: Zone 4 (What We'll Explore)
      stack(
        dir: ttb,
        spacing: 10pt,
        text(font: "JetBrains Mono", size: 10pt, weight: "bold", fill: coral, tracking: 1.4pt, "WHAT WE'LL EXPLORE"),

        // Pillar 1
        box(
          width: 100%,
          fill: white,
          stroke: 0.8pt + rgb("#E2DDD3"),
          radius: 7pt,
          inset: (x: 13pt, y: 10pt),
          grid(
            columns: (30pt, 1fr),
            column-gutter: 10pt,
            box(
              width: 28pt, height: 28pt, radius: 14pt, fill: rgb("#FDF3D7"),
              align(center + horizon, text(font: "JetBrains Mono", weight: "bold", size: 11pt, fill: gold, "01"))
            ),
            stack(
              spacing: 3.5pt,
              text(weight: "bold", size: 12.2pt, fill: navy, "Spanish's Global Surprises"),
              par(leading: 0.46em, text(size: 10.1pt, fill: muted, [Most of the world's languages have no subjunctive mood, don't drop subject pronouns, and don't split "to be" into #emph[ser] and #emph[estar]. Discover where Spanish stands on the global map.]))
            )
          )
        ),

        // Pillar 2
        box(
          width: 100%,
          fill: white,
          stroke: 0.8pt + rgb("#E2DDD3"),
          radius: 7pt,
          inset: (x: 13pt, y: 10pt),
          grid(
            columns: (30pt, 1fr),
            column-gutter: 10pt,
            box(
              width: 28pt, height: 28pt, radius: 14pt, fill: rgb("#FCEAE7"),
              align(center + horizon, text(font: "JetBrains Mono", weight: "bold", size: 11pt, fill: coral, "02"))
            ),
            stack(
              spacing: 3.5pt,
              text(weight: "bold", size: 12.2pt, fill: navy, "One Language, Many Systems"),
              par(leading: 0.46em, text(size: 10.1pt, fill: muted, [Why do Caribbean speakers say #emph["¿Qué tú quieres?"] while Andean speakers drop pronouns almost entirely? Trace how grammar adapts across communities.]))
            )
          )
        ),

        // Pillar 3
        box(
          width: 100%,
          fill: white,
          stroke: 0.8pt + rgb("#E2DDD3"),
          radius: 7pt,
          inset: (x: 13pt, y: 10pt),
          grid(
            columns: (30pt, 1fr),
            column-gutter: 10pt,
            box(
              width: 28pt, height: 28pt, radius: 14pt, fill: rgb("#E3F4F2"),
              align(center + horizon, text(font: "JetBrains Mono", weight: "bold", size: 11pt, fill: teal, "03"))
            ),
            stack(
              spacing: 3.5pt,
              text(weight: "bold", size: 12.2pt, fill: navy, "Worlds in Contact"),
              par(leading: 0.46em, text(size: 10.1pt, fill: muted, [What happens when Spanish lives alongside Quechua, Guaraní, English in the U.S., or African languages in Equatorial Guinea? Explore how contact reshapes a language.]))
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
          spacing: 10pt,
          text(font: "JetBrains Mono", size: 10pt, weight: "bold", fill: navy, tracking: 1.4pt, "INSIDE THE SEMINAR"),

          // Item 1: Interactive Maps & Visual Discovery
          stack(
            spacing: 3.5pt,
            stack(
              dir: ltr, spacing: 7pt,
              box(width: 8pt, height: 8pt, radius: 4pt, fill: teal, baseline: -1pt),
              text(weight: "bold", size: 11.4pt, fill: navy, "Interactive Maps & Visual Tools")
            ),
            par(leading: 0.45em, text(size: 9.8pt, fill: ink, "Explore real patterns across the Spanish-speaking world using interactive atlases, visual apps, and critical checks on how AI handles variation."))
          ),

          line(length: 100%, stroke: 0.6pt + rgb("#D5CBB8")),

          // Item 2: Think Like a Field Linguist
          stack(
            spacing: 3.5pt,
            stack(
              dir: ltr, spacing: 7pt,
              box(width: 8pt, height: 8pt, radius: 4pt, fill: coral, baseline: -1pt),
              text(weight: "bold", size: 11.4pt, fill: navy, "Think Like a Linguist")
            ),
            par(leading: 0.45em, text(size: 9.8pt, fill: ink, "Move beyond textbook rules to uncover why every variety of Spanish has its own internal logic, structure, and history."))
          ),

          line(length: 100%, stroke: 0.6pt + rgb("#D5CBB8")),

          // Item 3: Hands-On Discovery
          stack(
            spacing: 3.5pt,
            stack(
              dir: ltr, spacing: 7pt,
              box(width: 8pt, height: 8pt, radius: 4pt, fill: gold, baseline: -1pt),
              text(weight: "bold", size: 11.4pt, fill: navy, "Hands-On Discovery")
            ),
            par(leading: 0.45em, text(size: 9.8pt, fill: ink, "Learn by doing: investigate real-world case studies, test competing ideas with evidence, and build your own capstone showcase."))
          ),

          // Clear breathing room before the floating navy callout
          v(6pt),
          box(
            width: 100%,
            fill: navy,
            radius: 6pt,
            inset: (x: 10pt, y: 8.5pt),
            align(center, par(leading: 0.45em, text(font: "JetBrains Mono", size: 8pt, fill: gold-bright, weight: "bold", tracking: 0.4pt, "COUNTS FOR SPANISH MAJOR & MINOR\nLANGUAGE / LINGUISTICS SEMINAR")))
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
        spacing: 6pt,
        stack(
          dir: ltr,
          spacing: 10pt,
          badge("SPA 379", bg: gold, fg: navy, border: gold, size: 9.5pt),
          box(baseline: -1pt, text(font: "JetBrains Mono", size: 10.5pt, weight: "bold", fill: gold-bright, "TR 9:30–10:45am")),
          box(baseline: -1pt, text(font: "Avenir Next", weight: "bold", size: 11.5pt, fill: white, "·  Prof. Jerid Francom")),
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
        qr-code()
      )
    )
  )
)
