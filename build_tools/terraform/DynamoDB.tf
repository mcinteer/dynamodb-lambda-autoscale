resource "aws_dynamodb_table" "dynamodb-lambda-autoscale" {
    name = "dynamodb-lambda-autoscale"
    read_capacity = 1
    write_capacity = 1
    hash_key = "TableName"
    attribute {
      name = "TableName"
      type = "S"
    }
}
