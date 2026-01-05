# If the S3 bucket already exists and you want to manage it with Terraform, you can use the 'terraform import' command.
# This example assumes you have already created an S3 bucket in AWS console with the name specified in the variable "aws_s3_bucket_name".
# Follow the steps below to import the existing S3 bucket into your Terraform state.
# e.g., if your bucket name is "my-unique-s3-231", you would run:
# terraform import aws_s3_bucket.config_bucket my-unique-s3-231 
# Replace "my-unique-s3-231" with your actual bucket name.
# ------------------------------------------------------------------------------
# First create the S3 bucket in AWS console and same name as in variable "aws_s3_bucket_name". 
# Create resource to manage the existing S3 bucket.
# Then import the existing S3 bucket into Terraform state using the command:
# terraform import aws_s3_bucket.config_bucket <bucket_name>  
# Replace <bucket_name> with the actual bucket name.
# After importing, run 'terraform plan' to see the current state.
# Finally, run 'terraform apply' to manage the imported resource with Terraform.
# ------------------------------------------------------------------------------
# 1. S3 Bucket Resource
# ------------------------------------------------------------------------------


resource "aws_s3_bucket" "config_bucket" {
  bucket = "${var.aws_s3_bucket_name}"
  # key    = "configs/appsettings.json"
  tags = {
    Name        = "${var.aws_s3_bucket_name}-demo-tf-import"
    Environment = "Demo"
    Managed_by  = "Terraform"
  }
} 


# import {
#   to = aws_s3_bucket.config_bucket
#   identity = {
#     bucket = "${var.aws_s3_bucket_name}"
#   }
# }