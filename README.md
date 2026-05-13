# What Solana Teaches Us About the Future of Scalable Blockchains

Slides and sources for a conference talk about Solana as a case study for scalable blockchain infrastructure: real load, TPS vs usability, fee markets, RPC reliability, transaction landing, and next-gen L1 design.

## Files

- `slides.md` - Marp source for the slide deck.
- `presentation.pdf` - generated PDF version of the presentation.
- `sources.md` - source list used for the talk.
- `repo-qr.svg` - QR code linking to this repository.
- `Makefile` - local commands for previewing and exporting the slides.

## Build

Requirements:

- Node.js
- npm
- make

Preview the slides:

```bash
make preview
```

Generate PDF:

```bash
make pdf
```

Generate HTML:

```bash
make html
```

Generate PNG images:

```bash
make images
```

Marp is executed through `npx`, so a local npm install is not required.

## Repository

https://github.com/kalaninja/solana-scalability-lessons
