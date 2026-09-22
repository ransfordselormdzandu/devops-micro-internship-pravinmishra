output "ec2_public_ip" {
  description = "Public IP address of the EpicBook EC2 instance"
  value       = module.compute.public_ip
}

output "rds_endpoint" {
  description = "Connection endpoint for the RDS database"
  value       = module.database.db_endpoint
}