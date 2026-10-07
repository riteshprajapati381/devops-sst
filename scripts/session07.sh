#!/usr/bin/env bash
set -euxo pipefail
cd "$HOME/devops-sst/Docker Images/multi-stage-app"
docker rm -f homework-app 2>/dev/null || true
docker build -t multi-stage-homework .
docker run -d --name homework-app -p 8080:8080 multi-stage-homework
for attempt in $(seq 1 20); do curl --max-time 15 -fsS http://localhost:8080 && break || sleep 2; done
curl --max-time 15 -fsS http://localhost:8080
docker ps --filter name=homework-app
