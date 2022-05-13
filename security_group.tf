resource "aws_security_group" "this" {
  name = "${lower(local.local_data.tag_prefix)}-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_client)}"
  description = "Terraform-managed security group"
  vpc_id = local.local_data.vpc_id
  ingress {
    description = "Inbound HTTP Allow"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    protocol = "tcp"
    from_port = 80
    to_port = 80
  }
  ingress {
    description = "Inbound HTTPS Allow"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    protocol = "tcp"
    from_port = 443
    to_port = 443
  }
  egress {
    description = "Outbound Allow List"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    protocol = "-1"
    from_port = 0
    to_port = 0
  }
}