resource "aws_cloudfront_distribution" "self" {
  origin {
    domain_name = "${var.domain_name}.s3.amazonaws.com"
    origin_id   = "topLevelDomainOrigin"
  }

  enabled         = true
  is_ipv6_enabled = true

  comment             = "CDN for ${var.domain_name} domain"
  default_root_object = "index.html"

  logging_config {
    include_cookies = false
    bucket          = "${aws_s3_bucket.logs.bucket_domain_name}"
    prefix          = "cloudfront/top_domain"
  }

  aliases = ["www.${var.domain_name}", "${var.domain_name}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "topLevelDomainOrigin"
    compress         = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    lambda_function_association {
      event_type = "origin-response"
      lambda_arn = "${aws_lambda_function.security_lambda.qualified_arn}" #${aws_lambda_function.security_lambda.version}
    }
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = "${var.certificate}"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.1_2016"
  }
}

resource "aws_s3_bucket" "logs" {
  bucket = "ajp-logs"
}
