output "CodePipeline_S3_bucket" {
  description = "S3 bucket storing CodePipeline artefacts"
  value       = module.setup_cicd_account.codepipeline_s3_bucket
}

output "CodeBuild_S3_bucket" {
  description = "S3 bucket storing CodeBuild artefacts"
  value       = module.setup_cicd_account.codebuild_s3_bucket
}

output "CodePipeline_Name" {
  description = "Name of the CodePipeline"
  value       = module.setup_cicd_account.codepipeline_name[0]
}

output "CodeCommit_Repository_Name" {
  description = "CodeCommit Repository Name"
  value       = module.setup_cicd_account.codecommit_repo_name
}