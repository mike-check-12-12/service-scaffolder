# Service Scaffolder

Automated microservice scaffolding for Walmart Platform Engineering, powered by [Port.io](https://app.getport.io).

## What it does

When a developer triggers the "Scaffold New Microservice" action in Port's self-service hub, this workflow:

1. **Creates a new GitHub repository** in the `mike-check-12-12` org
2. **Scaffolds project structure** with language-specific boilerplate (Java, Go, Python, TypeScript, Rust, Kotlin)
3. **Adds standard configs**: Dockerfile, Kubernetes manifests, CI pipeline, CODEOWNERS
4. **Registers the service** in Port's software catalog automatically
5. **Reports status** back to Port with success/failure

## Supported Languages

- Java
- Go
- Python
- TypeScript
- Rust
- Kotlin

## Required Secrets

| Secret | Description |
|--------|-------------|
| `PORT_CLIENT_ID` | Port.io client ID |
| `PORT_CLIENT_SECRET` | Port.io client secret |
| `ORG_ADMIN_TOKEN` | GitHub PAT with `repo` and `admin:org` scopes |
