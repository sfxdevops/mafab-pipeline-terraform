variable "repo_id" {
  default = "seamfix/platform-report-ms"
}

variable "codepipeline_role" {
  default = "scripts/codepipeline_role.json"
}

variable "codepipeline_role_policy" {
  default = "scripts/codepipeline_role_policy.json"
}

variable "codestar_connector_credentials" {
  default = "arn:aws:codestar-connections:us-east-2:341481854267:connection/866ad547-8eb8-4053-8359-53c890ea0f54"
  type    = string
}