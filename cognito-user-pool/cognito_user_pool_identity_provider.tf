resource "aws_cognito_identity_provider" "linkedin" {
  user_pool_id = aws_cognito_user_pool.pool.id

  provider_name = "Linkedin"
  provider_type = "OIDC"

  attribute_mapping = {
    email       = "email"
    family_name = "family_name"
    given_name  = "given_name"
    username    = "sub"
  }

  provider_details = {
    client_id                     = var.linkedin_credentials.client_id
    client_secret                 = var.linkedin_credentials.client_secret
    authorize_scopes              = "openid profile email"
    attributes_request_method     = "GET"
    attributes_url                = "https://api.linkedin.com/v2/userinfo"
    attributes_url_add_attributes = "false"
    authorize_url                 = "https://www.linkedin.com/oauth/v2/authorization"
    jwks_uri                      = "https://www.linkedin.com/oauth/openid/jwks"
    oidc_issuer                   = "https://www.linkedin.com"
    token_url                     = "https://www.linkedin.com/oauth/v2/accessToken"
  }

  # only create if client ID is defined
  count = var.linkedin_credentials.client_id != null ? 1 : 0

  depends_on = [
    aws_cognito_user_pool.pool
  ]
}

resource "aws_cognito_identity_provider" "github" {
  user_pool_id = aws_cognito_user_pool.pool.id

  provider_name = "Github"
  provider_type = "OIDC"

  attribute_mapping = {
    email       = "email"
    family_name = "name"
    given_name  = "name"
    picture     = "avatar_url"
    username    = "sub"
  }

  provider_details = {
    client_id                     = var.github_credentials.client_id
    client_secret                 = var.github_credentials.client_secret
    authorize_scopes              = "user openid"
    attributes_request_method     = "GET"
    attributes_url_add_attributes = "false"
    authorize_url                 = "https://github.com/login/oauth/authorize"
    oidc_issuer                   = "https://www.github.com"
    attributes_url                = "${local.github_api_gateway_endpoint}/oauth/user"
    jwks_uri                      = "${local.github_api_gateway_endpoint}/oauth/access_token"
    token_url                     = "${local.github_api_gateway_endpoint}/oauth/access_token"
  }

  # only create if client ID is defined
  count = var.github_credentials.client_id != null ? 1 : 0

  depends_on = [
    aws_cognito_user_pool.pool,
    module.github_lambda_function
  ]
}

module "github_lambda_function" {
  source             = "./github"
  pool_name          = var.pool_name
  github_credentials = var.github_credentials
  stage              = var.stage

  count = var.github_credentials.client_id != null ? 1 : 0
}

resource "aws_cognito_identity_provider" "google" {
  user_pool_id = aws_cognito_user_pool.pool.id

  provider_name = "Google"
  provider_type = "Google"

  attribute_mapping = {
    email          = "email"
    email_verified = "email_verified"
    family_name    = "family_name"
    given_name     = "given_name"
    phone_number   = "phoneNumbers"
    picture        = "picture"
    username       = "sub"
  }

  provider_details = {
    client_id                     = var.google_credentials.client_id
    client_secret                 = var.google_credentials.client_secret
    attributes_url                = "https://people.googleapis.com/v1/people/me?personFields="
    attributes_url_add_attributes = true
    authorize_scopes              = "openid email profile"
    authorize_url                 = "https://accounts.google.com/o/oauth2/v2/auth"
    oidc_issuer                   = "https://accounts.google.com"
    token_request_method          = "POST"
    token_url                     = "https://www.googleapis.com/oauth2/v4/token"
  }

  # only create if client ID is defined
  count = var.google_credentials.client_id != null ? 1 : 0

  depends_on = [
    aws_cognito_user_pool.pool
  ]
}
