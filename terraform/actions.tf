##############################################################################
# Self-Service Actions — Developer workflows triggered from the portal
##############################################################################

# ── Scaffold New Microservice (CREATE) ──────────────────────────────────────
resource "port_action" "scaffold_new_microservice" {
  identifier  = "scaffold_new_microservice"
  title       = "Scaffold New Microservice"
  icon        = "Microservice"
  description = "Create a new microservice repository with standardized project structure, CI/CD pipeline, Kubernetes manifests, and automatic catalog registration."

  self_service_trigger {
    operation            = "CREATE"
    blueprint_identifier = port_blueprint.service.identifier

    user_properties {
      string_props = {
        "service_name" = {
          title       = "Service Name"
          description = "Name of the new microservice (lowercase, hyphens only)"
          pattern     = "^[a-z][a-z0-9-]*$"
          required    = true
        }
        "domain" = {
          title       = "Business Domain"
          description = "Business domain this service belongs to"
          enum        = ["retail", "supply-chain", "financial-services", "customer-experience", "infrastructure"]
          required    = true
        }
        "team" = {
          title       = "Owning Team"
          description = "Team that will own this service"
          enum        = ["platform-engineering", "checkout-squad", "inventory-team", "payment-processing", "search-discovery", "sre-core", "security-engineering", "customer-analytics-team"]
          required    = true
        }
        "language" = {
          title    = "Primary Language"
          enum     = ["Java", "Go", "Python", "TypeScript", "Rust", "Kotlin"]
          required = true
        }
        "tier" = {
          title    = "Service Tier"
          enum     = ["Tier 1 - Critical", "Tier 2 - Standard", "Tier 3 - Internal"]
          required = true
        }
      }
    }

    required_jq_query = "true"
    order             = ["service_name", "domain", "team", "language", "tier"]
  }

  github_method {
    org                    = var.github_org
    repo                   = "service-scaffolder"
    workflow               = "scaffold-service.yml"
    report_workflow_status = true
    workflow_inputs = jsonencode({
      service_name = "{{ .inputs.service_name }}"
      domain       = "{{ .inputs.domain }}"
      team         = "{{ .inputs.team }}"
      language     = "{{ .inputs.language }}"
      tier         = "{{ .inputs.tier }}"
      port_run_id  = "{{ .run.id }}"
    })
  }
}

# ── Promote to Production (DAY-2) ──────────────────────────────────────────
resource "port_action" "promote_to_production" {
  identifier  = "promote_to_production"
  title       = "Promote to Production"
  icon        = "Rocket"
  description = "Update a service's lifecycle to Production and ensure monitoring and runbooks are enabled."

  self_service_trigger {
    operation            = "DAY-2"
    blueprint_identifier = port_blueprint.service.identifier

    user_properties {}

    required_jq_query = "true"
  }

  github_method {
    org                    = var.github_org
    repo                   = "service-scaffolder"
    workflow               = "promote-service.yml"
    report_workflow_status = true
    workflow_inputs = jsonencode({
      service_name = "{{ .entity.identifier }}"
      port_run_id  = "{{ .run.id }}"
    })
  }
}
