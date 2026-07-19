# PortusHumanitas™

**A Harbor of Inquiry**

Public orientation, phrase, lineage, and provenance surface for the bounded humanistic record through which the later PortusSophia™ research programme became necessary to continue the inquiry responsibly.

## Public site

`https://humanitas.portussophia.com`

## Repository boundary

The complete source estate remains private and is not identified by public repository path here.

The repository currently contains:

- editorial orientation to the Humanitas corpus;
- selected public phrases with stated historical and present disposition;
- the derivation path from lived and literary inquiry toward disciplined research;
- empty receiving pages for future public ledgers, witnesses, seals, and corrections;
- an empty sealed-artifact index and a verifier prepared for governed admission.

No sealed artifact or associated provenance record has yet been admitted. Editorial pages and excerpts are not sealed corpus objects and do not inherit the standing of any source artifact they discuss.

## Governed admission

A future sealed artifact may be admitted only after public release is authorized and the artifact’s existing standing, digest, and provenance references are identified. Humanitas does not reseal, rewrite, or create authority by copying a file into this repository.

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

Each admitted sealed artifact must be registered in `_data/artifact-index.yml` with its established SHA-256 digest.

```bash
python -m pip install PyYAML==6.0.2
python scripts/verify_sealed.py
```

The verifier:

- compares stored file bytes with the declared digest;
- rejects sealed files that are not indexed;
- rejects paths outside `corpus/sealed/`;
- does not require or add Jekyll front matter.

This is presently an explicit pre-publication check. A successful result establishes byte identity only; it does not establish truth, endorsement, peer review, or current canonical authority.

## Rights

No open-source or Creative Commons license is granted. See [RIGHTS.md](RIGHTS.md).
