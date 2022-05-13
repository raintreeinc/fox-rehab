resource "aws_lb" "this" {
  name                        = "ALB-${upper(local.local_data.tag_prefix)}-${upper(local.local_data.tag_env)}-${upper(local.local_data.tag_client)}"
  internal                    = false
  load_balancer_type          = "application"
  security_groups             = [aws_security_group.this.id]
  subnets                     = local.local_data.vpc_public_app_subnets
  enable_deletion_protection  = false
  access_logs {
    bucket  = aws_s3_bucket.this.bucket
    prefix  = "${lower(local.local_data.tag_client)}"
    enabled = true
  }
}

resource "aws_lb_target_group" "this" {
  name      = "TG-${upper(local.local_data.tag_prefix)}-${upper(local.local_data.tag_env)}-${upper(local.local_data.tag_client)}"
  port      = 80
  protocol  = "HTTP"
  vpc_id    = local.local_data.vpc_id
}

resource "aws_lb_listener" "this" {
  load_balancer_arn   = aws_lb.this.arn
  port                = "80"
  protocol            = "HTTP"

  default_action {
    type              = "forward"
    target_group_arn  = aws_lb_target_group.this.arn
  }
}