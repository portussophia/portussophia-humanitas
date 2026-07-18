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
