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


variable "enable-green" {
  type = bool
  default = true
}

 variable "color" {
  type = string
  default = "green"
} 


 variable "dns-green" {
  type = string
  default = "module.lb-green.load_balancer_addr"
} 
 variable "dns-blue" {
  type = string
  default = "module.lb-blue.load_balancer_addr"
} 

variable "zone" {
  description = "for single zone deployment"
  default = "eu-central-1a"
}

variable "zones" {
    description = "Availability zones"
    type = list(string)
    default = ["eu-central-1a","eu-central-1b"]
}

 variable "subnet_ids" {
  type = list(string)
    default = ["module.net.subnet_ids"]
} 

