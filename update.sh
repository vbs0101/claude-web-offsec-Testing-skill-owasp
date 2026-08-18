#!/usr/bin/env bash

set -euo pipefail

REPO_URL="https://github.com/vbs0101/claude-web-offsec-Testing-skill-owasp.git"
SKILL_NAME="web-security-test"

SKILLS_DIR="${HOME}/.claude/skills"
TARGET="${SKILLS_DIR}/${SKILL_NAME}"

if [[ ! -f "${TARGET}/SKILL.md" ]]; then
    echo "Skill is not installed: ${TARGET}"
    exit 1
fi

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

echo "Downloading latest skill..."

git clone --depth 1 "${REPO_URL}" "${TMP_DIR}/repo"

if [[ ! -f "${TMP_DIR}/repo/skill/SKILL.md" ]]; then
    echo "ERROR: skill/SKILL.md not found in repository."
    exit 1
fi

echo "Updating skill..."

rm -rf "${TARGET:?}"/*
cp -R "${TMP_DIR}/repo/skill/." "${TARGET}/"

if [[ ! -f "${TARGET}/SKILL.md" ]]; then
    echo "ERROR: update failed."
    exit 1
fi

echo
echo "[OK] Skill updated successfully:"
echo "     ${TARGET}"
