##############################################################################
# Walmart Internal Developer Portal — Port.io IaC
# 
# This Terraform configuration captures the complete Port.io organization
# setup for Walmart's Internal Developer Portal demo. It provisions:
#   - 5 custom blueprints (Domain, Service, Jira Project, Jira Issue, Security Finding)
#   - 2 scorecards (Production Readiness, Security Posture)
#   - 2 self-service actions (Scaffold New Microservice, Promote to Production)
#   - 62 sample entities across all blueprints
#
# Usage:
#   export PORT_CLIENT_ID="your-port-client-id"
#   export PORT_CLIENT_SECRET="your-port-client-secret"
#   terraform init
#   terraform plan
#   terraform apply
##############################################################################

terraform {
  required_providers {
    port = {
      source  = "port-labs/port-labs"
      version = "~> 2.0"
    }
  }
}

provider "port" {
  client_id = var.port_client_id
  secret    = var.port_client_secret
}

# ---------------------------------------------------------------------------
# Variables
# ---------------------------------------------------------------------------

variable "port_client_id" {
  description = "Port.io client ID"
  type        = string
  sensitive   = true
}

variable "port_client_secret" {
  description = "Port.io client secret"
  type        = string
  sensitive   = true
}

variable "github_org" {
  description = "GitHub organization for self-service action workflows"
  type        = string
  default     = "mike-check-12-12"
}
