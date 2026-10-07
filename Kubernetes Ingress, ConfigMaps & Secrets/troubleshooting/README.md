# Trailing-newline Secret troubleshooting

The teacher's troubleshooting example demonstrates that `echo value | base64` encodes a newline as well as the value. After decoding, the application receives a different password and database authentication fails. Use `printf '%s' value | base64`, `echo -n value | base64` or Kubernetes `stringData` to avoid this bug. Padding alone does not reliably diagnose a newline; inspect decoded bytes with `od -An -tx1` or `xxd`.

The reproducible script [session12-secret.sh](../../scripts/session12-secret.sh) compares the actual decoded bytes before and after suppressing the newline. A database using password authentication would receive a different password; localhost trust authentication does not check the password. Screenshots and raw output are linked in [the assignment README](../readme.md).
