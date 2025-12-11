# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repository contains **Project Genesis** - a Claude Code skill for scaffolding complex `.claude/` environments. It creates a "Virtual Team" of sub-agents to kickstart new projects.

## Usage

Run the `/idea` command with a project description:
```
/idea [project_description]
```

This triggers the Project Genesis protocol which:
1. Expands your idea into a Genesis Specification (JSON)
2. Creates the standard `.claude/` directory structure
3. Generates agents, docs, and commands based on the spec
4. Hands off to a `/develop` command

## Architecture

### Directory Structure
```
.claude/
├── commands/
│   └── idea.md          # Entry point - triggers Project Genesis
└── skills/
    └── project-genesis/
        ├── SKILL.md     # Skill definition and capabilities
        ├── prompts/
        │   └── expand-idea.md    # Transforms raw idea → Genesis Spec JSON
        ├── cookbook/
        │   └── agent-architecture.md  # Templates for agents/commands
        └── tools/
            └── init-structure.sh      # Creates .claude/ directory skeleton
```

### Genesis Protocol Flow

1. **Expand**: `prompts/expand-idea.md` converts a 1-sentence idea into structured JSON containing tech stack, critical rules, and agent definitions
2. **Scaffold**: `tools/init-structure.sh` creates directories: `.claude/{agents,commands,docs,memory}`
3. **Build**: Uses `cookbook/agent-architecture.md` templates to write agent files, docs (ARCHITECTURE.md, RULES.md), and commands
4. **Handoff**: Summarizes the created team and prompts to run `/develop`

### Genesis Specification JSON Schema

The expand prompt produces JSON with:
- `project_name`: Project identifier
- `tech_stack`: Frontend, backend, database choices
- `critical_rules`: Array of project constraints
- `agents`: Array of agent definitions (filename, name, specialty, personality_prompt)
- `docs`: Array of documentation files to generate

### Agent "Holy Trinity" Pattern

Projects typically scaffold three core agents:
- **The Builder**: Writes code
- **The Critic**: Reviews and validates
- **The Manager**: Coordinates and delegates

### File Frontmatter Requirements

**Agents** (`.claude/agents/*.md`) require:
- `name`, `description`, `icon`, `permissions`, `model`

**Commands** (`.claude/commands/*.md`) require:
- `description`, `argument-hint` (optional)

## Key Files to Modify

- `prompts/expand-idea.md`: Change how ideas are analyzed and expanded
- `cookbook/agent-architecture.md`: Modify agent/command templates
- `tools/init-structure.sh`: Adjust default directory structure
