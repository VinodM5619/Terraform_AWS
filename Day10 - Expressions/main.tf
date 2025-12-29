resource "aws_instance" "example" {
  ami           = "ami-0ff8a91507f77f867"
  instance_type = var.region=="ap-south-12" ? "t2.micro" : "t3.micro"
  count = var.config.instance_count
  tags = merge(
    var.tags,
    {
      Project = "TerraformDemo"
    }
  )
}
# ==============================================================================
# EXAMPLE 2: DYNAMIC BLOCKS
# ==============================================================================

resource "aws_security_group" "dynamic_sg" {
  name        = "dynamic-sg-${var.environment}"
  description = "Security group with dynamic rules"
  
  # Dynamic block creates multiple ingress rules from a list
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "dynamic-sg-${var.environment}"
  }
}



# ==============================================================================
# EXAMPLE 3: SPLAT EXPRESSIONS
# ==============================================================================
# Uncomment the blocks below to test splat expressions
# This example creates multiple instances and uses splat [*] to extract values
# - Creates 'instance_count' number of instances
# - Extracts all IDs and IPs in a single expression
# ==============================================================================

resource "aws_instance" "splat_example" {
  count = var.config.instance_count
  ami           = "ami-0ff8a91507f77f867"
  instance_type = "t2.micro"
  
  tags = {
    Name = "instance-${count.index + 1}"
  }
}

# Use splat expressions to extract values from all instances
locals {
  # Get all instance IDs in one line using [*]
  all_instance_ids = aws_instance.splat_example[*].id
  
  # Get all private IPs using [*]
  all_private_ips = aws_instance.splat_example[*].private_ip
}