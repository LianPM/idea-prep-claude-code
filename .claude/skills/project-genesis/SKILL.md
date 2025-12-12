---
description: EXPERT capability for scaffolding complex .claude/ environments (Agents, Docs, Commands, Memory).
tools: ["init-structure.sh"]
---

# Project Genesis Skill

Use this skill whenever the user wants to start a new project or run the `/idea` command.
It provides the standard operating procedures for creating a "Virtual Team" of sub-agents with shared memory and coordinated workflows.

## Capabilities

1. **Architecture Expansion**
   - Use `prompts/expand-idea.md` to transform a 1-sentence idea into a comprehensive Genesis Specification
   - Analyzes feasibility, security, and complexity
   - Identifies project type and designs custom agent team
   - Outputs structured JSON with tech stack, features, data models, agents, and workflows

2. **Structural Integrity**
   - Use `tools/init-structure.sh` to create the `.claude/` filesystem
   - Initializes memory system (context, tasks, decisions, handoffs)
   - Creates placeholder documentation (ARCHITECTURE.md, RULES.md)

3. **Template Compliance**
   - Read `cookbook/agent-architecture.md` before creating any agent, command, or skill files
   - Ensures correct frontmatter, permissions, and structure
   - Follow memory file patterns for consistency

4. **Agent Personality Design**
   - Reference `prompts/agent-personalities.md` for personality dimensions
   - Design agents with appropriate style, communication, and focus
   - Ensure team composition creates productive tension (Builder vs Critic)

5. **Collaboration Protocol**
   - Apply rules from `cookbook/collaboration-protocol.md`
   - Define handoff protocols between agents
   - Establish memory access patterns
   - Set up conflict resolution hierarchy

## Usage

### When to Invoke
- User runs `/idea [description]`
- User asks to "start a new project"
- User wants to "bootstrap" or "scaffold" an AI team

### Protocol Steps

**Step 1: Expand**
```
Read prompts/expand-idea.md
Pass user's idea as $ARGUMENTS
Generate Genesis Specification JSON
```

**Step 2: Scaffold**
```
Run tools/init-structure.sh [project-name]
Verify directory structure created
Confirm memory files initialized
```

**Step 3: Build**
```
Read cookbook/agent-architecture.md for templates
Read prompts/agent-personalities.md for personality design
Read cookbook/collaboration-protocol.md for coordination rules

Create files using Genesis Spec:
1. .claude/agents/*.md (Builder, Critic, Manager, + specialists)
2. .claude/docs/ARCHITECTURE.md (from spec outline)
3. .claude/docs/RULES.md (from critical_rules)
4. Update .claude/memory/context.md with project info
5. Update .claude/memory/tasks.md with initial tasks
```

**Step 4: Handoff**
```
Summarize the team created:
- List agents and their roles
- Show available commands
- Describe workflow phases

Prompt: "Your AI team is ready. Run /develop plan to start."
```

## File Reference

| File | Purpose |
|------|---------|
| `prompts/expand-idea.md` | Idea → Genesis Spec transformation |
| `prompts/agent-personalities.md` | Personality dimension guide |
| `cookbook/agent-architecture.md` | File templates (agents, commands, skills, memory) |
| `cookbook/collaboration-protocol.md` | Agent coordination rules |
| `tools/init-structure.sh` | Directory and memory initialization |

## Output Artifacts

After running Project Genesis, the target project will have:

```
.claude/
├── agents/
│   ├── builder.md
│   ├── critic.md
│   └── manager.md
├── commands/
│   └── develop.md
├── docs/
│   ├── ARCHITECTURE.md
│   └── RULES.md
├── memory/
│   ├── context.md
│   ├── tasks.md
│   ├── decisions.md
│   └── handoffs.md
└── skills/
    └── (project-specific skills if needed)
```
