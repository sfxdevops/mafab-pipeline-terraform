resource "aws_ecr_repository" "platform-document-ecr" {
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

# data "external" "tags_of_most_recently_pushed_image" {
#   program = [
#     "aws", "ecr", "describe-images",
#     "--repository-name", "${aws_ecr_repository.platform-document-ecr.name}",
#     "--query", "{\"tags\": to_string(sort_by(imageDetails, &imagePushedAt)[-1].imageTags)}",
#     "--region", "${var.region}"
#   ]
# }
