#!/usr/bin/env python3

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

PATTERNS = (
    re.compile(r"@app\.route\(\s*[\"']([^\"']+)[\"']"),
    re.compile(r"fetch\(\s*[`\"']([^`\"']+)"),
    re.compile(r"axios\.(?:get|post|put|patch|delete)\(\s*[\"']([^\"']+)"),
)


def extract_routes(root: Path) -> list[str]:
    routes: set[str] = set()

    for path in root.rglob("*"):
        if not path.is_file() or path.suffix not in {".py", ".js", ".html", ".ts", ".tsx"}:
            continue

        try:
            text = path.read_text(encoding="utf-8", errors="ignore")
        except OSError:
            continue

        for pattern in PATTERNS:
            routes.update(pattern.findall(text))

    return sorted(routes)


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Passively inventory application routes and API references."
    )
    parser.add_argument("root", nargs="?", default=".")
    args = parser.parse_args()

    root = Path(args.root).resolve()
    if not root.exists():
        print(f"Directory not found: {root}", file=sys.stderr)
        return 1

    for route in extract_routes(root):
        print(route)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
