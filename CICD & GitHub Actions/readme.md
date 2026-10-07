# CICD & GitHub Actions

## Execution environment

Name: Ritesh Prajapati. Fresh evidence was collected on 7 October 2026 from Ubuntu host `devops-ritesh`, reached using `ssh dev.devops-ritesh.riteshprajapati.coder`. Terminal images are Playwright captures of a live browser terminal connected to that SSH host. Browser images show the actual remote services through SSH port forwarding.

## Demo project

The calculator demo contains application code, pytest tests and a build script. The active workflow is [`../.github/workflows/homework-ci.yml`](../.github/workflows/homework-ci.yml); workflows nested inside the reference demo are retained as examples and do not run from that location.

CI runs automated tests and builds the calculator artifact. The workflow also tests the session 21 API. A runner executes jobs, jobs contain steps, secrets inject sensitive values at runtime, and artifacts preserve build output. CD deploys a validated result; session 17 demonstrates that deployment stage.

## Run locally

```bash
cd 'CICD & GitHub Actions/demo'
python3 -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
python -m pytest -v
bash build.sh
```

## Successful CI evidence

[Successful GitHub Actions run](https://github.com/riteshprajapati381/devops-sst/actions/runs/37620943900). Both calculator and TaskBoard jobs passed. The calculator build is uploaded as a downloadable artifact.

The Dockerfile packages the calculator and its image runs the demonstration addition. The [session 17 workflow](../Complete%20CICD%20%26%20DevSecOps/readme.md) extends these CI concepts through a registry push and actual Kubernetes deployment, providing the CD demonstration.

The fresh SSH run passed all five calculator tests, produced the build artifact and ran its Docker image. Its actual test output is included in the [combined session 16/17 log](../Complete%20CICD%20%26%20DevSecOps/output/logs/remote-tests.log).

## Captured evidence

![Successful calculator and TaskBoard CI](output/playwright/github-actions-success.png)

### Actual command output

- [github actions](output/logs/github-actions.log)
- [remote tests](output/logs/remote-tests.log)
