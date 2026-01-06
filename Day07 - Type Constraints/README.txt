What Are Type Constraints?
- A type constraint is an optional declaration on a variable that restricts the type of value it can take.
- If a value doesn’t match the type, Terraform will throw an error during plan or apply.
- This ensures consistency across environments and prevents misconfiguration.

📋 Supported Types
Terraform supports both primitive types and complex types:
Primitive Types
- string → text values
- number → integers or floats
- bool → true/false
Complex Types
- list(<TYPE>) → ordered collection of values of the same type
- map(<TYPE>) → key-value pairs with values of the same type
- set(<TYPE>) → unordered collection of unique values
- object({ key = type, ... }) → structured collection with named attributes
- tuple([type1, type2, ...]) → fixed-length collection with mixed types

🧩 Examples
String Constraint
variable "region" {
  type        = string
  default     = "us-east-1"
}


List of Strings
variable "availability_zones" {
  type = list(string)
}


Map of Numbers
variable "instance_counts" {
  type = map(number)
}


Object
variable "db_config" {
  type = object({
    name     = string
    port     = number
    username = string
    password = string
  })
}


Tuple
variable "mixed_values" {
  type = tuple([string, number, bool])
}



⚡ Best Practices
- Always define types for clarity and validation.
- Use objects for structured configs (e.g., DB settings).
- Use maps/lists for scalable infra (e.g., multiple AZs, instance types).
- Mark sensitive variables with sensitive = true to hide them in logs.
- Combine with validation blocks for custom rules (e.g., enforce region choices).

✅ Real-World Example
For multi-environment pipelines, you might define:
variable "env_config" {
  type = object({
    env            = string
    instance_type  = string
    enable_monitor = bool
  })
}


Then pass different values via dev.tfvars, stage.tfvars, prod.tfvars to reuse the same Terraform code safely across environments.
