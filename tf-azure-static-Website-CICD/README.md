# Azure Static Website CI/CD — Terraform deployment target

This project provisions the AWS infrastructure for Assignment 02, "Deploy Static Website to AWS EC2 Using an Azure DevOps CI/CD Pipeline." It does not install Nginx or deploy the website: the assignment requires Ansible for host configuration and Azure DevOps for deployment.

## Prerequisites

- Terraform, AWS CLI configured with credentials, and an existing SSH key pair.
- The public outbound IPv4 of your **existing self-hosted Azure DevOps agent VM**, and your workstation's public IPv4.
- AWS permissions to create VPC, subnet, routing, security group, key pair, and EC2 resources.

## Setup

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with real values before proceeding.
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply
terraform output
```

The example IPs in `terraform.tfvars.example` are documentation-only addresses and **must be replaced**. Check the outbound IP from the self-hosted agent with `curl -4 https://checkip.amazonaws.com` and your workstation's outbound IP with the same command on your workstation (or another trusted IP check). Both must be specified as `/32` CIDRs. Do not use the agent's private `172.31.x.x` IP. If the agent has a dynamic public IP, update `agent_ssh_cidr` when it changes.

The key pair is created from your **public** SSH key only. The corresponding private key stays on your workstation and is entered securely into the Azure DevOps SSH service connection. If the private key is only on your workstation, your self-hosted agent does not need a copy of it; the service connection manages the credential.

## After Terraform

1. Run Ansible to install and start Nginx and configure a deployment account with write permission to `/var/www/html`. Do not use `chmod 777`.
2. Verify SSH from both your workstation and the self-hosted agent VM, plus HTTP on port 80.
3. Create an Azure DevOps SSH service connection using the new target's `public_ip` output and your chosen SSH account.
4. Configure `azure-pipelines.yml` to use the existing `SelfHostedPool-ransford` pool and the SSH service connection. Use `CopyFilesOverSSH@0` and `SSH@0` per the assignment.
5. Confirm the pipeline and website, and capture the assignment screenshots.

## Cleanup

```bash
terraform destroy
```

This removes the managed target infrastructure; it does not remove the separately created Azure DevOps agent VM. AWS resources may incur charges while provisioned. Keep `.tfstate` and private credentials out of public repositories.
