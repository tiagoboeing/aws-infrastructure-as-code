## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.25.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.25.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.certificate_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_cognito_identity_provider.google](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_identity_provider) | resource |
| [aws_cognito_identity_provider.linkedin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_identity_provider) | resource |
| [aws_cognito_user_group.group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_group) | resource |
| [aws_cognito_user_pool.pool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |
| [aws_cognito_user_pool_client.api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client) | resource |
| [aws_cognito_user_pool_domain.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain) | resource |
| [aws_route53_record.auth-cognito-A](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.certificate_records](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [random_string.hash](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_route53_zone.domain_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_callback_urls"></a> [callback\_urls](#input\_callback\_urls) | List of allowed callback URLs | `list(string)` | `[]` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Custom domain name to use on the user pool | `string` | n/a | yes |
| <a name="input_google_credentials"></a> [google\_credentials](#input\_google\_credentials) | Google OAuth settings | `map(string)` | `{}` | no |
| <a name="input_linkedin_credentials"></a> [linkedin\_credentials](#input\_linkedin\_credentials) | Linkedin OIDC settings | `map(string)` | `{}` | no |
| <a name="input_logout_urls"></a> [logout\_urls](#input\_logout\_urls) | List of allowed logout URLs | `list(string)` | `[]` | no |
| <a name="input_pool_name"></a> [pool\_name](#input\_pool\_name) | The name of the user pool | `string` | n/a | yes |
| <a name="input_route53_private_zone"></a> [route53\_private\_zone](#input\_route53\_private\_zone) | n/a | `bool` | `false` | no |
| <a name="input_route53_zone_domain"></a> [route53\_zone\_domain](#input\_route53\_zone\_domain) | Route53 zone domain (base domain) | `string` | `""` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage (dev, test, prod) | `string` | `"dev"` | no |
| <a name="input_user_groups"></a> [user\_groups](#input\_user\_groups) | List of user groups | `list(map(string))` | <pre>[<br>  {<br>    "description": "Admin users",<br>    "name": "Admins"<br>  }<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_cognito_user_pool_client_api_id"></a> [aws\_cognito\_user\_pool\_client\_api\_id](#output\_aws\_cognito\_user\_pool\_client\_api\_id) | Clients |
| <a name="output_aws_cognito_user_pool_client_api_secret"></a> [aws\_cognito\_user\_pool\_client\_api\_secret](#output\_aws\_cognito\_user\_pool\_client\_api\_secret) | n/a |
| <a name="output_aws_cognito_user_pool_domain"></a> [aws\_cognito\_user\_pool\_domain](#output\_aws\_cognito\_user\_pool\_domain) | n/a |
| <a name="output_aws_cognito_user_pool_id"></a> [aws\_cognito\_user\_pool\_id](#output\_aws\_cognito\_user\_pool\_id) | n/a |
