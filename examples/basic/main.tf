provider "aws" {
  region = "eu-north-1"
}

module "iam_profile" {
  source    = "../../"
  name      = var.name
  enable_cw = true
  enable_ha = true
}
