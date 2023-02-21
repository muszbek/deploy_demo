resource "aws_ecr_repository" "repo" {
  name = "demo-repository"
  
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = "my-bucket"
}
