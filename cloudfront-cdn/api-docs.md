## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.59.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.59.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.certificate](https://registry.terraform.io/providers/hashicorp/aws/4.59.0/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.certificate_validation](https://registry.terraform.io/providers/hashicorp/aws/4.59.0/docs/resources/acm_certificate_validation) | resource |
| [aws_cloudfront_distribution.cloudfront](https://registry.terraform.io/providers/hashicorp/aws/4.59.0/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_control.cloudfront_acl](https://registry.terraform.io/providers/hashicorp/aws/4.59.0/docs/resources/cloudfront_origin_access_control) | resource |
| [aws_route53_record.certificate_records](https://registry.terraform.io/providers/hashicorp/aws/4.59.0/docs/resources/route53_record) | resource |
| [aws_route53_record.domain_record](https://registry.terraform.io/providers/hashicorp/aws/4.59.0/docs/resources/route53_record) | resource |
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/4.59.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.bucket_acl](https://registry.terraform.io/providers/hashicorp/aws/4.59.0/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership](https://registry.terraform.io/providers/hashicorp/aws/4.59.0/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/4.59.0/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.bucket_public_access](https://registry.terraform.io/providers/hashicorp/aws/4.59.0/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_object.public_folder](https://registry.terraform.io/providers/hashicorp/aws/4.59.0/docs/resources/s3_object) | resource |
| [null_resource.cache_invalidation](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/4.59.0/docs/data-sources/caller_identity) | data source |
| [aws_route53_zone.domain_zone](https://registry.terraform.io/providers/hashicorp/aws/4.59.0/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cdn_domain"></a> [cdn\_domain](#input\_cdn\_domain) | Domain name (Where you want to deploy the CloudFront distribution. Leave empty to deploy inside base domain) | `string` | `""` | no |
| <a name="input_cloudfront_allowed_methods"></a> [cloudfront\_allowed\_methods](#input\_cloudfront\_allowed\_methods) | n/a | `list(string)` | <pre>[<br>  "GET",<br>  "HEAD",<br>  "OPTIONS"<br>]</pre> | no |
| <a name="input_cloudfront_cached_methods"></a> [cloudfront\_cached\_methods](#input\_cloudfront\_cached\_methods) | n/a | `list(string)` | <pre>[<br>  "GET",<br>  "HEAD",<br>  "OPTIONS"<br>]</pre> | no |
| <a name="input_cloudfront_default_root_object"></a> [cloudfront\_default\_root\_object](#input\_cloudfront\_default\_root\_object) | n/a | `string` | `"index.html"` | no |
| <a name="input_cloudfront_http_version"></a> [cloudfront\_http\_version](#input\_cloudfront\_http\_version) | n/a | `string` | `"http2"` | no |
| <a name="input_route53_private_zone"></a> [route53\_private\_zone](#input\_route53\_private\_zone) | n/a | `bool` | `false` | no |
| <a name="input_route53_zone_domain"></a> [route53\_zone\_domain](#input\_route53\_zone\_domain) | Route53 zone domain (base domain) | `string` | `""` | no |
| <a name="input_service"></a> [service](#input\_service) | Service name | `string` | `"terraform-cdn"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage (dev, test, prod) | `string` | `"dev"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_cloudfront_default_domain"></a> [aws\_cloudfront\_default\_domain](#output\_aws\_cloudfront\_default\_domain) | n/a |
| <a name="output_cdn_domain"></a> [cdn\_domain](#output\_cdn\_domain) | n/a |
