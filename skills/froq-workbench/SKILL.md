---
name: froq-workbench
description: froQ 的工作环境规范：工具链（mo、mise、cf）、目录约定（~/code/<owner>/<repo>）、机器名（Mini/Air）、安全边界（不用学校资源、静默测试）。装东西、跑命令、部署、clone 仓库时使用。
license: MIT
metadata:
  author: froQ
  version: "0.1.0"
  source: Hand-written. https://github.com/0froq/skills-pack
---

# froq-workbench

环境和工具层。管"用什么工具、东西放哪、在哪台机器"，不管"repo 里代码怎么写"（那是 `froq-code-style`）和"repo 怎么建"（那是 `froq-create-repo` / `froq-stack`）。

## 工具链

| 场景 | 用 | 不用 |
| --- | --- | --- |
| Clone GitHub repo | `mo clone` → `~/code/<owner>/<repo>` | `gh repo clone`、`git clone` |
| 全局 CLI | mise（`mise use -g npm:xxx` 管 npm CLI） | 直接 npm i -g；mise 管不了才走 brew |
| Cloudflare 部署 | `cf`（后续可能迁 `void`） | wrangler |
| 接 repo 前看状态 | `~/code/.sync/INDEX` 读一行 | 直接读全文快照 |
| 包管理器 | pnpm（所有 repo 默认） | npm / yarn |

## 目录与机器

- 仓库一律 `~/code/<owner>/<repo>`，按 GitHub owner/repo 原名落盘，fork 不改名（`0froq/x18n` 与 `x18n-dev/x18n` 并存）。
- `~/code/.sync/INDEX` 由 `mo` 命令生成，agent 只读。
- **Mini**：主力常开机器。**Air**：出差机。操作前说清是哪台，不混用上下文。
- agent/dotfiles 类配置的 source of truth 在 `~/code/0froq/dotfiles`（`dots` CLI 管理）。

## Boundaries

- 不用学校资源（教育邮箱、机构网络、机构 GitHub org）办开源/事业上的事。
- 测试不放任何音频/音效，静默测试。
- 不把 session ID、模型名、逐轮日志写进跨端存储。
- 对外身份相关操作（发邮件、发帖、上游发言）默认只起草不发送，除非那个 skill 明确允许。草稿也要按 `external-copy-polish` 润到可发状态。

## Hand-offs

- 编码风格：`froq-code-style`
- 建 repo / 工具栈选型：`froq-create-repo` / `froq-stack`
- 持久化记忆与工作台：`froq-notion-yard`
- 对外文案润色：`external-copy-polish`
