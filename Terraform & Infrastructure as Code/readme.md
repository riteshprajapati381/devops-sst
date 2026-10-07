# Terraform & Infrastructure as Code

## Execution environment

Name: Ritesh Prajapati. Fresh evidence was collected on 7 October 2026 from Ubuntu host `devops-ritesh`, reached using `ssh dev.devops-ritesh.riteshprajapati.coder`. Terminal images are Playwright captures of a live browser terminal connected to that SSH host. Browser images show the actual remote services through SSH port forwarding.

## Task 1 — S3 infrastructure

`terraform-s3-demo/` contains the AWS provider, bucket resource, inputs, outputs and provider lock file. Change `bucket_name` to a globally unique value before creating a bucket. The provider region defaults to `ap-south-1`.

```bash
cd terraform-s3-demo
terraform fmt -recursive
terraform init
terraform validate
terraform plan
terraform apply
terraform show
terraform output
terraform destroy
```

Run AWS-changing commands only with the intended course/lab account. Do not put credentials in source control. Initialization and validation check configuration; they do not prove that AWS resources were created.

## Task 2 — AWS service research

The five requested documents are in `aws-services/01-iam`, `02-ec2`, `03-s3`, `04-vpc`, and `05-dynamodb-rds`. Each explains concepts, best practices and use cases.

## Execution limits

No course AWS credentials were supplied for this run. Live plan/apply/destroy evidence must not be claimed without that access. The teacher's final lecture grants a files-only Terraform exception for the capstone; it does not explicitly waive the session 18/19 cloud homework. Any remaining cloud work is recorded as pending.

## Verified configuration and AWS blocker

`terraform fmt`, `terraform init` and `terraform validate` passed on the SSH host. `terraform plan` failed with **No valid credential sources found**. The exact output is captured below. No AWS resources were created; apply, show/output of live resources and destroy remain pending credentials. The invalid `type` attributes in the teacher's S3 outputs were removed because Terraform outputs infer their type from their value.

## Captured evidence

![Both Terraform configurations valid; AWS credentials missing](output/playwright/terraform-summary.png)

![Terraform validation passed; AWS plan requires credentials](output/playwright/terraform-validation.png)

### Actual command output

- [terraform validation](output/logs/terraform-validation.log)
- [terraform](output/logs/terraform.log)
