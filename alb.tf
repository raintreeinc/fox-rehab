resource "aws_lb" "this" {
  name                        = "NLB-${upper(local.local_data.tag_prefix)}-${upper(local.local_data.tag_env)}-${upper(local.local_data.tag_client)}"
  internal                    = false
  load_balancer_type          = "network"
  subnets                     = local.local_data.vpc_public_app_subnets
  enable_deletion_protection  = false
}

resource "aws_lb_target_group" "this" {
  name      = "TG-${upper(local.local_data.tag_prefix)}-${upper(local.local_data.tag_env)}-${upper(local.local_data.tag_client)}"
  port      = 10021
  protocol  = "TCP"
  vpc_id    = local.local_data.vpc_id
}

resource "aws_lb_listener" "this" {
  load_balancer_arn   = aws_lb.this.arn
  port                = "10021"
  protocol            = "TCP"

  default_action {
    type              = "forward"
    target_group_arn  = aws_lb_target_group.this.arn
  }
}