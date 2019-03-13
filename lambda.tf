data "aws_iam_role" "cloudfront_access" {
  name = "access-cloudfront"
}

data "archive_file" "source" {
  type        = "zip"
  source_file = "${lookup(var.lambda,"file_path", "")}"
  output_path = ".terraform_tmp/headers.zip"
}

resource "aws_lambda_function" "security_lambda" {
  provider         = "aws.virginia"
  filename         = ".terraform_tmp/headers.zip"
  function_name    = "add-security-headers"
  role             = "${data.aws_iam_role.cloudfront_access.arn}"
  handler          = "${lookup(var.lambda,"handler", "")}"
  source_code_hash = "${data.archive_file.source.output_base64sha256}"
  runtime          = "${lookup(var.lambda,"runtime", "")}"
  publish          = true
}
