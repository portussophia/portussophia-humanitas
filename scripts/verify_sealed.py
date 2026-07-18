#!/usr/bin/env python3
"""Verify byte integrity of the public sealed corpus.

The script reads ``_data/artifact-index.yml`` and compares each declared
``expected_sha256`` value with the bytes stored at ``sealed_file``.

The index is a routing map to existing authority. It does not reseal,
reauthorize, or modify an artifact.
"""

from __future__ import annotations

import hashlib
import sys
from pathlib import Path
from typing import Any

import yaml

ROOT = Path(__file__).resolve().parent.parent
SEALED_ROOT = ROOT / "corpus" / "sealed"
INDEX_PATH = ROOT / "_data" / "artifact-index.yml"
IGNORED_NAMES = {".gitkeep", ".DS_Store"}


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def load_index() -> list[dict[str, Any]]:
    if not INDEX_PATH.exists():
        raise FileNotFoundError(f"Artifact index not found: {INDEX_PATH}")

    data = yaml.safe_load(INDEX_PATH.read_text(encoding="utf-8")) or {}
    artifacts = data.get("artifacts", [])
    if not isinstance(artifacts, list):
        raise ValueError("artifact-index.yml: 'artifacts' must be a list")
    return artifacts


def resolve_sealed_file(value: str) -> Path:
    relative = value.lstrip("/")
    path = (ROOT / relative).resolve()
    sealed_root = SEALED_ROOT.resolve()
    if path != sealed_root and sealed_root not in path.parents:
        raise ValueError(f"Sealed file escapes corpus/sealed/: {value}")
    return path


def main() -> int:
    errors: list[str] = []

    if not SEALED_ROOT.exists():
        print(f"Sealed root not found: {SEALED_ROOT}")
        return 1

    try:
        artifacts = load_index()
    except (OSError, ValueError, yaml.YAMLError) as exc:
        print(f"Verification FAILED: {exc}")
        return 1

    indexed_paths: set[Path] = set()

    for position, artifact in enumerate(artifacts, start=1):
        if not isinstance(artifact, dict):
            errors.append(f"Entry {position} is not a mapping")
            continue

        artifact_id = str(artifact.get("id") or f"entry-{position}")
        sealed_file = artifact.get("sealed_file")
        expected = str(artifact.get("expected_sha256") or "").lower()

        if not sealed_file:
            errors.append(f"{artifact_id}: missing sealed_file")
            continue
        if len(expected) != 64 or any(char not in "0123456789abcdef" for char in expected):
            errors.append(f"{artifact_id}: expected_sha256 is not a valid SHA-256 digest")
            continue

        try:
            path = resolve_sealed_file(str(sealed_file))
        except ValueError as exc:
            errors.append(f"{artifact_id}: {exc}")
            continue

        indexed_paths.add(path)
        if not path.is_file():
            errors.append(f"{artifact_id}: sealed file not found: {path.relative_to(ROOT)}")
            continue

        actual = sha256(path)
        if actual != expected:
            errors.append(
                f"{artifact_id}: hash mismatch for {path.relative_to(ROOT)} "
                f"(expected {expected}, found {actual})"
            )

    unindexed = sorted(
        path.resolve()
        for path in SEALED_ROOT.rglob("*")
        if path.is_file() and path.name not in IGNORED_NAMES and path.resolve() not in indexed_paths
    )
    for path in unindexed:
        errors.append(f"Unindexed sealed file: {path.relative_to(ROOT)}")

    if errors:
        print("Verification FAILED:")
        for error in errors:
            print(f"  - {error}")
        return 1

    if artifacts:
        print(f"Verification OK: {len(artifacts)} sealed artifact(s) matched their declared hashes.")
    else:
        print("Verification OK: no sealed artifacts are indexed yet.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
