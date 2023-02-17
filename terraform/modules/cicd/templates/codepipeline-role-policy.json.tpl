{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect":"Allow",
      "Action": [
        "s3:Get*",
        "s3:Put*",
        "s3:List*"
      ],
      "Resource": [
        "${codepipeline_bucket_arn}",
        "${codepipeline_bucket_arn}/*"
      ]
    },
    {
      "Effect":"Allow",
      "Action": [
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey",
        "kms:Decrypt",
        "kms:Encrypt"
      ],
      "Resource": [
        "${kms_key_arn}"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild"
      ],
      "Resource": "*"
    }
  ]
}