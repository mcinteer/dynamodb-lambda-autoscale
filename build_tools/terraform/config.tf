variable "access_key" {}
variable "secret_key" {}

variable "lambda_code_filename" {
  default = "../../dist.zip"
}

/*
AWS Environment
* platdev-test
* platdev-prod
* paas-prod
*/
variable "aws-env" {
  default = "platdev-test"
}

variable "region" {
  type = "map"
  default = {
    platdev-test = "us-west-2"
    platdev-prod = "us-east-1"
    paas-prod = "us-east-1"
  }
}
