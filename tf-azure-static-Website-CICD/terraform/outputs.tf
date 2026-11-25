output "instance_id" {
  description = "EC2 instance ID."
  value       = aws_instance.web.id
}

output "public_ip" {
  description = "Public IPv4 address of the website deployment target."
  value       = aws_instance.web.public_ip
}

output "website_url" {
  description = "HTTP URL after Nginx and the website have been deployed."
  value       = "http://${aws_instance.web.public_ip}"
}

output "ssh_command" {
  description = "Example SSH command; supply your private key path separately."
  value       = "ssh -i <path-to-private-key> ubuntu@${aws_instance.web.public_ip}"
}

output "ubuntu_ami_id" {
  description = "Region-specific Ubuntu 22.04 x64 AMI selected at plan time."
  value       = data.aws_ami.ubuntu.id
}
