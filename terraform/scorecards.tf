##############################################################################
# Scorecards — Quality gates for service maturity
##############################################################################

# ── Production Readiness ────────────────────────────────────────────────────
resource "port_scorecard" "production_readiness" {
  identifier = "production_readiness"
  title      = "Production Readiness"
  blueprint  = port_blueprint.service.identifier

  rules {
    identifier  = "has_oncall"
    title       = "Has On-Call Contact"
    description = "Service has an on-call contact assigned for incident response"
    level       = "Bronze"

    query {
      combinator = "and"
      conditions = [jsonencode({
        property = "on_call"
        operator = "isNotEmpty"
      })]
    }
  }

  rules {
    identifier  = "has_slack"
    title       = "Has Slack Channel"
    description = "Service has a Slack channel for team communication"
    level       = "Bronze"

    query {
      combinator = "and"
      conditions = [jsonencode({
        property = "slack_channel"
        operator = "isNotEmpty"
      })]
    }
  }

  rules {
    identifier  = "has_monitoring_check"
    title       = "Monitoring Configured"
    description = "Service has monitoring and alerting configured"
    level       = "Silver"

    query {
      combinator = "and"
      conditions = [jsonencode({
        property = "has_monitoring"
        operator = "="
        value    = true
      })]
    }
  }

  rules {
    identifier  = "has_runbook_check"
    title       = "Has Runbook"
    description = "Service has an operational runbook for incident response"
    level       = "Silver"

    query {
      combinator = "and"
      conditions = [jsonencode({
        property = "has_runbook"
        operator = "="
        value    = true
      })]
    }
  }

  rules {
    identifier  = "test_coverage_check"
    title       = "Test Coverage >= 80%"
    description = "Service has test coverage above 80%"
    level       = "Gold"

    query {
      combinator = "and"
      conditions = [jsonencode({
        property = "test_coverage"
        operator = ">="
        value    = 80
      })]
    }
  }

  rules {
    identifier  = "low_critical_vulns"
    title       = "Critical Vulns < 3"
    description = "Service has fewer than 3 critical vulnerabilities"
    level       = "Gold"

    query {
      combinator = "and"
      conditions = [jsonencode({
        property = "critical_vulns"
        operator = "<"
        value    = 3
      })]
    }
  }
}

# ── Security Posture ────────────────────────────────────────────────────────
resource "port_scorecard" "security_posture" {
  identifier = "security_posture"
  title      = "Security Posture"
  blueprint  = port_blueprint.service.identifier

  rules {
    identifier  = "not_deprecated"
    title       = "Not Deprecated"
    description = "Service lifecycle is not deprecated"
    level       = "Bronze"

    query {
      combinator = "and"
      conditions = [jsonencode({
        property = "lifecycle"
        operator = "!="
        value    = "Deprecated"
      })]
    }
  }

  rules {
    identifier  = "security_monitoring"
    title       = "Security Monitoring Active"
    description = "Service has monitoring to detect security incidents"
    level       = "Bronze"

    query {
      combinator = "and"
      conditions = [jsonencode({
        property = "has_monitoring"
        operator = "="
        value    = true
      })]
    }
  }

  rules {
    identifier  = "zero_critical"
    title       = "Zero Critical Vulns"
    description = "Service has zero critical vulnerabilities"
    level       = "Silver"

    query {
      combinator = "and"
      conditions = [jsonencode({
        property = "critical_vulns"
        operator = "<="
        value    = 0
      })]
    }
  }

  rules {
    identifier  = "security_oncall"
    title       = "Security On-Call"
    description = "Service has an on-call for rapid security incident response"
    level       = "Silver"

    query {
      combinator = "and"
      conditions = [jsonencode({
        property = "on_call"
        operator = "isNotEmpty"
      })]
    }
  }

  rules {
    identifier  = "high_coverage"
    title       = "Test Coverage >= 85%"
    description = "Service has test coverage above 85% for security-critical code"
    level       = "Gold"

    query {
      combinator = "and"
      conditions = [jsonencode({
        property = "test_coverage"
        operator = ">="
        value    = 85
      })]
    }
  }

  rules {
    identifier  = "security_runbook"
    title       = "Security Runbook"
    description = "Service has operational runbook for security incident handling"
    level       = "Gold"

    query {
      combinator = "and"
      conditions = [jsonencode({
        property = "has_runbook"
        operator = "="
        value    = true
      })]
    }
  }
}
