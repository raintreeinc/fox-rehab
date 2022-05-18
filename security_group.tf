resource "aws_security_group" "this" {
  name = "${lower(local.local_data.tag_prefix)}-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_client)}"
  description = "Terraform-managed security group"
  vpc_id = local.local_data.vpc_id
    ingress {
    description = "Internal Allow List"
    cidr_blocks = ["10.0.0.0/8"]
    protocol = -1
    from_port = 0
    to_port = 0
  }
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
  ingress {
    description = "Inbound Raintree Service Allow"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    protocol = "tcp"
    from_port = 10021
    to_port = 10021
  }
  ingress {
    description = "Inbound Management"
    cidr_blocks = ["73.171.35.142/32"]
    ipv6_cidr_blocks = ["2601:5c2:1:fc0:755b:ca7c:aac1:2e39/128"]
    protocol = "tcp"
    from_port = 3389
    to_port = 3389
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