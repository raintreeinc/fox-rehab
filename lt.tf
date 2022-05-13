data "aws_ami" "this" {
  owners           = ["amazon"]
  most_recent      = true 
  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-ContainersLatest-*"]
  }
}

resource "aws_launch_template" "this" {
  name = "LT-${upper(local.local_data.tag_prefix)}-${upper(local.local_data.tag_env)}-${upper(local.local_data.tag_client)}"
  update_default_version = true
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 128
      delete_on_termination = true
      encrypted = true
      volume_type = "gp2"
    }
  }
  disable_api_termination = false
  ebs_optimized = true
  image_id = data.aws_ami.this.image_id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "m5zn.large"
  key_name = aws_key_pair.this.key_name
  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "optional"
  }
  monitoring {
    enabled = true
  }
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination = true
    security_groups = [ aws_security_group.this.id ]
  }
}