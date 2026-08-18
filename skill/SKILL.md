---
name: web-security-test
description: Authorized web application security testing based on the OWASP Top 10. Performs structured reconnaissance, attack-surface inventory, passive and controlled active testing, authentication/authorization checks, API security checks, evidence collection, severity assessment, remediation guidance, and retesting. Use only for systems the user owns or is explicitly authorized to test.
---

# Web Security Test

## Purpose

Perform a structured, evidence-driven security assessment of a web application using the current OWASP Top 10 as the primary taxonomy.

Prefer passive testing by default. Use active testing only when the target is explicitly authorized and the test is appropriate for the environment.

Never perform destructive testing against production unless the user explicitly authorizes the exact action.

## 1. Authorization and Scope

Before active testing, establish:

- Target URL(s)
- Environment: development, staging, or production
- Authorization to test
- Authentication accounts available
- API endpoints in scope
- WebSocket endpoints, if applicable
- File upload functionality
- External integrations
- Whether rate-limit testing is allowed
- Whether active exploitation is allowed
- Production restrictions

If scope or authorization is unclear, stop active testing and ask for clarification. Passive analysis may continue where appropriate.

## 2. Test Modes

### Passive mode

Allowed:

- HTTP inspection
- headers and cookies
- TLS inspection
- HTML/JavaScript inspection
- route discovery
- API documentation inspection
- source review
- dependency review
- authentication flow observation
- error-message analysis

No destructive requests.

### Controlled active mode

Allowed only for explicitly authorized targets. Prefer staging and dedicated test accounts.

Examples:

- harmless parameter manipulation
- authorization checks using test accounts
- controlled IDOR/BOLA verification
- safe XSS probes
- controlled injection verification
- CSRF validation
- conservative rate-limit verification
- file-upload validation with test files

Do not delete data, alter real financial state, install persistence, exfiltrate secrets, or intentionally degrade availability.

## 3. Assessment Workflow

Follow this order:

1. Scope validation
2. Reconnaissance
3. Technology fingerprinting
4. Endpoint inventory
5. Authentication mapping
6. Authorization mapping
7. Session/cookie analysis
8. API security testing
9. OWASP Top 10 assessment
10. Security headers/TLS
11. Business-logic testing
12. Evidence collection
13. Risk classification
14. Remediation recommendations
15. Retesting

## 4. Application Inventory

Build an inventory containing:

- domains and in-scope subdomains
- application routes
- API routes
- HTTP methods
- parameters and request bodies
- authentication requirements
- roles
- file uploads
- redirects
- external services
- client-side storage
- cookies
- session/token mechanisms

For each endpoint record:

| Method | Path | Auth | Role | Parameters | Data sensitivity | Notes |
|---|---|---|---|---|---|---|

## 5. OWASP Top 10 Testing

Use the current OWASP Top 10 taxonomy. Do not force categories that are not applicable.

For each applicable category:

1. Identify the attack surface.
2. Identify relevant controls.
3. Perform safe tests.
4. Capture evidence.
5. Determine exploitability and impact.
6. Assign severity.
7. Provide remediation.
8. Define retest criteria.

Consult the reference files in `references/` for focused methodology.

## 6. Broken Access Control

Check for:

- IDOR/BOLA
- horizontal privilege escalation
- vertical privilege escalation
- missing authorization checks
- object-level authorization failures
- hidden admin endpoints
- method-based authorization bypass
- path-based authorization bypass
- role manipulation
- forced browsing
- predictable identifiers

Use separate authorized accounts where possible. A normal user must not access another user's private objects or invoke administrative actions.

## 7. Authentication and Session Security

Assess:

- weak password policies
- credential enumeration
- brute-force protections
- login rate limits
- MFA enforcement and bypass
- password reset and recovery
- reset-token entropy and expiration
- session rotation after login
- session invalidation after logout
- remember-me functionality
- cookie attributes
- session fixation
- token validation
- timeout behavior

Never use credential stuffing against real users. Use dedicated test accounts.

## 8. Cryptographic Failures

Check:

- HTTPS everywhere
- TLS configuration
- secure cookies
- sensitive data over HTTP
- password hashing
- token protection
- encryption at rest where relevant
- hardcoded secrets
- secrets in JavaScript bundles
- sensitive information in logs
- randomness where security-sensitive

Mask any discovered secret in the report and rotate it through the owner's normal process.

## 9. Injection

Test applicable inputs for:

- SQL injection
- NoSQL injection
- OS command injection
- LDAP injection
- template injection
- XPath injection
- expression-language injection

Start with non-destructive detection. Never use destructive SQL or commands against production.

Distinguish suspicious reflection from a confirmed injection.

## 10. Insecure Design / Business Logic

Review workflows for:

- trust in client-supplied values
- state-transition bypasses
- payment manipulation
- privilege assumptions
- duplicate/replay behavior
- race conditions
- approval bypass
- missing server-side validation
- client-side-only security checks

Verify critical values and authorization decisions are enforced server-side.

## 11. Security Misconfiguration

Check:

- debug mode
- exposed stack traces
- directory listing
- default credentials
- unnecessary HTTP methods
- admin/debug endpoints
- environment/config exposure
- verbose errors
- missing security headers
- unsafe CORS
- CSP
- HSTS
- X-Content-Type-Options
- Referrer-Policy
- Permissions-Policy
- clickjacking protection
- exposed `.git`
- backup files
- source maps
- configuration files

## 12. Vulnerable Components

Identify relevant:

- JavaScript dependencies
- backend dependencies
- server packages
- frameworks
- third-party libraries

Where possible record:

- component
- version
- known vulnerabilities/CVEs
- whether the vulnerable component is reachable or actually used
- mitigations

Do not classify an outdated package as exploitable solely because it is old.

## 13. Software / Data Integrity and Supply Chain

Check:

- unsafe deserialization
- untrusted update mechanisms
- unsigned downloads
- dependency integrity
- CI/CD secrets
- build artifact integrity
- package integrity
- update URL security
- release signing

For mobile/update flows verify package identity, signing, download origin, versioning, HTTPS, and artifact integrity where applicable.

## 14. Logging and Monitoring

Check whether important security events are auditable:

- login success/failure
- privilege changes
- password changes
- administrative actions
- payment changes
- authorization failures
- suspicious access

Verify logs do not contain passwords, tokens, secrets, or biometric data.

## 15. SSRF

Where applicable, test server-side URL fetches, webhooks, remote imports, and integrations.

Safely determine whether the server can reach internal resources. Never perform destructive internal actions.

## 16. XSS

Test applicable inputs for:

- reflected XSS
- stored XSS
- DOM XSS
- HTML injection

Review output encoding and dangerous DOM sinks. Use harmless proof-of-execution payloads only.

## 17. CSRF

For state-changing actions, assess:

- CSRF tokens
- SameSite cookies
- Origin validation
- Referer validation where appropriate

Test high-impact actions such as password changes, account changes, wallet/payment changes, administrative actions, and other state changes.

GET requests should not perform destructive state changes.

## 18. API Security

For each API endpoint check:

- authentication
- authorization
- object-level authorization
- function-level authorization
- mass assignment
- excessive data exposure
- rate limiting
- pagination
- input validation
- output validation
- HTTP method enforcement
- error handling
- CORS

A hidden UI control is not an API security control.

## 19. File Upload Security

Where uploads exist, test:

- extension validation
- MIME validation
- magic-byte validation
- filename/path traversal
- executable content
- oversized files
- decompression risks
- SVG/script risks
- download authorization
- storage location

Verify uploaded files cannot become executable server-side.

## 20. CORS

Check:

- wildcard origins
- credentialed wildcard CORS
- reflected Origin
- null origin handling
- unnecessary methods/headers

Do not recommend permissive CORS without understanding credential behavior.

## 21. Rate Limiting

Assess appropriate sensitive endpoints:

- login
- password reset
- MFA
- sensitive APIs
- payment/wallet APIs
- expensive endpoints

Use conservative rates and stop if degradation appears.

## 22. Evidence Requirements

Every confirmed vulnerability requires evidence.

Acceptable evidence includes:

- request/response
- HTTP status and headers
- sanitized payload
- source location
- screenshot
- browser behavior
- test database effect in staging
- relevant server logs

Clearly distinguish:

- observation
- suspected issue
- confirmed vulnerability
- false positive
- environmental limitation

## 23. Severity

Use:

- Critical
- High
- Medium
- Low
- Informational

For each confirmed finding include:

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

Do not inflate severity.

## 24. Safety Rules

Never:

- destroy production data
- delete accounts
- alter real balances without explicit authorization
- steal credentials
- bypass authentication on unauthorized accounts
- deploy malware
- install persistence
- exfiltrate secrets
- perform denial-of-service testing without explicit authorization

Prefer staging and dedicated test accounts.

## 25. Output

Produce:

### Executive Summary
Overall security posture.

### Scope
Targets, environment, accounts, exclusions, and test mode.

### Attack Surface
Routes, APIs, roles, integrations, uploads, and sensitive workflows.

### OWASP Findings

| OWASP | Finding | Severity | Status |
|---|---|---|---|

### Detailed Findings
For every confirmed issue.

### Passed Controls
Important controls that were verified.

### Not Tested
Anything that could not safely or technically be tested.

### Remediation Plan
Prioritize Critical → High → Medium → Low.

### Retest Plan
Exactly what must be tested after each fix.

## 26. Testing Philosophy

Be skeptical and evidence-driven.

Prefer:

"Verified"

over:

"Probably safe"

Prefer:

"Not tested"

over:

"No vulnerability found"

Never confuse absence of evidence with evidence of absence.

## 27. Execution Rule

When asked to run a security test:

1. Confirm scope.
2. Confirm environment.
3. Confirm authorization for active tests if unclear.
4. Inventory endpoints and roles.
5. Start passively.
6. Use dedicated test accounts for active checks.
7. Run OWASP checks systematically.
8. Collect evidence.
9. Produce a structured report.
10. Offer targeted retesting after remediation.

Do not jump directly to exploit payloads.
