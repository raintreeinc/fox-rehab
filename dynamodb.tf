resource "aws_dynamodb_table" "this" {
  name            = "${lower(local.local_data.tag_prefix)}-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_client)}-tfstate-lock"
  hash_key        = "LockID"
  read_capacity   = 20
  write_capacity  = 20
  attribute {
    name          = "LockID"
    type          = "S"
  }
}