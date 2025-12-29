
# Reference with var. prefix in main.tf
resource "aws_s3_bucket" "demo" {
  bucket = local.bucket_name  # Using input variable
  
  tags = var.tags
}

resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.0.0.0/16"
    tags = var.tags
}

resource "aws_instance" "demo_instance" {
  ami           = "ami-067e50f3c2b7ab990" # Example AMI ID for ap-south-1
  instance_type =  var.allowed_vm_types[3]
  count = var.config.instance_count
  monitoring =  var.config.monitoring
  associate_public_ip_address = var.associate_public_type
  region      = var.config.region

  tags = var.tags
}