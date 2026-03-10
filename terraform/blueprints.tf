##############################################################################
# Blueprints — Schema layer for Walmart's software catalog
##############################################################################

# ── Domain ──────────────────────────────────────────────────────────────────
resource "port_blueprint" "domain" {
  identifier  = "domain"
  title       = "Domain"
  icon        = "Organization"
  description = "Business domain grouping related services"

  properties = {
    string_props = {
      "description" = {
        title = "Description"
      }
      "slack_channel" = {
        title = "Slack Channel"
      }
      "vp_owner" = {
        title = "VP Owner"
      }
    }
  }
}

# ── Service ─────────────────────────────────────────────────────────────────
resource "port_blueprint" "service" {
  identifier  = "service"
  title       = "Service"
  icon        = "Microservice"
  description = "A microservice in the Walmart platform"

  properties = {
    string_props = {
      "tier" = {
        title       = "Tier"
        enum        = ["Tier 1 - Critical", "Tier 2 - Standard", "Tier 3 - Internal"]
        enum_colors = {
          "Tier 1 - Critical" = "turquoise"
          "Tier 2 - Standard" = "green"
          "Tier 3 - Internal" = "blue"
        }
      }
      "lifecycle" = {
        title       = "Lifecycle"
        enum        = ["Production", "Development", "Deprecated", "Beta"]
        enum_colors = {
          "Production"  = "green"
          "Development" = "orange"
          "Deprecated"  = "red"
          "Beta"        = "purple"
        }
      }
      "primary_language" = {
        title       = "Primary Language"
        enum        = ["Java", "Go", "Python", "TypeScript", "Rust", "Kotlin"]
        enum_colors = {
          "Java"       = "red"
          "Go"         = "turquoise"
          "Python"     = "darkGray"
          "TypeScript" = "blue"
          "Rust"       = "orange"
          "Kotlin"     = "green"
        }
      }
      "on_call" = {
        title = "On-Call"
      }
      "slack_channel" = {
        title = "Slack Channel"
      }
    }
    boolean_props = {
      "has_monitoring" = {
        title = "Has Monitoring"
      }
      "has_runbook" = {
        title = "Has Runbook"
      }
    }
    number_props = {
      "test_coverage" = {
        title = "Test Coverage %"
      }
      "critical_vulns" = {
        title = "Critical Vulnerabilities"
      }
    }
  }

  relations = {
    "domain" = {
      title    = "Domain"
      target   = port_blueprint.domain.identifier
      required = false
      many     = false
    }
  }
}

# ── Jira Project ────────────────────────────────────────────────────────────
resource "port_blueprint" "jira_project" {
  identifier  = "jiraProject"
  title       = "Jira Project"
  icon        = "Jira"
  description = "Jira project tracking engineering work"

  properties = {
    string_props = {
      "key" = {
        title = "Project Key"
      }
      "lead" = {
        title = "Project Lead"
      }
      "project_type" = {
        title = "Project Type"
        enum  = ["software", "service_desk", "business"]
      }
      "url" = {
        title  = "URL"
        format = "url"
      }
    }
    number_props = {
      "issue_count" = {
        title = "Issue Count"
      }
    }
  }
}

# ── Jira Issue ──────────────────────────────────────────────────────────────
resource "port_blueprint" "jira_issue" {
  identifier  = "jiraIssue"
  title       = "Jira Issue"
  icon        = "Jira"
  description = "Individual Jira tickets and issues"

  properties = {
    string_props = {
      "status" = {
        title       = "Status"
        enum        = ["To Do", "In Progress", "In Review", "Done"]
        enum_colors = {
          "To Do"       = "blue"
          "In Progress" = "orange"
          "In Review"   = "purple"
          "Done"        = "green"
        }
      }
      "priority" = {
        title       = "Priority"
        enum        = ["Critical", "High", "Medium", "Low"]
        enum_colors = {
          "Critical" = "red"
          "High"     = "orange"
          "Medium"   = "yellow"
          "Low"      = "green"
        }
      }
      "issue_type" = {
        title       = "Issue Type"
        enum        = ["Bug", "Story", "Task", "Epic", "Incident"]
        enum_colors = {
          "Bug"      = "red"
          "Story"    = "blue"
          "Task"     = "green"
          "Epic"     = "purple"
          "Incident" = "orange"
        }
      }
      "assignee" = {
        title = "Assignee"
      }
      "created" = {
        title  = "Created"
        format = "date-time"
      }
      "url" = {
        title  = "URL"
        format = "url"
      }
    }
  }

  relations = {
    "jiraProject" = {
      title    = "Jira Project"
      target   = port_blueprint.jira_project.identifier
      required = false
      many     = false
    }
    "service" = {
      title    = "Service"
      target   = port_blueprint.service.identifier
      required = false
      many     = false
    }
  }
}

# ── Security Finding ───────────────────────────────────────────────────────
resource "port_blueprint" "security_finding" {
  identifier  = "securityFinding"
  title       = "Security Finding"
  icon        = "Alert"
  description = "Vulnerability or security finding from scanning tools"

  properties = {
    string_props = {
      "severity" = {
        title       = "Severity"
        enum        = ["Critical", "High", "Medium", "Low"]
        enum_colors = {
          "Critical" = "red"
          "High"     = "orange"
          "Medium"   = "yellow"
          "Low"      = "green"
        }
      }
      "status" = {
        title       = "Status"
        enum        = ["Open", "In Progress", "Fixed", "Accepted"]
        enum_colors = {
          "Open"        = "red"
          "In Progress" = "orange"
          "Fixed"       = "green"
          "Accepted"    = "blue"
        }
      }
      "source" = {
        title = "Source"
        enum  = ["Dependabot", "CodeScanning", "Snyk"]
      }
      "cve_id" = {
        title = "CVE ID"
      }
      "package" = {
        title = "Package"
      }
      "found_date" = {
        title  = "Found Date"
        format = "date-time"
      }
    }
    boolean_props = {
      "fix_available" = {
        title = "Fix Available"
      }
    }
  }

  relations = {
    "service" = {
      title    = "Service"
      target   = port_blueprint.service.identifier
      required = false
      many     = false
    }
  }
}
