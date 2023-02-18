resource "aws_codecommit_approval_rule_template" "code_repo_approval_rule_template" {
  name        = "CICDApprovalRuleTemplate"
  description = "This is an approval rule template"

  content = <<EOF
{
    "Version": "2018-11-08",
    "DestinationReferences": ["refs/heads/master"],
    "Statements": [{
        "Type": "Approvers",
        "NumberOfApprovalsNeeded": 2,
        "ApprovalPoolMembers": ["arn:aws:sts::${var.account_id}:assumed-role/CodeCommitReview/*"]
    }]
}
EOF
}

resource "aws_codecommit_repository" "code_repo" {
  repository_name = var.git_repository_name
  description     = "Code Repository"

  tags = var.custom_tags
}

resource "aws_codecommit_approval_rule_template_association" "example" {
  approval_rule_template_name = aws_codecommit_approval_rule_template.code_repo_approval_rule_template.name
  repository_name             = aws_codecommit_repository.code_repo.repository_name
}

resource "aws_codepipeline" "codepipeline" {
  for_each = toset(var.branches)
  name     = "${var.git_repository_name}-${each.value}"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"

    encryption_key {
      id   = aws_kms_key.codebuild-key.arn
      type = "KMS"
    }
  }



  stage {
    name = "Source"

    action {
      name             = "Source-${var.git_repository_name}"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName = var.git_repository_name
        BranchName     = each.value
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build-${aws_codebuild_project.codebuild_deployment["build"].name}"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      run_order        = 1
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName = aws_codebuild_project.codebuild_deployment["build"].name
        EnvironmentVariables = jsonencode([{
          name  = "ENVIRONMENT"
          value = each.value
          },
          {
            name  = "PROJECT_NAME"
            value = var.account_type
        }])
      }
    }
  }
  tags = var.custom_tags
}
