# Define in variables.tf
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "staging"
}

variable "region" {     
  description = "AWS region" 
  type        = string
  default     = "ap-south-1"
  
}