

///   LB    

resource "aws_lb" "lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.lb_sec_groups #[aws_security_group.nginx-sg.id]
  subnets           = var.lb_subnets  #[aws_subnet.sn-1.id,aws_subnet.sn-2.id]

  enable_deletion_protection = false


}


resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.cert.arn
  

  default_action {
    type             = "forward"
    target_group_arn = var.lb-target-group  #aws_lb_target_group.tg.arn
  }
}






/* resource "aws_lb_listener_rule" "phpmyadmin" {
  listener_arn = aws_lb_listener.webserver_lb.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.phpmyadmin-tg.arn
  }

  condition {
    path_pattern {
      values = ["/phpmyadmin/*"]
    }
  }

  
  } */






/* 
/// phpmyadmin target group

resource "aws_lb_target_group" "phpmyadmin-tg" {
  name     = "phpmyadmin-tg"
  port     = 443
  protocol = "HTTPS"
  target_type = "instance"
  vpc_id           = var.vpc_id
}

resource "aws_lb_target_group_attachment" "phpmyadmin" {
  target_group_arn = aws_lb_target_group.phpmyadmin-tg.arn
  target_id        = var.phpmyadmin_id #data.aws_subnet_ids.private.id
  port             = 443
  
} */





///   TLS keys    

resource "tls_private_key" "atym" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "atym" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.atym.private_key_pem

  subject {
    common_name  = "atym.pp.ua"
    organization = "DEVPRO"
  }

  validity_period_hours = 120

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_acm_certificate" "cert" {
  private_key      = tls_private_key.atym.private_key_pem
  certificate_body = tls_self_signed_cert.atym.cert_pem
}