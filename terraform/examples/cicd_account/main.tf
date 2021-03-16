provider "aws" {
  region = "eu-west-1"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}


module "setup_cicd_account" {
  source = "../../modules/cicd"

  custom_tags                     = var.custom_tags
  account_type                    = "Demo"
  pipeline_deployment_bucket_name = "${var.git_repository_name}-${data.aws_caller_identity.current.account_id}"
  account_id                      = data.aws_caller_identity.current.account_id
  region                          = data.aws_region.current.name
  roles                           = var.cross_account_roles
  code_pipeline_build_stages      = var.code_pipeline_build_stages
  git_repository_name             = var.git_repository_name
}
