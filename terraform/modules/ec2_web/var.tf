variable "zone" {
  description = "for single zone deployment"
  default = "eu-central-1a"
}

variable "subnet_id" {
    type = string

}



variable "ami" {
type = string
default     = "ami-047e03b8591f2d48a" # ubuntu "ami-0a49b025fffbbdac6"
}

variable "instance_type" {
type = string
default = "t2.micro"
}

variable "webserver_name" {
type = string
default = "webserver"
}





variable "vpc_id" {
    type = string
}



variable "user_data" {
    type = string
    default = ""
}
variable "color" {
    type = string
    default = ""
}



variable "sec_groups" {
type = list(string)
}

variable "key_name" {
type = string
default = "AWS atym"
}

variable "iam_profile" {
type = string
default = "webserver"
}
