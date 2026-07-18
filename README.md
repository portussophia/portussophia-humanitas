# PortusHumanitas™

**A Harbor of Lived Inquiry**

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

## Local build

This repository uses the existing Ruby and Jekyll installation managed at the parent workspace level.

From the repository root:

```bash
bundle check
bundle exec jekyll serve
```

Then open `http://127.0.0.1:4000/`.

For a production build:

```bash
bundle exec jekyll build --trace
```

Run `bundle install` only when the Gemfile, lockfile, Ruby version, or installed dependency set changes.

## Deployment

GitHub Pages deploys from the `main` branch at the repository root. No repository-level Ruby-installation workflow is required.

## Shared assets

The PortusSophia family stylesheet is loaded from:

`https://assets.portussophia.com/styles/v1/site.css`

Humanitas then applies its own local literary and provenance stylesheet from `assets/css/main.css`.

## Sealed artifact verification

Each sealed artifact must be registered in `_data/artifact-index.yml` with its existing SHA-256 digest.

Verification remains a local operation until the public sealed corpus is introduced:

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
