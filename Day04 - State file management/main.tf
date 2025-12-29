terraform {
  backend "s3" {
    bucket       = "newbuckettechtutorial"
    key          = "test/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt      = true
  }
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

resource "aws_s3_bucket" "demobucket1" {
  bucket = "mytfbucketdevdbakal"
  tags = {
    Name        = "MyBucket"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket" "demobucket2" {
  bucket = "mytfbucketdevdbakalanasu"
  tags = {
    Name        = "MyBucket"
    Environment = "Prod"
  }
}
