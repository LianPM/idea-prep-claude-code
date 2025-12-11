# Project Genesis

A Claude Code skill for scaffolding complex `.claude/` environments with a "Virtual Team" of sub-agents.

## What it does

Project Genesis transforms a simple project idea into a complete Claude Code project structure with:
- **Agents**: AI team members with defined roles (Builder, Critic, Manager)
- **Commands**: Slash commands for common workflows
- **Docs**: Project architecture and rules documentation
- **Memory**: Persistent context storage

## Installation

Copy the `.claude` folder into your project root:

```bash
git clone https://github.com/LianPM/idea-prep-claude-code.git
cp -r idea-prep-claude-code/.claude your-project/.claude
```

Or use as a template repository.

## Usage

In Claude Code, run:

```
/idea Build a task management app with real-time collaboration
```

The skill will:
1. **Analyze** your idea for technical feasibility and complexity
2. **Generate** a Genesis Specification with tech stack and agent definitions
3. **Scaffold** the `.claude/` directory structure
4. **Create** agent files, documentation, and commands
5. **Hand off** to the generated `/develop` command

## Generated Structure

After running `/idea`, your project will have:

```
.claude/
├── agents/
│   ├── builder.md      # Writes code
│   ├── critic.md       # Reviews and validates
│   └── manager.md      # Coordinates work
├── commands/
│   └── develop.md      # Development workflow
├── docs/
│   ├── ARCHITECTURE.md # Technical design
│   └── RULES.md        # Project constraints
└── memory/
    └── context.md      # Persistent state
```

## Customization

### Modify Agent Templates
Edit `.claude/skills/project-genesis/cookbook/agent-architecture.md` to change how agents are structured.

### Change Idea Expansion Logic
Edit `.claude/skills/project-genesis/prompts/expand-idea.md` to adjust how ideas are analyzed and converted to specifications.

### Adjust Directory Structure
Edit `.claude/skills/project-genesis/tools/init-structure.sh` to add or modify default directories.

## The "Holy Trinity" Pattern

Project Genesis creates three core agents by default:

| Agent | Role |
|-------|------|
| **The Builder** | Writes code, implements features |
| **The Critic** | Reviews code, catches issues, ensures quality |
| **The Manager** | Coordinates tasks, delegates work, maintains context |

## Requirements

- [Claude Code](https://claude.ai/code) CLI installed
- A project directory to scaffold

## License

MIT
