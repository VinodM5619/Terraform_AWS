In Terraform, data sources let you query and retrieve information about existing infrastructure or external systems without creating new resources. They are read‑only and are often used to dynamically fetch values like AMI IDs, subnet IDs, or configuration details from providers.

🔎 What Are Data Sources?
- Definition: A data source in Terraform is a way to pull information from external systems or services (cloud platforms, APIs, or other Terraform workspaces) and use that data in your configuration.
- Key Point: Unlike resources, data sources do not create or modify infrastructure. They only query and return information.

📋 Common Use Cases
- Cloud Images: Fetch the latest Amazon Machine Image (AMI) for EC2.
- Networking: Retrieve subnet IDs, VPC details, or security group rules.
- Identity & Access: Query IAM roles, policies, or user details.
- External Systems: Pull data from APIs, files, or other Terraform workspaces.
- Cross‑Environment Reuse: Share outputs between Terraform projects.

🛠 Example Usage
# Fetch the latest Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
}


- The data "aws_ami" block queries AWS for the latest Ubuntu AMI.
- The aws_instance resource then uses that AMI dynamically.
