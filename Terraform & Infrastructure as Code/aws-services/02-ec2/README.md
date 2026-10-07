# EC2 — compute

EC2 supplies virtual machines. An AMI defines the operating-system image; the instance type determines CPU, RAM and architecture. A key pair supports SSH authentication. EBS provides persistent block storage and can outlive an instance depending on delete-on-termination settings.

Security Groups are stateful interface-level firewalls. Public IPs support internet routing when the subnet has an Internet Gateway route; private IPs support internal communication. Instances move through pending, running, stopping, stopped and terminated states. Stopping compute does not automatically remove chargeable storage. Typical uses include web servers, CI runners and development hosts.
