---
name: monorepo
description: Monorepo setup with pnpm workspaces, workspace protocol, and internal package aliasing. Use when creating or managing multi-package repositories.
---

# Monorepo Setup

## pnpm Workspaces

Use pnpm workspaces for monorepo management:

```yaml
# pnpm-workspace.yaml
packages:
  - 'packages/*'
  - 'apps/*'
```

## Scripts Convention

Have scripts in each package, and use `-r` (recursive) flag at root.
Have a `ci` script at root that runs all checks.

```json
// root package.json
{
  "scripts": {
    "build": "pnpm run -r build",
    "test": "vitest",
    "lint": "vp lint",
    "lint:fix": "vp lint --fix",
    "dev": "pnpm run -r --parallel dev",
    "clean": "rm -rf node_modules packages/*/node_modules apps/*/node_modules"
  }
}
```

In each package's `package.json`, add the scripts:

```json
// packages/*/package.json
{
  "scripts": {
    "build": "tsdown",
    "dev": "tsdown --watch",
    "prepack": "pnpm build"
  }
}

// apps/*/package.json
{
  "scripts": {
    "build": "nuxt build",
    "dev": "nuxt dev",
    "generate": "nuxt generate"
  }
}
```

## Internal Package Aliases

This is package-name aliasing for workspace source resolution (`@myorg/core` → `packages/core/src`), not `paths` aliases. Vite/Nuxt/Vitest read it from one `alias.ts` at project root:

```ts
// alias.ts
import fs from 'node:fs'
import { fileURLToPath } from 'node:url'
import { join, relative } from 'pathe'

const root = fileURLToPath(new URL('.', import.meta.url))
const r = (path: string) => fileURLToPath(new URL(`./packages/${path}`, import.meta.url))

export const alias = {
  '@myorg/core': r('core/src/index.ts'),
  '@myorg/utils': r('utils/src/index.ts'),
  '@myorg/ui': r('ui/src/index.ts'),
  // Add more aliases as needed
}

// Auto-update tsconfig.alias.json paths
const raw = fs.readFileSync(join(root, 'tsconfig.alias.json'), 'utf-8').trim()
const tsconfig = JSON.parse(raw)
tsconfig.compilerOptions.paths = Object.fromEntries(
  Object.entries(alias).map(([key, value]) => [key, [`./${relative(root, value)}`]]),
)
const newRaw = JSON.stringify(tsconfig, null, 2)
if (newRaw !== raw)
  fs.writeFileSync(join(root, 'tsconfig.alias.json'), `${newRaw}\n`, 'utf-8')
```

Then update the `tsconfig.json` to use the alias file:

```json
{
  "extends": [
    "./tsconfig.alias.json"
  ]
}
```

### Using Alias in Configs

Reference the centralized alias in all config files:

```ts
// vite.config.ts
import { alias } from './alias'

export default defineConfig({
  resolve: { alias },
})
```

```ts
// nuxt.config.ts
import { alias } from './alias'

export default defineNuxtConfig({
  alias,
})
```

```ts
// vitest.config.ts
import { alias } from './alias'

export default defineConfig({
  resolve: { alias },
})
```

## Package Naming

Use scoped packages for internal packages:

```json
// packages/core/package.json
{
  "name": "@myorg/core",
  "version": "1.0.0",
  "main": "./dist/index.js",
  "types": "./dist/index.d.ts"
}
```

## Internal Dependencies

Reference workspace packages with `workspace:` protocol:

```json
{
  "dependencies": {
    "@myorg/core": "workspace:*",
    "@myorg/utils": "workspace:*"
  }
}
```

## Build Order

pnpm automatically handles build order based on `workspace:` dependencies. No need for manual sequencing.

## Publishing

```bash
# Version all packages
pnpm version [major|minor|patch]

# Publish all
pnpm publish -r
```
