#!/usr/bin/env bash
set -euo pipefail

TARGET="${HOME}/.claude/skills/web-security-test"

if [[ ! -d "${TARGET}/.git" ]]; then
  echo "Skill is not installed."
  exit 1
fi

git -C "${TARGET}" pull --ff-only
echo "Skill updated successfully."
