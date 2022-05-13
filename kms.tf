resource "aws_kms_key" "this" {
  description             = "${local.local_data.tag_client} KMS Key"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_kms_alias" "this" {
  name          = "alias/${lower(local.local_data.tag_client)}"
  target_key_id = aws_kms_key.this.key_id
}