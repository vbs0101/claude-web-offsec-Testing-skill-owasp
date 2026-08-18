# Web Security Testing Methodology

## Assessment workflow

1. Confirm authorization and scope.
2. Identify environment.
3. Perform passive reconnaissance.
4. Inventory routes and APIs.
5. Map authentication.
6. Map authorization and roles.
7. Analyze sessions and cookies.
8. Test APIs.
9. Assess applicable OWASP Top 10 categories.
10. Test business logic.
11. Review security headers/TLS.
12. Review file uploads and downloads.
13. Collect evidence.
14. Classify severity.
15. Recommend remediation.
16. Retest after fixes.

## Testing principles

- Passive testing first.
- Active testing only with explicit authorization.
- Prefer staging.
- Avoid destructive requests.
- Never intentionally damage production data.
- Never expose credentials or secrets.
- Every confirmed vulnerability requires evidence.
- Distinguish suspected issues from confirmed vulnerabilities.
- “Not tested” is not equivalent to “secure”.
