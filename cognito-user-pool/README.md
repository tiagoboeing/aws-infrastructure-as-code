# Cognito User Pool

![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white) ![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)

AWS Cognito User Pool in Infrastructure as Code with Terraform. Include Identity Providers settings, just need to configure OAuth credentials.

| Resource      | Supported? |
| ------------- | ---------- |
| Custom domain | Yes        |

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

# Client apps
logout_urls   = ["https://..."]
callback_urls = ["https://..."]

# Identity provider settings
linkedin_credentials = { client_id = "<your-client-id>", client_secret = "<your-secret>" }
google_credentials   = { client_id = "<your-client-id>", client_secret = "<your-secret>" }
```
