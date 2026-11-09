# skills-pack

froQ 自己的 agent skills。`froq-` 前缀标记 froQ 个人工作流/环境类 skill；通用方法论 skill 不带前缀。skill 正文正在从中文迁往英文，单个 skill 内容定稿时顺手翻。

[0froq/skills](https://github.com/0froq/skills) 是 [antfu/skills](https://github.com/antfu/skills) 的 fork。那边有生成器、git submodule，以及一整份上游文档镜像。`pnpm start cleanup` 会删掉任何没有写进 `meta.ts` `manual` 的目录，手写 skill 也必须套进那四类 taxonomy。这边没有生成器，也没有 `meta.ts`。加一份 skill 就是加一个目录。

Vue、Nuxt、Vite 等框架 skill 从各自的上游仓库装，不放在这里。第三方手写 skill（humanizer、caveman、ponytail 等）也从上游装，不收进这个包。

## 安装

```bash
pnpx skills add 0froq/skills-pack --skill='*'
```

只装一份：

```bash
pnpx skills add 0froq/skills-pack --skill=froq-stack
```

## Skills

| Skill | |
| --- | --- |
| [froq-workbench](skills/froq-workbench) | 环境规范：mo/mise/cf、目录约定、Mini/Air、安全边界 |
| [froq-notion-yard](skills/froq-notion-yard) | 持久化记忆与工作台（当前后端 Notion） |
| [froq-briefing](skills/froq-briefing) | 晨报/晚报写什么、什么时候写 |
| [froq-os-contrib](skills/froq-os-contrib) | 开源贡献经营：选题、两阶段修程、认领、上游权限边界 |
| [froq-create-pr](skills/froq-create-pr) | 起草 PR 标题与描述：模板顺序、fallback 骨架、Fixes 规则 |
| [froq-create-issue](skills/froq-create-issue) | 起草新 issue：模板、复现结构、查重 |
| [froq-create-repo](skills/froq-create-repo) | 建 repo 的决策清单与形态路由 |
| [froq-stack](skills/froq-stack) | 技术栈选型与配置：目录、ESLint、Nuxt、UnoCSS、catalogs |
| [froq-web-app](skills/froq-web-app) | web app 架构与 Cloudflare 发布 |
| [froq-code-style](skills/froq-code-style) | 编码规范：文件布局、types、测试、catalog、发布 |
| [froq-longform](skills/froq-longform) | froQ 声音的长文/随笔 + 对外文案 polish |
| [froq-mailman](skills/froq-mailman) | Fastmail 邮件（JMAP）：读、搜、起草，默认不发送 |
| [froq-design](skills/froq-design) | 设计原则与 UI 审核标准 |
| [whittle](skills/whittle) | 把开放设计问题收敛为 DAG 并清零 |
| [feeds-card-copy](skills/feeds-card-copy) | feed 卡片文案配方 |
| [lake-paper-academic-advisor](skills/lake-paper-academic-advisor) | Lake 项目的学术顾问 |
| [external-copy-polish](skills/external-copy-polish) | 对外文案去 AI 味：标点、口吻、checklist |

预留：`froq-review`（code review 规范，待写）。

## 加一份

在 `skills/<name>/SKILL.md` 写 frontmatter。个人工作流类用 `froq-` 前缀，通用方法论不带。Frontmatter 遵循 [agentskills.io](https://agentskills.io/specification) spec，正文结构按 [TEMPLATE.md](TEMPLATE.md)（固定节：定位段 + 领域节 + `Boundaries` + `Hand-offs`）：

```yaml
---
name: <dir-name>
description: <one line, matches body language>
license: MIT
metadata:
  author: froQ
  version: "0.1.0"
  source: Hand-written. https://github.com/0froq/skills-pack
---
```

正文骨架：一段定位（这层回答什么、不回答什么）→ 领域规则节（自由组织）→ `## Boundaries`（硬性不做，没有就写 None）→ `## Hand-offs`（委托给谁/被谁调用，没有就写 None）。`When` 和 `References` 可选。

`metadata.version` 是 semver：PATCH 修内容、MINOR 加章节、到 `1.0.0` 算稳定。需要拆开的说明放在同目录的 `references/`。可执行脚本放 `scripts/`。不要加生成脚本，也不要把上游文档镜像进来。

## 引用关系

skill 之间平行原子化，靠引导指向串起来：

```text
froq-create-repo ──→ froq-stack / froq-web-app / froq-code-style
froq-os-contrib  ──→ froq-create-pr / froq-create-issue / froq-review(预留)
froq-os-contrib, froq-mailman ──→ froq-longform（对外草稿 polish）
froq-briefing    ──→ froq-notion-yard（读写 yard）
```
