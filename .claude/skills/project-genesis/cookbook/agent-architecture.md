# The Gold Standard: Agent & Command Architecture

When creating files in `.claude/`, strictly adhere to these templates and patterns.

## 1. Agent Template

**Location**: `.claude/agents/{role-name}.md`

### Required Frontmatter

```yaml
---
name: "The [Role]"
description: "[One-line description of capabilities]"
icon: "[Relevant emoji]"
model: inherit
permissions:
  - bash
  - read_file
  - write_file
  - glob
  - grep
---
```

### Full Agent Template

```markdown
---
name: "The Builder"
description: "Implements features, writes code, creates files"
icon: "🔨"
model: inherit
permissions:
  - bash
  - read_file
  - write_file
  - glob
  - grep
---

# The Builder

You are **The Builder**, a pragmatic full-stack developer who ships working code.

## Core Identity

[2-3 sentences describing who this agent is and their philosophy]

## Behavioral Traits

- **Decision Style**: [cautious | balanced | aggressive]
- **Communication**: [verbose | concise | technical]
- **Focus**: [quality | speed | innovation]

## Capabilities

1. [Primary capability]
2. [Secondary capability]
3. [Tertiary capability]

## Constraints

1. ALWAYS read `.claude/docs/RULES.md` before writing code
2. ALWAYS update `.claude/memory/context.md` after completing work
3. NEVER commit directly - hand off for review first
4. NEVER modify files outside project scope

## Workflow

### Starting Work
1. Read the task assignment from Manager or memory
2. Load relevant context from `.claude/memory/`
3. Review RULES.md for project constraints
4. Announce: "Building {task}..."

### During Work
1. Create/modify files as needed
2. Test basic functionality
3. Track progress in memory
4. Report blockers immediately

### Completing Work
1. List all files created/modified
2. Update `.claude/memory/tasks.md`
3. Create handoff in `.claude/memory/handoffs.md`
4. Announce: "Complete. Ready for review."

## Handoff Protocol

### Receiving Work
Expect from Manager:
- Task ID and description
- Relevant context
- Expected artifacts
- Deadline/priority if any

### Handing Off
Send to Critic:
- List of files changed
- Summary of implementation
- Known limitations
- Areas of concern

## Communication Patterns

**Starting**: "Building {task-id}: {description}..."
**Progress**: "Created {file}. Working on {next}..."
**Blocked**: "Blocked: {issue}. Need: {what you need}."
**Complete**: "Complete. Files: {list}. Requesting review."

## Error Handling

- **Compilation error**: Fix immediately, retry
- **Test failure**: Document, attempt fix, escalate if stuck
- **Missing dependency**: Note in handoff, continue if possible
- **Unclear requirements**: Stop, ask Manager for clarification
```

## 2. Command Template

**Location**: `.claude/commands/{action}.md`

### Required Frontmatter

```yaml
---
description: "[What this command does]"
argument-hint: "[expected arguments]"
model: inherit  # or specific model
---
```

### Full Command Template

```markdown
---
description: "Execute the main development workflow"
argument-hint: "[task-id | feature-name | next | review | status]"
model: inherit
---

# Command: /develop

**Purpose**: Coordinate development workflow across agents.

## Arguments

| Argument | Description | Example |
|----------|-------------|---------|
| `next` | Pick next available task | `/develop next` |
| `{task-id}` | Work on specific task | `/develop auth-01` |
| `review` | Request code review | `/develop review` |
| `status` | Show progress report | `/develop status` |
| `plan` | Enter planning mode | `/develop plan` |

## Prerequisites

Before running, ensure:
- [ ] `.claude/memory/context.md` exists
- [ ] `.claude/memory/tasks.md` has tasks (or use `plan`)
- [ ] `.claude/docs/RULES.md` is defined

## Workflow

### Step 1: Context Loading
1. Read `.claude/memory/context.md`
2. Determine current phase
3. Load relevant task data

### Step 2: Action Selection
Based on argument:
- `next` → Find first unblocked task
- `{task-id}` → Validate task exists
- `review` → Gather recent changes
- `status` → Compile report

### Step 3: Delegation
Route to appropriate agent:
- Building tasks → The Builder
- Review requests → The Critic
- Planning → The Manager

### Step 4: Memory Update
After completion:
1. Update task status
2. Record in context
3. Log handoff if applicable

## Error Handling

| Error | Resolution |
|-------|------------|
| No tasks found | Suggest `/develop plan` |
| Task has dependencies | Show blocking tasks |
| Agent unavailable | Fall back to Manager |
| Memory file missing | Run `init-structure.sh` |

## Examples

\`\`\`bash
# Start next available task
/develop next

# Work on specific task
/develop auth-01

# Check project status
/develop status

# Request review of recent work
/develop review
\`\`\`
```

## 3. Skill Template

**Location**: `.claude/skills/{skill-name}/SKILL.md`

### Required Frontmatter

```yaml
---
description: "[What this skill provides]"
tools: ["list", "of", "tool-files.sh"]
---
```

### Full Skill Template

```markdown
---
description: "Expert capability for [domain]"
tools: ["tool-one.sh", "tool-two.sh"]
---

# Skill: [Name]

## Purpose
[2-3 sentences describing what this skill enables]

## Capabilities

1. **[Capability 1]**: [Description]
   - Use: `prompts/capability-1.md`

2. **[Capability 2]**: [Description]
   - Use: `tools/capability-2.sh`

3. **[Capability 3]**: [Description]
   - Use: `cookbook/capability-3.md`

## Directory Structure

\`\`\`
.claude/skills/{skill-name}/
├── SKILL.md           # This file
├── prompts/           # LLM prompts
│   └── *.md
├── tools/             # Executable scripts
│   └── *.sh
└── cookbook/          # Reference docs
    └── *.md
\`\`\`

## Usage

### When to Use
- [Trigger condition 1]
- [Trigger condition 2]

### How to Invoke
[Step-by-step instructions]

## Dependencies
- [Required tool/file 1]
- [Required tool/file 2]
```

## 4. Memory File Patterns

### context.md Pattern

```markdown
# Project Context

**Project**: {name}
**Phase**: planning | building | reviewing | shipping
**Current Feature**: {feature or "None"}
**Last Updated**: {ISO timestamp}

## Recent Changes
- {Change 1 with timestamp}
- {Change 2 with timestamp}

## Current Focus
{What we're actively working on}

## Session Notes
{Free-form notes from current session}

## Blockers
{Any blocking issues, or "None"}
```

### tasks.md Pattern

```markdown
# Task Board

## Backlog
- [ ] `{id}`: {Description} (@{agent}) [deps: {dependencies}]

## In Progress
- [~] `{id}`: {Description} (@{agent}) [started: {timestamp}]

## Done
- [x] `{id}`: {Description} (@{agent}) [completed: {timestamp}]

---
*Last updated: {timestamp}*
```

### decisions.md Pattern

```markdown
# Architectural Decision Records

## ADR-{number}: {Title}
- **Date**: {timestamp}
- **Status**: proposed | accepted | deprecated | superseded
- **Context**: {Why this decision was needed}
- **Decision**: {What was decided}
- **Alternatives**: {Other options considered}
- **Consequences**: {Impact of this decision}
```

### handoffs.md Pattern

```markdown
# Agent Handoff Log

## {timestamp} - {From} → {To}
**Type**: build-complete | review-feedback | escalation | status-update
**Task**: {task-id}
**Context**: {Summary of work done}
**Action Required**: {What receiving agent should do}
**Files**: {Relevant file list}
```

## 5. Best Practices

### Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Agent files | `{role}.md` | `builder.md` |
| Command files | `{verb}.md` | `develop.md` |
| Task IDs | `{feature}-{number}` | `auth-01` |
| ADR numbers | 3-digit padded | `ADR-001` |

### Permission Levels

| Level | Permissions | Use For |
|-------|-------------|---------|
| Read-only | `read_file`, `glob`, `grep` | Critic, Reviewer |
| Standard | + `write_file`, `bash` | Builder, Manager |
| Full | + `mcp_*` | Specialists with external access |

### Model Selection

| Scenario | Recommended Model |
|----------|-------------------|
| Quick tasks | `claude-3-5-haiku` |
| Standard dev | `inherit` (uses session model) |
| Complex reasoning | `claude-3-5-sonnet` |
| Architecture decisions | `claude-3-opus` |

### File Organization

```
.claude/
├── agents/           # One file per agent role
├── commands/         # One file per slash command
├── docs/             # Project documentation
│   ├── ARCHITECTURE.md
│   └── RULES.md
├── memory/           # Runtime state (may be gitignored)
│   ├── context.md
│   ├── tasks.md
│   ├── decisions.md
│   └── handoffs.md
└── skills/           # Reusable capabilities
    └── {skill-name}/
        ├── SKILL.md
        ├── prompts/
        ├── tools/
        └── cookbook/
```
