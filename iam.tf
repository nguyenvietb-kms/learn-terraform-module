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