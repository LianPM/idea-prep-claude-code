# Project Genesis

> Transform a single idea into a complete AI development team.

Project Genesis is a Claude Code skill that scaffolds complex `.claude/` environments with coordinated AI agents, shared memory, and development workflows.

## What It Does

**Input**: A one-sentence project idea
**Output**: A fully configured AI team ready to build

```
/idea Build a real-time collaborative note-taking app
```

Project Genesis will:

1. **Analyze** your idea for technical feasibility, security needs, and complexity
2. **Design** a custom agent team with specialized roles
3. **Generate** a complete Genesis Specification (tech stack, features, data models)
4. **Scaffold** the `.claude/` directory with agents, commands, and memory
5. **Initialize** documentation templates (ARCHITECTURE.md, RULES.md)
6. **Hand off** to the `/develop` workflow

## Installation

```bash
git clone https://github.com/LianPM/idea-prep-claude-code.git
cp -r idea-prep-claude-code/.claude your-project/.claude
```

Or use as a GitHub template repository.

## Quick Start

```bash
# 1. Copy .claude folder to your project
cp -r idea-prep-claude-code/.claude ~/my-new-project/.claude

# 2. Open Claude Code in your project
cd ~/my-new-project
claude

# 3. Run the idea command
/idea A task management API with team collaboration features
```

## Generated Structure

After running `/idea`, your project will have:

```
.claude/
├── agents/
│   ├── builder.md       # Implements features
│   ├── critic.md        # Reviews code quality
│   └── manager.md       # Coordinates work
├── commands/
│   ├── idea.md          # Bootstrap (entry point)
│   └── develop.md       # Development workflow
├── docs/
│   ├── ARCHITECTURE.md  # Technical design
│   └── RULES.md         # Development constraints
├── memory/
│   ├── context.md       # Current project state
│   ├── tasks.md         # Task board
│   ├── decisions.md     # Architectural decisions
│   └── handoffs.md      # Agent communication log
└── skills/
    └── project-genesis/ # This skill
```

## The Agent Team

### The Holy Trinity (Default)

| Agent | Role | Personality |
|-------|------|-------------|
| **The Builder** | Implements features, writes code | Balanced, concise, speed-focused |
| **The Critic** | Reviews code, catches issues | Cautious, technical, quality-focused |
| **The Manager** | Coordinates work, maintains context | Balanced, verbose, quality-focused |

### Specialist Agents (Created When Needed)

- **The Architect** - Complex system design
- **The Security Expert** - Auth and security-critical code
- **The Data Engineer** - Data pipelines and models
- **The DevOps** - Infrastructure and deployment
- **The Tester** - Testing strategy and implementation

## Development Workflow

After bootstrapping with `/idea`, use `/develop`:

```bash
# Plan features into tasks
/develop plan

# Start next available task
/develop next

# Work on specific task
/develop auth-01

# Request code review
/develop review

# Check project status
/develop status
```

### Workflow Phases

```
planning → building → reviewing → shipping
    ↑__________|___________|__________↓
```

## Memory System

Project Genesis includes a shared memory system for agent coordination:

| File | Purpose |
|------|---------|
| `context.md` | Current project state, phase, focus |
| `tasks.md` | Task board (backlog, in-progress, done) |
| `decisions.md` | Architectural Decision Records (ADRs) |
| `handoffs.md` | Agent-to-agent communication log |

Agents read and write to these files, enabling:
- Session continuity (pick up where you left off)
- Context sharing (agents know what others did)
- Decision tracking (why was X chosen over Y?)

## Genesis Specification

The `/idea` command produces a comprehensive JSON spec:

```json
{
  "project_name": "collab-notes",
  "project_type": "web-app",
  "tech_stack": {
    "frontend": "Next.js 14 + TailwindCSS",
    "backend": "Next.js API Routes + Socket.io",
    "database": "PostgreSQL + Redis"
  },
  "features": [
    {
      "name": "Real-time Editing",
      "priority": "mvp",
      "tasks": [...]
    }
  ],
  "data_models": [...],
  "api_endpoints": [...],
  "agents": [...],
  "critical_rules": [...]
}
```

## Customization

### Modify Agent Personalities
```
.claude/skills/project-genesis/prompts/agent-personalities.md
```
Define behavioral traits, communication styles, and decision approaches.

### Change Idea Expansion
```
.claude/skills/project-genesis/prompts/expand-idea.md
```
Adjust how ideas are analyzed and converted to specifications.

### Update Agent/Command Templates
```
.claude/skills/project-genesis/cookbook/agent-architecture.md
```
Modify the structure and format of generated agents and commands.

### Customize Collaboration Rules
```
.claude/skills/project-genesis/cookbook/collaboration-protocol.md
```
Define how agents hand off work, resolve conflicts, and communicate.

### Adjust Directory Structure
```
.claude/skills/project-genesis/tools/init-structure.sh
```
Add or modify default directories and memory file templates.

## File Reference

| File | Purpose |
|------|---------|
| `SKILL.md` | Skill definition and capabilities |
| `prompts/expand-idea.md` | Idea → Genesis Specification prompt |
| `prompts/agent-personalities.md` | Personality design guide |
| `cookbook/agent-architecture.md` | Templates for agents, commands, skills |
| `cookbook/collaboration-protocol.md` | Agent coordination rules |
| `tools/init-structure.sh` | Directory and memory initialization |
| `commands/idea.md` | Entry point command |
| `commands/develop.md` | Development workflow command |

## Requirements

- [Claude Code](https://claude.ai/code) CLI
- A project directory to scaffold

## Examples

### Web Application
```
/idea A SaaS dashboard for tracking marketing metrics with OAuth and Stripe integration
```

### CLI Tool
```
/idea A CLI tool for batch-renaming files with regex patterns and dry-run mode
```

### API Service
```
/idea A REST API for managing inventory with barcode scanning and low-stock alerts
```

### Data Pipeline
```
/idea An ETL pipeline that syncs Salesforce contacts to a data warehouse nightly
```

## License

MIT

---

Built with Project Genesis. Bootstrapped by `/idea`.
