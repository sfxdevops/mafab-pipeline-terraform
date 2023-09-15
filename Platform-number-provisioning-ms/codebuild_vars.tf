variable "codebuild_role" {
  default = "scripts/codebuild_role.json"
}

variable "codebuild_role_policy" {
  default = "scripts/codebuild_role_policy.json"
}

variable "buildspec_java" {
  default = "scripts/buildspec-java.yml"
}

variable "buildspec_node" {
  default = "scripts/buildspec-node.yml"
}

variable "code_repo" {
  default = "https://github.com/seamfix/platform-number-provisioning-ms.git"
}

variable "repo_branch" {
  default = "snapshot-dev"
}