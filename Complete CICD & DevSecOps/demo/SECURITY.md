# Security Policy

## Supported Versions

Use this section to tell people about which versions of your project are
currently being supported with security updates.

| Version | Supported          |
| ------- | ------------------ |
| 5.1.x   | :white_check_mark: |
| 5.0.x   | :x:                |
| 4.0.x   | :white_check_mark: |
| < 4.0   | :x:                |

## Reporting a Vulnerability

Use this section to tell people how to report a vulnerability.

Tell them where to go, how often they can expect to get an update on a
reported vulnerability, what to expect if the vulnerability is accepted or
declined, etc.

## Homework security changes

Flask debug mode is disabled and the container runs as UID 10001. CI runs Bandit, pip-audit, Gitleaks and Trivy. Bandit excludes B104 (the container must bind its server to all container interfaces) and B311 (the reference dashboard uses non-security randomness only to simulate pipeline durations).

The inherited repository contained two base64 classroom demo credentials in the session 12 Secret manifest. The current manifest now contains runtime placeholders; the README creates the actual Secret with kubectl. `.gitleaksignore` baselines only the two exact historical findings, not a path or whole rule. New secrets still fail the pipeline. Gitleaks scans the full Git history. No AWS keys or GitHub tokens are committed.
