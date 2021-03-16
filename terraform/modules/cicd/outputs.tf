output "codepipeline_name" {
  value = values(aws_codepipeline.codepipeline)[*].id
}

output "codebuild_name" {
  value = values(aws_codebuild_project.codebuild_deployment)[*].name
}

output "codepipeline_s3_bucket" {
  value = aws_s3_bucket.codepipeline_bucket.bucket
}

output "codebuild_s3_bucket" {
  value = aws_s3_bucket.codebuild_bucket.bucket
}

output "codecommit_repo_name" {
  value = aws_codecommit_repository.code_repo.repository_id
}