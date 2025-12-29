# Security Group
resource "aws_security_group" "app_sg" {
  name        = "app-security-group"
  description = "Security group for application servers"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP from anywhere"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS from anywhere"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = var.tags
}


resource aws_instance example {
    ami           = "ami-0ff8a91507f77f867"
    instance_type =  var.allowed_vm_types[0]
    region =  tolist(var.allowed_region)[1]
    #vpc_security_group_ids = [aws_security_group.app_sg.id]
    security_groups = [aws_security_group.app_sg.name]
    
    lifecycle {
        # create_before_destroy = true
        # prevent_destroy = true
        # ignore_changes = [tags]
         postcondition {
           condition     = contains(keys(var.tags), "created_by")
           error_message = "Security group name validation failed"
         }
        #  replace_triggered_by = [ aws_security_group.app_sg.id]
    }

    tags = var.tags
}


# # Launch Template for Auto Scaling Group
# resource "aws_launch_template" "app_server" {
#   name_prefix   = "app-server-"
#   image_id      = aws_instance.example.ami.image_id
#   instance_type = var.allowed_vm_types[2]
# }


# resource "aws_autoscaling_group" "app_servers" {
#   desired_capacity     = var.config.instance_count
#   max_size             = 3
#   min_size             = 1
#   launch_template {
#     id      = aws_launch_template.app_server.image_id
#     version = "$Latest"
#   }
#   lifecycle {    
#     ignore_changes = [desired_capacity]
#   }
# }