terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

}

provider "aws" {
  shared_config_files      = ["/home/vinod/.aws/config"]
  shared_credentials_files = ["/home/vinod/.aws/credentials"]
  profile                  = "default"
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/24"
}


