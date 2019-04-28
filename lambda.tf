data "aws_iam_role" "cloudfront_access" {
  name = "access-cloudfront"
}

resource "aws_lambda_function" "security_lambda" {
  provider         = "aws.virginia"
  filename         = "${lookup(var.lambda,"file_path", "")}"
  function_name    = "${lookup(var.lambda,"name", "")}"
  role             = "${data.aws_iam_role.cloudfront_access.arn}"
  handler          = "${lookup(var.lambda,"handler", "")}"
  source_code_hash = "${file(lookup(var.lambda,"file_path", ""))}"
  runtime          = "${lookup(var.lambda,"runtime", "")}"
  publish          = true
}
