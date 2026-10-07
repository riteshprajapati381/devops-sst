#!/usr/bin/env bash
set -euxo pipefail
cd "$HOME/devops-sst/Docker Networking"
docker rm -f homework-app 2>/dev/null || true
docker compose up -d
for attempt in $(seq 1 30); do docker exec homework-database mysqladmin ping -uroot -pdemo-local-only && break || sleep 2; done
docker network ls
docker inspect homework-backend --format '{{json .NetworkSettings.Networks}}'
docker exec homework-frontend ping -c 2 homework-backend
docker exec homework-backend ping -c 2 homework-database
# Expected isolation failure: frontend has no shared network with database.
if docker exec homework-frontend ping -c 1 homework-database; then exit 1; else echo 'Frontend-to-database isolation verified'; fi
docker compose ps
docker compose stop
docker run -d --name homework-apache --network host httpd:2.4-alpine
for attempt in $(seq 1 20); do curl --max-time 10 -fsS http://localhost:80 && break || sleep 1; done
curl --max-time 15 -fsS http://localhost:80
docker ps --filter name=homework-apache
docker rm -f homework-apache
docker run -d --name homework-bind -p 8080:80 --mount type=bind,source="$(pwd)/bind-mount",target=/usr/share/nginx/html nginx:1.29-alpine
for attempt in $(seq 1 20); do curl --max-time 10 -fsS http://localhost:80 && break || sleep 1; done
curl --max-time 15 -fsS http://localhost:8080
printf '<h1>Hello students — live bind mount update</h1>\n' >bind-mount/index.html
curl --max-time 15 -fsS http://localhost:8080
docker ps --filter name=homework-bind
