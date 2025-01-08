output "main_bucket_name" {
  description = "Name of the main S3 bucket"
  value       = aws_s3_bucket.main.id
}

output "logging_bucket_name" {
  description = "Name of the logging S3 bucket"
  value       = aws_s3_bucket.logging.id
}

