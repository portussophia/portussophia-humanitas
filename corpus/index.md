---
layout: shoreline-masthead
title: "The Corpus"
permalink: /corpus/
---

*A governed receiving surface for public artifacts whose standing, integrity, and provenance were established before admission here.*

The public corpus is not a copy of the private source estate. At present, no sealed artifacts have been admitted. The pages now available are editorial orientation and selected public excerpts; they do not constitute a sealed corpus by themselves.

## Corpus rule

> Humanitas does not reseal, rewrite, or reauthorize an artifact. It may publish an already authorized public artifact while preserving its established standing and provenance.

When a sealed source file is admitted, its stored copy must remain byte-identical under `corpus/sealed/`. It receives no Jekyll front matter, formatting change, or silent line-ending normalization. An editorial reading page may introduce and contextualize it, but that page does not inherit the artifact’s standing.

## Admission sequence

A sealed artifact is not public merely because it exists elsewhere. Admission requires:

1. confirmation that public release is authorized;
2. identification of the authoritative source object and its existing standing;
3. its declared SHA-256 digest and available provenance references;
4. a byte-identical copy placed within the sealed corpus boundary;
5. successful repository verification;
6. an artifact-index entry that routes readers without creating new authority.

## Public artifact index

{% assign artifact_index = site.data["artifact-index"].artifacts %}
{% if artifact_index and artifact_index.size > 0 %}
<ul class="artifact-list">
  {% for artifact in artifact_index %}
    <li>
      {% if artifact.public_path %}<a href="{{ artifact.public_path | relative_url }}">{% endif %}
      <strong>{{ artifact.title }}</strong>
      {% if artifact.public_path %}</a>{% endif %}
      {% if artifact.standing %}<span> — {{ artifact.standing }}</span>{% endif %}
    </li>
  {% endfor %}
</ul>
{% else %}
No sealed artifacts have been admitted to the public index yet. This is an accurate statement of current public standing, not a missing claim of completion.
{% endif %}

## Verification

The repository includes an explicit verifier that compares every indexed sealed file with its declared SHA-256 digest, rejects unindexed sealed files, and rejects paths outside the sealed corpus boundary. At present this is a deliberate pre-publication check, not a claim of continuous external verification.

A successful hash check establishes byte identity. It does not establish philosophical correctness, truth, peer review, endorsement, originality, or present canonical authority.
