#!/usr/bin/env bash
set -euxo pipefail
cd "$HOME/devops-sst/Final DevOps Project & Troubleshooting/taskboard"
docker compose up -d --build
for attempt in $(seq 1 60); do curl --max-time 15 -fsS http://localhost:8000/ready && break || sleep 2; done
docker compose ps
curl --max-time 15 -fsS http://localhost:8000/health
curl --max-time 15 -fsS http://localhost:8000/ready
curl --max-time 15 -fsS http://localhost:3000 | head -c 500
docker compose run --rm --no-deps -v "$(pwd)/backend/tests:/app/tests:ro" -v "$(pwd)/backend/pytest.ini:/app/pytest.ini:ro" backend pytest -v
curl --max-time 15 -fsS -X POST http://localhost:8000/api/tasks -H 'Content-Type: application/json' -d '{"title":"DevOps SSH assignment","description":"Run Compose, capture evidence, document the results"}'
curl --max-time 15 -fsS http://localhost:8000/api/tasks
curl --max-time 15 -fsS http://localhost:8000/api/tasks/stats
curl --max-time 15 -fsS http://localhost:8000/metrics | head -n 20 || true
