## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.75.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.75.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm"></a> [acm](#module\_acm) | ./modules/acm | n/a |
| <a name="module_alb"></a> [alb](#module\_alb) | ./modules/alb | n/a |
| <a name="module_ecr"></a> [ecr](#module\_ecr) | ./modules/ecr | n/a |
| <a name="module_ecs"></a> [ecs](#module\_ecs) | ./modules/ecs | n/a |
| <a name="module_elastic_ip"></a> [elastic\_ip](#module\_elastic\_ip) | ./modules/elastic_ip | n/a |
| <a name="module_igw"></a> [igw](#module\_igw) | ./modules/igw | n/a |
| <a name="module_nat"></a> [nat](#module\_nat) | ./modules/nat | n/a |
| <a name="module_route_table"></a> [route\_table](#module\_route\_table) | ./modules/route_table | n/a |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | ./modules/sg | n/a |
| <a name="module_subnet"></a> [subnet](#module\_subnet) | ./modules/subnet | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_resourcegroups_group.service](https://registry.terraform.io/providers/hashicorp/aws/5.75.1/docs/resources/resourcegroups_group) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.75.1/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/5.75.1/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | Domain where cluster will be provisioned (e.g. example.com) | `string` | `""` | no |
| <a name="input_ecr_repository_name"></a> [ecr\_repository\_name](#input\_ecr\_repository\_name) | Repository name (eg.: namespace/repo-name) | `string` | `"namespace/repo-name"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region where the resources will be created | `string` | `"us-east-1"` | no |
| <a name="input_route53_base_domain"></a> [route53\_base\_domain](#input\_route53\_base\_domain) | Route53 hosted zone domain (use the base domain) | `string` | `""` | no |
| <a name="input_route53_private_zone"></a> [route53\_private\_zone](#input\_route53\_private\_zone) | n/a | `bool` | `false` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Service name | `string` | `"cluster"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage (e.g. dev, test, prod) | `string` | `"dev"` | no |
| <a name="input_subnet_az_1"></a> [subnet\_az\_1](#input\_subnet\_az\_1) | Availability Zone 1 | `string` | `"us-east-1a"` | no |
| <a name="input_subnet_az_2"></a> [subnet\_az\_2](#input\_subnet\_az\_2) | Availability Zone 2 | `string` | `"us-east-1b"` | no |

## Outputs

No outputs.
