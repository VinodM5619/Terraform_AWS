
locals {
  value = lower(var.project_name)
  value2 = merge(var.tags, var.tags1)
  value3 = replace(upper(replace(substr(var.bucket_name, 11, 6), "bucket", "newbucket")), "NEWBUCKET", "TERAFORM!")
  port_list = split(",", "80,443,22,8080")
  sg_rules = [for port in local.port_list : 
    { name = "rule-${port}"
      port = port
      Description = "Allow inbound traffic on port ${port}"
    } ]
  instance_sizes = lookup(var.instance_sizes,var.environment,"t2.micro")
  concat_strings = concat(var.user_locations, var.default_locations)
  unique_locations = toset(local.concat_strings)
  positive_costs = [for cost in var.monthly_costs : abs(cost) ]
  maximum_cost = max(local.positive_costs...)
  minimum_cost = min(local.positive_costs...)
  total_cost = sum(local.positive_costs)
  average_cost = local.total_cost / length(local.positive_costs)
  current_time = timestamp()
  format1 = formatdate("DD-MM-YYYY", local.current_time)
  format2 = formatdate("YYYY-MM-DD", local.current_time)
  format3 = "backup-${local.format2}"
  config_file_exists = fileexists("config.json")
  config_data = local.config_file_exists ? jsondecode(file("config.json")) : {} 
} 

output "replacing_text" {
  value = replace(local.value, "project alpha resource", "Project BETA Resource")
}
output "merging_tags" {
  value = local.value2
}
output "bucket_name" {
  value = local.value3
}
output "port_list" {
  value = local.port_list
}
output "port_sg_rules" {
  value = local.sg_rules
}
output "instance_sizes" {
  value = local.instance_sizes
}
output "unique_locations" {
  value = local.unique_locations
}
output "positive_costs" {
  value = local.positive_costs
}
output "maximum_cost" {
  value = local.maximum_cost
}
output "minimum_cost" {
  value = local.minimum_cost
}
output "total_cost" {
  value = local.total_cost
}
output "average_cost" {
  value = local.average_cost
}
output "current_time" {
  value = local.current_time
}
output "timestamps" { 
  value = {
    format1 = local.format1
    format2 = local.format2
    format3 = replace(local.format3, "-", "_")
  }
}
output "config_file_exists" {
  value = local.config_file_exists
}
output "config_data" {
  value = local.config_data
}
# output "joined" {
#   value = join("-", ["aws", "terraform", "vinod"])
#   # => "aws-terraform-vinod"
# }
# output "trim_space" {
#   value = trim("   aws-terraform-vinod   ", " ")
# }
# output "trim_letters" {
#   value = trim("   aws-terraform-vinod", "v")
# }
# #It won't tring middle letters.. only start or ending letter

# output "replace_letters" {
#   value = replace("   aws-terraform-vinod", "vinod","kalpana")
# }

# output "merged_map" {
#   value = merge({a = 1}, {b = 2})
#   # => {a = 1, b = 2}
# }

# output "max" {
#   value = max(10,20,5,30,15)
#   #30
# }

# output "substring" {
#   value = substr("terraform",0,4)
#   #30
# }

# output "concatination_lists" {
#   value = concat([1,2,3],[4,5,6])
#   #[1,2,3,4,5,6]
# }

# output "merge_lists" {
#   value = merge({a=1}, {b=2, c=3})
#   #[1,2,3,4,5,6]
# }

# output "toset" {
#   value = toset([1,2,3,4,5])
#   #[1,2,3,4,5]
# }

# output "timeadd" {
#   value = timeadd("2024-01-01T00:00:00Z", "72h")
#   #"2024-01-04T00:00:00Z"
# }

# output "timecmp" {
#   value = timecmp("2024-01-01T00:00:00Z", "2024-01-02T00:00:00Z")
#   #-1
# }

# output "timestamp" { 
#   value = formatdate("DD-MM-YYYY", timestamp())
#   #"2024-01-01T00:00:00Z"
# }
 
# # resource "aws_instance" "example" {
# #   ami           = "ami-0ff8a91507f77f867"
# #   instance_type = var.region=="ap-south-12" ? "t2.micro" : "t3.micro"
# #   count = var.config.instance_count
# #   tags = merge(
# #     var.tags,
# #     {
# #       Project = "TerraformDemo"
# #     }
# #   )
# # }
# # # ==============================================================================
# # # EXAMPLE 2: DYNAMIC BLOCKS
# # # ==============================================================================

# # resource "aws_security_group" "dynamic_sg" {
# #   name        = "dynamic-sg-${var.environment}"
# #   description = "Security group with dynamic rules"
  
# #   # Dynamic block creates multiple ingress rules from a list
# #   dynamic "ingress" {
# #     for_each = var.ingress_rules
# #     content {
# #       from_port   = ingress.value.from_port
# #       to_port     = ingress.value.to_port
# #       protocol    = ingress.value.protocol
# #       cidr_blocks = ingress.value.cidr_blocks
# #       description = ingress.value.description
# #     }
# #   }
  
# #   egress {
# #     from_port   = 0
# #     to_port     = 0
# #     protocol    = "-1"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }
  
# #   tags = {
# #     Name = "dynamic-sg-${var.environment}"
# #   }
# # }



# # # ==============================================================================
# # # EXAMPLE 3: SPLAT EXPRESSIONS
# # # ==============================================================================
# # # Uncomment the blocks below to test splat expressions
# # # This example creates multiple instances and uses splat [*] to extract values
# # # - Creates 'instance_count' number of instances
# # # - Extracts all IDs and IPs in a single expression
# # # ==============================================================================

# # resource "aws_instance" "splat_example" {
# #   count = var.config.instance_count
# #   ami           = "ami-0ff8a91507f77f867"
# #   instance_type = "t2.micro"
  
# #   tags = {
# #     Name = "instance-${count.index + 1}"
# #   }
# # }

# # # Use splat expressions to extract values from all instances
# # locals {
# #   # Get all instance IDs in one line using [*]
# #   all_instance_ids = aws_instance.splat_example[*].id
  
# #   # Get all private IPs using [*]
# #   all_private_ips = aws_instance.splat_example[*].private_ip
# # }