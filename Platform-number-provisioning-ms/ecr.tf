resource "aws_ecr_repository" "platform-number-provisioning-ecr" {
  name                 = "${var.project}/${var.project_component}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    createdby   = var.createdby
    project     = var.project
    Name        = var.project_component
    environment = var.environment
  }
}
