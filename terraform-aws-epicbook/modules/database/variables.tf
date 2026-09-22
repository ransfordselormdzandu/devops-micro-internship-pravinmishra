variable "project_name" {
  description = "Name used to prefix and tag RDS resources"
  type        = string
}

variable "private_db_subnet_a_id" {
  description = "ID of private database subnet A (from network module)"
  type        = string
}

variable "private_db_subnet_b_id" {
  description = "ID of private database subnet B (from network module)"
  type        = string
}

variable "rds_security_group_id" {
  description = "ID of the RDS security group (from network module)"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "engine_version" {
  description = "MySQL engine version"
  type        = string
  default     = "8.0"
}

variable "allocated_storage" {
  description = "Allocated storage size in GB"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Name of the initial database schema"
  type        = string
  default     = "epicbook"
}

variable "db_username" {
  description = "Database administrator username"
  type        = string
}

variable "db_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}