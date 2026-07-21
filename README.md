# PortusHumanitas™

**A Harbor of Lived Inquiry**

Public reading surface for the literary, ethical, theological, and philosophical writing from which PortusSophia later emerged.

## Public site

`https://humanitas.portussophia.com`

## Reader-facing structure

The site now leads with the writing itself:

- **The Book** — selected public passages from the first assembled manuscript;
- **Genesis** — the full public Latin-English Genesis;
- **Trilogia** — Pater, Mater, and Revelatio;
- **The Bridges** — all five bilingual bridge texts;
- **The Essays** — the four early philosophical essays listed in the publication corpus;
- **Phrases** — an anthology of language carried forward;
- **Lineage** — the story of the Book reaching the limit that made disciplined research necessary.

Provenance and verification remain supporting concerns rather than the public site’s organizing personality.

## Source boundary

The complete source estate remains private. Public pages reproduce or excerpt material identified by the PortusHumanitas workbook as public-ready or suitable for bounded public use.

Private correspondence, sensitive records, and intimate material are not published merely because they contributed to the history of the inquiry.

## Adopted site shell

- `shoreline-home` is the production homepage layout.
- `shoreline-masthead` is the production internal-page layout.
- Shared PortusSophia tokens and imagery load from `assets.portussophia.com`.
- Humanitas keeps local Jekyll layout, include, and CSS mirrors because Liquid templates cannot be loaded remotely.

## Local build

```bash
bundle check
bundle exec jekyll serve
```

For a production build:

```bash
bundle exec jekyll build --trace
```

## Rights and use

Copyright © 2026 PortusSophia, LLC. All rights reserved.

No open-source or Creative Commons license is granted.

See [`RIGHTS.md`](RIGHTS.md) for the repository’s default rights and use statement.

See [`LICENSE.md`](LICENSE.md) for the limited permissions specific to reading, citing, linking to, and briefly quoting material from PortusHumanitas™.