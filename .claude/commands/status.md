---
description: Check Project Genesis initialization status and project state
argument-hint: (none)
---

# Status Check Protocol

**Goal**: Report Project Genesis initialization status and current project state.

## Step 1: Check Initialization

Perform these checks in order:

### Check A: .claude Directory
```
Does .claude/ directory exist?
```

### Check B: Memory System
```
Do these files exist?
- .claude/memory/context.md
- .claude/memory/tasks.md
- .claude/memory/decisions.md
- .claude/memory/handoffs.md
```

### Check C: Agents
```
Are there any .md files in .claude/agents/?
```

### Check D: Documentation
```
Do these files exist?
- .claude/docs/ARCHITECTURE.md
- .claude/docs/RULES.md
```

## Step 2: Report Status

### If NOT Initialized

Display:

```
┌─────────────────────────────────────────────────────────┐
│  📊 Project Genesis Status                              │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Status: ❌ NOT INITIALIZED                             │
│                                                         │
│  Missing:                                               │
│  {list what's missing}                                  │
│                                                         │
│  To initialize, run:                                    │
│                                                         │
│    /idea [your project description]                     │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### If Initialized

Read `.claude/memory/context.md` and `.claude/memory/tasks.md`, then display:

```
┌─────────────────────────────────────────────────────────┐
│  📊 Project Genesis Status                              │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Status: ✅ INITIALIZED                                 │
│                                                         │
│  Project: {project name from context.md}                │
│  Phase: {current phase}                                 │
│  Last Updated: {timestamp}                              │
│                                                         │
├─────────────────────────────────────────────────────────┤
│  📁 Structure                                           │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Agents: {count} ({list names})                         │
│  Commands: {count}                                      │
│  Memory Files: {count}/4                                │
│  Docs: {count}/2                                        │
│                                                         │
├─────────────────────────────────────────────────────────┤
│  📋 Task Board                                          │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Backlog: {count}                                       │
│  In Progress: {count}                                   │
│  Done: {count}                                          │
│                                                         │
├─────────────────────────────────────────────────────────┤
│  🎯 Next Action                                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  {Recommended next command based on state}              │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

## Step 3: Recommend Next Action

Based on current state, recommend:

| State | Recommendation |
|-------|----------------|
| No tasks in backlog | Run `/develop plan` to break down features |
| Tasks in backlog, none in progress | Run `/develop next` to start building |
| Task in progress | Run `/develop next` to continue |
| Task complete, not reviewed | Run `/develop review` to check quality |
| All tasks done | Celebrate! Or run `/develop plan` for next feature |

## Quick Check Mode

If you just need a yes/no on initialization (for gating), check:
1. `.claude/memory/context.md` exists
2. At least one file in `.claude/agents/`

Both true = initialized. Either false = not initialized.
