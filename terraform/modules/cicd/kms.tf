resource "aws_kms_key" "codebuild-key" {
  description             = "Key to be used by CodeBuild to encrypt data"
  deletion_window_in_days = 30
  enable_key_rotation     = true
}

resource "aws_kms_alias" "codebuild-key" {
  name          = "alias/codebuild-${var.git_repository_name}-key"
  target_key_id = aws_kms_key.codebuild-key.key_id
}
