#!/usr/bin/env bash
set -euxo pipefail
echo 'With echo: decoded bytes include trailing 0a'
echo taskboard | base64 | base64 --decode | od -An -tx1
echo 'With printf: decoded bytes contain only the value'
printf '%s' taskboard | base64 | base64 --decode | od -An -tx1
with_newline=$(echo taskboard | base64)
without_newline=$(printf '%s' taskboard | base64)
test "$with_newline" != "$without_newline"
echo 'Verified: printf removes the unintended newline'
