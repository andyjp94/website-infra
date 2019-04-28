variable "hosted_zone_id" {
  type = "string"
}

variable "domain_name" {
  type = "string"
}

variable "certificate" {
  type = "string"
}

variable "www" {
  type    = "string"
  default = "true"
}

variable "log_bucket" {
  type    = "string"
  default = ""
}

variable "lambda" {
  type = "map"

  default = {
    name      = ""
    file_path = ""
    handler   = ""
    runtime   = ""
  }
}
