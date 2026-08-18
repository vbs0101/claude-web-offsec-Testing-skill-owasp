#!/usr/bin/env bash

set -euo pipefail

REPO_URL="https://github.com/vbs0101/claude-web-offsec-Testing-skill-owasp.git"
SKILL_NAME="web-security-test"

SKILLS_DIR="${HOME}/.claude/skills"
TARGET="${SKILLS_DIR}/${SKILL_NAME}"

printf '\n==============================================\n'
printf ' Claude Web Security Test Skill\n'
printf ' OWASP Top 10\n'
printf '==============================================\n\n'

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

echo "Downloading repository..."

git clone --depth 1 "${REPO_URL}" "${TMP_DIR}/repo"

if [[ ! -f "${TMP_DIR}/repo/skill/SKILL.md" ]]; then
    echo "ERROR: skill/SKILL.md not found in repository."
    exit 1
fi

echo "Installing skill..."

mkdir -p "${TARGET}"

# Remove previous installation contents.
rm -rf "${TARGET:?}"/*

# Copy the CONTENTS of skill/ directly into the Claude skill directory.
cp -R "${TMP_DIR}/repo/skill/." "${TARGET}/"

if [[ ! -f "${TARGET}/SKILL.md" ]]; then
    echo "ERROR: installation failed."
    echo "Expected: ${TARGET}/SKILL.md"
    exit 1
fi

echo
echo "[OK] Installed: ${TARGET}"
echo "[OK] SKILL.md: ${TARGET}/SKILL.md"
echo
echo "Restart Claude Code to load the skill."
echo
echo "Try:"
echo "  Run the web-security-test skill against my staging application."
echo
