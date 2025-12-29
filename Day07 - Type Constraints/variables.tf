# Define in variables.tf
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "staging"
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "mytfbucketondayfive"
}
variable "region" {     
  description = "AWS region" 
  type        = string
  default     = "ap-south-1"
  
}

variable "monitoring" { 
  type = bool
  default = false
}

variable "associate_public_type" { 
  type = bool
  default = false
}

variable "allowed_vm_types" {
   description = "List of allowed VM types"
   type = list(string)
   default = [ "t2.micro","t2.small","t3.micro","t3.small" ]
}

variable "allowed_region" {
  description = "List of allowed regions"
  type = set(string)
  default = ["ap-south-1","ap-south-1","us-east-1"]
}

variable tags {
  type = map(string)
  default = {
    Name        = "dev"  # Using input variable
    Environment = "dev-instance"  # Using input variable
    created_by = "terraform"
  }
}

variable "ingress_values" {
  type = tuple([ number,string,number ])
  default = [443, "tcp", 443 ]
}

variable "config" {
  type = object({
    region = string,
    monitoring = bool
    instance_count = number
  })
  default = ({
    region = "us-east-1"
    monitoring = true,
    instance_count = 1   
  })
}
