# PortusHumanitas™

**A Harbor of Inquiry**

Public reading and provenance surface for the governed humanistic corpus from which the later PortusSophia™ research architecture became necessary.

## Public site

`https://humanitas.portussophia.com`

## Repository boundary

The complete source estate remains private under `PortusSophia/Book`.

This repository contains only:

- sealed artifacts already authorized for public standing;
- byte-identical public copies of those artifacts;
- their existing public ledgers, witnesses, hashes, and seals;
- editorial reading pages that explain chronology, relation, and standing.

Editorial pages do not inherit the standing of the sealed artifact they introduce.

## Adopted site shell

- `shoreline-home` is the production homepage layout.
- `shoreline-masthead` is the production internal-page layout.
- Shared PortusSophia tokens and imagery load from `assets.portussophia.com`.
- Humanitas keeps local Jekyll layout, include, and CSS mirrors because Liquid templates cannot be loaded remotely.

## Local build

From the repository root:

```bash
bundle check
bundle exec jekyll serve
```

For a production build:

```bash
bundle exec jekyll build --trace
```

## Sealed artifact verification

Each sealed artifact must be registered in `_data/artifact-index.yml` with its established SHA-256 digest.

```bash
python -m pip install PyYAML==6.0.2
python scripts/verify_sealed.py
```

The verifier:

- compares the stored file bytes with the declared digest;
- rejects sealed files that are not indexed;
- rejects paths outside `corpus/sealed/`;
- does not require or add Jekyll front matter.

## Rights

No open-source or Creative Commons license is granted. See [RIGHTS.md](RIGHTS.md).
