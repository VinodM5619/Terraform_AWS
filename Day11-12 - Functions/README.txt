Terraform provides a rich set of built‑in functions that let you transform values, perform calculations, and make your configurations dynamic. You cannot define custom functions directly in Terraform, but providers may expose their own functions.

🔑 Overview of Terraform Functions
Functions in Terraform are predefined operations you can call inside expressions. They help you avoid hardcoding values and make your infrastructure code reusable and flexible.
- Syntax:
function_name(arg1, arg2, ...)
- Example: max(5, 12, 9) → returns 12.
- Types of Functions:
- String functions – manipulate text (upper(), lower(), replace(), substr()).
- Numeric functions – perform math (abs(), ceil(), floor(), max(), min()).
- Collection functions – work with lists/maps (length(), concat(), merge(), keys()).
- Encoding functions – convert formats (jsonencode(), base64encode()).
- Filesystem functions – read files (file(), filebase64()).
- Date/time functions – handle timestamps (timestamp(), timeadd()).
- IP/network functions – manage CIDRs (cidrsubnet(), cidrhost()).
- Type conversion functions – cast values (toset(), tolist(), tonumber()).
📋 Examplesvariable "env" {
  default = "dev"
}

resource "aws_instance" "example" {
  ami           = "ami-123456"
  instance_type = var.env == "prod" ? "t3.large" : "t3.micro"

  tags = {
    Name = upper(var.env)         # Converts "dev" → "DEV"
    Index = tostring(count.index) # Converts number to string
  }
}
- upper() ensures consistent capitalization in tags.
- tostring() converts numeric values into strings for labels.
- Conditional expression uses functions to adapt instance type dynamically.
