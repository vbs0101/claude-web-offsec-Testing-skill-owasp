# Claude Web Security Test

OWASP Top 10-based web application security testing skill for Claude Code.

## What it does

- Scope and authorization checks
- Passive reconnaissance and endpoint inventory
- Authentication and session review
- Authorization / IDOR / BOLA testing
- API security testing
- Injection, XSS, CSRF, SSRF and file-upload checks where applicable
- Security misconfiguration and dependency review
- Evidence-driven findings and severity assessment
- Remediation and retesting workflow

## Install

```bash
Copy the below to Claude and ask Claude to install this Skill
https://raw.githubusercontent.com/vbs0101/claude-web-offsec-Testing-skill-owasp/main/install.sh
```

Restart Claude Code after installation.

## Usage

Examples:

```text
Run the web-security-test skill against my staging application.
```

```text
Run a passive OWASP Top 10 security assessment against staging.
```

```text
Run an authorized API security assessment using my staging admin and player accounts.
```

```text
Retest all previously identified security findings.
```

For active testing, explicitly provide the target, environment, authorization, scope, and safety restrictions.

## Safety

This skill is for authorized security testing only. Prefer staging and dedicated test accounts. Production testing defaults to passive/read-only unless explicitly authorized.

## Layout

```text
skill/
├── SKILL.md
├── references/
│   ├── methodology.md
│   ├── authentication.md
│   ├── api-testing.md
│   └── reporting.md
└── scripts/
    ├── endpoint_inventory.py
    └── security_headers.py
```
