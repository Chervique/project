
////  terraform output ansible_inventory > ../'!HW7 ansible'/inventory.txt

/*
provisioner "local-exec" { 
    command = <<-EOT
     "cd '../!HW7 ansible'"
     "ssh-agent bash"
     "sudo cp ../'!HW7 ansible/AWS_atym.pem' ~/.ssh/"
     "chmod 400 ../'!HW7 ansible/AWS_atym.pem'"
     "ssh-add ~/.ssh/'AWS_atym.pem'"
    EOT
  }
*/

///   aws key pair    

resource "tls_private_key" "atym" {
  algorithm = "RSA"

<<<<<<< HEAD
  provisioner "local-exec" { 
    command = "chmod 777 ../'!HW7_ansible/AWS atym.pem' && rm -f -- ../'!HW7_ansible/AWS atym.pem'"
  }
=======
  /* provisioner "local-exec" { 
    command = "rm -f -- ../'!HW7_ansible/AWS_atym.pem'"
  } */
>>>>>>> ea6360fa87fd80e820e54e169c21057a1ae32ae1
}



resource "aws_key_pair" "atym" {

  key_name   = "AWS atym"
  public_key = tls_private_key.atym.public_key_openssh


  provisioner "local-exec" { 
    command = "echo '${tls_private_key.atym.private_key_pem}' > ../'!HW7_ansible/AWS_atym.pem' && chmod 400 ../'!HW7_ansible/AWS_atym.pem'"
  }
 
}


///   VPC and subnets   

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  
  tags = {
    Name = "NEW"
  }
  
}

module "net" {
  source = "./modules/net"
  vpc_id = aws_vpc.main.id
  public_cidr_block = "10.0.1.0/24"
  private_cidr_block = "10.0.2.0/24"

}

///   EC2 instances   

module "nginx" {
  source = "./modules/ec2_web"
  vpc_id = aws_vpc.main.id

  count = 2
  subnet_id = module.net.public_id
  webserver_name = "nginx"
  sec_groups = [module.nginx-sg.security_group.id]
  //user_data     = file("amazon-nginx.sh")
  //  zones = var.zones[count.index]
  
}

module "phpmyadmin" {
  source = "./modules/ec2_web"
  vpc_id = aws_vpc.main.id

  subnet_id = module.net.private_id
  webserver_name = "phpmyadmin"
  sec_groups = [module.nginx-sg.security_group.id]
  //  user_data     = file("phpmyadmin.sh")
  // zones = ["eu-central-1a","eu-central-1b"]
  
}

///   Roles and policies    

module "EC2_policy" {
 source = "./modules/keys"
policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"

}


///   S3    
module "s3_bucket" {
  source = "./modules/s3"

  bucket_name = "atymhw4"
  bucket_type = "public-read"
}
resource "aws_s3_bucket_object" "object" {
  for_each = fileset("for_s3/", "*")
  bucket   = module.s3_bucket.bucket_name
  key      = each.value
  source   = "for_s3/${each.value}"

  etag = filemd5("for_s3/${each.value}")

}

///   Security group    

module "nginx-sg" {
  source = "./modules/sec"

vpc_id = aws_vpc.main.id
  open_port = "443"
  protocol = "TCP"
  inc_cidr_block = ["0.0.0.0/0"]
}




///   LB    

module "lb" {
  source = "./modules/lb"

  vpc_id = aws_vpc.main.id
/*
  nginx_ip = "10.0.1.*" #"module.net.public_cidr_block"
  phpmyadmin_ip = "10.0.2.*" #"module.net.private_cidr_block"
 */
  nginx1_id = module.nginx[0].instance_id
  nginx2_id = module.nginx[1].instance_id
  phpmyadmin_id = module.phpmyadmin.instance_id
 
  lb_subnets =  [module.net.public_id, module.net.private_id]
  lb_sec_groups = [module.nginx-sg.security_group.id]

  
}

///   Cloudflare    

resource "cloudflare_record" "set-lb-cname" {
  zone_id = "6a997a1bf60b60dc3ca23297fb5db1ab"
  name    = "@"
  value   = module.lb.load_balancer_addr
  type    = "CNAME"
  ttl     = "1"
  proxied = "true"
}






