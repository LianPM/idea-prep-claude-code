---
description: EXPERT capability for scaffolding complex .claude/ environments (Agents, Docs, Commands).
tools: ["init-structure.sh"]
---

# Project Genesis Skill

Use this skill whenever the user wants to start a new project or run the `/idea` command.
It provides the standard operating procedures for creating a "Virtual Team" of sub-agents.

## Capabilities
1.  **Architecture Expansion**: Use the prompt in `prompts/expand-idea.md` to turn a 1-sentence idea into a full technical spec.
2.  **Structural Integrity**: Use `tools/init-structure.sh` to guarantee the filesystem is ready.
3.  **Template Compliance**: You MUST read `cookbook/agent-architecture.md` before creating any `.claude/agents/*.md` files to ensure they have the correct Frontmatter and Tool definitions.