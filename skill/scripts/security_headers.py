#!/usr/bin/env python3

from __future__ import annotations

import argparse
import sys
from urllib.error import HTTPError, URLError
from urllib.request import Request, urlopen

EXPECTED_HEADERS = (
    "Strict-Transport-Security",
    "Content-Security-Policy",
    "X-Content-Type-Options",
    "Referrer-Policy",
    "Permissions-Policy",
    "X-Frame-Options",
)


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Passively inspect common security headers."
    )
    parser.add_argument("url")
    args = parser.parse_args()

    request = Request(
        args.url,
        headers={"User-Agent": "Claude-Web-Security-Test/1.0"},
        method="GET",
    )

    try:
        with urlopen(request, timeout=10) as response:
            print(f"HTTP {response.status}")
            for name in EXPECTED_HEADERS:
                value = response.headers.get(name)
                if value:
                    print(f"[PASS] {name}: {value}")
                else:
                    print(f"[INFO] {name}: missing")
    except HTTPError as exc:
        print(f"HTTP {exc.code}: {exc.reason}", file=sys.stderr)
        return 1
    except URLError as exc:
        print(f"Request failed: {exc.reason}", file=sys.stderr)
        return 1
    except Exception as exc:
        print(f"Unexpected error: {exc}", file=sys.stderr)
        return 1

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
