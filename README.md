# DevOps homework — Ritesh Prajapati

Course homework for sessions 1–21, with source files, commands, explanations, real terminal output and screenshots. Enrollment number and section are pending student input.

## Assignment sources

The teacher's [devops-heros repository](https://github.com/Nency-Ravaliya/devops-heros) was pulled to commit `8376590`. Requirements were checked against the [homework document](https://docs.google.com/document/d/1cjXFYf2Thm8cBEN-0C48B-v02cj3jGLd47lcO18prHE/edit) and the available class transcripts, including the final October 4 lecture.

Each session requires its own README link in the course Google Form. Sessions 1 and 2 share the Linux homework. The final lecture simplifies the session 21 **homework** to running and documenting the provided TaskBoard project. The separate graded capstone requires an original Python application in the assigned domain; the teacher's TaskBoard reference is not an original capstone submission.

## Homework index

| Session | README to submit |
|---|---|
| 01–02 | [Linux Fundamentals](Linux%20Fundamentals/readme.md) |
| 03 | [Shell Scripting](Shell%20Scripting/readme.md) |
| 04 | [Networking](Networking/readme.md) |
| 05 | [Git and GitHub](Git%20and%20GitHub/readme.md) |
| 06 | [Docker Fundamentals](Docker%20Fundamentals/readme.md) |
| 07 | [Docker Images](Docker%20Images/readme.md) |
| 08 | [Docker Networking](Docker%20Networking/readme.md) |
| 09 | [Kubernetes Fundamentals](Kubernetes%20Fundamentals/readme.md) |
| 10 | [Kubernetes Pods, ReplicaSets & Deployments](Kubernetes%20Pods%2C%20ReplicaSets%20%26%20Deployments/readme.md) |
| 11 | [Kubernetes Networking & Services](Kubernetes%20Networking%20%26%20Services/readme.md) |
| 12 | [Kubernetes Ingress, ConfigMaps & Secrets](Kubernetes%20Ingress%2C%20ConfigMaps%20%26%20Secrets/readme.md) |
| 13 | [Kubernetes Storage, HPA & Probes](Kubernetes%20Storage%2C%20HPA%20%26%20Probes/readme.md) |
| 14 | [Kubernetes Troubleshooting](Kubernetes%20Troubleshooting/readme.md) |
| 15 | [Helm](Helm/readme.md) |
| 16 | [CICD & GitHub Actions](CICD%20%26%20GitHub%20Actions/readme.md) |
| 17 | [Complete CICD & DevSecOps](Complete%20CICD%20%26%20DevSecOps/readme.md) |
| 18 | [Terraform & Infrastructure as Code](Terraform%20%26%20Infrastructure%20as%20Code/readme.md) |
| 19 | [Cloud & Terraform in Action](Cloud%20%26%20Terraform%20in%20Action/readme.md) |
| 20 | [Monitoring, Observability & GitOps](Monitoring%2C%20Observability%20%26%20GitOps/readme.md) |
| 21 | [Final DevOps Project & Troubleshooting](Final%20DevOps%20Project%20%26%20Troubleshooting/readme.md) |

## Evidence and environment

Fresh practical work ran on Ubuntu host `devops-ritesh` using:

```bash
ssh dev.devops-ritesh.riteshprajapati.coder
```

Playwright captured a live SSH terminal and actual services viewed through SSH port forwarding. Screenshots are embedded in the relevant READMEs under `output/playwright/`; actual command transcripts are under `output/logs/`. The Argo CD reconciliation passed in a GitHub Actions kind cluster after the SSH host experienced API timeouts; both results are documented. Earlier session 11/12 screenshots from the existing repository remain labeled as earlier kind-cluster evidence.

Reproducible execution scripts are in [scripts](scripts/). These scripts create classroom workloads; read each script before running it. Workloads were cleaned up between exercises to fit the SSH host's 929 MiB RAM.

## CI/CD evidence

- [Calculator and TaskBoard test workflow](https://github.com/riteshprajapati381/devops-sst/actions/workflows/homework-ci.yml).
- [Successful full DevSecOps pipeline](https://github.com/riteshprajapati381/devops-sst/actions/runs/37621662696): tests, Bandit, pip-audit, full-history Gitleaks, Docker build, Trivy security gate, GHCR push and actual kind-cluster deployment with HTTP checks.

## Verified results

The repository includes 72 fresh Playwright screenshots, actual SSH command output, successful CI/DevSecOps runs and a successful Argo CD self-healing run. Calculator tests: 5 passed; Flask tests: 8 passed; TaskBoard API tests: 10 passed. Storage/HPA, troubleshooting and Helm upgrade/rollback were verified on the SSH Minikube cluster. The deployed HTTP load-generator exercise also passed in kind. Terraform initialization and validation passed for both projects.

## Remaining external steps

AWS `apply`, resource verification and `destroy` for sessions 18–19 require credentials for an authorized AWS account. Terraform source and AWS service research are included; actual AWS creation/deletion must not be claimed until executed. The final lecture's Terraform files-only exception was for the original capstone, and does not explicitly waive homework 18–19.

Add your enrollment number to the session 7 README and select the correct course section before submitting the per-session README links. [Section A form](https://forms.gle/ydjAJcwxjpjBXgxB8) / [Section B form](https://forms.gle/pAuXQaokwVzhRzit6). No form has been submitted automatically. The final transcript indicates homework is due Wednesday October 7 and the separate capstone Sunday October 11; confirm the exact deadline in the course portal.
