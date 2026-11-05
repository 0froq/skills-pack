---
name: feeds-card-copy
description: >-
  Only when Fed writes card copy: the instant-lane POST /api/lane title/summary
  (absorb-atoms), queue/**/*.yaml title/summary (06:37 morning-digest or
  rewriting an existing card), before push. Enforces public voice + incremental
  summary + 发版与上架并卡 + 核真实发布时间 + 当日窗口 (only publishedAt after the previous digest
  cutoff; older → drop, never fake the date; exceptions: backfill of a
  never-carded event within 72h, and ongoing ai-deals). Not for Scout, Rook, UI
  work, or polishing Atom originals.
metadata:
  author: froQ
  version: "2026.11.06"
  source: Hand-written. https://github.com/0froq/skills-pack
---
# 贴图文案（Daily Brief card copy）

**谁用：** 只给 **Fed** 写 `title` / `summary`：即时通道 `POST /api/lane` 和 `queue/**/*.yaml`。  
**谁不用：** Scout 不读；Atom 保持检索向。Rook 不代写。改 UI 的人不加载。Fed **不发社媒**（发布归本地 agents）。

窗口、分流、`register`、人名、状态 → feeds/briefing 仓库的 `AGENTS.md`；即时判定与先行通道 → `docs/operations.md` §5.3 + `AGENTS.md` §8。这两份在仓库里时以它们为准。本 skill 是可携带的卡片口吻规则，只管**听起来像不像一张新闻卡**，外加入卡前必过的时间关（硬规则 D）。

## When

- `absorb-atoms` 即时判定命中（有效可行动羊毛 / `priority: flash`）：核官方页、定最终 kebab-case `id` 后，写 lane 的 `title`/`summary` 之前必读。
- `morning-digest`（06:37，只写**当日** `queue/**/<D>.yaml`）：路由、去重、过当日窗口之后，写每条 `title`/`summary` 之前必读。已推过 lane 的条目（Notion Atom `Lane ID` 非空）用**同一个 `id`**；文案可以改得更好，不要求与先行版一致。
- 改已有条目的 title/summary 时也用。`id` 一旦发布不改。
- 写完用「写完自检」过一遍再 push。
- **不要**提前建 `queue/**/<D+1>.yaml`；**不要**按这套去润色 Atom 原文。

## Return

lane 请求体或 YAML 里的 `title`、`summary`；核验细节进 `notes`（lane 没有 notes，就记在 Atom 上）。不改 `url` / `register` / 频道 / `id`。

## 卡片

1080×1440。标题最多约 3 行。摘要 **2–4 句**。读者要能说出「谁、发生了什么」。

| 字段 | 给谁 | 放什么 |
| --- | --- | --- |
| `title` | **公众读者** | 一件事、一个动词；不知名 X 贴主**不进标题** |
| `summary` | **公众读者** | 谁 → 发生了什么 → 对谁生效；**相对 title 必须有增量** |
| `notes` | 编辑（不对读者） | 核验、去重、并卡理由、changelog 其余、分流理由、未见原文等 |

正文用**产品名**，不用 X 的 `@handle`（写 Notion / Granola，不写 @NotionHQ）。

## 硬规则 A：summary 是给读者的（必过）

`title` / `summary` 会印在对外卡片上（公众号、小红书、feeds 站、会员订阅）。写的时候默认**陌生人在读**，不是 froQ，不是编辑备忘。

**禁止写进 summary**（一律进 `notes`）：
- 流水线黑话：Atom、Dedup、queue、morning-digest、lane、先行、并卡、另开卡、routed、补漏
- 编辑自述：未见 arXiv、未打开原文、未独立复跑、数字取帖文摘要、summary 不复读 people
- 对内分流/去重理由（如「免费工具不进 ai-deals」）

读者侧不确定感用对外口吻：`发帖称…`、`目前未能独立核实`、`无官方公告`。不要提我们内部有没有打开哪一页。

## 硬规则 B：摘要相对标题有增量（必过）

1. **summary 禁止换词复读 title。** 删掉 title 里已有主谓宾后，summary 仍须站得住。
2. **长度：2–4 句。** 单句卡一律不过。
3. **增量写什么：** 入口/范围/限制、硬数字、对比基线、谁能用/何时推全、截止时间、rumor 归因名。
4. **口诀：** 只看 summary、不看 title，读者仍应多知道至少两点。

## 硬规则 C：发版与上架并卡（必过）

模型 / 产品**主发版**与当日相关**上架 / 可用性**（第三方 harness、GitHub Copilot、AI Gateway、OpenRouter、Cursor 分发等）是**同一故事** → **一张卡**，禁止拆成 N 张。

- **主链**：官方发版页（或厂商官宣）做 `id` / `url` / title。
- **summary**：用 1–2 句写关键可用性（谁能用、哪些入口上架）；细节可进 `links`。
- **notes**：写并卡理由与已并入的 id（对内）；禁止再拆分发卡。
- **不要**：为每个 harness / 订阅入口各开一张「上架」新闻卡。例：Grok 4.7 发版 + Copilot 上架 Grok 4.7 = **一卡**。
- **例外**：可行动折扣 / 限时码 / 免费额度（羊毛）走 `ai-deals`，与发版事实卡分轨；纯「某某上架了该模型」的新闻卡不得单独存活。

## 硬规则 D：核真实发布时间 + 当日窗口（必过）

入卡看**事件发布时间**，不是刷到帖子、也不是 Atom 入库的时间。完整条文见仓库 `AGENTS.md` §3。

- 打开官网 / changelog / 官方页 / 原帖，核对真实发布或发版时间。`publishedAt` 写可核验的事件时间：能核到时刻就写完整时间（`2026-09-27T14:05:00+08:00`），只能核到日就写日期。找不到可核时间 → 不成卡、不推 lane，勿猜。X 帖用雪花 ID 换算。
- **当日窗口**：当日 `ai-briefing` / `stack-briefing` 队列只收 `publishedAt` 在「上一次 `morning-digest` 截止（前一天约 06:37；若当天有补跑，以补跑 cutoff 为准）→ 本次运行」之间的条目（约 24h）。当天已推过 lane 的按事件时间本就在窗口内，照常写。
- 窗口之前的默认不成卡：Atom 标 routed / 丢弃，原因「超出当日窗口」。**绝不**把 `publishedAt` 改成今天凑窗口。旧闻回声默认丢，仅窗口内有新的可核变化才入卡。
- **例外一：补漏（72h）。** 事件真实时间在本次运行前 **72 小时内**，且这件事**从未成过卡**（按事件查 `queue/**`，不按链接或 id），可以写进当日队列。Atoms Tags 带 `backfill` 的都是这类；froQ 直接丢的料同样适用。`publishedAt` 仍写真实事件时间，绝不改日期。YAML 写法（froQ 09-28 定，PROJECT.md §8、`queue/_template.yaml`）：加 `backfill: true`；可选 `addedAt`（入列时刻，ISO 带 `+08:00`，不写按当天 12:00）；写进**入列当天**的 queue 文件，补漏行放在文件**最前面**。前端按 addedAt 排在入列当天最前，并自动显示「补漏 · 事件时间 M/D」，**title / summary 里不要再写补漏或事件日期标记**。`notes` 写「补漏」及依据。超过 72h 照旧 drop。
- **例外二：`ai-deals`。** 仍在进行中、可行动的羊毛发现晚了也可入卡（`publishedAt` 仍写真实公告日；靠置顶汇总「进行中的羊毛」与 `/c/ai-deals`「进行中」区展示，不靠排序）；已结束的不收。
- **具名泄露、内部人士预热**按传闻卡处理：`register: rumor`，summary 用「据称」+ 具名出处（Atoms Tags 带 `rumor`）。匿名臆测、无出处的日期说法不写成事实。**官方账号自己发的预热/倒计时不是传闻**（前端会给 rumor 打「尚未被官方证实」），写 `register: community`，其中转述的外部爆料仍用「据称」归因。
- 目的：订阅按 `publishedAt` 倒序取前 100，当日新卡应在最前。所以 absorb-atoms / digest 要当天消化完 Atoms；Atoms 普遍滞后（大量入库即已出窗口）→ 在 digest 运营摘要报 Rook。
- 羊毛 / flash 有截止就写 `expiresAt`（完整时间）；过期的 lane 条目 `DELETE /api/lane/<id>`。`priority: flash` 只给按小时算的要紧事（见 operations §5.3）。

## 标题

专有名词保留原文。优先一行；约 28 字硬上限可到两行，版面允许可到三行。

不要：分号/顿号堆功能；版本号当主语再跟补丁清单；空评论当新闻；括号里塞编辑备注；不知名贴主名进标题；「有人说/有人称」。

## 摘要（写法）

只写原文能确认的。数字只留最硬的；其余进 `notes`。

**个人宣布先溯源：** 主链是个人 X/博客时，先找官网/changelog/组织号/官方 GitHub/HF org。找到 → 官方页做 `url`，按内容标 register，去掉个人转发者 people。找不到 → 内容是发版则仍 `release`，`url` 用作者仓库或 HF，保留作者 people；标题勿把雇主组织写成发版方。发现帖可进 `links`。

**归因：**
- 禁用「有人说 / 有人称」。
- **rumor：summary 必须写贴主名**（`Fomsky_Wei 称…`）；title 只写事实句。
- community：title 不写贴主；summary 写做法/结果，需要归因时可写贴主名，但不要「某某介绍」开场套话。

不要：宣布/旨在/标志着；复述标题后再堆第二产品；changelog/方法段整段搬进卡；分流判断写给读者。

## 按材料压

| 材料 | 卡上留 | 丢进 `notes` |
| --- | --- | --- |
| 发版 / 条款 | 变化本身 + 谁能用 + 入口/限制 | 安装脚本、退出开关、同版本其他修复 |
| changelog | **一条**主变化 + 对谁生效 | 完整 bullet |
| 论文 / 评测 | 测了什么 + 一个可核结果 | 方法、消融、未见 arXiv |
| 官方 X | 帖里可核事实 + 范围 | 氛围、转发链 |
| community | 活动/趣闻/可复现实践/带数据调研 | 空观点、感想 |
| rumor | title=事实；summary=「谁称…」 | 你的判断、未打开原文 |
| 羊毛 | 谁、给什么、怎么领、截止 | 薅法细节、同类比较 |

社区压不成「谁做了什么 / 有何数据」→ 不成卡。

## 写完自检

- [ ] **summary 无 Atom/lane/并卡/补漏/未见原文/分流理由等内部话，读起来像给公众看的**
- [ ] 标题无「有人说」；不知名贴主不在 title
- [ ] rumor 的 summary 有贴主名归因
- [ ] 摘要相对标题有增量（2–4 句），不是换词复读；只看 summary 也能多知 ≥2 点
- [ ] 正文无 @handle（产品名）
- [ ] 无宣布/标志着；读者看不到 register/分流理由
- [ ] 没有把 notes 编辑句搬进 summary
- [ ] 发版与上架未拆成多卡（可用性进 summary/links；羊毛才进 ai-deals）
- [ ] **已核真实发布时间 + 当日窗口**：`publishedAt`=可核事件时间（非刷帖、非入库时间），落在上次 digest 截止之后；窗口外的已丢，除非是 72h 内从未成卡的补漏（`backfill: true`、放文件最前、notes 注明）或进行中 ai-deals；没改日期凑窗口；有截止写了 `expiresAt`
- [ ] lane 推过的条目：digest 用了同一个 `id`；没建 D+1 队列文件
