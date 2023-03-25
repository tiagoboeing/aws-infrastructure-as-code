# CloudFront CDN with custom domain

> Tested with custom subdomain.

## Stack

- CloudFront
- S3
- Amazon Certificate Manager
  - Custom SSL Certificate
- Route53

## Pricing

In most cases, the price will be near to zero.

The pricing is based on the number of requests and the amount of data transferred (pay-per-use). See [AWS CloudFront Pricing](https://aws.amazon.com/cloudfront/pricing/), [AWS S3 Pricing](https://aws.amazon.com/s3/pricing/) and [AWS Route53 Pricing](https://aws.amazon.com/route53/pricing/).

> Note: The price of Route53 Hosted Zone is not included.

## How to use

Change the values on `terraform.tfvars` file to your needs.

```bash
# See the changes
terraform plan

# Apply the changes
terraform apply
```

> This example don't consider Remote State. You can use [Terraform Remote State](https://www.terraform.io/docs/state/remote.html) to store the state file in a remote location.