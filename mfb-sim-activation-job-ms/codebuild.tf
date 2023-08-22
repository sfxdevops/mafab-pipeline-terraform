
# resource "aws_iam_role" "mfb_codebuild" {
#   name = "${var.environment}-${var.project}-${var.project_component}-role"

#   assume_role_policy = data.template_file.codebuild_role.rendered

# }

# data "template_file" "codebuild_role" {
#   template = file("${var.codebuild_role}")
# }


# resource "aws_iam_role_policy" "mfb-role-policy" {
#   role = aws_iam_role.mfb_codebuild.name

#   policy = data.template_file.codebuild_role_policy.rendered
# }

# data "template_file" "codebuild_role_policy" {
#   template = file("${var.codebuild_role_policy}")
# }

resource "aws_codebuild_project" "mfb_codebuild_project" {
  depends_on  = [aws_ecr_repository.mfb-sim-activation-job-ms-ecr]
  name        = "${var.environment}-${var.project}-${var.project_component}"
  description = "Build project for ${var.project_component} for ${var.project} on ${var.environment}"
  # service_role  = aws_iam_role.ecs_codebuild.arn
  service_role  = "arn:aws:iam::341481854267:role/project-mafab-dev-role"
  badge_enabled = false

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type = "NO_CACHE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "AWS_ECR_URI"
      type  = "PLAINTEXT"
      value = "341481854267.dkr.ecr.us-east-1.amazonaws.com"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/codebuild/${var.environment}-${var.project}-${var.project_component}"
      stream_name = "${var.project_component}-build"
    }

    s3_logs {
      status = "DISABLED"
    }
  }

  source {
    type            = "GITHUB"
    location        = var.code_repo
    git_clone_depth = 1
    buildspec       = data.template_file.buildspec.rendered

    git_submodules_config {
      fetch_submodules = true
    }
  }

  source_version = (var.environment == "prod" ? "master" : var.environment == "staging" ? "DEVOPSS-276" : "staging-dev")

  tags = {
    createdby   = var.createdby
    project     = var.project
    Name        = var.project_component
    environment = var.environment
  }
}

data "template_file" "buildspec" {
  template = (var.tech == "java" ? file("${var.buildspec_java}") : file("${var.buildspec_node}")) #file("${var.buildspec}")
  vars = {
    ecr_repo_url = aws_ecr_repository.mfb-sim-activation-job-ms-ecr.repository_url
    region       = var.region
    # image_name   = "${var.environment}-${var.project}/${var.project_component}"
  }
}