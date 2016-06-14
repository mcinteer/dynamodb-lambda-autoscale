resource "aws_iam_role_policy" "dynamodb-lambda-autoscale" {
    name = "dynamodb-lambda-autoscale"
    role = "${aws_iam_role.dynamodb-lambda-autoscale.id}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "dynamodb:ListTables",
                "dynamodb:DescribeTable",
                "dynamodb:UpdateTable",
                "dynamodb:scan",
                "cloudwatch:GetMetricStatistics",
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
EOF
}
