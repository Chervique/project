


/////   Roles and polices   
#policy for EC2 to access S3

data "aws_iam_policy_document" "s3_access" {
  version = "2012-10-17"
  statement {
    sid = ""
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    

      principals {
        type        = "Service"
        identifiers = ["ec2.amazonaws.com"]
      }
  }
}
data "aws_iam_policy" "s3_access" {
  arn = var.policy_arn
}

/////   Profile     
resource "aws_iam_instance_profile" "instance_pofile" {
  name = "webserver"
  role = aws_iam_role.S3role.name
}


 resource "aws_iam_role" "S3role" {
  name = "EC2accessS3"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.s3_access.json

 }

  resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.S3role.name
  policy_arn = data.aws_iam_policy.s3_access.arn
}

