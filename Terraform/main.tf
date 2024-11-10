terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "2.25.0"
    }
  }
}

provider "linode" {
  token = var.linodeToken
}

# create a Linode instance
resource "linode_instance" "flask_app" {
  count      = length(data.linode_instance.existing_instance) == 0 ? 1 : 0
  label      = "flask-app-instance"
  region     = "it-mil"                   # Choose the Linode region (example: us-east)
  type       = "g6-nanode-1"              # Linode instance type
  image      = "linode/ubuntu24.04"       # Base image (Ubuntu 20.04)
  root_pass  = var.rootPass               # Root password for the instance
  tags       = ["flask", "github-webhook"] # Tags for identifying the instance
  authorized_keys = [var.sshKey]          # SSH key for access
  lifecycle {
    prevent_destroy = true  # Prevent accidental destruction of the instance
  }
}



# GitHub provider for creating the Webhook
provider "github" {
  token = var.githubToken
}

# GitHub Webhook creation
resource "github_repository_webhook" "webhook" {
  repository = "push-event-logger"  # Name of the GitHub repository
  configuration {
    url          = "http://${linode_instance.flask_app.ip_address}:3000/webhook"  # Flask app URL
    content_type = "json"
    # secret       = var.webhookSecret        # Webhook secret for security
    insecure_ssl = false                     # Ensure SSL is used (set to true if testing locally)
  }

  events = ["push"]  # Trigger webhook on push events
}