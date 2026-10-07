#!/usr/bin/env bash
set -euxo pipefail
cd "$HOME/devops-sst/CICD & GitHub Actions/demo"
docker run --rm -v "$PWD:/work" -w /work python:3.12-slim sh -c 'pip install -r requirements.txt && python -m pytest -v && bash build.sh'
docker build -t homework-calculator .
docker run --rm homework-calculator
cd "$HOME/devops-sst/Complete CICD & DevSecOps/demo"
docker run --rm -v "$PWD:/work" -w /work python:3.12-slim sh -c 'pip install -r requirements-dev.txt && pytest -v --cov=app'
docker build -t homework-devsecops .
docker rm -f homework-devsecops 2>/dev/null || true
docker run -d --name homework-devsecops -p 8081:5001 homework-devsecops
for attempt in $(seq 1 30); do curl --max-time 10 -fsS http://localhost:8081/health && break || sleep 2; done
curl --max-time 15 -fsS http://localhost:8081/health
curl --max-time 15 -fsS http://localhost:8081/api/status
curl --max-time 15 -fsS http://localhost:8081/api/greet/Ritesh
curl --max-time 15 -fsS -X POST http://localhost:8081/api/add -H 'Content-Type: application/json' -d '{"number1":2,"number2":3}'
docker ps --filter name=homework-devsecops
