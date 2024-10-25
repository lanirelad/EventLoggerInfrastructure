# Output the public IP of the Linode instance
output "linode_public_ip" {
  description = "The public IP address of the Linode instance."
  value       = linode_instance.flask_app.ip_address
}

output "linode_instance_id" {
  description = "The ID of the created Linode instance."
  value       = linode_instance.flask_app.id
}

output "linode_instance_label" {
  description = "The label of the created Linode instance."
  value       = linode_instance.flask_app.label
}

output "linode_instance_region" {
  description = "The region of the created Linode instance."
  value       = linode_instance.flask_app.region
}

output "linode_instance_status" {
  description = "The current status of the created Linode instance."
  value       = linode_instance.flask_app.status
}