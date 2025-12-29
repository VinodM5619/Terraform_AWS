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