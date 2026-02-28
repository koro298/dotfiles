# Agent Skills 作成ルール

## ディレクトリ構造

```
skill-name/
├── SKILL.md                  # 必須
├── scripts/                  # 決定的・反復的な処理用スクリプト
├── references/               # 必要時にロードされるドキュメント
└── assets/                   # テンプレート、画像等
```

- `SKILL.md` は必ず配置する。他のディレクトリは必要に応じて作成する
- 大きな参照ドキュメントは `references/` に分離し、SKILL.md からいつ読むべきか指示する
- 300行を超える reference ファイルには冒頭に目次を付ける

## SKILL.md の書き方

### Frontmatter（必須）

```yaml
---
name: skill-name           # 64文字以内
description: ...           # 200文字以内
---
```

### description の書き方

Claude はスキルを使わない方向に偏る傾向がある。description は積極的（pushy）に書く。

悪い例:
> パワポを作成する

良い例:
> python-pptxでパワポを作成する。プレゼン、スライド、発表資料、pptx、PowerPointに言及された場合は必ずこのスキルを使うこと

ポイント:
- スキルが何をするかに加え、**いつ使うべきか**を明記する
- トリガーとなるユーザーの発話パターンを列挙する
- 「必ずこのスキルを使うこと」のような強い表現を使う

### 本文の書き方

- 500行以内に収める。超える場合は `references/` に分離する
- 指示は命令形で書く（「〜してください」ではなく「〜する」「〜せよ」）
- 出力フォーマットはテンプレートとして明示的に定義する
- 入出力の具体例を含める
- 「なぜそうするか」の理由を添える（MUSTの連発より効果的）

### Progressive Disclosure

スキルは3段階で読み込まれる:

1. **Metadata** — name + description（常にコンテキストに入る、約100語）
2. **SKILL.md 本文** — スキル発動時に読み込まれる（500行以内が目安）
3. **Bundled resources** — 必要時にオンデマンドで読む（サイズ制限なし）

SKILL.md には「どの reference をいつ読むか」の指示を含める。

## ドメイン分割

スキルが複数のドメイン・フレームワークをサポートする場合は reference で分割する:

```
cloud-deploy/
├── SKILL.md            # ワークフロー + 選択ロジック
└── references/
    ├── aws.md
    ├── gcp.md
    └── azure.md
```

Claude は関連する reference ファイルのみ読み込む。

## Examples パターン

```markdown
**Example 1:**
Input: JWTを使ったユーザー認証を追加
Output: feat(auth): JWT認証を実装
```

入出力例はユーザーが実際に入力しそうな自然な表現にする。

## 公式リファレンス

- [Claude Code Skills ドキュメント](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/skills)
- [公式 skill-creator サンプル](https://github.com/anthropics/skills/blob/main/skills/skill-creator/SKILL.md)
