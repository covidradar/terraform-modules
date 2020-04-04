variable "s3_bucket_prefix" {
    description = "Prefix that will be append to all S3 buckets names."
    type        = string
}
variable "cors_rules" {
  type = map(object({
    allowed_headers=list(string)
    allowed_methods=list(string)
    allowed_origins=list(string)
    expose_headers=list(string)
    max_age_seconds=number
  }))
    
}
variable "project_name" {
    description = "Project current using that bucket"
    type        = string
}

variable "environment" {
    description = "Environment"
    type        = string
    default     = "dev"
}

variable "s3_access_log_bucket" {
    description = "Name of the S3 bucket that will record all access logs (SEC requirement.)"
    type        = string
}

variable "s3_bucket_names" {
    description = "Name of the buckets to be created"
    type        = list(string)
}
