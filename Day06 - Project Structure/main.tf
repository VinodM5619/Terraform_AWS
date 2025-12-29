
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