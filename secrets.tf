resource "aws_secretsmanager_secret" "this" {
  name        = "${lower(local.local_data.tag_prefix)}-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_client)}"
  description = "${local.local_data.tag_client} secrets"
  kms_key_id  = aws_kms_key.this.id
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = jsonencode(tomap({"Keypair" = aws_key_pair.this.key_name, "Public Key" = tls_private_key.this.public_key_pem, "Private Key" = tls_private_key.this.private_key_pem, "AWS_ACCESS_KEY_ID" = local.access_key, "AWS_SECRET_ACCESS_KEY" = local.secret_key}))
}