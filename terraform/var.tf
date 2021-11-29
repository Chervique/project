variable "awsid" {
<<<<<<< HEAD
  description = "The username for the DB master user"
  type        = string
  sensitive   = true
}

variable "awskey" {
  description = "The password for the DB master user"
  type        = string
  sensitive   = true
=======
  description = "AWS ID"
  type        = string
//  sensitive   = true
}

variable "awskey" {
  description = "AWS key"
  type        = string
//  sensitive   = true
>>>>>>> ea6360fa87fd80e820e54e169c21057a1ae32ae1
}