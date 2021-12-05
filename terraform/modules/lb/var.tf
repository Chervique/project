variable "lb_sec_groups" {
 type = list(string)
}

variable "lb-target-group" {
}

variable "tg-arn" {
}
 
variable "lb_subnets" {
    type = list(string)
}

variable "vpc_id" {
    type = string
}


variable "tg-color" {
    type = string
}


variable "nginx1_id" {
    type = string
}
variable "nginx2_id" {
    type = string
}



output "load_balancer_addr" {
  description = "LB adress for CLoudflare CNAME"
  value       = aws_lb.lb.dns_name
} 

variable "lb_name" {
    type = string
}




 variable "color" {
type = string
} 