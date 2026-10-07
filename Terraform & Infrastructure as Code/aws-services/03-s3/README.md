# S3 — object storage

S3 stores objects in uniquely named buckets. An object has a key, content and metadata. Storage classes trade retrieval speed and cost, including Standard, infrequent-access classes and Glacier archive classes. Versioning keeps multiple versions of a key; lifecycle rules transition or expire objects and versions.

Encrypt objects using SSE-S3 or KMS as appropriate. IAM and bucket policies govern access; keep Block Public Access enabled unless public serving is deliberate. S3 suits backups, static assets, logs and Terraform remote state. It is object storage, not a mounted filesystem with ordinary local-file semantics.
