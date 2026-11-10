---
name: setting-up
description: One-time repo setup files: .gitignore, GitHub Actions workflows, standard package.json scripts, baseline tsconfig. Use when scaffolding a new froQ repository.
---

# Project Setup

## .gitignore

Create when `.gitignore` is not present:

```
*.log
*.tgz
.cache
.DS_Store
.eslintcache
.idea
.env
.env.local
.env.*.local
.nuxt
.temp
.output
.turbo
cache
coverage
dist
lib-cov
logs
node_modules
temp
```

## GitHub Actions

### Autofix Workflow

**`.github/workflows/autofix.yml`** - Auto-fix linting on PRs:

```yaml
name: autofix.ci

on: [pull_request]

jobs:
  autofix:
    uses: sxzz/workflows/.github/workflows/autofix.yml@v1
    permissions:
      contents: read
```

### Unit Test Workflow

**`.github/workflows/unit-test.yml`** - Run tests on push/PR:

```yaml
name: Unit Test

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

permissions: {}

jobs:
  unit-test:
    uses: sxzz/workflows/.github/workflows/unit-test.yml@v1
```

### Release Workflow

See [release-workflow](release-workflow.md) for changelogithub setup.

## package.json Scripts

Standard scripts for oQ-style projects:

```json
{
  "scripts": {
    "dev": "nuxt dev",
    "build": "nuxt build",
    "generate": "nuxt generate",
    "preview": "nuxt preview",
    "lint": "vp lint",
    "lint:fix": "vp lint --fix",
    "fmt": "vp fmt",
    "fmt:check": "vp fmt --check",
    "ci": "vp run lint && vp run fmt:check && vp run typecheck && vp run test --run",
    "postinstall": "nuxt prepare",
    "prepare": "npx simple-git-hooks"
  }
}
```

## TypeScript Configuration

```json
{
  "compilerOptions": {
    "target": "ESNext",
    "module": "ESNext",
    "moduleResolution": "bundler",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true
  },
  "exclude": ["node_modules", ".nuxt", "dist"]
}
```
