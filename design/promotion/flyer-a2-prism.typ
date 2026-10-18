#import "_flyer-template.typ": *

#let prism-graphic = {
  box(width: 100%, height: 100%, {
    // Subtle dark radial/grid backdrop
    for i in range(1, 14) {
      place(left + top, dx: i * 42pt, dy: 0pt,
        line(start: (0pt, 0pt), end: (0pt, 170pt), stroke: 0.35pt + rgb("#1A263B"))
      )
    }

    // Left Incoming Beam: "SPANISH" (Single perceived language)
    place(left + top, dx: 24pt, dy: 52pt,
      box(
        fill: rgb("#18253A"),
        stroke: 0.7pt + rgb("#3B5278"),
        radius: 4pt,
        inset: (x: 8pt, y: 5pt),
        stack(
          spacing: 2pt,
          text(font: "JetBrains Mono", size: 7pt, weight: "bold", fill: gold-bright, "INPUT: \"ONE\" LANGUAGE"),
          text(font: "Avenir Next", size: 8.5pt, weight: "bold", fill: white, "El Español"),
          text(size: 7pt, fill: rgb("#94A3B8"), "Shared core grammar")
        )
      )
    )

    // Concentrated white/gold beam hitting prism
    place(left + top,
      polygon(
        fill: white.transparentize(15%),
        stroke: none,
        (134pt, 74pt), (218pt, 80pt), (215pt, 88pt), (134pt, 82pt)
      )
    )
    place(left + top,
      polygon(
        fill: gold-bright.transparentize(65%),
        stroke: none,
        (134pt, 70pt), (220pt, 77pt), (214pt, 92pt), (134pt, 86pt)
      )
    )

    // Refracted Spectrum Beams (Right of Prism)
    // Ray 1 (Gold - Top)
    place(left + top,
      polygon(
        fill: gold-bright.transparentize(30%),
        stroke: none,
        (264pt, 62pt), (380pt, 22pt), (380pt, 36pt), (268pt, 72pt)
      )
    )
    // Ray 2 (Coral - Upper Mid)
    place(left + top,
      polygon(
        fill: coral.transparentize(28%),
        stroke: none,
        (268pt, 74pt), (380pt, 60pt), (380pt, 74pt), (272pt, 84pt)
      )
    )
    // Ray 3 (Teal - Lower Mid)
    place(left + top,
      polygon(
        fill: teal.transparentize(28%),
        stroke: none,
        (272pt, 86pt), (380pt, 98pt), (380pt, 112pt), (276pt, 96pt)
      )
    )
    // Ray 4 (Sky/Indigo - Bottom)
    place(left + top,
      polygon(
        fill: rgb("#60A5FA").transparentize(30%),
        stroke: none,
        (276pt, 98pt), (380pt, 136pt), (380pt, 150pt), (280pt, 108pt)
      )
    )

    // Center Geometric Prism ("WORLD LANGUAGES / TYPOLOGY")
    place(left + top, dx: 195pt, dy: 24pt,
      polygon(
        fill: rgb("#1E3252").transparentize(20%),
        stroke: 2pt + gold-bright,
        (52pt, 0pt), (104pt, 112pt), (0pt, 112pt)
      )
    )
    // Inner prism facet lines
    place(left + top, dx: 195pt, dy: 24pt,
      line(start: (52pt, 0pt), end: (44pt, 112pt), stroke: 0.8pt + white.transparentize(55%))
    )
    place(left + top, dx: 204pt, dy: 142pt,
      box(
        fill: rgb("#0F1724"),
        inset: (x: 6pt, y: 2pt),
        text(font: "JetBrains Mono", size: 6.8pt, weight: "bold", fill: gold-bright, tracking: 0.8pt, "LENS: WORLD LANGUAGES")
      )
    )

    // Right Output Cards (The Refracted Spectrum of Spanish)
    let spec-card(y, color, tag, detail) = {
      place(left + top, dx: 378pt, dy: y,
        box(
          width: 155pt,
          fill: rgb("#162235"),
          stroke: (left: 3pt + color, rest: 0.6pt + rgb("#2E4263")),
          radius: 4pt,
          inset: (x: 8pt, y: 4.5pt),
          stack(
            spacing: 2pt,
            text(font: "JetBrains Mono", size: 6.8pt, weight: "bold", fill: color, tag),
            text(font: "Avenir Next", size: 7.4pt, fill: white, detail)
          )
        )
      )
    }

    spec-card(14pt, gold-bright, "GLOBAL RARITIES", "Ser/estar · Subjunctive · Null subjects")
    spec-card(52pt, coral, "PRONOUN & ORDER CLINE", "Caribbean \"¿Qué tú dices?\" vs. Andean")
    spec-card(90pt, teal, "MOOD RENEGOTIATION", "Los Angeles · Equatorial Guinea")
    spec-card(128pt, rgb("#60A5FA"), "CONTACT ECOLOGIES", "Quechua · Guaraní · English · Pichi")
  })
}

#render-flyer(
  concept-tag: "CONCEPT A2 · THE LINGUISTIC PRISM",
  hero-graphic: prism-graphic
)
