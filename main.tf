provider "aws" {
	region = "us-east-1"
}

resource "aws_lambda_function" "terraform_demo" {
  function_name = "terrfrom_demo"
  handler = "index.handler"
  runtime = "nodejs4.3"
  filename = "demo.zip"
  source_code_hash = "${base64sha256("demo.zip")}"  
  role = "${aws_iam_role.lambda_exec_role.arn}"
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  assume_role_policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}