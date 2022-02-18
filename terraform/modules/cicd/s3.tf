resource "aws_s3_bucket" "codebuild_bucket" {
  bucket = "${var.pipeline_deployment_bucket_name}-codebuild"
  tags = var.custom_tags
}

resource "aws_s3_bucket_acl" "codebuild_bucket_acl" {
  bucket = aws_s3_bucket.codebuild_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "enforce_sse_kms_encryption_codebuild_bucket" {
  bucket = aws_s3_bucket.codebuild_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "${var.pipeline_deployment_bucket_name}-codepipeline"
  tags = var.custom_tags
}

resource "aws_s3_bucket_versioning" "versioning_codepipeline" {
  # Need for CloudWatch
  bucket = aws_s3_bucket.codepipeline_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "codepipeline_bucket_acl" {
  bucket = aws_s3_bucket.codepipeline_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "enforce_sse_kms_encryption_codepipeline_bucket" {
  bucket = aws_s3_bucket.codepipeline_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
    }
  }
}


resource "aws_s3_bucket_public_access_block" "pipeline_buckets" {

  for_each                = local.buckets_to_lock
  bucket                  = each.value
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}
