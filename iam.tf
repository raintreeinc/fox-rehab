resource "aws_iam_user" "this" {
  name        = "${upper(local.local_data.tag_prefix)}-${upper(local.local_data.tag_env)}-${upper(local.local_data.tag_client)}"
  path        = "/"
}

data "aws_iam_policy" "this" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group" "this" {
  name        = "${upper(local.local_data.tag_prefix)}-${upper(local.local_data.tag_env)}-${upper(local.local_data.tag_client)}-DevOps"
}

resource "aws_iam_group_policy_attachment" "this" {
  group       = aws_iam_group.this.name
  policy_arn  = data.aws_iam_policy.this.arn
}

resource "aws_iam_access_key" "this" {
  user    = aws_iam_user.this.name
}