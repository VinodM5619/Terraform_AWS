Terraform variables are a way to parameterize your configuration so you can reuse code across environments and make it more flexible. Instead of hardcoding values (like instance types, regions, or AMI IDs), you define variables and pass values at runtime.

🔑 Types of Variables in Terraform
Terraform supports several variable types:
- String → plain text values
- Number → integers or floats
- Bool → true/false values
- List → ordered collection of values
- Map → key-value pairs
- Object → complex structured values
- Tuple → fixed-length collections with mixed types

📂 Declaring Variables
You declare variables in a variables.tf file:
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}



⚙️ Using Variables
Reference them in your resources:
provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
}



📥 Supplying Variable Values
You can provide values in multiple ways:
- Default values (inside variables.tf)
- Command line flags
terraform apply -var="instance_type=t3.micro"
- Variable definition files (terraform.tfvars or *.auto.tfvars)
instance_type = "t3.large"
- Environment variables (TF_VAR_<variable_name>)
export TF_VAR_instance_type=t3.medium



🧩 Best Practices
- Use descriptive names (e.g., db_password, not var1).
- Provide defaults for common values, but require explicit input for sensitive ones.
- Mark sensitive variables with sensitive = true to hide them in logs.
- Group variables logically (networking, compute, database).
- Use locals for derived values to avoid repeating expressions.

✅ Real-World Example
For multi-environment deployments (dev/stage/prod), you can define variables like:
variable "env" {
  description = "Environment name"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}


Then supply different values via dev.tfvars, stage.tfvars, prod.tfvars to reuse the same Terraform code across environments.
