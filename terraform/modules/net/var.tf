output "a_id" {
    value = aws_subnet.a.id
}

output "b_id" {
    value = aws_subnet.b.id
}
output "phpmyadmin_id" {
    value = aws_subnet.db.id
} 

output "db_id" {
    value = aws_db_subnet_group.db.id
} 

 variable "zones" {
    description = "Availability zones"
    type = list(string)
    default = ["eu-central-1a","eu-central-1b","eu-central-1c"]
} 

/////

variable "subnet_name" {
type = string
default = ""
}


variable "green_cidr_block" {
type = string
}
variable "blue_cidr_block" {
type = string
}
variable "db_cidr_block" {
type = string
}

variable "vpc_id" {
type = string
}
