output "db_endpoint" {
  description = "Connection endpoint for the RDS instance"
  value       = aws_db_instance.epicbook.endpoint
}

output "db_port" {
  description = "Port the RDS instance is listening on"
  value       = aws_db_instance.epicbook.port
}