output "dns_name_green" {
  description = "Green DNS"
    value = module.lb-green.load_balancer_addr
}
output "dns_name_blue" {
  description = "Blue DNS"
    value = module.lb-blue.load_balancer_addr
}

/* 
output "ansible_inventory" {
  value = [module.nginx-green.*.instance_public_ips, module.nginx-blue.*.instance_public_ips ]
    
} */
#module.phpmyadmin.*.instance_public_ips



output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.default.address

}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.default.port
//  sensitive   = true
}

output "rds_username" {
  description = "RDS instance root username"
  value       = aws_db_instance.default.username
//  sensitive   = true
}