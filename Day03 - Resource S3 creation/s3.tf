
resource "aws_s3_bucket" "demobucket1" {
  bucket = "mytfbucketdevdbakal"
  tags = {
    Name        = "MyBucket"
    Environment = "Prod"
  }
}

