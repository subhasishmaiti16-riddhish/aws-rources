# 🚀 AWS Infrastructure Automation | Terraform + GitHub Actions + OIDC

### Secure & Automated AWS Infrastructure Provisioning with GitHub Actions, IAM OIDC Federation, Terraform, and S3 Remote State Backend

## 📌 Project Overview

This project demonstrates an automated Infrastructure as Code (IaC) deployment workflow using **Terraform and GitHub Actions** to provision AWS resources securely.

The pipeline uses **OpenID Connect (OIDC)** for passwordless authentication between GitHub Actions and AWS IAM, eliminating the need to store long-lived AWS access keys or secret keys in GitHub repository secrets.

Terraform manages AWS infrastructure, while an **Amazon S3 backend** stores the Terraform state remotely.

The project also uses a **self-hosted GitHub Actions runner on Windows** to execute Terraform commands.

## 🏗️ Architecture Overview

```text
Developer
    |
    | Git Push
    v
GitHub Repository
    |
    v
GitHub Actions Workflow
    |
    +-----------------------------+
    |                             |
    v                             v
Feature Branch                 Main Branch
    |                             |
    v                             v
Terraform Plan               Terraform Apply
    |                             |
    +--------------+--------------+
                   |
                   v
          GitHub OIDC Provider
                   |
                   v
             AWS IAM Role
          (GitHubTerraformRole)
                   |
                   v
          Temporary AWS Credentials
                   |
                   v
             Terraform CLI
                   |
          +--------+--------+
          |                 |
          v                 v
     AWS Resources      Amazon S3
                       Remote State
```

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| AWS | Cloud Infrastructure |
| Terraform | Infrastructure as Code |
| GitHub Actions | CI/CD Automation |
| AWS IAM | Identity and Access Management |
| OIDC Federation | Secure AWS Authentication |
| Amazon S3 | Terraform Remote State Backend |
| Windows Self-hosted Runner | Pipeline Execution |
| Git | Version Control |

## 🔐 AWS OIDC Authentication

Implemented GitHub Actions authentication with AWS using OpenID Connect (OIDC).

**Key security benefits:**

- No long-lived AWS Access Keys stored in GitHub Secrets.
- Uses temporary AWS credentials through STS.
- IAM Trust Policy restricts access to the specific GitHub repository.
- Branch-based authentication for `main` and `feature/*`.
- Uses `sts.amazonaws.com` as the OIDC audience.

**Authentication Flow:**

1. GitHub Actions requests an OIDC token.
2. AWS IAM validates the token against the GitHub OIDC Identity Provider.
3. AWS STS assumes the configured IAM role.
4. Temporary credentials are provided to Terraform.
5. Terraform authenticates with AWS and provisions infrastructure.

## ⚙️ Automated CI/CD Workflow

The pipeline follows a branch-based deployment strategy.

| Git Branch | Pipeline Action |
|---|---|
| `feature/*` | Terraform Init, Validate & Plan |
| `main` | Terraform Init, Validate & Apply |

### Feature Branch Workflow

When a developer pushes changes to a feature branch:

- GitHub Actions automatically triggers the workflow.
- AWS authentication is performed through OIDC.
- Terraform initializes the backend.
- Terraform validates the configuration.
- Terraform Plan previews infrastructure changes.

### Main Branch Workflow

When changes are pushed or merged into the main branch:

- GitHub Actions triggers the deployment workflow.
- AWS authentication uses OIDC.
- Terraform initializes and validates the configuration.
- Terraform Apply provisions or updates AWS infrastructure.

## 🗄️ Terraform Remote State Backend

Configured an Amazon S3 backend to store Terraform state remotely.

**Benefits:**

- Centralized Terraform state management.
- State persistence outside the local machine.
- Shared state for team collaboration.
- S3 versioning can help recover previous state versions.
- Supports state locking with S3 lockfiles when configured.

Example backend configuration:

```hcl
terraform {
  backend "s3" {
    bucket       = "your-terraform-state-bucket"
    key          = "aws-infrastructure/dev/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
```

> Note: Create the S3 bucket before running `terraform init`. Enable bucket versioning and configure appropriate access restrictions.

## 📂 Project Structure

```text
aws-rources/
│
├── .github/
│   └── workflows/
│       └── terraform.yml
│
└── parent/
    ├── provider.tf
    ├── backend.tf
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    └── terraform.tfvars
```

## 🚀 Deployment Steps

### 1. Clone Repository

```bash
git clone https://github.com/subhasishmaiti16-riddhish/aws-rources.git

cd aws-rources
```

### 2. Configure AWS IAM OIDC

- Create GitHub OIDC Identity Provider in AWS IAM.
- Configure an IAM role named `GitHubTerraformRole`.
- Configure the role's Trust Policy for the required GitHub repository and branches.
- Attach the minimum required AWS permissions to the role.

### 3. Configure GitHub Actions Runner

Configure a self-hosted GitHub Actions runner and assign the required labels.

### 4. Configure Terraform Backend

Create an S3 bucket for remote state storage and configure the backend in Terraform.

### 5. Push Code

```bash
git checkout -b feature/new-resource

git add .
git commit -m "Add AWS infrastructure using Terraform"

git push origin feature/new-resource
```

The feature branch triggers Terraform Plan.

After review and merge into `main`, the pipeline executes Terraform Apply.

## 🔒 Security Best Practices

- OIDC-based authentication instead of static AWS credentials.
- Restrict IAM Trust Policy to the required repository and branches.
- Apply least-privilege IAM permissions.
- Enable S3 bucket versioning and encryption.
- Restrict public access to the Terraform state bucket.
- Protect the main branch with pull request reviews.
- Use GitHub Environment approval before production deployments.
- Keep Terraform state files and sensitive variables out of Git.

## 🎯 Key Learning Outcomes

- Implemented Infrastructure as Code using Terraform.
- Automated AWS provisioning using GitHub Actions.
- Configured secure AWS authentication using OIDC Federation.
- Integrated AWS IAM with GitHub Actions.
- Implemented S3 remote Terraform state management.
- Configured a Windows self-hosted GitHub Actions runner.
- Implemented branch-based Terraform Plan and Apply workflows.

## 👨‍💻 Author

**Subhasish Maiti**

Cloud & DevOps | AWS | Azure | Terraform | Kubernetes | CI/CD

GitHub: [View Project Repository](https://github.com/subhasishmaiti16-riddhish/aws-rources)

---

### 🔖 Tags

#AWS #Terraform #GitHubActions #OIDC #DevOps #CloudAutomation #InfrastructureAsCode #AWSCICD #IAM #S3 #CloudSecurity

<img width="1012" height="652" alt="Screenshot 2026-11-02 170524" src="https://github.com/user-attachments/assets/56ef41dc-fcc7-43bf-965c-301daf0aa460" />
