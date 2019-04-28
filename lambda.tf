data "aws_iam_role" "cloudfront_access" {
  name = "access-cloudfront"
}

resource "aws_lambda_function" "security_lambda" {
  provider         = "aws.virginia"
  function_name    = "add-security-headers"
  filename         = "${lookup(var.lambda,"file_path", "")}"
  role             = "${data.aws_iam_role.cloudfront_access.arn}"
  handler          = "${lookup(var.lambda,"handler", "")}"
  source_code_hash = "${data.archive_file.source.output_base64sha256}"
  runtime          = "${lookup(var.lambda,"runtime", "")}"
  publish          = true
}
