// Virginia Tech Memo Template
// Adapted from the texMemo LaTeX class by Rob Oakes,
// with AIS branding by Robert Weiss.

#let vt-memo(
  // Memo metadata
  to: none,
  from: "Robert Weiss (AIS Director)",
  includes-from: none,
  signature-space: 0in,
  subject: none,
  date: datetime.today().display("[month repr:long] [day], [year]"),
  identifier: none,
  confidential: false,
  // Logo: set to an image or none
  logo: image("assets/AIS.png", width: 50%),
  // Body content
  body,
) = {
  // Page setup: US letter, 1in margins, matching LaTeX article 11pt
  set page(
    paper: "us-letter",
    margin: 1in,
    numbering: "1",
    number-align: center,
  )

  // LaTeX 11pt article: \normalsize = 10.95pt, baselineskip = 13.6pt
  // LaTeX PDF uses Latin Modern Roman; New Computer Modern is the modern equivalent
  set text(font: "New Computer Modern", size: 10.95pt)
  set par(justify: true, first-line-indent: 0pt, leading: 6.12pt, spacing: 6.12pt)

  // Heading style: matches LaTeX \subsection* with \vspace{-1em} before
  set heading(numbering: none)
  show heading.where(level: 1): it => {
    v(12pt)
    text(size: 12pt, weight: "bold", it.body)
    v(1pt)
  }
  show heading.where(level: 2): it => {
    v(8pt)
    text(size: 10.95pt, weight: "bold", it.body)
    v(1pt)
  }

  // List styling to match LaTeX itemize with noitemsep
  set list(indent: 1.2em, body-indent: 0.5em, spacing: 6.12pt, marker: ([•], [--]))
  set enum(indent: 1.2em, body-indent: 0.5em, spacing: 6.12pt)

  // Logo (right-aligned)
  if logo != none {
    align(right, logo)
    v(0.2in)
  }

  // Memo fields
  {
    let field(label, value) = {
      if value != none {
        grid(
          columns: (auto, 1fr),
          column-gutter: 0.75em,
          text(weight: "bold", label), value,
        )
      }
    }

    set par(spacing: 6.72pt)

    if confidential {
      align(center, text(fill: red, weight: "bold", size: 18pt, smallcaps[Confidential]))
      v(0.5em)
    }

    field([To:], to)
    field([From:], from)
    if signature-space != 0in {
      v(signature-space)
    }
    if includes-from != none { field([Includes from:], includes-from) }
    if includes-from != none and signature-space != 0in {
      v(signature-space)
    }
    field([Subject:], subject)
    if identifier != none { field([Identifier:], identifier) }
    field([Date:], date)
  }

  // Decorative line
  v(0.3em)
  line(length: 100%, stroke: 0.5pt)
  v(0.25em)

  // Body content
  body
}
