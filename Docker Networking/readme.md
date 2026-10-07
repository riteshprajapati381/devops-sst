# Docker Networking

## Task 1

Created frontend, backend and database containers using three networks.
Backend is connected to frontend-net and backend-net.

```bash
docker compose up -d
docker network ls
docker inspect homework-backend
docker exec homework-frontend ping -c 2 backend
docker exec homework-backend ping -c 2 database
docker compose down
```

## Task 2

Apache container using host network:

```bash
docker pull httpd:2.4-alpine
docker run -d --name homework-apache --network host httpd:2.4-alpine
curl http://localhost:80
docker rm -f homework-apache
```

## Task 3

Nginx container using bind mount:

```bash
docker run -d --name homework-bind -p 8080:80 \
  --mount type=bind,source="$(pwd)/bind-mount",target=/usr/share/nginx/html \
  nginx:1.29-alpine
curl http://localhost:8080
```

Changes made in index.html are shown without restarting the container.

## Task 4

Overlay network connects containers running on different Docker hosts.
It is mainly used with Docker Swarm for multi-host communication.

```bash
docker network create --driver overlay --attachable app-overlay
```

## Network isolation and overlay notes

The frontend joins frontend-net. The backend joins frontend-net and backend-net. MySQL joins backend-net and isolated-net. The frontend can reach the backend, the backend can reach MySQL, and the frontend cannot resolve or reach MySQL because they share no network. Docker's embedded DNS provides service/container name lookup within shared user-defined networks.

An overlay network uses VXLAN to carry container traffic between hosts. Swarm manages membership and service discovery; standalone containers require an attachable overlay. Hosts need TCP 2377 for Swarm control, TCP/UDP 7946 for node discovery and UDP 4789 for overlay data traffic. An encrypted overlay can protect data-plane traffic with IPsec, at a performance cost. This is useful for distributed services across multiple machines; the homework's multi-host overlay portion is research, so no multi-host execution is claimed.

Run `docker swarm init` on a manager before creating a Swarm overlay; join other nodes using the generated join command. The live three-network exercise here uses local bridge networks.

## Captured evidence

![Network volume browser](output/playwright/network-volume-browser.png)

![Network volume](output/playwright/network-volume.png)

### Actual command output

- [network volume first attempt](output/logs/network-volume-first-attempt.log)
- [network volume](output/logs/network-volume.log)
