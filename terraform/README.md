<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.27 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.67.0 |
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | 3.4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_EC2_policy"></a> [EC2\_policy](#module\_EC2\_policy) | ./modules/keys | n/a |
| <a name="module_lb-blue"></a> [lb-blue](#module\_lb-blue) | ./modules/lb | n/a |
| <a name="module_lb-green"></a> [lb-green](#module\_lb-green) | ./modules/lb | n/a |
| <a name="module_net"></a> [net](#module\_net) | ./modules/net | n/a |
| <a name="module_nginx-blue-1"></a> [nginx-blue-1](#module\_nginx-blue-1) | ./modules/ec2_web | n/a |
| <a name="module_nginx-blue-2"></a> [nginx-blue-2](#module\_nginx-blue-2) | ./modules/ec2_web | n/a |
| <a name="module_nginx-green-1"></a> [nginx-green-1](#module\_nginx-green-1) | ./modules/ec2_web | n/a |
| <a name="module_nginx-green-2"></a> [nginx-green-2](#module\_nginx-green-2) | ./modules/ec2_web | n/a |
| <a name="module_nginx-sg"></a> [nginx-sg](#module\_nginx-sg) | ./modules/sec | n/a |
| <a name="module_phpmyadmin-blue"></a> [phpmyadmin-blue](#module\_phpmyadmin-blue) | ./modules/ec2_web | n/a |
| <a name="module_phpmyadmin-green"></a> [phpmyadmin-green](#module\_phpmyadmin-green) | ./modules/ec2_web | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_lb_target_group.blue-tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.green-tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.phpmyadmin-blue-tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.phpmyadmin-green-tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.blue1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.blue2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.green1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.green2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.phpmyadmin-blue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.phpmyadmin-green](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [cloudflare_record.set-lb-cname](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_awsid"></a> [awsid](#input\_awsid) | AWS ID | `string` | n/a | yes |
| <a name="input_awskey"></a> [awskey](#input\_awskey) | AWS key | `string` | n/a | yes |
| <a name="input_color"></a> [color](#input\_color) | Set this var to color name GREEN/BLUE to change the branch | `string` | `"green"` | no |
| <a name="input_first_subnet"></a> [first\_subnet](#input\_first\_subnet) | First subnet cidr | `string` | `"10.0.1.0/24"` | no |
| <a name="input_names"></a> [names](#input\_names) | Instance names | `list(string)` | <pre>[<br>  "nginx-green-1",<br>  "nginx-green-2",<br>  "nginx-blue-1",<br>  "nginx-blue-2",<br>  "phpmyadmin-green",<br>  "phpmyadmin-blue"<br>]</pre> | no |
| <a name="input_rds-pass"></a> [rds-pass](#input\_rds-pass) | RDS username | `string` | `"12345678"` | no |
| <a name="input_rds-user"></a> [rds-user](#input\_rds-user) | RDS password | `string` | `"atym"` | no |
| <a name="input_rds_subnet"></a> [rds\_subnet](#input\_rds\_subnet) | Database subnet cidr | `string` | `"10.0.3.0/24"` | no |
| <a name="input_second_subnet"></a> [second\_subnet](#input\_second\_subnet) | Second subnet cidr | `string` | `"10.0.2.0/24"` | no |
| <a name="input_vps_cidr"></a> [vps\_cidr](#input\_vps\_cidr) | VPS net | `string` | `"10.0.0.0/16"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | for single zone deployment | `string` | `"eu-central-1a"` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | Availability zones | `list(string)` | <pre>[<br>  "eu-central-1a",<br>  "eu-central-1b",<br>  "eu-central-1c"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_name_blue"></a> [dns\_name\_blue](#output\_dns\_name\_blue) | Blue DNS |
| <a name="output_dns_name_green"></a> [dns\_name\_green](#output\_dns\_name\_green) | Green DNS |
| <a name="output_rds_hostname"></a> [rds\_hostname](#output\_rds\_hostname) | RDS instance hostname |
| <a name="output_rds_port"></a> [rds\_port](#output\_rds\_port) | RDS instance port |
| <a name="output_rds_username"></a> [rds\_username](#output\_rds\_username) | RDS instance root username |
<!-- END_TF_DOCS -->