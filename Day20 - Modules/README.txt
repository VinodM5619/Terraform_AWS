What Are Modules?
- A module in Terraform is a container for multiple resources that are used together.
- It’s essentially a reusable blueprint: instead of repeating resource definitions, you package them into a module and call it wherever needed.
- Modules can be:
- Root module → the main entry point (your project).
- Child modules → reusable components, either local or remote.
- Public modules → shared via the Terraform Registry.

📋 Why Use Modules?
- Reusability → Define once, use across dev/stage/prod.
- Consistency → Enforce standards and compliance.
- Abstraction → Hide complexity, expose only variables/outputs.
- Scalability → Easier to manage large infrastructures.
- Auditability → Centralize logic for governance.

🛠 Example: Local Module
Folder structure:
project/
├── main.tf
├── variables.tf
├── outputs.tf
└── modules/
    └── ec2/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf


Calling the module:
module "web_server" {
  source        = "./modules/ec2"
  instance_type = "t3.micro"
  ami_id        = "ami-123456"
}


Inside modules/ec2/main.tf:
resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = "web-server"
  }
}



📊 Modules vs Resources
|  |  |  | 
|  |  |  | 
|  |  |  | 
|  |  |  | 
|  | aws_instance | module "ec2" | 



⚡ Best Practices
- Use versioning for remote modules (e.g., source = "git::https://...//?ref=v1.0.0").
- Keep modules small & focused (e.g., one for EC2, one for networking).
- Expose only necessary variables/outputs to avoid tight coupling.
- Document inputs/outputs for team clarity.
- Test modules independently before integrating into pipelines.
- Registry modules → leverage community modules for common infra (VPC, subnets, security groups).
