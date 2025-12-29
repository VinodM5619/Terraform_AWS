terraform {
  backend "s3" {
    bucket       = "mytfbucketdevdbavin"
    key          = "dev/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt      = true
  }
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
provider "aws" {
  region = "ap-south-1"
}
/*
resource "aws_s3_bucket" "demobucket" {
  bucket = "mytfbucketdevdbavin"
  tags = {
    Name        = "MyBucket"
    Environment = "Prod"
  }
}

*/