# VPC — networking

A VPC is an isolated virtual network defined by a CIDR block. Subnets split that address space across availability zones. Route tables determine next hops. A public subnet routes internet-bound traffic to an Internet Gateway; its instances also need a public address for direct internet access. Private subnets commonly use a NAT Gateway for outbound IPv4 access.

Security Groups are stateful and apply to interfaces; Network ACLs are stateless and apply at subnet boundaries, so return traffic must also be allowed. Keep databases private, expose only necessary application ports, and use multiple availability zones for resilience.
