resource "aws_iam_role" "codepipeline_role" {
  name = local.codepipeline_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags               = var.custom_tags
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = local.codepipeline_policy_name
  role = aws_iam_role.codepipeline_role.id

  policy = templatefile("${path.module}/templates/codepipeline-role-policy.json.tpl", {
    codepipeline_bucket_arn = aws_s3_bucket.codepipeline_bucket.arn
  })

}

resource "aws_iam_role_policy_attachment" "codepipeline_codecommit" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
}