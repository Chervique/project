variable "open_port" {
    type = string
}

variable "protocol" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "inc_cidr_block" {
    type = list(string)
}

output "security_group" {
    value = aws_security_group.nginx-sg
}