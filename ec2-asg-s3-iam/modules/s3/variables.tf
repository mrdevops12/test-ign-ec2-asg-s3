variable "bucket_name" {
  description = "Base name for the main S3 bucket"
  type        = string
}

variable "logging_bucket_name" {
  description = "Base name for the logging S3 bucket"
  type        = string
}

variable "environment" {
  description = "Environment tag for resources (e.g., Dev, QA, Prod)"
  type        = string
}

variable "transition_days" {
  description = "Days to transition objects to GLACIER storage"
  type        = number
}

variable "expiration_days" {
  description = "Days after which objects are permanently deleted"
  type        = number
}

