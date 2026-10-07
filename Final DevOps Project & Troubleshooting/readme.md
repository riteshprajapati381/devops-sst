# Final DevOps Project & Troubleshooting

## Execution environment

Name: Ritesh Prajapati. Fresh evidence was collected on 7 October 2026 from Ubuntu host `devops-ritesh`, reached using `ssh dev.devops-ritesh.riteshprajapati.coder`. Terminal images are Playwright captures of a live browser terminal connected to that SSH host. Browser images show the actual remote services through SSH port forwarding.

## Session 21 homework — run the reference project

This folder contains the teacher's TaskBoard reference and evidence that it was run on the SSH host. It is the session homework, not a claim to be an original capstone. The final lecture allows running this reference for session 21 homework. The separately graded capstone needs an original application domain.

```text
Browser -> Nginx/React -> FastAPI -> PostgreSQL
                         |
                         +-> /health, /ready, /docs, /metrics
```

## Run

```bash
cd taskboard
docker compose up -d --build
docker compose ps
curl http://localhost:8000/health
curl http://localhost:8000/ready
curl http://localhost:8000/api/tasks
curl http://localhost:8000/metrics
docker compose run --rm --no-deps \
  -v "$(pwd)/backend/tests:/app/tests:ro" \
  -v "$(pwd)/backend/pytest.ini:/app/pytest.ini:ro" backend pytest -v
docker compose exec -T postgres psql -U taskboard -d taskboard -c 'SELECT id,title,status FROM tasks;'
```

Open the frontend at port 3000 and Swagger at backend port 8000 `/docs`, using SSH forwards when working remotely.

## Results and fixes

Ten API tests pass, covering health, service metadata, create/read/list/update/delete, missing tasks, input validation, statistics and Prometheus metrics. They use a temporary SQLite test database and a TestClient lifespan context, separate from the running PostgreSQL database. The production image omits tests; the test command mounts them explicitly.

A task was created through the browser and verified in PostgreSQL. The reference frontend attempted to reset `event.currentTarget` after awaiting the API request; React clears that event property. Capturing the form before the await fixes task creation without changing the interface.

Screenshots and raw command logs below provide the run evidence. Static sidebar activity text in the teacher's UI is decorative; real CI success is evidenced by GitHub Actions, not that UI text.

## Captured evidence

![Api tests](output/playwright/api-tests.png)

![Compose database](output/playwright/compose-database.png)

![Taskboard browser](output/playwright/taskboard-browser.png)

### Actual command output

- [compose verified](output/logs/compose-verified.log)
- [compose](output/logs/compose.log)
