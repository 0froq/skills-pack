---
name: cloudflare-sites
description: Deploy froQ static sites and Nuxt sites to Cloudflare as Workers with the cf CLI. Use when adding Cloudflare deploy, Workers Builds, Worker Previews, migrating a Pages project, migrating wrangler.jsonc, replacing --prebuilt or cf:build, or when asked to copy void, paper-landing, lig, or poim. Do not create new Pages projects. Do not use wrangler for deploy or preview.
metadata:
  author: froQ
  version: "2026.10.12"
  source: Hand-written. Reference 0froq/poim main (PR #5). https://github.com/0froq/skills-pack
---

新的 froQ 静态站和 Nuxt 站发布到 Cloudflare Workers（静态资源），用 `cf`。不要新建 Pages 项目，也不要照抄 void、paper-landing、lig。参照 [0froq/poim](https://github.com/0froq/poim) main（[PR #5](https://github.com/0froq/poim/pull/5)）。

## 不要照抄的仓库

- `void`：先是 Worker 加 GitHub Action（仓库里放 API token），后来改成 Pages 的 GitHub 连接。那是旧决定。
- `paper-landing`：Pages 的 GitHub 连接，构建 `pnpm generate`，发布 `.output/public`。没有 wrangler。
- `lig`：没有部署。

不要照抄它们的部署方式。新站点和从 Pages 迁过来的站点都读这份 skill。迁的时候新建 Worker，不要沿用 Pages 项目、仓库里的 API token，或 `preset: 'cloudflare_pages'`。

## Pages

`cf` 不能创建 Pages 项目。控制台里新建 Pages 的入口已经被收起来。官方文档仍说现有 Pages 不会被关掉，新项目从 Workers 开始。静态资源请求在 Workers 上和 Pages 一样不按请求计费。Wrangler 还有 `wrangler pages project create`，那不是新站点的路径。

## 已有 wrangler 配置时

仓库里有 `wrangler.jsonc` 或 `wrangler.toml`，还没有 `cloudflare.config.ts`：

1. 工作区要干净。`cf migrate` 在脏工作区会停，除非加上 `--force`。
2. 安装 wrangler，至少 4.136。`cf` 的 Wrangler bundler 需要它。
3. 跑 `cf migrate`。它写出 `cloudflare.config.ts`。没有 `@cloudflare/vite-plugin` 时，资源目录写在 `wrangler.config.ts` 的 `assetsDirectory`。
4. 它不覆盖已有的 `cloudflare.config.ts`，也不删除旧的 `wrangler.jsonc`。
5. `cf deploy --dry-run` 通过之后，再删 `wrangler.jsonc`。

还没有 `cloudflare.config.ts` 时，不要跑 `cf init`、`cf dev`、`cf build`、`cf deploy`。它们不读 `wrangler.jsonc`，可能改写配置。

## Nuxt 静态站

Nitro 用静态预设，公开目录指到 `dist`。不要设 `preset: 'cloudflare_pages'`。那个预设会写 `_routes.json` 和 `_redirects`（`/* /404.html 404`），并警告要切到 D1。Workers Builds 会设 `WORKERS_CI`，Nitro 否则会自选 Cloudflare 预设。

```ts
nitro: {
  preset: 'static',
  output: {
    publicDir: 'dist',
  },
}
```

`cloudflare.config.ts` 放 Worker 本身。`compatibilityDate` 用动手那天的日期。名字可以以数字开头。

```ts
import { defineConfig } from 'cf/config'

export default defineConfig({
  worker: {
    name: '<worker-name>',
    compatibilityDate: '<YYYY-MM-DD>',
    observability: {
      enabled: true,
      traces: { enabled: true },
    },
    assets: {
      htmlHandling: 'drop-trailing-slash',
      notFoundHandling: '404-page',
    },
  },
})
```

`wrangler.config.ts` 只放构建侧的资源目录。它不是 Pages 配置，不要写 `pages_build_output_dir`。

```ts
import { defineWranglerConfig } from 'wrangler/experimental-config'

export default defineWranglerConfig({
  types: { generate: false },
  assetsDirectory: './dist',
})
```

`package.json` 保留 `dev`、`build`、`generate`。另加：

```json
"deploy": "pnpm generate && cf deploy",
"preview:deploy": "pnpm generate && cf previews deploy"
```

`cf build` 和 `cf deploy` 不跑 `package.json` 脚本，所以生成要写在 deploy 前面。不要把 `pnpm dev` 换成 `cf dev`。不要加 `cf:build`。部署和预览只用 `cf`，不要用 wrangler，也不要 `wrangler build --x-cf-build-output` 或 `--prebuilt`。`cf previews deploy --prebuilt` 会失败：prebuilt 产出不是 preview build。

Nuxt 路由没有尾斜杠，静态文件却是 `folder/index.html`。`auto-trailing-slash` 会把 `/s/0001/homepage` 307 到 `/s/0001/homepage/`，空段再进文档路径就会 404。用 `drop-trailing-slash`。页面如果自己拼接 slug，丢掉空段。

`public/_headers` 会被复制进 `dist`，用来给 `/_nuxt` 加缓存头。`.cloudflare` 和 `.wrangler` 放进 `.gitignore`。

## Workers Builds

控制台这样设（GitHub 连接，仓库不放 API token）：

- 构建命令：`pnpm generate`
- 生产部署：`pnpm exec cf deploy`（用项目里钉住的 `cf`）
- 打开 Worker Previews（一次性，不能撤销）。预览命令：`pnpm exec cf previews deploy`。Builds for Preview branches 打开。
- Production 和 Previews Base 都设 `NODE_VERSION=22`
- API token 用 `Workers Builds - 2026-09-19 22:23`

预览地址：分支别名 `<branch-slug>-<worker>.sayhola.workers.dev`（每个 PR 固定，后面的构建更新同一条），以及每次提交的 `<hash>-<worker>.sayhola.workers.dev`。Cloudflare 的 PR 评论在用 `cf` 时会写 "No Preview URL"（只有 `wrangler preview` 才会填链接）。这是预期的，从别名或构建日志拿地址。继续用 `cf`，不要为了那条评论改成 wrangler。

Worker Previews 不继承生产的变量、绑定、密钥。预览要用就写到 Previews Base。静态站两边都只要 `NODE_VERSION`。

改完控制台设置后不要点 Retry：Retry 会沿用旧设置。推一个新 commit。

已经连上 Workers Builds、还在用旧的非生产 trigger 的 Worker，才能做一次 `cf workers-builds workers migrate-to-previews`。这一步不能撤销。新建的 Worker 默认就是预览，不要再跑迁移。

## 工具版本

- `cf` 是 beta，命令和配置格式还会变。验证过的版本是 `1.0.0-beta.12`，钉死这个版本，不要跟 latest。
- 加载 `cloudflare.config.ts` 需要 Node.js >= 22.18（`module.registerHooks`）。报错文案可能让人以为是 Bun，先看 `node -v`。
- 项目声明了 `cf` 之后，全局的 `cf` 会转给项目里的那份。
- `cf deploy --dry-run` 不需要登录，用来确认资源打进了包。不要加 `--prebuilt`。
- `cf auth login` 要浏览器。无人值守用环境变量 `CLOUDFLARE_API_TOKEN`，不要写进仓库。

## 文档

- https://developers.cloudflare.com/cf/wrangler/migrate/
- https://developers.cloudflare.com/cf/projects/
- https://developers.cloudflare.com/workers/static-assets/routing/static-site-generation/
- https://developers.cloudflare.com/workers/previews/
- https://developers.cloudflare.com/workers/ci-cd/builds/configuration/
- https://developers.cloudflare.com/pages/get-started/
