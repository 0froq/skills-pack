---
name: repo-face
description: >-
  Rewrite a froQ README, port README, or library README in the house style,
  including badges, acknowledgements, and the license section. Use when asked
  to rewrite a README, add star history, or state how a repo is licensed.
metadata:
  author: froQ
  version: "2026.10.14"
  source: Hand-written from the LiG README pass. https://github.com/0froq/skills-pack
---

这份 skill 只存 README 的形状。
版本号、色值、组件名单、端口列表留在那个仓库里。
不要把另一个仓库的事实抄进模板。

## 存法

`SKILL.md` 只做分流。
一种仓库一份 `references/` 文件，里面是带槽位的骨架。
槽位写成 `{{NAME}}`。
换一种仓库就加一个 reference，不要再开一份 skill，除非步骤本身变了。
工具链约定在 `oq`，不在这里重复。

读且只读对上的那一份：

| 仓库 | 文件 |
| --- | --- |
| 对外产品，例如 lig | [references/product.md](references/product.md) |
| 库，例如 @froq/ui | [references/library.md](references/library.md) |
| 生成出来的编辑器或工具 port | [references/port.md](references/port.md) |
| 仓库内部契约，例如 core、syntax、编译器 | [references/internal.md](references/internal.md) |

许可规则在 [references/license.md](references/license.md)。写任何 README 的许可节之前读它。

## 声音

英文。
一句话一行。
长句在逗号处断开。
命令和表保持精确。
许可放在最后。
徽章和 Star History 只放在对外产品 README。
不要把第三方文件改成仓库自己的许可。
