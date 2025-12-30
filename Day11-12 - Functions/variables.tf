# Define in variables.tf
variable "environment" {
  type = string
  default = "dev"
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "This is My bucket created on 30th Dec 2025"
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

variable tags1 {
  type = map(string)
  default = {
    App = "Cooke"  # Using input variable
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

variable "project_name" {
  default     = "Project ALPHA Resource"
}

variable "instance_sizes" {
  default = {
    dev = "t2.micro",
    staging = "t2.small",
    prod = "t3.micro"
  }
  type = map(string)
  # validation {
  #   condition     = can(regex("^t[2-3]\\.", var.instance_sizes.dev)) && can(regex("^t[2-3]\\.", var.instance_sizes.staging)) && can(regex("^t[2-3]\\.", var.instance_sizes.prod))
  #   error_message = "All instance sizes must be of type t2.* or t3.*"
  # }
  # validation {
  #   condition     = can(regex("^t[2-3]\\.", var.instance_sizes.dev)) && can(regex("^t[2-3]\\.", var.instance_sizes.staging)) && can(regex("^t[2-3]\\.", var.instance_sizes.prod))
  #   error_message = "All instance sizes must be of type t2.* or t3.*"
  # }
}


variable "monthly_costs" {
  type        = list(number)
  description = "Monthly infrastructure costs (can include negative values for credits)"
  default     = [-50, 100, 75, 200]
}



variable "user_locations" {
  type        = list(string)
  description = "User-specified AWS regions"
  default     = ["us-east-1", "us-west-2", "us-east-1"] # Contains duplicate
}

variable "default_locations" {
  type        = list(string)
  description = "Default AWS regions"
  default     = ["us-west-1"]
}