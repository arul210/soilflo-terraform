resource "aws_cognito_user_pool" "user_pool" {
  name                     = "${var.cloud_run_service_name}-user-pool"
  auto_verified_attributes = ["email"]
  username_attributes      = ["email"]
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name                = "${var.cloud_run_service_name}-client"
  user_pool_id        = aws_cognito_user_pool.user_pool.id
  explicit_auth_flows = [
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
  ]

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]
  callback_urls                        = ["https://${var.cloud_run_service_name}-${var.aws_region}.run.app/oauth2/idpresponse"]
  logout_urls                          = ["https://${var.cloud_run_service_name}-${var.aws_region}.run.app/"]
  supported_identity_providers         = ["COGNITO"]
  generate_secret                      = false
}

resource "aws_cognito_user_pool_domain" "domain" {
  domain       = "${var.cognito_domain_prefix}"
  user_pool_id = aws_cognito_user_pool.user_pool.id
}