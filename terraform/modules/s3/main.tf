resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = var.bucket_type
}

output "bucket_name" {
  description = "Name (id) of the bucket"
  value       = aws_s3_bucket.bucket.id
}

variable "bucket_name" {
  description = "Name of the s3 bucket. Must be unique."
  type        = string
}

variable "bucket_type" {
  description = "Access type (public/private)"
  type        = string
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}