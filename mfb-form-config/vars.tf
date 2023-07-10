variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "aws_profile" {
  default = "ddennis"
}
# variable "aws_profile" {
#   default = "sfx"
# }

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

# variable "createdby" {
#   default = "echiejina"
# }

variable "createdby" {
  default = "ddennis"
}

variable "project" {
  default = "mfb"
}

variable "environment" {
  default = "dev"
}

variable "project_component" {
  default = "form-config"
}

variable "tech" {
  default = "node"
}