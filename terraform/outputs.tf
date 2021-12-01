output "dns_name_green" {
    value = module.lb-green.load_balancer_addr
}
output "dns_name_blue" {
    value = module.lb-blue.load_balancer_addr
}

/* output "dns_name_blue" {
    value = module.lb-blue.load_balancer_addr
} */
/* 
output "ansible_inventory" {
  value = [module.nginx-green.*.instance_public_ips, module.nginx-blue.*.instance_public_ips ]
    
} */
#module.phpmyadmin.*.instance_public_ips