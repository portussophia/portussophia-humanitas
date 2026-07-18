---
layout: shoreline-masthead
title: "The Corpus"
permalink: /corpus/
---

*A public reading surface for approved artifacts whose standing, integrity, and provenance were established before publication here.*

The corpus is not a copy of the private `/Book` estate. It contains only artifacts already admitted to public standing, together with reading pages that preserve their historical and canonical distinctions.

## Corpus rule

> Humanitas does not reseal, rewrite, or reauthorize an artifact. It publishes the already sealed public artifact and preserves its established provenance.

Sealed source files remain byte-identical under `corpus/sealed/`. They do not receive Jekyll front matter, formatting changes, or silent line-ending normalization. Editorial reading pages may introduce and contextualize them, but those pages do not inherit the artifact’s standing.

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
No sealed artifacts have been added to the public index yet. Admission begins only when the existing authoritative files and their declared hashes are copied from the private source estate.
{% endif %}

## Verification

Every indexed sealed file is checked against the SHA-256 digest already declared for it. A mismatch fails verification. The check establishes byte integrity—not philosophical correctness, external endorsement, or truth.
