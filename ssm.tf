resource "aws_ssm_parameter" "db_password" {
  name        = "/db/password"
  value       = "uninitialized"
  type        = "SecureString"
  description = "Database Password"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "wasabi_access_key_id" {
  name        = "/riflessione/prd/access_key_id"
  value       = "uninitialized"
  type        = "SecureString"
  description = "AWS Access Key"

  lifecycle {
    ignore_changes = [value]
  }
}


resource "aws_ssm_parameter" "wasabi_secret_access_key" {
  name        = "/riflessione/prd/secret_access_key"
  value       = "uninitialized"
  type        = "SecureString"
  description = "AWS Secret Access Key"

  lifecycle {
    ignore_changes = [value]
  }
}
