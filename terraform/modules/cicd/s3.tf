resource "aws_s3_bucket" "codebuild_bucket" {
  #checkov:skip=CKV_AWS_21: "Ensure all data stored in the S3 bucket have versioning enabled"
  #checkov:skip=CKV2_AWS_6: "Ensure that S3 bucket has a Public Access block"
  #for_each loop not recognised by checkov
  bucket = "${var.pipeline_deployment_bucket_name}-codebuild"

  tags = var.custom_tags
}

resource "aws_s3_bucket" "codepipeline_bucket" {
  #checkov:skip=CKV_AWS_21: "Ensure all data stored in the S3 bucket have versioning enabled"
  #checkov:skip=CKV2_AWS_6: "Ensure that S3 bucket has a Public Access block"
  #for_each loop not recognised by checkov
  bucket = "${var.pipeline_deployment_bucket_name}-codepipeline"

  tags = var.custom_tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "pipeline_buckets" {
  for_each = local.buckets_to_lock
  bucket = each.value

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_acl" "pipeline_buckets" {
  for_each = local.buckets_to_lock
  bucket = each.value
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "pipeline_buckets" {
  for_each = local.buckets_to_lock
  bucket = each.value
  versioning_configuration {
    status = "Enabled"
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
