resource "aws_iam_role" "bvn_role" {
  name = format("bvn-%s-role", var.tag_environment)

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF

  tags = merge({ Name = format("bvn-%s-role", var.tag_environment) }, local.common_tags)
}

resource "aws_iam_role_policy" "bvn_gluejob_role_policy" {
  name = format("bvn-%s-role-policy", var.tag_environment)
  role = aws_iam_role.bvn_role.id

  policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
  {
    "Action": [
        "s3:List*",
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
    ],
    "Effect": "Allow",
    "Resource": [
        "arn:aws:s3:::${local.bucket_name}",
        "arn:aws:s3:::${local.bucket_name}/*"
    ],
    "Sid": "s3Access"
  },
  {
    "Action": [
        "glue:Get*"
    ],
    "Effect": "Allow",
    "Resource": [
        "arn:aws:glue:${var.region}:${var.account_id}:catalog",
        "arn:aws:glue:${var.region}:${var.account_id}:database/*",
        "arn:aws:glue:${var.region}:${var.account_id}:table/*"
    ],
    "Sid": "GlueAccess"
  },
  {
    "Action": [
        "secretsmanager:GetResourcePolicy",
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret",
        "secretsmanager:ListSecretVersionIds"
    ],
    "Effect": "Allow",
    "Resource": [
        "arn:aws:secretsmanager:${var.region}:${var.account_id}:secret:*"
    ],
    "Sid": "SecretAccess"
  },
  {
    "Effect": "Allow",
    "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:DescribeLogStreams",
        "logs:PutLogEvents"
    ],
    "Resource": "arn:aws:logs:${var.region}:${var.account_id}:*:/aws-glue/jobs/*"
  }
]
}
EOF
}