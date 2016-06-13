resource "aws_lambda_function" "dynamodb-lambda-autoscale" {
  filename = "${var.lambda_code_filename}"
  description = "AWS Lambda function to scale a given list of dynamo tables"
  function_name = "dynamodb-lambda-autoscale"
  role = "${aws_iam_role.dynamodb-lambda-autoscale.arn}"
  handler = "index.handler"
  timeout = "5"
  runtime = "nodejs4.3"
  memory_size = "128"
}