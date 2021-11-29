output "dns_name" {
    value = module.lb.load_balancer_addr
}


output "ansible_inventory" {
  value = [module.nginx.*.instance_public_ips, module.phpmyadmin.*.instance_public_ips]
    
}