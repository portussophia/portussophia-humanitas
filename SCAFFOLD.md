# PortusHumanitas™ Repository Scaffold

```text
portussophia-humanitas/
├── README.md
├── RIGHTS.md
├── CITATION.cff
├── CNAME
├── .gitignore
├── .gitattributes
├── _config.yml
├── Gemfile
├── Gemfile.lock
├── index.md
├── 404.html
├── robots.txt
│
├── about/
│   └── index.md
├── corpus/
│   ├── index.md
│   └── sealed/
│       ├── book/
│       ├── genesis/
│       ├── trilogia/
│       ├── prefaces/
│       ├── bridges/
│       ├── essays/
│       ├── appendices/
│       ├── rosetta/
│       ├── atlas/
│       └── releases/
├── phrases/
│   └── index.md
├── provenance/
│   ├── index.md
│   ├── ledgers/index.md
│   ├── witnesses/index.md
│   ├── seals/index.md
│   └── corrections/index.md
├── lineage/
│   └── index.md
│
├── _data/
│   ├── navigation.yml
│   └── artifact-index.yml
├── _layouts/
│   ├── default.html
│   ├── home.html
│   ├── page.html
│   └── artifact.html
├── _includes/
│   ├── header.html
│   ├── footer.html
│   ├── artifact-standing.html
│   └── provenance-links.html
├── assets/
│   ├── css/main.css
│   ├── images/
│   └── js/
├── scripts/
│   └── verify_sealed.py
└── .github/workflows/
    ├── verify-sealed.yml
    └── pages.yml
```

## Structural rule

`corpus/sealed/` is a static immutable corpus, **not a Jekyll collection**.

Sealed artifacts:

- remain byte-identical;
- receive no Jekyll front matter;
- are protected from line-ending normalization by `.gitattributes`;
- are indexed through `_data/artifact-index.yml`;
- are verified against their already established SHA-256 hashes.

The `artifact` layout belongs to editorial reading pages that point to sealed files. It does not wrap or modify the sealed source object itself.

## Source boundary

The private `PortusSophia/Book` tree remains the complete source estate. Only approved public artifacts and public provenance records are copied into this repository.
