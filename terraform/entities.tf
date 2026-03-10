##############################################################################
# Entities — Realistic sample data for Walmart's software catalog
##############################################################################

# ═══════════════════════════════════════════════════════════════════════════
# DOMAINS (5)
# ═══════════════════════════════════════════════════════════════════════════

locals {
  domains = {
    "retail" = {
      title         = "Retail & Commerce"
      description   = "Customer-facing retail platform including product discovery, cart, checkout, and order management"
      slack_channel = "#domain-retail"
      vp_owner      = "Sarah Chen"
    }
    "supply-chain" = {
      title         = "Supply Chain & Logistics"
      description   = "End-to-end supply chain management from procurement through last-mile delivery"
      slack_channel = "#domain-supply-chain"
      vp_owner      = "James Rodriguez"
    }
    "financial-services" = {
      title         = "Financial Services"
      description   = "Payment processing, fraud detection, tax compliance, and financial reporting"
      slack_channel = "#domain-finserv"
      vp_owner      = "Priya Patel"
    }
    "customer-experience" = {
      title         = "Customer Experience"
      description   = "Personalization, recommendations, loyalty programs, and customer analytics"
      slack_channel = "#domain-cx"
      vp_owner      = "Michael Thompson"
    }
    "infrastructure" = {
      title         = "Platform & Infrastructure"
      description   = "Shared platform services, developer tools, observability, and security infrastructure"
      slack_channel = "#domain-platform"
      vp_owner      = "David Kim"
    }
  }
}

resource "port_entity" "domain" {
  for_each   = local.domains
  identifier = each.key
  title      = each.value.title
  blueprint  = port_blueprint.domain.identifier

  properties = {
    string_props = {
      "description"   = each.value.description
      "slack_channel" = each.value.slack_channel
      "vp_owner"      = each.value.vp_owner
    }
  }
}

# ═══════════════════════════════════════════════════════════════════════════
# SERVICES (32)
# ═══════════════════════════════════════════════════════════════════════════

locals {
  services = {
    # ── Retail Domain ─────────────────────────────────────────────────────
    "cart-service" = {
      title            = "Cart Service"
      tier             = "Tier 1 - Critical"
      lifecycle        = "Production"
      primary_language = "Java"
      on_call          = "@checkout-oncall"
      slack_channel    = "#svc-cart"
      has_monitoring   = true
      has_runbook      = true
      test_coverage    = 92
      critical_vulns   = 0
      domain           = "retail"
    }
    "checkout-api" = {
      title            = "Checkout API"
      tier             = "Tier 1 - Critical"
      lifecycle        = "Production"
      primary_language = "Java"
      on_call          = "@checkout-oncall"
      slack_channel    = "#svc-checkout"
      has_monitoring   = true
      has_runbook      = true
      test_coverage    = 88
      critical_vulns   = 1
      domain           = "retail"
    }
    "product-catalog" = {
      title            = "Product Catalog"
      tier             = "Tier 1 - Critical"
      lifecycle        = "Production"
      primary_language = "Java"
      on_call          = "@catalog-oncall"
      slack_channel    = "#svc-catalog"
      has_monitoring   = true
      has_runbook      = false
      test_coverage    = 78
      critical_vulns   = 2
      domain           = "retail"
    }
    "price-engine" = {
      title            = "Price Engine"
      tier             = "Tier 1 - Critical"
      lifecycle        = "Production"
      primary_language = "Go"
      on_call          = "@pricing-oncall"
      slack_channel    = "#svc-pricing"
      has_monitoring   = true
      has_runbook      = true
      test_coverage    = 95
      critical_vulns   = 0
      domain           = "retail"
    }
    "search-service" = {
      title            = "Search Service"
      tier             = "Tier 1 - Critical"
      lifecycle        = "Production"
      primary_language = "Go"
      on_call          = "@search-oncall"
      slack_channel    = "#svc-search"
      has_monitoring   = true
      has_runbook      = true
      test_coverage    = 85
      critical_vulns   = 0
      domain           = "retail"
    }
    "recommendation-engine" = {
      title            = "Recommendation Engine"
      tier             = "Tier 2 - Standard"
      lifecycle        = "Production"
      primary_language = "Python"
      on_call          = "@ml-oncall"
      slack_channel    = "#svc-reco"
      has_monitoring   = true
      has_runbook      = false
      test_coverage    = 62
      critical_vulns   = 3
      domain           = "retail"
    }

    # ── Supply Chain Domain ───────────────────────────────────────────────
    "warehouse-management" = {
      title            = "Warehouse Management"
      tier             = "Tier 1 - Critical"
      lifecycle        = "Production"
      primary_language = "Java"
      on_call          = "@warehouse-oncall"
      slack_channel    = "#svc-warehouse"
      has_monitoring   = true
      has_runbook      = true
      test_coverage    = 75
      critical_vulns   = 0
      domain           = "supply-chain"
    }
    "inventory-sync" = {
      title            = "Inventory Sync"
      tier             = "Tier 1 - Critical"
      lifecycle        = "Production"
      primary_language = "Java"
      on_call          = "@inventory-oncall"
      slack_channel    = "#svc-inventory"
      has_monitoring   = true
      has_runbook      = true
      test_coverage    = 82
      critical_vulns   = 1
      domain           = "supply-chain"
    }
    "order-fulfillment" = {
      title            = "Order Fulfillment"
      tier             = "Tier 1 - Critical"
      lifecycle        = "Production"
      primary_language = "Java"
      on_call          = "@fulfillment-oncall"
      slack_channel    = "#svc-fulfillment"
      has_monitoring   = true
      has_runbook      = true
      test_coverage    = 80
      critical_vulns   = 2
      domain           = "supply-chain"
    }
    "shipping-calculator" = {
      title            = "Shipping Calculator"
      tier             = "Tier 2 - Standard"
      lifecycle        = "Production"
      primary_language = "Go"
      on_call          = "@logistics-oncall"
      slack_channel    = "#svc-shipping"
      has_monitoring   = true
      has_runbook      = false
      test_coverage    = 71
      critical_vulns   = 0
      domain           = "supply-chain"
    }
    "supply-chain-tracker" = {
      title            = "Supply Chain Tracker"
      tier             = "Tier 2 - Standard"
      lifecycle        = "Development"
      primary_language = "Python"
      on_call          = null
      slack_channel    = "#svc-sc-tracker"
      has_monitoring   = false
      has_runbook      = false
      test_coverage    = 35
      critical_vulns   = 4
      domain           = "supply-chain"
    }
    "demand-forecasting" = {
      title            = "Demand Forecasting"
      tier             = "Tier 2 - Standard"
      lifecycle        = "Beta"
      primary_language = "Python"
      on_call          = "@ml-oncall"
      slack_channel    = "#svc-forecast"
      has_monitoring   = true
      has_runbook      = false
      test_coverage    = 58
      critical_vulns   = 1
      domain           = "supply-chain"
    }

    # ── Financial Services Domain ─────────────────────────────────────────
    "payment-gateway" = {
      title            = "Payment Gateway"
      tier             = "Tier 1 - Critical"
      lifecycle        = "Production"
      primary_language = "Java"
      on_call          = "@payments-oncall"
      slack_channel    = "#svc-payments"
      has_monitoring   = true
      has_runbook      = true
      test_coverage    = 96
      critical_vulns   = 0
      domain           = "financial-services"
    }
    "tax-calculator" = {
      title            = "Tax Calculator"
      tier             = "Tier 1 - Critical"
      lifecycle        = "Production"
      primary_language = "Java"
      on_call          = "@finserv-oncall"
      slack_channel    = "#svc-tax"
      has_monitoring   = true
      has_runbook      = true
      test_coverage    = 94
      critical_vulns   = 0
      domain           = "financial-services"
    }
    "fraud-detection" = {
      title            = "Fraud Detection"
      tier             = "Tier 1 - Critical"
      lifecycle        = "Production"
      primary_language = "Python"
      on_call          = "@fraud-oncall"
      slack_channel    = "#svc-fraud"
      has_monitoring   = true
      has_runbook      = true
      test_coverage    = 90
      critical_vulns   = 0
      domain           = "financial-services"
    }
    "subscription-manager" = {
      title            = "Subscription Manager"
      tier             = "Tier 2 - Standard"
      lifecycle        = "Beta"
      primary_language = "TypeScript"
      on_call          = "@finserv-oncall"
      slack_channel    = "#svc-subscriptions"
      has_monitoring   = true
      has_runbook      = false
      test_coverage    = 68
      critical_vulns   = 1
      domain           = "financial-services"
    }
    "gift-card-service" = {
      title            = "Gift Card Service"
      tier             = "Tier 2 - Standard"
      lifecycle        = "Production"
      primary_language = "Java"
      on_call          = null
      slack_channel    = "#svc-giftcards"
      has_monitoring   = false
      has_runbook      = false
      test_coverage    = 42
      critical_vulns   = 6
      domain           = "financial-services"
    }
    "returns-processor" = {
      title            = "Returns Processor"
      tier             = "Tier 2 - Standard"
      lifecycle        = "Production"
      primary_language = "Kotlin"
      on_call          = "@returns-oncall"
      slack_channel    = "#svc-returns"
      has_monitoring   = true
      has_runbook      = false
      test_coverage    = 55
      critical_vulns   = 3
      domain           = "financial-services"
    }

    # ── Customer Experience Domain ────────────────────────────────────────
    "personalization-engine" = {
      title            = "Personalization Engine"
      tier             = "Tier 2 - Standard"
      lifecycle        = "Production"
      primary_language = "Python"
      on_call          = "@ml-oncall"
      slack_channel    = "#svc-personalization"
      has_monitoring   = true
      has_runbook      = false
      test_coverage    = 65
      critical_vulns   = 1
      domain           = "customer-experience"
    }
    "notification-service" = {
      title            = "Notification Service"
      tier             = "Tier 2 - Standard"
      lifecycle        = "Production"
      primary_language = "Go"
      on_call          = "@notifications-oncall"
      slack_channel    = "#svc-notifications"
      has_monitoring   = true
      has_runbook      = true
      test_coverage    = 88
      critical_vulns   = 0
      domain           = "customer-experience"
    }
    "customer-analytics" = {
      title            = "Customer Analytics"
      tier             = "Tier 2 - Standard"
      lifecycle        = "Production"
      primary_language = "Python"
      on_call          = "@analytics-oncall"
      slack_channel    = "#svc-analytics"
      has_monitoring   = true
      has_runbook      = false
      test_coverage    = 60
      critical_vulns   = 2
      domain           = "customer-experience"
    }
    "loyalty-service" = {
      title            = "Loyalty Service"
      tier             = "Tier 2 - Standard"
      lifecycle        = "Production"
      primary_language = "Java"
      on_call          = "@cx-oncall"
      slack_channel    = "#svc-loyalty"
      has_monitoring   = true
      has_runbook      = true
      test_coverage    = 82
      critical_vulns   = 1
      domain           = "customer-experience"
    }
    "reviews-ratings" = {
      title            = "Reviews & Ratings (Legacy)"
      tier             = "Tier 3 - Internal"
      lifecycle        = "Deprecated"
      primary_language = "Java"
      on_call          = null
      slack_channel    = "#svc-reviews-legacy"
      has_monitoring   = false
      has_runbook      = false
      test_coverage    = 22
      critical_vulns   = 8
      domain           = "customer-experience"
    }
    "associate-app-backend" = {
      title            = "Associate App Backend"
      tier             = "Tier 2 - Standard"
      lifecycle        = "Production"
      primary_language = "Kotlin"
      on_call          = null
      slack_channel    = "#svc-associate"
      has_monitoring   = false
      has_runbook      = false
      test_coverage    = 38
      critical_vulns   = 5
      domain           = "customer-experience"
    }

    # ── Platform & Infrastructure Domain ──────────────────────────────────
    "api-gateway" = {
      title            = "API Gateway"
      tier             = "Tier 1 - Critical"
      lifecycle        = "Production"
      primary_language = "Go"
      on_call          = "@platform-oncall"
      slack_channel    = "#svc-api-gw"
      has_monitoring   = true
      has_runbook      = true
      test_coverage    = 91
      critical_vulns   = 0
      domain           = "infrastructure"
    }
    "auth-service" = {
      title            = "Auth Service"
      tier             = "Tier 1 - Critical"
      lifecycle        = "Production"
      primary_language = "Go"
      on_call          = "@security-oncall"
      slack_channel    = "#svc-auth"
      has_monitoring   = true
      has_runbook      = true
      test_coverage    = 97
      critical_vulns   = 0
      domain           = "infrastructure"
    }
    "secrets-manager" = {
      title            = "Secrets Manager"
      tier             = "Tier 1 - Critical"
      lifecycle        = "Production"
      primary_language = "Go"
      on_call          = "@security-oncall"
      slack_channel    = "#svc-secrets"
      has_monitoring   = true
      has_runbook      = true
      test_coverage    = 93
      critical_vulns   = 0
      domain           = "infrastructure"
    }
    "config-service" = {
      title            = "Config Service"
      tier             = "Tier 1 - Critical"
      lifecycle        = "Production"
      primary_language = "Go"
      on_call          = "@platform-oncall"
      slack_channel    = "#svc-config"
      has_monitoring   = true
      has_runbook      = true
      test_coverage    = 89
      critical_vulns   = 0
      domain           = "infrastructure"
    }
    "feature-flags" = {
      title            = "Feature Flags"
      tier             = "Tier 1 - Critical"
      lifecycle        = "Production"
      primary_language = "TypeScript"
      on_call          = "@platform-oncall"
      slack_channel    = "#svc-feature-flags"
      has_monitoring   = true
      has_runbook      = true
      test_coverage    = 86
      critical_vulns   = 0
      domain           = "infrastructure"
    }
    "monitoring-aggregator" = {
      title            = "Monitoring Aggregator"
      tier             = "Tier 1 - Critical"
      lifecycle        = "Production"
      primary_language = "Go"
      on_call          = "@sre-oncall"
      slack_channel    = "#svc-monitoring"
      has_monitoring   = true
      has_runbook      = true
      test_coverage    = 78
      critical_vulns   = 1
      domain           = "infrastructure"
    }
    "deploy-pipeline" = {
      title            = "Deploy Pipeline v2"
      tier             = "Tier 2 - Standard"
      lifecycle        = "Development"
      primary_language = "Python"
      on_call          = null
      slack_channel    = "#svc-deploy"
      has_monitoring   = false
      has_runbook      = false
      test_coverage    = 40
      critical_vulns   = 3
      domain           = "infrastructure"
    }
    "image-cdn" = {
      title            = "Image CDN"
      tier             = "Tier 2 - Standard"
      lifecycle        = "Production"
      primary_language = "Rust"
      on_call          = "@infra-oncall"
      slack_channel    = "#svc-cdn"
      has_monitoring   = true
      has_runbook      = false
      test_coverage    = 70
      critical_vulns   = 2
      domain           = "infrastructure"
    }
  }
}

resource "port_entity" "service" {
  for_each   = local.services
  identifier = each.key
  title      = each.value.title
  blueprint  = port_blueprint.service.identifier

  properties = {
    string_props = merge(
      {
        "tier"             = each.value.tier
        "lifecycle"        = each.value.lifecycle
        "primary_language" = each.value.primary_language
        "slack_channel"    = each.value.slack_channel
      },
      each.value.on_call != null ? { "on_call" = each.value.on_call } : {}
    )
    number_props = {
      "test_coverage" = each.value.test_coverage
      "critical_vulns" = each.value.critical_vulns
    }
    boolean_props = {
      "has_monitoring" = each.value.has_monitoring
      "has_runbook"    = each.value.has_runbook
    }
  }

  relations = {
    single_relations = {
      "domain" = each.value.domain
    }
  }

  depends_on = [port_entity.domain]
}

# ═══════════════════════════════════════════════════════════════════════════
# JIRA PROJECTS (5)
# ═══════════════════════════════════════════════════════════════════════════

locals {
  jira_projects = {
    "CART" = {
      title        = "Retail & Cart Engineering"
      key          = "CART"
      lead         = "Lisa Wang"
      project_type = "software"
      issue_count  = 47
      url          = "https://walmart-eng.atlassian.net/projects/CART"
    }
    "SUPPLY" = {
      title        = "Supply Chain Operations"
      key          = "SUPPLY"
      lead         = "Carlos Mendez"
      project_type = "software"
      issue_count  = 63
      url          = "https://walmart-eng.atlassian.net/projects/SUPPLY"
    }
    "PAY" = {
      title        = "Payment & Financial Platform"
      key          = "PAY"
      lead         = "Anika Sharma"
      project_type = "software"
      issue_count  = 29
      url          = "https://walmart-eng.atlassian.net/projects/PAY"
    }
    "PLAT" = {
      title        = "Platform Engineering"
      key          = "PLAT"
      lead         = "David Kim"
      project_type = "software"
      issue_count  = 85
      url          = "https://walmart-eng.atlassian.net/projects/PLAT"
    }
    "SEC" = {
      title        = "Security Engineering"
      key          = "SEC"
      lead         = "Rachel Torres"
      project_type = "software"
      issue_count  = 142
      url          = "https://walmart-eng.atlassian.net/projects/SEC"
    }
  }
}

resource "port_entity" "jira_project" {
  for_each   = local.jira_projects
  identifier = each.key
  title      = each.value.title
  blueprint  = port_blueprint.jira_project.identifier

  properties = {
    string_props = {
      "key"          = each.value.key
      "lead"         = each.value.lead
      "project_type" = each.value.project_type
      "url"          = each.value.url
    }
    number_props = {
      "issue_count" = each.value.issue_count
    }
  }
}

# ═══════════════════════════════════════════════════════════════════════════
# JIRA ISSUES (10)
# ═══════════════════════════════════════════════════════════════════════════

locals {
  jira_issues = {
    "CART-1247" = {
      title        = "Cart items lost during session handoff between mobile and web"
      status       = "In Progress"
      priority     = "Critical"
      issue_type   = "Bug"
      assignee     = "Lisa Wang"
      created      = "2026-03-08T10:30:00Z"
      url          = "https://walmart-eng.atlassian.net/browse/CART-1247"
      jira_project = "CART"
      service      = "cart-service"
    }
    "CART-1250" = {
      title        = "Implement Apple Pay tokenization for checkout v3"
      status       = "To Do"
      priority     = "High"
      issue_type   = "Story"
      assignee     = "Jake Morrison"
      created      = "2026-03-09T14:15:00Z"
      url          = "https://walmart-eng.atlassian.net/browse/CART-1250"
      jira_project = "CART"
      service      = "checkout-api"
    }
    "CART-1253" = {
      title        = "Add voice search support for mobile app"
      status       = "To Do"
      priority     = "Medium"
      issue_type   = "Story"
      assignee     = "Sophia Lee"
      created      = "2026-03-10T11:00:00Z"
      url          = "https://walmart-eng.atlassian.net/browse/CART-1253"
      jira_project = "CART"
      service      = "search-service"
    }
    "SUPPLY-892" = {
      title        = "Inventory count mismatch between DC-Austin and store POS systems"
      status       = "In Progress"
      priority     = "Critical"
      issue_type   = "Incident"
      assignee     = "Carlos Mendez"
      created      = "2026-03-07T09:00:00Z"
      url          = "https://walmart-eng.atlassian.net/browse/SUPPLY-892"
      jira_project = "SUPPLY"
      service      = "inventory-sync"
    }
    "SUPPLY-905" = {
      title        = "Real-time RFID tracking integration for distribution centers"
      status       = "In Progress"
      priority     = "High"
      issue_type   = "Epic"
      assignee     = "Maria Garcia"
      created      = "2026-03-10T08:00:00Z"
      url          = "https://walmart-eng.atlassian.net/browse/SUPPLY-905"
      jira_project = "SUPPLY"
      service      = "warehouse-management"
    }
    "PAY-445" = {
      title        = "Intermittent timeout on Visa network during peak hours"
      status       = "In Review"
      priority     = "High"
      issue_type   = "Bug"
      assignee     = "Anika Sharma"
      created      = "2026-03-05T11:30:00Z"
      url          = "https://walmart-eng.atlassian.net/browse/PAY-445"
      jira_project = "PAY"
      service      = "payment-gateway"
    }
    "PLAT-1580" = {
      title        = "Migrate deploy pipeline to ArgoCD-based GitOps model"
      status       = "In Progress"
      priority     = "Medium"
      issue_type   = "Epic"
      assignee     = "David Kim"
      created      = "2026-03-06T13:45:00Z"
      url          = "https://walmart-eng.atlassian.net/browse/PLAT-1580"
      jira_project = "PLAT"
      service      = "deploy-pipeline"
    }
    "SEC-2103" = {
      title        = "Remediate 6 critical CVEs in gift-card-service dependencies"
      status       = "In Progress"
      priority     = "Critical"
      issue_type   = "Task"
      assignee     = "Rachel Torres"
      created      = "2026-03-01T16:00:00Z"
      url          = "https://walmart-eng.atlassian.net/browse/SEC-2103"
      jira_project = "SEC"
      service      = "gift-card-service"
    }
    "SEC-2110" = {
      title        = "OWASP Top 10 remediation for associate app backend"
      status       = "To Do"
      priority     = "High"
      issue_type   = "Task"
      assignee     = "Omar Hassan"
      created      = "2026-03-09T09:30:00Z"
      url          = "https://walmart-eng.atlassian.net/browse/SEC-2110"
      jira_project = "SEC"
      service      = "associate-app-backend"
    }
    "SEC-2115" = {
      title        = "Legacy reviews service has 8 unpatched critical vulnerabilities"
      status       = "In Progress"
      priority     = "Critical"
      issue_type   = "Incident"
      assignee     = "Rachel Torres"
      created      = "2026-03-10T07:00:00Z"
      url          = "https://walmart-eng.atlassian.net/browse/SEC-2115"
      jira_project = "SEC"
      service      = "reviews-ratings"
    }
  }
}

resource "port_entity" "jira_issue" {
  for_each   = local.jira_issues
  identifier = each.key
  title      = each.value.title
  blueprint  = port_blueprint.jira_issue.identifier

  properties = {
    string_props = {
      "status"     = each.value.status
      "priority"   = each.value.priority
      "issue_type" = each.value.issue_type
      "assignee"   = each.value.assignee
      "created"    = each.value.created
      "url"        = each.value.url
    }
  }

  relations = {
    single_relations = {
      "jiraProject" = each.value.jira_project
      "service"     = each.value.service
    }
  }

  depends_on = [port_entity.jira_project, port_entity.service]
}

# ═══════════════════════════════════════════════════════════════════════════
# SECURITY FINDINGS (10)
# ═══════════════════════════════════════════════════════════════════════════

locals {
  security_findings = {
    "CVE-2026-0142" = {
      title         = "RCE in log4j-core 2.17.0"
      severity      = "Critical"
      status        = "Open"
      source        = "Dependabot"
      cve_id        = "CVE-2026-0142"
      package       = "log4j-core@2.17.0"
      fix_available = true
      found_date    = "2026-03-01T12:00:00Z"
      service       = "gift-card-service"
    }
    "CVE-2026-0198" = {
      title         = "Auth bypass in Spring Boot 3.1.2"
      severity      = "Critical"
      status        = "Open"
      source        = "Dependabot"
      cve_id        = "CVE-2026-0198"
      package       = "spring-boot@3.1.2"
      fix_available = true
      found_date    = "2026-02-28T08:00:00Z"
      service       = "gift-card-service"
    }
    "CVE-2026-0201" = {
      title         = "Deserialization vulnerability in Jackson"
      severity      = "High"
      status        = "In Progress"
      source        = "CodeScanning"
      cve_id        = "CVE-2026-0201"
      package       = "jackson-databind@2.14.1"
      fix_available = false
      found_date    = "2026-03-05T10:00:00Z"
      service       = "reviews-ratings"
    }
    "CVE-2026-0215" = {
      title         = "Text interpolation RCE in commons-text"
      severity      = "Critical"
      status        = "Open"
      source        = "Dependabot"
      cve_id        = "CVE-2026-0215"
      package       = "commons-text@1.10.0"
      fix_available = true
      found_date    = "2026-03-02T14:00:00Z"
      service       = "reviews-ratings"
    }
    "CVE-2026-0220" = {
      title         = "Buffer overflow in NumPy array operations"
      severity      = "High"
      status        = "Open"
      source        = "Dependabot"
      cve_id        = "CVE-2026-0220"
      package       = "numpy@1.24.0"
      fix_available = true
      found_date    = "2026-03-08T09:00:00Z"
      service       = "recommendation-engine"
    }
    "CVE-2026-0225" = {
      title         = "Type confusion in Kotlin stdlib coroutines"
      severity      = "High"
      status        = "In Progress"
      source        = "Dependabot"
      cve_id        = "CVE-2026-0225"
      package       = "kotlin-stdlib@1.8.0"
      fix_available = true
      found_date    = "2026-03-03T11:00:00Z"
      service       = "associate-app-backend"
    }
    "CVE-2026-0230" = {
      title         = "Path traversal in Express static middleware"
      severity      = "Medium"
      status        = "Fixed"
      source        = "Dependabot"
      cve_id        = "CVE-2026-0230"
      package       = "express@4.18.2"
      fix_available = true
      found_date    = "2026-02-20T15:00:00Z"
      service       = null
    }
    "CVE-2026-0235" = {
      title         = "Model deserialization RCE in TensorFlow"
      severity      = "Critical"
      status        = "Open"
      source        = "CodeScanning"
      cve_id        = "CVE-2026-0235"
      package       = "tensorflow@2.15.0"
      fix_available = false
      found_date    = "2026-03-09T16:00:00Z"
      service       = "supply-chain-tracker"
    }
    "CVE-2026-0240" = {
      title         = "HTTP smuggling in Netty server"
      severity      = "High"
      status        = "Fixed"
      source        = "Dependabot"
      cve_id        = "CVE-2026-0240"
      package       = "netty@4.1.90"
      fix_available = true
      found_date    = "2026-02-15T10:00:00Z"
      service       = "checkout-api"
    }
    "CVE-2026-0245" = {
      title         = "Heap overflow in Pillow image processing"
      severity      = "Medium"
      status        = "Open"
      source        = "Dependabot"
      cve_id        = "CVE-2026-0245"
      package       = "pillow@10.1.0"
      fix_available = true
      found_date    = "2026-03-07T13:00:00Z"
      service       = "image-cdn"
    }
  }
}

resource "port_entity" "security_finding" {
  for_each   = local.security_findings
  identifier = each.key
  title      = each.value.title
  blueprint  = port_blueprint.security_finding.identifier

  properties = {
    string_props = {
      "severity"   = each.value.severity
      "status"     = each.value.status
      "source"     = each.value.source
      "cve_id"     = each.value.cve_id
      "package"    = each.value.package
      "found_date" = each.value.found_date
    }
    boolean_props = {
      "fix_available" = each.value.fix_available
    }
  }

  relations = {
    single_relations = merge(
      {},
      each.value.service != null ? { "service" = each.value.service } : {}
    )
  }

  depends_on = [port_entity.service]
}
