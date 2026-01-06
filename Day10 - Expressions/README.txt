Terraform expressions are the building blocks that let you compute values dynamically in your configuration. They allow you to reference resources, perform arithmetic, apply conditional logic, and use built-in functions to make your infrastructure code flexible and reusable.

🔎 What Are Terraform Expressions?
Expressions in Terraform are snippets of code that evaluate to a value. They can be simple (like a string or number) or complex (like a function call or conditional logic). You use them in resource arguments, variables, outputs, and anywhere Terraform expects a value.
Key Types of Expressions
- Literal Values
- Strings: "hello", "world"
- Numbers: 42, 3.14
- Booleans: true, false
- References
- Access values from resources, variables, or data sources.
- Example: aws_instance.example.id or var.instance_type
- Arithmetic & Logical Operations
- Perform calculations: 5 + 3, count.index % 2 == 0
- Combine conditions: var.enabled && var.is_production
- Conditional Expressions
- Ternary-style logic: var.env == "prod" ? "t3.large" : "t3.micro"
- For Expressions
- Transform collections into new lists/maps.
- Example:
[for s in var.subnets : aws_subnet[s].id]
- Splat Expressions
- Shortcut for extracting attributes from multiple resources.
- Example: aws_instance.example[*].id
- Built-in Functions
- Terraform provides many functions for string manipulation, math, collections, and more.
- Example: upper(var.name), length(var.list), join(",", var.tags)

📋 Example Usage
variable "env" {
  default = "dev"
}

resource "aws_instance" "example" {
  ami           = "ami-123456"
  instance_type = var.env == "prod" ? "t3.large" : "t3.micro"
  tags = {
    Name = "${upper(var.env)}-server"
  }
}


- Conditional Expression chooses instance size based on environment.
- Function Expression (upper) capitalizes the environment name for tags.

⚡ Best Practices
- Keep expressions simple: Avoid deeply nested logic; use locals for readability.
- Use functions wisely: Built-in functions reduce duplication and improve clarity.
- Prefer references over hardcoding: Makes configurations reusable across environments.
- Document complex expressions: Especially when using for or splat constructs.
