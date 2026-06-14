---
name: hello-world-gate
description: Use when working in the Biz-compiler repository and a change may affect Hello,world.md, repo current-state self-description, root/template/knowledge/output layout, read order, pending counts, or before completing such work.
---

# Hello World Gate

## Scope

This is a Biz-compiler repo-local skill. Do not install it globally. Use it only inside `D:\local\Biz-compiler`.

The executable gate is `knowledge/ops/hello-world-gate.ps1`.

## Purpose

Keep `Hello,world.md` true.

`Hello,world.md` is the repo position file. This skill decides when to regenerate it and when to block progress because it is stale.

## Trigger

Use this skill when any work touches or may affect:

- root layout or root file descriptions
- read order or first-read files
- `Hello,world.md`
- `AGENTS.md`, `SOUL.md`, `USER.md`, `COMPASS.md`, or `MEMORY.md`
- `template/` phase layout or template assets listed by Hello World
- `knowledge/` top-level layout, pending counts, approved counts, or ops assets listed by Hello World
- `output/` business-folder naming rules or actual `output/` directories
- `knowledge/ops/hello-world-gate.ps1` itself

## Required Workflow

1. Start in repo root: `D:\local\Biz-compiler`.
2. Run `.\knowledge\ops\hello-world-gate.ps1 check` before relying on `Hello,world.md` if current-state accuracy matters.
3. Make the requested repo change.
4. If the change affects any trigger item, run `.\knowledge\ops\hello-world-gate.ps1 sync` in the same turn.
5. Always run `.\knowledge\ops\hello-world-gate.ps1 check` after `sync` and before reporting completion.
6. If `check` fails, do not continue as if complete. Fix the stale/mismatched state or report the blocker.

## When Sync Runs

Run `sync` after the change, not before, because it regenerates `Hello,world.md` from the current filesystem state.

Run `sync` in the same turn as the change when:

- adding, moving, renaming, or deleting directories under root, `template/`, `knowledge/`, or `output/`
- changing the meaning or description of first-read files
- changing pending/approved state with `pending-review.ps1`
- changing `COMPASS.md` role text or read routing
- changing `hello-world-gate.ps1` generation logic

For read-only explanation work, run `check` only. If `check` fails, run `sync` only when the mismatch is a legitimate stale Hello World state and not a structural violation.

## What The Gate Enforces

`check` fails when:

- required root dirs/files are missing
- forbidden root dirs exist
- required `template/` phase dirs are missing
- the consent flowchart asset is missing
- `output/` contains placeholders or wrongly named business folders
- generated current-state content differs from `Hello,world.md`

## Reporting

In the final response, state whether `sync` ran and whether `check` passed. If tests or UI checks were not relevant, do not invent them.
