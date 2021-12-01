
///   aws key pair    

resource "tls_private_key" "atym" {
  algorithm = "RSA"

   provisioner "local-exec" { 
    command = "rm -f -- ../AWS_atym.pem"
  } 
}



resource "aws_key_pair" "atym" {

  key_name   = "AWS atym"
  public_key = tls_private_key.atym.public_key_openssh


  provisioner "local-exec" { 
    command = "echo '${tls_private_key.atym.private_key_pem}' > ../AWS_atym.pem && chmod 400 ../AWS_atym.pem"
  }
 
}

///   SG    

resource "aws_security_group" "nginx-sg" {
  name        = "nginx-sg"
  description = "Allow 22,80,443"
  vpc_id      = var.vpc_id


    ingress {
    from_port   = var.open_port
    to_port     = var.open_port
    protocol    = var.protocol
    cidr_blocks = var.inc_cidr_block
    }

    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    }


    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    }

   
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}