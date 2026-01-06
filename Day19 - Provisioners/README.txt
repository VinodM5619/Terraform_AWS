What Are Provisioners?
Provisioners in Terraform are used to execute scripts or commands on a resource after it is created or destroyed. They act as a bridge between Terraform and configuration management tools or ad‑hoc setup tasks.
- They run inside the resource block.
- They’re often used for bootstrapping, installing software, or running configuration scripts.
- Provisioners are considered a last resort—HashiCorp recommends using configuration management tools (like Ansible, Chef, or cloud‑init) instead for long‑term maintainability.

📋 Types of Provisioners
- local-exec
- Runs a command on the machine where Terraform is executed.
- Example: trigger a script, send a notification, or run ansible-playbook.
provisioner "local-exec" {
  command = "echo ${self.public_ip} >> ips.txt"
}
- remote-exec
- Runs commands on the remote resource (via SSH or WinRM).
- Example: install packages or configure a VM.
provisioner "remote-exec" {
  inline = [
    "sudo apt-get update",
    "sudo apt-get install -y nginx"
  ]
}
- file
- Uploads files or directories to the remote resource.
- Example: copy configuration files to a VM.
provisioner "file" {
  source      = "config.cfg"
  destination = "/etc/config.cfg"
}



⚡ Best Practices
- Prefer cloud-init or Ansible: Provisioners should be fallback tools, not your main automation strategy.
- Use null_resource with provisioners: This lets you run provisioners without tying them to a specific resource.
- Handle errors carefully: By default, provisioner failures mark the resource as tainted (forcing recreation).
- Keep them idempotent: Scripts should be safe to run multiple times without breaking.
- Limit scope: Use provisioners for small bootstrap tasks, not full configuration management.
