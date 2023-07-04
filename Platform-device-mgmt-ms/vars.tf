variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "aws_profile" {
  default = "sfx"
}

# terraform {
#   backend "s3" {}
# }

variable "manager" {
  type = list(string)
  default = [
    "terraform",
    "cloudformation",
    "console"
  ]
}

variable "createdby" {
  default = "echiejina"
}

variable "project" {
  default = "sfx-platform"
}

variable "environment" {
  default = "staging"
}

variable "project_component" {
  default = "device-mgmt-ms"
}

variable "tech" {
  default = "node"
}