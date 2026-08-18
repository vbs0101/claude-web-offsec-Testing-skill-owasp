# API Security Testing

For every API endpoint evaluate:

- Authentication
- Authorization
- Object-level authorization
- Function-level authorization
- IDOR/BOLA
- Mass assignment
- Input validation
- Excessive data exposure
- HTTP method enforcement
- Rate limiting
- Pagination
- Error handling
- CORS
- CSRF where applicable

Never assume UI restrictions protect APIs.

Use separate authorized admin and normal-user accounts.

Test:

- horizontal privilege escalation
- vertical privilege escalation
- unauthorized object access
- unauthorized state changes
