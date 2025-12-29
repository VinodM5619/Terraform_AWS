 terraform {
    required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
 }


locals {
  bucket_name = "${var.bucket_name}"
  environment = "${var.environment}"
  region      = "${var.region}"
}
 

# Reference with var. prefix in main.tf
resource "aws_s3_bucket" "demo" {
  bucket = local.bucket_name  # Using input variable
  
  tags = {
    Environment = local.environment  # Using input variable

  }
}

resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.0.0.0/16"
    tags = {
        Name        = "demo-vpc-${local.environment}"  # Using input variable
        Environment = local.environment  # Using input variable
        region      = local.region      # Using input variable
    }
}

resource "aws_instance" "demo_instance" {
  ami           = "ami-067e50f3c2b7ab990" # Example AMI ID for ap-south-1
  instance_type = "t2.micro"

  tags = {
    Name        = "demo-instance-${local.environment}"  # Using input variable
    Environment = local.environment  # Using input variable
    region      = local.region      # Using input variable
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.demo.bucket
}

output "vpc_id" {
  value = aws_vpc.demo_vpc.id
}

output "instance_id" {
  value = aws_instance.demo_instance.id
}

provider "aws" {
  region = local.region
}

