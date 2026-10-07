#!/usr/bin/env bash
set -euxo pipefail
kind="$1"
cd "$HOME/devops-sst/Docker Fundamentals"
docker build -t "homework-${kind,,}" "$kind"
docker rm -f homework-app 2>/dev/null || true
port=80
case "$kind" in nodejs-app) port=3000;; python-app) port=8000;; java-app) port=8080;; esac
docker run -d --name homework-app -p "8080:$port" "homework-${kind,,}"
for attempt in $(seq 1 30); do curl --max-time 15 -fsS http://localhost:8080 && break || sleep 2; done
curl --max-time 15 -fsS http://localhost:8080
docker ps --filter name=homework-app
docker logs homework-app
