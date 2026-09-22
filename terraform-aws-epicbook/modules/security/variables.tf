variable "project_name" {
  description = "Name used to prefix and tag security group resources"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC these security groups belong to (from the networking module)"
  type        = string
}

variable "ssh_ingress_cidr" {
  description = "CIDR block allowed to SSH into EC2 (your public IP with /32 recommended)"
  type        = string
}