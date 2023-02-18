{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iam:CreateRole",
        "iam:GetRole",
        "iam:GetRolePolicy",
        "iam:TagRole",
        "iam:List*",
        "iam:AttachRolePolicy",
        "iam:DetachRolePolicy",
        "iam:DeleteRole",
        "iam:DeleteRolePolicy",
        "iam:PassRole",
        "iam:PutRolePolicy"
      ],
      "Resource": "arn:aws:iam::${account_id}:role/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codecommit:CreateRepository",
        "codecommit:TagResource",
        "codecommit:DeleteRepository"
      ],
      "Resource": "arn:aws:codecommit:${region}:${account_id}:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codecommit:CreateApprovalRuleTemplate",
        "codecommit:AssociateApprovalRuleTemplateWithRepository",
        "codecommit:DeleteApprovalRuleTemplate",
        "codecommit:DisassociateApprovalRuleTemplateFromRepository"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:DeleteProject"
      ],
      "Resource": "arn:aws:codebuild:${region}:${account_id}:project/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "kms:CreateKey",
        "kms:CreateAlias",
        "kms:DescribeKey",
        "kms:EnableKeyRotation",
        "kms:Get*",
        "kms:List*",
        "kms:DeleteAlias",
        "kms:ScheduleKeyDeletion"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:CreateBucket",
        "s3:List*",
        "s3:Get*",
        "s3:Put*",
        "s3:DeleteBucket"
      ],
      "Resource": "*"
    }
  ]
}