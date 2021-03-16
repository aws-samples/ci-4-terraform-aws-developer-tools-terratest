variable "custom_tags" {
  description = "Resources tags"
  type = object({
    Environment    = string
    TargetAccounts = string
    DeploymentType = string
  })
  default = {
    Environment    = "Deployment"
    TargetAccounts = "Demo"
    DeploymentType = "Terraform"
  }
}

variable "cross_account_roles" {
  description = "ARN of the roles to be assumed by CodeBuild in case of Cross Account Deployment"
  type        = list(any)
  default     = []
}

variable "git_repository_name" {
  description = "Name of the remote git repository to be created"
  type        = string
}

variable "code_pipeline_build_stages" {
  description = "maps of build type stages configured in CodePipeline"
  default = {
    "build" = "terraform/modules/buildspec.yaml"
  }
}