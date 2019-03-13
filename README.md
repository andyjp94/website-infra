# Module for building a static website

This module leverages:
1. s3
2. Cloudfront
3. Lambda
4. Route53

A website configured this way should have an A+ rating for security headers and communicate only over HTTPS.

### TODO strip out the CSP from the module
### TODO Add descriptions to the variables
### TODO Add outputs

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| certificate |  | string | n/a | yes |
| domain\_name |  | string | n/a | yes |
| hosted\_zone\_id |  | string | n/a | yes |
| www |  | string | `"true"` | no |

