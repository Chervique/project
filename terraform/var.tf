variable "awsid" {
  description = "AWS ID"
  type        = string
//  sensitive   = true
}

variable "awskey" {
  description = "AWS key"
  type        = string
//  sensitive   = true
}

 variable "color" {
  description = "Set this var to color name GREEN/BLUE to change the branch"
  type = string
  default = "green"
} 

variable "vps_cidr" {
  description = "VPS net"
  default = "10.0.0.0/16"
}

variable "first_subnet" {
  description = "First subnet cidr"
  default = "10.0.1.0/24"
}
variable "second_subnet" {
  description = "Second subnet cidr"
  default = "10.0.2.0/24"
}
variable "rds_subnet" {
  description = "Database subnet cidr"
  default = "10.0.3.0/24"
}

variable "names" {
    description = "Instance names"
    type = list(string)
    default = ["nginx-green-1","nginx-green-2","nginx-blue-1","nginx-blue-2"]
}




variable "zone" {
  description = "for single zone deployment"
  default = "eu-central-1a"
}

variable "zones" {
    description = "Availability zones"
    type = list(string)
    default = ["eu-central-1a","eu-central-1b","eu-central-1c"]
}

