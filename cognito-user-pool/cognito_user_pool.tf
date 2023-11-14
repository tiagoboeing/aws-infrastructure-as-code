resource "aws_cognito_user_pool" "pool" {
  name              = var.pool_name
  mfa_configuration = "OPTIONAL"

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = "1"
    }
  }

  admin_create_user_config {
    allow_admin_create_user_only = "false"
  }

  alias_attributes         = ["email", "preferred_username"]
  auto_verified_attributes = ["email"]
  deletion_protection      = "ACTIVE"

  device_configuration {
    challenge_required_on_new_device      = "false"
    device_only_remembered_on_user_prompt = "false"
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  password_policy {
    minimum_length                   = "6"
    require_lowercase                = "false"
    require_numbers                  = "true"
    require_symbols                  = "false"
    require_uppercase                = "false"
    temporary_password_validity_days = "7"
  }

  schema {
    name                     = "email"
    attribute_data_type      = "String"
    developer_only_attribute = "false"
    mutable                  = "true"
    required                 = "true"

    string_attribute_constraints {
      max_length = "2048"
      min_length = "0"
    }
  }

  schema {
    name                     = "family_name"
    attribute_data_type      = "String"
    developer_only_attribute = "false"
    mutable                  = "true"
    required                 = "true"

    string_attribute_constraints {
      max_length = "2048"
      min_length = "0"
    }
  }

  schema {
    name                     = "given_name"
    attribute_data_type      = "String"
    developer_only_attribute = "false"
    mutable                  = "true"
    required                 = "true"

    string_attribute_constraints {
      max_length = "2048"
      min_length = "0"
    }
  }

  # sms_configuration {
  #   external_id    = "8653cf60-ad41-438e-808d-1f8679d9f388"
  #   sns_caller_arn = "arn:aws:iam::847640070182:role/service-role/cognito-resume-dev"
  #   sns_region     = "us-east-1"
  # }

  software_token_mfa_configuration {
    enabled = "true"
  }

  user_attribute_update_settings {
    attributes_require_verification_before_update = ["email"]
  }

  username_configuration {
    case_sensitive = "false"
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
  }

  tags = {
    "Stage" = var.stage
  }
}
