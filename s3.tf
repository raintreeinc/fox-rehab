resource "aws_s3_bucket" "this" {
  bucket                = "${lower(local.local_data.tag_prefix)}-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_client)}-tfstate"
}

resource "aws_s3_bucket_acl" "this" {
  bucket                = aws_s3_bucket.this.id
  acl                   = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket                = aws_s3_bucket.this.bucket
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_alias.this.name
      sse_algorithm     = "aws:kms"
    }
  }
}