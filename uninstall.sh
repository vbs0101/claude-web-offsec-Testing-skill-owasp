#!/usr/bin/env bash
set -euo pipefail

TARGET="${HOME}/.claude/skills/web-security-test"

if [[ -d "${TARGET}" ]]; then
  rm -rf "${TARGET}"
  echo "Removed ${TARGET}"
else
  echo "Skill is not installed."
fi
