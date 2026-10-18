#import "_flyer-template.typ": *

#let bubble-node(x, y, color, region, phrase, feature) = {
  place(left + top, dx: x, dy: y,
    box(
      width: 148pt,
      fill: rgb("#162338"),
      stroke: 1.2pt + color,
      radius: 7pt,
      inset: (x: 9pt, y: 6pt),
      stack(
        spacing: 2.5pt,
        stack(
          dir: ltr,
          spacing: 5pt,
          circle(radius: 3pt, fill: color),
          text(font: "JetBrains Mono", size: 6.5pt, weight: "bold", fill: color, region)
        ),
        text(font: "Charter", size: 9.5pt, weight: "bold", style: "italic", fill: white, phrase),
        text(font: "Avenir Next", size: 6.8pt, fill: rgb("#CBD5E1"), feature)
      )
    )
  )
}

#let network-graphic = {
  box(width: 100%, height: 100%, {
    // Background concentric rings around center
    place(center + horizon, circle(radius: 78pt, stroke: 0.5pt + rgb("#233552"), fill: none))
    place(center + horizon, circle(radius: 52pt, stroke: 0.7pt + rgb("#2B4266"), fill: rgb("#131F33")))

    // Connecting network lines from center (272pt, 85pt) to outer speech bubbles
    let cx = 272pt
    let cy = 85pt
    let links = (
      (90pt, 36pt, coral),
      (90pt, 128pt, gold-bright),
      (450pt, 36pt, teal),
      (450pt, 128pt, rgb("#60A5FA")),
      (272pt, 22pt, gold-bright),
      (272pt, 148pt, coral)
    )
    for l in links {
      place(left + top,
        line(start: (cx, cy), end: (l.at(0), l.at(1)), stroke: (paint: l.at(2).transparentize(35%), thickness: 1.3pt, dash: "densely-dashed"))
      )
    }

    // Center Hub Node
    place(center + horizon,
      box(
        width: 112pt,
        height: 62pt,
        fill: navy,
        stroke: 1.8pt + gold-bright,
        radius: 31pt,
        align(center + horizon,
          stack(
            spacing: 3pt,
            text(font: "JetBrains Mono", size: 6.8pt, weight: "bold", fill: gold-bright, "ONE LANGUAGE"),
            text(font: "Canela Text", size: 11pt, weight: "bold", fill: white, "Many Systems"),
            text(font: "Avenir Next", size: 6.5pt, fill: rgb("#94A3B8"), "World Typology Network")
          )
        )
      )
    )

    // Top-Left Bubble: Caribbean
    bubble-node(16pt, 12pt, coral, "CARIBBEAN (SAN JUAN / STO. DOMINGO)", "\"¿Qué tú quieres?\"", "Overt pronoun + non-inverted question")

    // Bottom-Left Bubble: Andean
    bubble-node(16pt, 102pt, gold-bright, "ANDEAN (LIMA / QUITO)", "\"De mi mamá su casa\"", "Quechua contact · double possessive")

    // Top-Right Bubble: Rioplatense / Paraguayan
    bubble-node(380pt, 12pt, teal, "SOUTHERN CONE & PARAGUAY", "\"¿Vos sabés qué pasó?\"", "Voseo system · Guaraní contact")

    // Bottom-Right Bubble: U.S. & Equatorial Guinea
    bubble-node(380pt, 102pt, rgb("#60A5FA"), "LOS ANGELES & MALABO", "\"Espero que vienes mañana\"", "Bilingual contact · mood renegotiation")

    // Top Center Micro-Pill
    place(center + top, dy: 10pt,
      box(
        fill: rgb("#1E2E48"), stroke: 0.7pt + gold, radius: 10pt, inset: (x: 9pt, y: 3.5pt),
        text(font: "JetBrains Mono", size: 6.5pt, fill: gold-bright, "IBERIA: \"¿Qué queréis vosotros?\"")
      )
    )

    // Bottom Center Spectrum Bar
    place(center + bottom, dy: -8pt,
      box(
        fill: rgb("#101929"), stroke: 0.7pt + rgb("#334155"), radius: 10pt, inset: (x: 12pt, y: 4pt),
        text(font: "JetBrains Mono", size: 6.8pt, fill: rgb("#CBD5E1"), "CONTINUUM OF VARIATION  ·  EVIDENCE, NOT PRESCRIPTION")
      )
    )
  })
}

#render-flyer(
  concept-tag: "CONCEPT A3 · SPEECH-BUBBLE NETWORK",
  hero-graphic: network-graphic
)
