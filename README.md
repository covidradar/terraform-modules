# Terraform S3 bucket module for AWS accounts

## Import the module

    module "my_s3_bucket" {
            source = "git::https://github.com/covidradar/terrafom-modules.git//s3-bucket"

            s3_bucket_prefix     = "covidradar-my-application-prod"
            s3_access_log_bucket = "covidradar-my-application-prod-server-access-logs"

            s3_bucket_names = ["my-bucket-1", "my-bucket-2"]
    }