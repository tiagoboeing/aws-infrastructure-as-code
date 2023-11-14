# Cognito User Pool

![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white) ![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)

AWS Cognito User Pool in Infrastructure as Code with Terraform. Include Identity Providers settings, just need to configure OAuth credentials.

This stack uses the following AWS services:

- Cognito User Pool

| Resource                    | Supported?                                         |
| --------------------------- | -------------------------------------------------- |
| Cognito native domain       | Yes. [Read this section.](#cognito-self-hosted-ui) |
| Custom domain + Certificate | Yes                                                |

## Pricing

In most cases, the price will be near to zero. Cognito have a free tier until 50k users. See [Cognito pricing](https://aws.amazon.com/cognito/pricing/) to learn more.

## Preconfigured providers

| Provider                                                                                                           | Provider type | Variable                                                          |
| ------------------------------------------------------------------------------------------------------------------ | ------------- | ----------------------------------------------------------------- |
| ![Google](https://img.shields.io/badge/google-4285F4?style=for-the-badge&logo=google&logoColor=white)              | Google        | `google_credentials   = { client_id = "", client_secret = "" }`   |
| ![LinkedIn](https://img.shields.io/badge/linkedin-%230077B5.svg?style=for-the-badge&logo=linkedin&logoColor=white) | OIDC          | `linkedin_credentials   = { client_id = "", client_secret = "" }` |
| Login via form                                                                                                     | Cognito       |                                                                   |

> The identity will be configured only if `client_id` is defined.

## Supported variables

Create a `.tfvars` file and configure the following variables:

```tf
pool_name = "resume-dev"
stage     = "dev"
route53_zone_domain = "domain.com"
domain    = "auth.domain.com"

# Client apps
logout_urls   = ["https://..."]
callback_urls = ["https://..."]

# Identity provider settings
linkedin_credentials = { client_id = "<your-client-id>", client_secret = "<your-secret>" }
google_credentials   = { client_id = "<your-client-id>", client_secret = "<your-secret>" }

# User groups
user_groups = [{  name = "super-admins", description = "Super admin users" }]
```

## Usage

Configure the variable creating a `.tfvars` file and pass all the OAuth credentials to configure the identity providers.

To deploy this stack, run the following commands:

```sh
terraform init
terraform plan
terraform apply
```

> It can take a few minutes to deploy.

### Client apps

Create client apps inside [`cognito_user_pool_client.tf`](./cognito_user_pool_client.tf) file. This file contains some examples and there isn't any variable to dynamic configure because each client app can have different settings. If you need to create more than one client app, just copy and paste the example and change the name.

There are two preconfigured client apps: `api` - used to authenticate the API and supports Identity Providers - and `login-via-form` - used to authenticate using Cognito credentials (as login/phone/password).

### Cognito self-hosted UI

If you don't want to use a custom domain Cognito have a Self Hosted UI with a subdomain for it.

Just remove the `certificate.tf` file and remove all lines bellow `# Custom domain` comment inside the [`cognito_user_pool_domain.tf`](./cognito_user_pool_domain.tf) file:

> Don't forget to unset `domain` variable if is set.
