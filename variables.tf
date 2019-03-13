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

variable "lambda" {
  type = "map"

  default = {
    file_path = ""
    handler   = ""
    runtime   = ""
  }
}
