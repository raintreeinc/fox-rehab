provider "aws" {
  default_tags {
    tags = {
      Environment   = local.local_data.tag_env
      Owner         = local.local_data.tag_owner
      Client        = local.local_data.tag_client
      Automated     = "True"
    }
  }
}

locals {
  local_data = jsondecode(file("${path.module}/variables.tfvars.json"))
}
