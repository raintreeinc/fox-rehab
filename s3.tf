resource "aws_s3_bucket" "this" {
  bucket                = "${local.local_data.tag_prefix}-${local.local_data.tag_environment}-${local.local_data.tag_client}-tfstate"
  lifecycle {
    prevent_destroy     = true
  }
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