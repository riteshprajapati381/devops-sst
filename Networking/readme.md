# Networking

| Command | Purpose |
|---|---|
| ping | Check ICMP reachability and response time |
| traceroute | Show network hops to a destination |
| ip -brief addr | Show interface addresses |
| ip route | Show routes and the default gateway |
| ss -lnt | Show listening TCP ports |
| dig, nslookup | Look up DNS records |
| curl -I | Check HTTP response headers |
| tcpdump | Inspect network packets |

```bash
ip -brief addr
ip route
ss -lnt
ping -c 2 example.com
dig example.com
nslookup example.com
curl -I https://example.com
```

Result: DNS lookup succeeded and the HTTP request returned 200.

## Screenshots

![Dns http](output/screenshots/dns-http.png)

![Interfaces routing](output/screenshots/interfaces-routing.png)

## Command output

- [session02 05](output/logs/session02-05.log)
