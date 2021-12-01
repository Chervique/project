 output "instance_public_ips" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.webserver.*.public_ip
} 

 output "instance_id" {
    value = aws_instance.webserver.id
} 
