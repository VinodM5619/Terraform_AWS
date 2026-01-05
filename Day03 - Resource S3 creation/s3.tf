
resource "aws_s3_bucket" "demobucket10" {
  bucket = "mytfbucketdevdbakal"
  tags = {
    Name        = "MyBucket"
    Environment = "Prod"
    ManagedBy   = "Terraform"
  }
}


resource "aws_s3_bucket" "demobucket11" {
  bucket = "mytfbucketdevdbakalanasuya"
  tags = {
    Name        = "MyBucket"
    Environment = "Prod"
    ManagedBy   = "Terraform"
    Project     = "Terraform Demo for HCP"
  }
}
