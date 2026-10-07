# IAM — identities and permissions

IAM controls who can access AWS resources and which actions they can perform. A user is an identity, a group collects users, and a role is assumed to obtain temporary credentials. Policies describe allowed or denied actions on resources; an explicit deny overrides an allow.

Prefer roles and temporary credentials for EC2 workloads and CI. Give each role the least privileges required, enable MFA for human access, avoid root-account daily use, and do not commit access keys. A deployment role can be restricted to the project resources instead of granting administrator access.
