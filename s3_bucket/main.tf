variable "Repository" {
  description = "Name ff the S3 Bucket"
  type        = string
}

resource "aws_s3_bucket" "repository_bucket" {
  bucket = var.Repository
  acl    = "private"

  versioning {
    enabled = true
  }

}


resource "aws_s3_bucket_server_side_encryption_configuration" "sse_config" {
  bucket = aws_s3_bucket.repository_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "repository_bucket_lifecycle" {
  bucket = aws_s3_bucket.repository_bucket.id

  rule {
    id     = "expire_objects"
    status = "Enabled"

    expiration {
      days = 15
    }
  }
}
