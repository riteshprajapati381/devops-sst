# DynamoDB and RDS — database services

DynamoDB is a managed NoSQL database of tables, items and attributes. The partition key distributes and identifies data; an optional sort key orders items within a partition and supports range queries. Design keys around access patterns. Common uses include sessions, event data and high-throughput key-value lookup.

RDS manages relational engines such as PostgreSQL and MySQL, with DB instances, network access controls, encryption and automated backups. Multi-AZ supports availability/failover; read replicas support read scaling and are not equivalent to Multi-AZ failover. RDS suits transactions, joins and structured business records. Choose DynamoDB for suitable key-based patterns and RDS for relational constraints and SQL queries.
