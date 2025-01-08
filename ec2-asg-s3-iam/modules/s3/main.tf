# Random Suffix for Bucket Names
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

# Main S3 Bucket
resource "aws_s3_bucket" "main" {
  bucket = "${var.bucket_name}-${random_string.bucket_suffix.result}"

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

# Logging Bucket
resource "aws_s3_bucket" "logging" {
  bucket = "${var.logging_bucket_name}-${random_string.bucket_suffix.result}"

  tags = {
    Name        = var.logging_bucket_name
    Environment = var.environment
  }
}

# Logging Configuration for Main Bucket
resource "aws_s3_bucket_logging" "main_logging" {
  bucket        = aws_s3_bucket.main.id
  target_bucket = aws_s3_bucket.logging.id
  target_prefix = "logs/"
}

# Versioning for Main Bucket
resource "aws_s3_bucket_versioning" "main_versioning" {
  bucket = aws_s3_bucket.main.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Lifecycle Rules for Main Bucket
resource "aws_s3_bucket_lifecycle_configuration" "main_lifecycle" {
  bucket = aws_s3_bucket.main.id

  rule {
    id     = "lifecycle-rule"
    status = "Enabled"

    transition {
      days          = var.transition_days
      storage_class = "GLACIER"
    }

    expiration {
      days = var.expiration_days
    }
  }
}

