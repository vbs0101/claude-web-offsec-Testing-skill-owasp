# Security Report Format

## Executive Summary

Provide a concise overview of the security posture.

## Scope

Include:

- Target
- Environment
- Accounts
- APIs
- Exclusions
- Testing mode

## Findings

For every confirmed issue include:

- Title
- Severity
- OWASP category
- Affected endpoint/component
- Preconditions
- Evidence
- Reproduction steps
- Security impact
- Recommended remediation
- Retest criteria

## Severity

Critical
High
Medium
Low
Informational

## Not Tested

Explicitly list functionality that could not safely be tested.

Never classify “not tested” as “secure”.
