variable "project_name" {
  description = "Name used to prefix and tag EC2 resources"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet (passed from the network module)"
  type        = string
}

variable "ec2_security_group_id" {
  description = "ID of the EC2 security group (passed from the network module)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "Name of the existing EC2 key pair for SSH access"
  type        = string
}

variable "ami_id" {
  description = "Optional AMI ID override. Leave blank to auto-select the latest Ubuntu 22.04 LTS AMI."
  type        = string
  default     = ""
}