# Secret Newline Troubleshooting

`echo value | base64` includes a newline. Use `printf '%s' value | base64`, `echo -n` or `stringData` to avoid it.

```bash
echo value | base64 | base64 --decode | od -An -tx1
printf '%s' value | base64 | base64 --decode | od -An -tx1
```

Result: the first value ends with byte `0a`; the second does not. A newline changes the password supplied to an application.

[Screenshots and output](../readme.md)
