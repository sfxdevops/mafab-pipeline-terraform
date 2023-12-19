variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "aws_profile" {
  default = "ddennis"
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
  default = "civ"
}

variable "environment" {
  default = "dev"
}

variable "project_component" {
  default = "data-migration-job-ms"
}

variable "tech" {
  default = "node"
}