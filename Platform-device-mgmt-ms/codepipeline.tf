resource "aws_codepipeline" "mfb_codepipeline_project" {
  depends_on = [aws_codebuild_project.mfb_codebuild_project]
  name       = "${var.environment}-${var.project}-${var.project_component}-pipeline"
  role_arn   = "arn:aws:iam::341481854267:role/staging-sfx-platform-codepipeline-role"

  artifact_store {
    # location = (var.environment == "prod" ? "codepipeline-us-east-1-454305357471" : var.environment == "stage" ? "codepipeline-us-east-2-404459981228" : "codepipeline-us-east-1-454305357471")
    location = (var.environment == "prod" ? "codepipeline-us-east-2-404459981228" : var.environment == "staging" ? "codepipeline-us-east-1-454305357471" : "codepipeline-us-east-1-454305357471")
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn        = var.codestar_connector_credentials
        FullRepositoryId     = var.repo_id
        BranchName           = (var.environment == "prod" ? "master" : var.environment == "staging" ? "DEVOPS-1728" : "staging-dev")
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.mfb_codebuild_project.name
      }
    }
  }
  
}

# resource "aws_iam_role" "mfb_codepipeline" {
#   name = "staging-sfx-platform-codepipeline-role"

#   assume_role_policy = data.template_file.codepipeline_role.rendered
# }

# data "template_file" "codepipeline_role" {
#   template = file("${var.codepipeline_role}")
# }

# resource "aws_iam_role_policy" "codepipeline_policy" {
#   name = "staging-sfx-platform-codepipeline_policy"
#   role = aws_iam_role.mfb_codepipeline.name

#   policy = data.template_file.codepipeline_role_policy.rendered
# }

# data "template_file" "codepipeline_role_policy" {
#   template = file("${var.codepipeline_role_policy}")
# }