variable "project_name" {
  description = "Name used to prefix and tag all resources in this project"
  type        = string
  default     = "epicbook"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_db_subnet_a_cidr" {
  description = "CIDR block for private database subnet A"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_db_subnet_b_cidr" {
  description = "CIDR block for private database subnet B"
  type        = string
  default     = "10.0.3.0/24"
}

variable "availability_zones" {
  description = "List of Availability Zones to use — index 0 for public + private A, index 1 for private B"
  type        = list(string)
}

