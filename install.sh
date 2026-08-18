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

mkdir -p "${SKILLS_DIR}"

if [[ -d "${TARGET}/.git" ]]; then
  echo "Updating existing skill..."
  git -C "${TARGET}" pull --ff-only
else
  echo "Installing skill..."
  rm -rf "${TARGET}"
  git clone --depth 1 "${REPO_URL}" "${TARGET}"
fi

echo
echo "[OK] Installed: ${TARGET}"
echo "Restart Claude Code to load the skill."
echo
echo "Try:"
echo "  Run the web-security-test skill against my staging application."
echo
