# skills-pack

froQ 自己的 agent skills。只放手写的约定。

[0froq/skills](https://github.com/0froq/skills) 是 [antfu/skills](https://github.com/antfu/skills) 的 fork。那边有生成器、git submodule，以及一整份上游文档镜像。`pnpm start cleanup` 会删掉任何没有写进 `meta.ts` `manual` 的目录，手写 skill 也必须套进那四类 taxonomy。这边没有生成器，也没有 `meta.ts`。加一份 skill 就是加一个目录。

Vue、Nuxt、Vite 等框架 skill 从各自的上游仓库装，不放在这里。

## 安装

```bash
pnpx skills add 0froq/skills-pack --skill='*'
```

只装一份：

```bash
pnpx skills add 0froq/skills-pack --skill=cloudflare-sites
```

## Skills

| Skill | |
| --- | --- |
| [cloudflare-sites](skills/cloudflare-sites) | 新站和从 Pages 迁过来的站，用 Workers、`cf`、Worker Previews |
| [oq](skills/oq) | 项目约定：ESLint、pnpm catalog、UnoCSS、发布 |

## 加一份

在 `skills/<name>/SKILL.md` 写 frontmatter 的 `name` 和 `description`。需要拆开的说明放在同目录的 `references/`。不要加生成脚本，也不要把上游文档镜像进来。
