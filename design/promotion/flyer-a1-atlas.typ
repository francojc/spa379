#import "_flyer-template.typ": *

#let pin(x, y, color, label, sublabel, align-right: false) = {
  place(left + top, dx: x, dy: y, {
    // outer glow
    place(center + horizon, circle(radius: 9pt, fill: color.transparentize(72%), stroke: none))
    place(center + horizon, circle(radius: 5.5pt, fill: color.transparentize(45%), stroke: none))
    circle(radius: 3.5pt, fill: color, stroke: 1pt + white)
  })
  let tag-x = if align-right { x - 135pt } else { x + 10pt }
  place(left + top, dx: tag-x, dy: y - 10pt,
    box(
      fill: rgb("#162235").transparentize(10%),
      stroke: 0.75pt + color,
      radius: 4pt,
      inset: (x: 6pt, y: 3.5pt),
      stack(
        spacing: 2pt,
        text(font: "JetBrains Mono", size: 6.8pt, weight: "bold", fill: color, label),
        text(font: "Avenir Next", size: 7.2pt, fill: white, sublabel)
      )
    )
  )
}

#let atlas-graphic = {
  box(width: 100%, height: 100%, {
    // Subtle lat/lon grid lines
    for i in range(1, 12) {
      place(left + top, dx: i * 48pt, dy: 0pt,
        line(start: (0pt, 0pt), end: (0pt, 170pt), stroke: 0.4pt + rgb("#1E2D45"))
      )
    }
    for j in range(1, 6) {
      place(left + top, dx: 0pt, dy: j * 30pt,
        line(start: (0pt, 0pt), end: (560pt, 0pt), stroke: 0.4pt + rgb("#1E2D45"))
      )
    }

    // Stylized continental landmass silhouettes (dot-matrix / polygon style)
    // North & Central America
    place(left + top, dx: 45pt, dy: 18pt,
      polygon(
        fill: rgb("#1D2D44"), stroke: 0.7pt + rgb("#2E4668"),
        (0pt, 10pt), (55pt, 5pt), (85pt, 25pt), (70pt, 52pt), (92pt, 68pt), (62pt, 65pt), (35pt, 42pt), (10pt, 28pt)
      )
    )
    // South America
    place(left + top, dx: 120pt, dy: 82pt,
      polygon(
        fill: rgb("#1D2D44"), stroke: 0.7pt + rgb("#2E4668"),
        (10pt, 0pt), (45pt, 6pt), (68pt, 28pt), (52pt, 62pt), (28pt, 82pt), (16pt, 65pt), (6pt, 28pt)
      )
    )
    // Iberia / Europe
    place(left + top, dx: 270pt, dy: 20pt,
      polygon(
        fill: rgb("#1D2D44"), stroke: 0.7pt + rgb("#2E4668"),
        (8pt, 15pt), (48pt, 5pt), (72pt, 18pt), (58pt, 40pt), (15pt, 44pt), (4pt, 30pt)
      )
    )
    // Africa
    place(left + top, dx: 278pt, dy: 66pt,
      polygon(
        fill: rgb("#1D2D44"), stroke: 0.7pt + rgb("#2E4668"),
        (12pt, 4pt), (55pt, 2pt), (82pt, 26pt), (68pt, 78pt), (42pt, 88pt), (26pt, 50pt), (4pt, 32pt)
      )
    )

    // Background typological scatter dots (WALS style)
    let bg-dots = (
      (65pt, 30pt, teal), (95pt, 40pt, gold), (315pt, 32pt, teal),
      (340pt, 42pt, coral), (335pt, 85pt, teal), (355pt, 115pt, gold),
      (410pt, 48pt, teal), (445pt, 62pt, coral), (470pt, 40pt, gold),
      (490pt, 95pt, teal), (430pt, 110pt, gold), (168pt, 108pt, teal)
    )
    for d in bg-dots {
      place(left + top, dx: d.at(0), dy: d.at(1),
        circle(radius: 2.2pt, fill: d.at(2).transparentize(45%), stroke: none)
      )
    }

    // Connecting arcs / lines between Spanish nodes
    place(left + top,
      curve(
        stroke: (paint: gold.transparentize(45%), thickness: 1pt, dash: "dashed"),
        curve.move((105pt, 55pt)),
        curve.quad((195pt, 20pt), (282pt, 52pt)),
      )
    )
    place(left + top,
      curve(
        stroke: (paint: coral.transparentize(45%), thickness: 1pt, dash: "dashed"),
        curve.move((132pt, 72pt)),
        curve.quad((130pt, 100pt), (138pt, 122pt)),
      )
    )
    place(left + top,
      curve(
        stroke: (paint: teal.transparentize(45%), thickness: 1pt, dash: "dashed"),
        curve.move((282pt, 52pt)),
        curve.quad((305pt, 85pt), (312pt, 112pt)),
      )
    )

    // Highlighted Pins + Callouts
    pin(92pt, 46pt, teal, "U.S. & HERITAGE", "English contact · mood shift", align-right: false)
    pin(132pt, 74pt, coral, "CARIBBEAN", "\"¿Qué tú dices?\" · overt tú/yo", align-right: false)
    pin(136pt, 126pt, gold-bright, "ANDEAN & GUARANI", "Quechua / Guaraní contact", align-right: false)
    pin(282pt, 52pt, gold-bright, "IBERIA", "Vosotros · leísmo · ser/estar", align-right: false)
    pin(312pt, 114pt, coral, "EQUATORIAL GUINEA", "Bantu/Pichi contact · mood", align-right: false)

    // Top-right Legend Overlay Card (WALS Atlas aesthetic)
    place(right + top, dx: -12pt, dy: 12pt,
      box(
        width: 138pt,
        fill: rgb("#131D2E").transparentize(8%),
        stroke: 0.7pt + rgb("#334155"),
        radius: 5pt,
        inset: 8pt,
        stack(
          spacing: 5pt,
          text(font: "JetBrains Mono", size: 6.8pt, weight: "bold", fill: gold-bright, "TYPOLOGICAL ATLAS LENS"),
          stack(dir: ltr, spacing: 5pt, circle(radius: 3pt, fill: gold-bright), text(size: 7pt, fill: rgb("#CBD5E1"), "Global rarity (ser/estar, null S)")),
          stack(dir: ltr, spacing: 5pt, circle(radius: 3pt, fill: coral), text(size: 7pt, fill: rgb("#CBD5E1"), "Internal shift (word order, mood)")),
          stack(dir: ltr, spacing: 5pt, circle(radius: 3pt, fill: teal), text(size: 7pt, fill: rgb("#CBD5E1"), "Contact restructuring"))
        )
      )
    )
  })
}

#render-flyer(
  concept-tag: "CONCEPT A1 · TYPOLOGICAL ATLAS",
  hero-graphic: atlas-graphic
)
