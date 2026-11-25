variable "aws_region" {
  description = "AWS region in which to create the deployment target."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name prefix for the infrastructure."
  type        = string
  default     = "azure-static-website-cicd"
}

variable "instance_type" {
  description = "EC2 type appropriate to your account and budget (for example t3.micro)."
  type        = string
  default     = "t3.micro"
}

variable "ssh_public_key_path" {
  description = "Path on the Terraform controller to the SSH PUBLIC key. Never supply the private key."
  type        = string
}

variable "admin_ssh_cidr" {
  description = "Your workstation public IPv4 address in /32 CIDR format."
  type        = string
  validation {
    condition     = can(cidrhost(var.admin_ssh_cidr, 0)) && endswith(var.admin_ssh_cidr, "/32")
    error_message = "Set admin_ssh_cidr to your public IPv4 address with /32, e.g. 203.0.113.10/32."
  }
}

variable "agent_ssh_cidr" {
  description = "Public outbound IPv4 address of your existing Azure DevOps self-hosted agent, with /32."
  type        = string
  validation {
    condition     = can(cidrhost(var.agent_ssh_cidr, 0)) && endswith(var.agent_ssh_cidr, "/32")
    error_message = "Set agent_ssh_cidr to the agent's public outbound IPv4 address with /32."
  }
}

variable "root_volume_size_gb" {
  description = "Root EBS volume size in GiB."
  type        = number
  default     = 12
}
