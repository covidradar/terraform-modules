resource "aws_s3_bucket" "bucket" {
    for_each = toset(var.s3_bucket_names)

    bucket = "${var.s3_bucket_prefix}-${var.project_name}-${var.environment}-${each.value}"
    acl    = "private"
    
    versioning {
        enabled = true
    }

    logging {
        target_bucket = "${var.s3_access_log_bucket}"
        target_prefix = "${each.value}/"
    }
    
    tags = {
        Project = "${var.project_name}"
        Environment = "${var.environment}"
    }
    
    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }
}

resource "aws_s3_bucket_policy" "bucket-policy" {
    for_each = aws_s3_bucket.bucket
    bucket = "${each.value.id}"

    policy = <<POLICY
{
"Id": "SSLBucketAcessPolicy",
"Version": "2012-10-17",
"Statement": [
    {
    "Sid": "DenyWithoutSSL",
    "Action": "s3:*",
    "Effect": "Deny",
    "Resource": "${each.value.arn}/*",
    "Condition": {
        "Bool": {
            "aws:SecureTransport": "false"
        }
    },
    "Principal": "*"
    }
]
}
POLICY
}

resource "aws_s3_bucket_public_access_block" "block" {
  for_each = aws_s3_bucket.bucket
  bucket = "${each.value.id}"

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}
