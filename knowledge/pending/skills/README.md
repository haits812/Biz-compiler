# Pending Skill Proposals

`skill-creator-gate` が作る repo-local Skill proposal を置く。

ここにあるものは正式Skillではない。人間が承認した後、`knowledge/ops/skills/<skill-name>/` に反映し、`knowledge/ops/registry.md`、`knowledge/ops/README.md`、`Hello-world.md` を同期する。

## 作成補助

```powershell
.\knowledge\ops\skills\skill-creator-gate\new-skill-proposal.ps1 `
  -Name "skill-name" `
  -Intent "何をSkill化したいか" `
  -Triggers "自然文1;自然文2" `
  -Steps "intake;inventory;design;validate" `
  -Validation "何を確認するか" `
  -CollisionCheck "既存Skillとの関係" `
  -Risk "残リスク"
```

## レビュー

```powershell
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 list -Stage all
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 show -Id "skills/<file>.md"
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 approve -Id "skills/<file>.md" -Reason "採用理由"
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 applied -Id "approved/skills/<file>.md" -Reason "正式Skillへ反映済み"
```