provider "aws" { 
    profile = "default" 
    region  = "eu-central-1" 
    access_key = var.awsid 
    secret_key = var.awskey
}