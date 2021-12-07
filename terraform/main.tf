///   VPC and subnets   

resource "aws_vpc" "main" {
  cidr_block = var.vps_cidr 
  enable_dns_hostnames = true
  
  tags = {
    Name = "NEW"
  }
  
}

module "net" {
  source = "./modules/net"
  vpc_id = aws_vpc.main.id
  green_cidr_block = var.first_subnet
  blue_cidr_block = var.second_subnet
  db_cidr_block = var.rds_subnet
  
}

///   RDS   

resource "aws_db_instance" "default" {
  db_subnet_group_name = module.net.db_id
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  //publicly_accessible  = true
  vpc_security_group_ids = [module.nginx-sg.security_group.id]

  name                 = "mydb"
  username             = "atym"
  password             = "12345678"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true

    
    provisioner "local-exec" { 
    command = <<-EOT
            echo "\$cfg['Servers'][\$i]['host'] = '${self.address}';" >> ../ansible/roles/phpmyadmin/tasks/files/config.inc.php 
            echo "ok!"
        EOT
  }  
}



///   EC2 instances   

module "nginx-green-1" {
  source = "./modules/ec2_web"
  vpc_id = aws_vpc.main.id
  
  sec_groups = [module.nginx-sg.security_group.id]
  #zone = "${var.zone != "" ? var.zone: var.zones[ count.index % length(var.zones) ]}"
  zone = var.zones[0]
  subnet_id = module.net.a_id         
  webserver_name = var.names[0]
}
module "nginx-green-2" {
  source = "./modules/ec2_web"
  vpc_id = aws_vpc.main.id
  
  sec_groups = [module.nginx-sg.security_group.id]
  zone = var.zones[1]
  subnet_id = module.net.b_id         
  webserver_name = var.names[1]
}
module "nginx-blue-1" {
  source = "./modules/ec2_web"
  vpc_id = aws_vpc.main.id
  
  sec_groups = [module.nginx-sg.security_group.id]
  #zone = "${var.zone != "" ? var.zone: var.zones[ count.index % length(var.zones) ]}"
  zone = var.zones[0]
  subnet_id = module.net.a_id         
  webserver_name = var.names[2]
}
module "nginx-blue-2" {
  source = "./modules/ec2_web"
  vpc_id = aws_vpc.main.id
  
  sec_groups = [module.nginx-sg.security_group.id]
  zone = var.zones[1]
  subnet_id = module.net.b_id         
  webserver_name = var.names[3]
}

///   EC2 PHPMYADMIN    

module "phpmyadmin-green" {
  source = "./modules/ec2_web"
  vpc_id = aws_vpc.main.id
  
  sec_groups = [module.nginx-sg.security_group.id]
  zone = var.zones[2]
  subnet_id = module.net.phpmyadmin_id         
  webserver_name = var.names[4]

  
    role = "phpmyadmin"
  
}

module "phpmyadmin-blue" {
  source = "./modules/ec2_web"
  vpc_id = aws_vpc.main.id
  
  sec_groups = [module.nginx-sg.security_group.id]
  zone = var.zones[2]
  subnet_id = module.net.phpmyadmin_id         
  webserver_name = var.names[5]
   
    role = "phpmyadmin"
  
}



///   Roles and policies    

module "EC2_policy" {
 source = "./modules/keys"
policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"

}

/* 
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

} */

///   Security group    

module "nginx-sg" {
  source = "./modules/sec"

vpc_id = aws_vpc.main.id
  open_port = "443"
  protocol = "TCP"
  inc_cidr_block = ["0.0.0.0/0"]
}




///   LB    

module "lb-green" { 
  source = "./modules/lb"
  color = "green"
  lb_name = "greenlb"
  tg-color = "green"
  vpc_id = aws_vpc.main.id

  nginx1_id = "module.nginx-green-1.instance_id"
  nginx2_id = "module.nginx-green-2.instance_id"
  
 
  lb_subnets =  [module.net.a_id,module.net.b_id,module.net.phpmyadmin_id]
  lb_sec_groups = [module.nginx-sg.security_group.id]
  lb-target-group = aws_lb_target_group.green-tg.arn

  tg-arn = aws_lb_target_group.phpmyadmin-green-tg.arn
}



module "lb-blue" { 
  source = "./modules/lb"
  color = "blue"
  lb_name = "bluelb"
  tg-color = "blue"
  vpc_id = aws_vpc.main.id

  nginx1_id = "module.nginx-blue-1.instance_id"
  nginx2_id = "module.nginx-blue-2.instance_id"
 
  lb_subnets =  [module.net.a_id,module.net.b_id,module.net.phpmyadmin_id]
  lb_sec_groups = [module.nginx-sg.security_group.id]
  lb-target-group = aws_lb_target_group.blue-tg.arn

  tg-arn = aws_lb_target_group.phpmyadmin-blue-tg.arn
}


/// nginx target group

/////   nginx-green   

resource "aws_lb_target_group" "green-tg" {
  name     = "green-tg"
  port     = 443
  protocol = "HTTPS"
  target_type = "instance"
  vpc_id           = aws_vpc.main.id
}
 
 resource "aws_lb_target_group_attachment" "green1" {
  target_group_arn = aws_lb_target_group.green-tg.arn
  target_id        = module.nginx-green-1.instance_id
  port             = 443     
  
}
resource "aws_lb_target_group_attachment" "green2" {
  target_group_arn = aws_lb_target_group.green-tg.arn
  target_id        = module.nginx-green-2.instance_id
  port             = 443     
  
}  


/////   nginx-blue    

resource "aws_lb_target_group" "blue-tg" {
  name     = "blue-tg"
  port     = 443
  protocol = "HTTPS"
  target_type = "instance"
  vpc_id           = aws_vpc.main.id
}
 
 resource "aws_lb_target_group_attachment" "blue1" {
  target_group_arn = aws_lb_target_group.blue-tg.arn
  target_id        = module.nginx-blue-1.instance_id
  port             = 443     
  
}
resource "aws_lb_target_group_attachment" "blue2" {
  target_group_arn = aws_lb_target_group.blue-tg.arn
  target_id        = module.nginx-blue-2.instance_id
  port             = 443     
  
} 

/////   phpmyadmin  green   

resource "aws_lb_target_group" "phpmyadmin-green-tg" {
  name     = "phpmyadmin-green-tg"
  port     = 443
  protocol = "HTTPS"
  target_type = "instance"
  vpc_id           = aws_vpc.main.id
}
resource "aws_lb_target_group_attachment" "phpmyadmin-green" {
  target_group_arn = aws_lb_target_group.phpmyadmin-green-tg.arn
  target_id        = module.phpmyadmin-green.instance_id
  port             = 443     
  
} 

/////   phpmyadmin  blue   

resource "aws_lb_target_group" "phpmyadmin-blue-tg" {
  name     = "phpmyadmin-blue-tg"
  port     = 443
  protocol = "HTTPS"
  target_type = "instance"
  vpc_id           = aws_vpc.main.id
}
resource "aws_lb_target_group_attachment" "phpmyadmin-blue" {
  target_group_arn = aws_lb_target_group.phpmyadmin-blue-tg.arn
  target_id        = module.phpmyadmin-blue.instance_id
  port             = 443     
  
} 

///   Cloudflare    

resource "cloudflare_record" "set-lb-cname" {
  zone_id = "6a997a1bf60b60dc3ca23297fb5db1ab"
  name    = "@"
  value   = var.color != "green" ? module.lb-blue.load_balancer_addr : module.lb-green.load_balancer_addr
  type    = "CNAME"
  ttl     = "1"
  proxied = "true"
}






