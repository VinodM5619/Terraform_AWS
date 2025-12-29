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
  default = ["ap-south-1","us-east-1"]
}

variable tags {
  type = map(string)
  default = {
    Name        = "dev"  # Using input variable
    Environment = "dev-instance"  # Using input variable
    created_by = "terraform1"
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


variable "bucket_names" {
   description = "List of bucket names"
   type = list(string)
   default = [ "vinone","kalptwo", "nishithree" ]
}

variable "bucket_name_set" {
   description = "Set of S3 bucket names to created"
   type = set(string)
   default = [ "vinone","kalptwo", "nishithree" ]
}

variable "ingress_rules" {
  description = "List of ingress rules for security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTPS"
    }
  ]
}