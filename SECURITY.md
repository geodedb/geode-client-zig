# Security Policy

## Reporting a Vulnerability

If you believe you've found a security vulnerability:

1. **Do not** open a public issue.
2. Email: <security@devnw.com>
3. Include:
   - affected version/commit
   - reproduction steps or PoC (as safe as possible)
   - impact assessment
   - suggested fix (if you have one)

## Response targets (best effort)

- Acknowledgment: within 2 business days
- Triage update: within 7 days

## Supported Versions

| Version | Supported |
|--------:|:---------:|
| 0.x     | Yes       |

## Disclosure

We prefer coordinated disclosure. We'll credit reporters unless anonymity is requested.

## Security Considerations

### TLS Certificate Verification

The client supports TLS 1.3 for secure connections to Geode servers. By default, TLS certificate verification is enabled and should remain enabled in production environments.

**WARNING:** The `insecure` configuration option (also accessible via `GEODE_INSECURE=1` environment variable or `insecure=true` DSN parameter) disables TLS certificate verification. When disabled:

- The client cannot verify the server's identity
- Connections are vulnerable to man-in-the-middle (MITM) attacks
- All transmitted data, including credentials, can be intercepted or modified
- Authentication tokens could be stolen

**Only use `insecure=true` for:**

- Local development with localhost connections
- Testing environments with self-signed certificates
- Controlled CI/CD pipelines with internal infrastructure

**Never use `insecure=true` for:**

- Production deployments
- Connections over untrusted networks
- Systems handling sensitive data

If you need to use self-signed certificates in production, configure proper certificate trust instead of disabling verification.

### Input Validation

All user input is validated before processing. The client includes:

- Query length limits (1MB maximum)
- Null byte detection in queries
- Parameter name validation
- Hostname and port validation
- JSON escaping for all user-provided values in protocol messages

### Credential Handling

- Credentials are never logged
- DSN parsing supports URL-encoded credentials for special characters
- Session tokens are stored securely and cleared on disconnect
