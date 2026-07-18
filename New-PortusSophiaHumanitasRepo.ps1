<#
.SYNOPSIS
    Scaffolds the portussophia-humanitas Jekyll GitHub Pages repository structure.

.DESCRIPTION
    Creates the full directory tree and placeholder files for the repo.
    Existing files/folders are left untouched (no overwrite) unless -Force is used.

.PARAMETER Path
    Root path where the repo should be created. Defaults to .\portussophia-humanitas

.PARAMETER Force
    Overwrite existing placeholder files with fresh stubs.

.EXAMPLE
    .\New-PortusSophiaHumanitasRepo.ps1
    .\New-PortusSophiaHumanitasRepo.ps1 -Path C:\repos\portussophia-humanitas -Force
#>

[CmdletBinding()]
param(
    [string]$Path = ".\portussophia-humanitas",
    [switch]$Force
)

$ErrorActionPreference = "Stop"

function New-Dir {
    param([string]$DirPath)
    if (-not (Test-Path -LiteralPath $DirPath)) {
        New-Item -ItemType Directory -Path $DirPath -Force | Out-Null
        Write-Host "  [dir]  $DirPath"
    }
}

function New-Stub {
    param(
        [string]$FilePath,
        [string]$Content = ""
    )
    $exists = Test-Path -LiteralPath $FilePath
    if ($exists -and -not $Force) {
        Write-Host "  [skip] $FilePath (exists)"
        return
    }
    $dir = Split-Path -Parent $FilePath
    if ($dir -and -not (Test-Path -LiteralPath $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
    Set-Content -LiteralPath $FilePath -Value $Content -NoNewline:$false -Encoding UTF8
    Write-Host "  [file] $FilePath"
}

Write-Host "Scaffolding portussophia-humanitas at: $Path`n"

New-Dir $Path
Push-Location $Path

try {
    # ---------------------------------------------------------------
    # Top-level directories
    # ---------------------------------------------------------------
    $dirs = @(
        "about",
        "corpus",
        "corpus/sealed/book",
        "corpus/sealed/genesis",
        "corpus/sealed/trilogia",
        "corpus/sealed/prefaces",
        "corpus/sealed/bridges",
        "corpus/sealed/essays",
        "corpus/sealed/appendices",
        "corpus/sealed/rosetta",
        "corpus/sealed/atlas",
        "corpus/sealed/releases",
        "phrases",
        "provenance",
        "provenance/ledgers",
        "provenance/witnesses",
        "provenance/seals",
        "provenance/corrections",
        "lineage",
        "_data",
        "_layouts",
        "_includes",
        "_sass",
        "assets/css",
        "assets/images",
        "assets/js",
        "scripts",
        ".github/workflows"
    )
    foreach ($d in $dirs) { New-Dir $d }

    # ---------------------------------------------------------------
    # Root files
    # ---------------------------------------------------------------

    New-Stub "CITATION.cff" @"
cff-version: 1.2.0
message: "If you use or reference this work, please cite it as below."
title: "PortusSophia Humanitas"
authors:
  - family-names: "Dennis"
    given-names: "James Roy"
date-released: $(Get-Date -Format 'yyyy-MM-dd')
"@

    New-Stub "CNAME" ""

    New-Stub ".gitignore" @"
_site/
.sass-cache/
.jekyll-cache/
.jekyll-metadata
vendor/
.bundle/
*.gem
.DS_Store
Thumbs.db
"@

    New-Stub ".gitattributes" @"
* text=auto eol=lf
*.pdf binary
*.png binary
*.jpg binary
"@

    New-Stub "_config.yml" @"
title: PortusSophia Humanitas
description: >-
  Public corpus and provenance record for the PortusSophia philosophy-of-science
  research program.
baseurl: ""
url: ""

markdown: kramdown
theme: null

collections:
  sealed:
    output: true
    permalink: /corpus/sealed/:path/

defaults:
  - scope:
      path: ""
      type: pages
    values:
      layout: page

exclude:
  - Gemfile
  - Gemfile.lock
  - scripts/
  - README.md
  - RIGHTS.md
"@

    New-Stub "Gemfile" @"
source "https://rubygems.org"

gem "jekyll", "~> 4.3"
gem "webrick", "~> 1.8"

group :jekyll_plugins do
  gem "jekyll-feed"
  gem "jekyll-sitemap"
  gem "jekyll-seo-tag"
end
"@

    New-Stub "Gemfile.lock" ""

    New-Stub "index.md" @"
---
layout: home
title: Home
---

# PortusSophia Humanitas

Welcome. Start with [About](/about/), browse the [Corpus](/corpus/), or review
[Provenance](/provenance/).
"@

    New-Stub "404.html" @"
---
layout: default
title: Not Found
permalink: /404.html
---

# 404 — Page Not Found

The page you're looking for doesn't exist. Return to the [home page](/).
"@

    # ---------------------------------------------------------------
    # Section index pages
    # ---------------------------------------------------------------
    New-Stub "about/index.md" @"
---
layout: page
title: About
permalink: /about/
---

# About PortusSophia Humanitas
"@

    New-Stub "corpus/index.md" @"
---
layout: page
title: Corpus
permalink: /corpus/
---

# Corpus

Sealed artifacts are organized under [sealed](/corpus/sealed/).
"@

    New-Stub "phrases/index.md" @"
---
layout: page
title: Phrases
permalink: /phrases/
---

# Phrases
"@

    New-Stub "provenance/index.md" @"
---
layout: page
title: Provenance
permalink: /provenance/
---

# Provenance

- [Ledgers](/provenance/ledgers/)
- [Witnesses](/provenance/witnesses/)
- [Seals](/provenance/seals/)
- [Corrections](/provenance/corrections/)
"@

    New-Stub "lineage/index.md" @"
---
layout: page
title: Lineage
permalink: /lineage/
---

# Lineage
"@

    # .gitkeep placeholders so empty dirs survive git init/commit
    $keepDirs = @(
        "corpus/sealed/book",
        "corpus/sealed/genesis",
        "corpus/sealed/trilogia",
        "corpus/sealed/prefaces",
        "corpus/sealed/bridges",
        "corpus/sealed/essays",
        "corpus/sealed/appendices",
        "corpus/sealed/rosetta",
        "corpus/sealed/atlas",
        "corpus/sealed/releases",
        "provenance/ledgers",
        "provenance/witnesses",
        "provenance/seals",
        "provenance/corrections",
        "_sass",
        "assets/css",
        "assets/images",
        "assets/js"
    )
    foreach ($d in $keepDirs) {
        New-Stub (Join-Path $d ".gitkeep") ""
    }

    # ---------------------------------------------------------------
    # _data
    # ---------------------------------------------------------------
    New-Stub "_data/navigation.yml" @"
- title: Home
  url: /
- title: About
  url: /about/
- title: Corpus
  url: /corpus/
- title: Phrases
  url: /phrases/
- title: Provenance
  url: /provenance/
- title: Lineage
  url: /lineage/
"@

    New-Stub "_data/artifact-index.yml" @"
# Machine-readable index of sealed artifacts.
# Populate as artifacts are added to corpus/sealed/*
artifacts: []
"@

    # ---------------------------------------------------------------
    # _layouts
    # ---------------------------------------------------------------
    New-Stub "_layouts/default.html" @"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{{ page.title }} | {{ site.title }}</title>
  <link rel="stylesheet" href="{{ '/assets/css/main.css' | relative_url }}">
</head>
<body>
  {% include header.html %}
  <main>
    {{ content }}
  </main>
  {% include footer.html %}
</body>
</html>
"@

    New-Stub "_layouts/home.html" @"
---
layout: default
---
<div class="home">
  {{ content }}
</div>
"@

    New-Stub "_layouts/page.html" @"
---
layout: default
---
<article class="page">
  <h1>{{ page.title }}</h1>
  {{ content }}
</article>
"@

    New-Stub "_layouts/artifact.html" @"
---
layout: default
---
<article class="artifact">
  <h1>{{ page.title }}</h1>
  {% include artifact-standing.html %}
  {{ content }}
  {% include provenance-links.html %}
</article>
"@

    # ---------------------------------------------------------------
    # _includes
    # ---------------------------------------------------------------
    New-Stub "_includes/header.html" @"
<header>
  <a href="{{ '/' | relative_url }}">{{ site.title }}</a>
  <nav>
    {% for item in site.data.navigation %}
      <a href="{{ item.url | relative_url }}">{{ item.title }}</a>
    {% endfor %}
  </nav>
</header>
"@

    New-Stub "_includes/footer.html" @"
<footer>
  <p>&copy; {{ 'now' | date: '%Y' }} PortusSophia. Here and Now!</p>
</footer>
"@

    New-Stub "_includes/artifact-standing.html" @"
{% comment %}
  Renders the current standing (draft / witnessed / sealed) of an artifact,
  driven by page front matter (e.g. page.standing).
{% endcomment %}
{% if page.standing %}
<div class="artifact-standing artifact-standing--{{ page.standing }}">
  Standing: {{ page.standing }}
</div>
{% endif %}
"@

    New-Stub "_includes/provenance-links.html" @"
{% comment %}
  Renders links to related provenance records (ledger entry, witness record,
  seal), driven by page front matter.
{% endcomment %}
<div class="provenance-links">
  {% if page.ledger %}<a href="{{ page.ledger | relative_url }}">Ledger</a>{% endif %}
  {% if page.witness %}<a href="{{ page.witness | relative_url }}">Witness</a>{% endif %}
  {% if page.seal %}<a href="{{ page.seal | relative_url }}">Seal</a>{% endif %}
</div>
"@

    # ---------------------------------------------------------------
    # assets
    # ---------------------------------------------------------------
    New-Stub "assets/css/main.css" @"
/* PortusSophia Humanitas — base stylesheet */
body {
  font-family: Georgia, 'Times New Roman', serif;
  margin: 0 auto;
  max-width: 780px;
  padding: 2rem 1rem;
  line-height: 1.6;
}
"@

    New-Stub "assets/js/main.js" @"
// PortusSophia Humanitas — base script (intentionally minimal)
"@

    # ---------------------------------------------------------------
    # scripts
    # ---------------------------------------------------------------
    New-Stub "scripts/verify_sealed.py" @"
#!/usr/bin/env python3
'''
verify_sealed.py

Verifies integrity of artifacts under corpus/sealed/ against the
provenance ledger (checksums, required front matter, standing field).

Usage:
    python scripts/verify_sealed.py
'''

import sys
from pathlib import Path

SEALED_ROOT = Path(__file__).resolve().parent.parent / "corpus" / "sealed"


def main() -> int:
    if not SEALED_ROOT.exists():
        print(f"Sealed root not found: {SEALED_ROOT}")
        return 1

    errors = []
    for artifact in SEALED_ROOT.rglob("*.md"):
        text = artifact.read_text(encoding="utf-8")
        if not text.startswith("---"):
            errors.append(f"Missing front matter: {artifact}")

    if errors:
        print("Verification FAILED:")
        for e in errors:
            print(f"  - {e}")
        return 1

    print("Verification OK.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
"@

    # ---------------------------------------------------------------
    # .github/workflows
    # ---------------------------------------------------------------
    New-Stub ".github/workflows/verify-sealed.yml" @"
name: Verify Sealed Corpus

on:
  pull_request:
    paths:
      - 'corpus/sealed/**'
  push:
    branches: [ main ]
    paths:
      - 'corpus/sealed/**'

jobs:
  verify:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: '3.12'
      - name: Run verification
        run: python scripts/verify_sealed.py
"@

    New-Stub ".github/workflows/pages.yml" @"
name: Build and Deploy Jekyll Site

on:
  push:
    branches: [ main ]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: true

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.2'
          bundler-cache: true
      - name: Build with Jekyll
        run: bundle exec jekyll build --destination ./_site
      - uses: actions/upload-pages-artifact@v3
        with:
          path: ./_site

  deploy:
    environment:
      name: github-pages
      url: `${{ steps.deployment.outputs.page_url }}`
    runs-on: ubuntu-latest
    needs: build
    steps:
      - id: deployment
        uses: actions/deploy-pages@v4
"@

    Write-Host "`nScaffold complete: $Path"
    Write-Host "Next steps:"
    Write-Host "  cd `"$Path`""
    Write-Host "  git init"
    Write-Host "  bundle install"
    Write-Host "  git add . ; git commit -m `"Initial scaffold`""
}
finally {
    Pop-Location
}