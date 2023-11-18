# Terraform Deployment Workflows

### Description:
This workflow performs the Terraform configuration checks, validation, and generates a plan for the infrastructure changes.

### Steps:
- **Configuration:**
  - Checks Terraform configurations for format and validation.
  - Performs a security scan using Checkov on Terraform code.

- **Plan:**
  - Generates a Terraform plan and saves it as an artifact.

- **Create PR:**
  - Creates a pull request with a link to the workflow run.

## Main Branch Deployment Workflow

### Description:
This workflow applies Terraform changes to the main branch.

### Steps:
- **Apply:**
  - Executes Terraform apply on the main branch.

