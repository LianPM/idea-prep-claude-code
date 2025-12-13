---
name: project-genesis
description: >
  Scaffold complete .claude/ development environments with custom AI agent teams,
  documentation, and workflow commands. Use when the user runs the /idea command
  to bootstrap a new project.
---

# Project Genesis

Bootstrap AI-powered development environments from a single idea.

## When to Use

This skill activates when the user runs:
```
/idea [project_description]
```

## Capabilities

### 1. Idea Expansion
Transform a one-sentence project description into a comprehensive Genesis Specification.

**Prompt**: [prompts/expand-idea.md](prompts/expand-idea.md)

The expansion analyzes:
- Domain and industry context
- Technical challenges and complexity
- Required expertise and agent roles
- Tech stack recommendations
- MVP feature breakdown

### 2. Directory Scaffolding
Create the standard `.claude/` directory structure.

**Script**: [tools/init-structure.sh](tools/init-structure.sh)

Creates:
```
.claude/
├── agents/    # Custom agent definitions
├── commands/  # Workflow commands
├── docs/      # Project documentation
└── memory/    # Shared state (gitignored)
```

### 3. Agent Generation
Generate custom agents tailored to the project domain.

**Template**: [cookbook/agent-architecture.md](cookbook/agent-architecture.md)

Each agent includes:
- Frontmatter (name, description, icon, model, permissions)
- System prompt with personality
- Expertise and responsibilities
- Collaboration patterns

### 4. Agent Personalities
Design distinct, domain-relevant agent personalities.

**Reference**: [prompts/agent-personalities.md](prompts/agent-personalities.md)

### 5. Collaboration Protocol
Define how agents communicate and hand off work.

**Reference**: [cookbook/collaboration-protocol.md](cookbook/collaboration-protocol.md)

### 6. Skill Creation
Create domain-aware project skills from the Genesis Spec.

**Template**: [cookbook/skill-template.md](cookbook/skill-template.md)

### 7. Hook Configuration
Configure UserPromptSubmit hooks for context loading and guardrails.

**Reference**: [cookbook/hook-patterns.md](cookbook/hook-patterns.md)

## Output

After running `/idea`, the project will have:
- **3-8 custom agents** based on project complexity
- **1-5 domain-aware skills** - Encoded expertise and standards
- **UserPromptSubmit hook** - Auto-loads context on every prompt
- **ARCHITECTURE.md** - Technical design overview
- **RULES.md** - Project constraints and standards
- **Memory system** - context.md, tasks.md, decisions.md
- **Ready for `/develop`** - Workflow command to start building

## Version History

- v1.2.0 (2025-12): Added domain-aware skills scaffolding, UserPromptSubmit hooks, skill-template.md, hook-patterns.md
- v1.1.0 (2025-12): Dynamic agent generation based on idea analysis, initialization gates
- v1.0.0 (2025-12): Initial release with Holy Trinity pattern
