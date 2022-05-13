resource "aws_dynamodb_table" "this" {
  name            = "${local.local_data.tag_prefix}-${local.local_data.tag_env}-${local.local_data.tag_client}-tfstate-lock"
  hash_key        = "LockID"
  read_capacity   = 20
  write_capacity  = 20
  attribute {
    name          = "LockID"
    type          = "S"
  }
  lifecycle {
    prevent_destroy       = true
  }
}