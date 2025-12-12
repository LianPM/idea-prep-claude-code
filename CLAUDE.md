# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Project Genesis** transforms a one-sentence project idea into a complete AI development team with coordinated agents, shared memory, and development workflows.

## Commands

| Command | Purpose |
|---------|---------|
| `/idea [description]` | Bootstrap a new project from an idea |
| `/develop plan` | Break features into tasks |
| `/develop next` | Start next available task |
| `/develop [task-id]` | Work on specific task |
| `/develop review` | Request code review |
| `/develop status` | Show project progress |

## Architecture

```
.claude/
├── commands/
│   ├── idea.md              # Entry point - triggers Project Genesis
│   └── develop.md           # Main development workflow
└── skills/
    └── project-genesis/
        ├── SKILL.md         # Skill definition
        ├── prompts/
        │   ├── expand-idea.md         # Idea → Genesis Spec JSON
        │   └── agent-personalities.md # Personality design guide
        ├── cookbook/
        │   ├── agent-architecture.md      # Agent/command/skill templates
        │   └── collaboration-protocol.md  # Agent coordination rules
        └── tools/
            └── init-structure.sh    # Directory + memory initialization
```

## Genesis Protocol Flow

1. **Expand** (`prompts/expand-idea.md`)
   - Analyzes idea for feasibility, security, complexity
   - Identifies project type (web-app, api, cli, mobile, data-pipeline)
   - Produces Genesis Specification JSON with:
     - Tech stack, features, data models, API endpoints
     - Agent definitions with personalities
     - Workflow phases and commands
     - Memory initialization data

2. **Scaffold** (`tools/init-structure.sh`)
   - Creates `.claude/{agents,commands,docs,memory,skills}`
   - Initializes memory files: context.md, tasks.md, decisions.md, handoffs.md
   - Creates placeholder ARCHITECTURE.md and RULES.md

3. **Build** (using cookbook templates)
   - Writes agent files from `cookbook/agent-architecture.md` templates
   - Writes documentation from spec outlines
   - Creates `/develop` command for workflow

4. **Handoff**
   - Summarizes created team
   - Prompts to run `/develop plan`

## Agent System

### Holy Trinity (Default)
- **The Builder**: Implements features, balanced/concise/speed-focused
- **The Critic**: Reviews code, cautious/technical/quality-focused
- **The Manager**: Coordinates work, balanced/verbose/quality-focused

### Specialists (Created When Needed)
- The Architect, Security Expert, Data Engineer, DevOps, Tester

### Personality Dimensions
- **Style**: cautious | balanced | aggressive
- **Communication**: verbose | concise | technical
- **Focus**: quality | speed | innovation

## Memory System

| File | Purpose |
|------|---------|
| `context.md` | Project state, phase, current focus |
| `tasks.md` | Task board (backlog/in-progress/done) |
| `decisions.md` | Architectural Decision Records |
| `handoffs.md` | Agent-to-agent communication log |

## Collaboration Protocol

Agents follow defined rules for:
- **Handoffs**: Explicit context passing between agents
- **Memory**: Shared read/write to memory files
- **Conflicts**: Priority hierarchy (Security > Performance > Features)
- **Escalation**: When uncertain, ask the human

## Key Files to Modify

| Goal | File |
|------|------|
| Change idea analysis | `prompts/expand-idea.md` |
| Modify agent templates | `cookbook/agent-architecture.md` |
| Adjust collaboration rules | `cookbook/collaboration-protocol.md` |
| Customize personalities | `prompts/agent-personalities.md` |
| Change directory structure | `tools/init-structure.sh` |
| Modify development workflow | `commands/develop.md` |

## Genesis Specification Schema

The expand prompt produces JSON with:
- `project_name`, `project_type`, `description`
- `tech_stack`: frontend, backend, database, infrastructure
- `features[]`: name, priority, complexity, tasks[]
- `data_models[]`: name, fields, relationships
- `api_endpoints[]`: method, path, description, auth_required
- `critical_rules[]`: development constraints
- `agents[]`: filename, name, role, specialty, personality, triggers, system_prompt
- `workflow`: phases[], commands{}
- `docs[]`: filename, purpose, outline[]
- `memory_init`: context, decisions, tasks (initial content)
