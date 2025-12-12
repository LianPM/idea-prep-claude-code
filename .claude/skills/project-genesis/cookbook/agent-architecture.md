# Agent & Command Architecture

Templates and patterns for creating dynamically-generated agents and commands.

## 1. Agent Template

**Location**: `.claude/agents/{agent-name}.md`

### Frontmatter (Required)

```yaml
---
name: "The [Domain-Relevant Name]"
description: "[Specific expertise area]"
icon: "[Emoji that represents their role]"
model: inherit
permissions:
  - bash
  - read_file
  - write_file
  - glob
  - grep
---
```

### Full Agent Structure

```markdown
---
name: "{name from Genesis Spec}"
description: "{expertise from Genesis Spec}"
icon: "{contextual emoji}"
model: inherit
permissions:
  - bash
  - read_file
  - write_file
  - glob
  - grep
---

# {Agent Name}

{system_prompt from Genesis Spec - this defines their personality and approach}

## Expertise

{expertise} - {expanded description of what makes them uniquely qualified}

## Responsibilities

{For each item in responsibilities array:}
- {responsibility}

## Triggers

Invoke me when:
{For each item in triggers array:}
- {trigger condition}

## Collaboration

I work closely with:
{For each collaborator in collaborates_with:}
- **{collaborator name}**: {context on what we hand off}

## Workflow

### Receiving Work
I expect to receive:
- Clear task description
- Relevant context from `.claude/memory/`
- Any constraints or requirements

### Doing Work
1. Read `.claude/docs/RULES.md` first
2. Check `.claude/memory/context.md` for current state
3. Execute my responsibilities
4. Document progress

### Handing Off
When complete, I:
1. Update `.claude/memory/context.md`
2. Log handoff in `.claude/memory/handoffs.md`
3. Notify the next agent in the workflow

## Constraints

1. ALWAYS read project rules before writing code
2. ALWAYS update memory files after completing work
3. NEVER work outside my area of expertise - delegate to appropriate agent
4. ALWAYS follow the collaboration protocol
```

## 2. Command Template

**Location**: `.claude/commands/{command-name}.md`

```markdown
---
description: "[What this command does]"
argument-hint: "[expected arguments]"
model: inherit
---

# Command: /{command-name}

**Purpose**: {description}

## Arguments

| Argument | Description |
|----------|-------------|
| {arg} | {what it does} |

## Workflow

### Step 1: {First Action}
{What to do}

### Step 2: {Next Action}
{What to do}

## Agent Delegation

When delegating to agents, use this pattern:

"Use the {Agent Name} agent to {specific task}.

Context:
- {relevant context}
- {relevant context}

Expected output:
- {what the agent should produce}"

## Error Handling

| Condition | Action |
|-----------|--------|
| {error condition} | {how to handle} |
```

## 3. Skill Template

**Location**: `.claude/skills/{skill-name}/SKILL.md`

```markdown
---
description: "{What this skill provides}"
tools: ["{tool-file.sh}"]
---

# Skill: {Name}

## Purpose
{What this skill enables}

## Capabilities
1. **{Capability}**: {Description}

## Usage
{How to invoke and use this skill}
```

## 4. Memory File Patterns

### context.md

```markdown
# Project Context

**Project**: {name}
**Phase**: planning | building | reviewing | shipping
**Complexity**: simple | medium | complex
**Domain**: {domain}
**Last Updated**: {timestamp}

## Team
{For each agent:}
- **{Agent Name}**: {one-line expertise}

## Key Challenges
{List from Genesis Spec analysis}

## Current Focus
{What's being worked on now}

## Recent Activity
- {timestamp}: {what happened}

## Blockers
{Any blocking issues, or "None"}
```

### tasks.md

```markdown
# Task Board

## Backlog
- [ ] `{task-id}`: {Description} (@{agent-name}) [priority: {mvp|phase-2}]

## In Progress
- [~] `{task-id}`: {Description} (@{agent-name}) [started: {timestamp}]

## Done
- [x] `{task-id}`: {Description} (@{agent-name}) [completed: {timestamp}]

---
*Updated: {timestamp}*
```

### decisions.md

```markdown
# Architectural Decision Records

## ADR-{number}: {Title}
- **Date**: {timestamp}
- **Status**: proposed | accepted | deprecated
- **Context**: {Why this decision was needed}
- **Decision**: {What was decided}
- **Alternatives**: {Other options considered}
- **Consequences**: {Impact}
```

### handoffs.md

```markdown
# Agent Handoff Log

## {timestamp} - {From Agent} → {To Agent}
**Type**: task-complete | review-request | escalation | question
**Task**: {task-id}
**Summary**: {What was done}
**Output**: {Files created/modified}
**Next Action**: {What receiving agent should do}
```

## 5. Dynamic Agent Invocation

Since agents are generated dynamically based on the project idea, the `/develop` command doesn't hardcode agent names. Instead, it:

1. Reads `.claude/memory/tasks.md` to find the assigned agent
2. Reads `.claude/agents/` to find the matching agent file
3. Invokes using: "Use the {Agent Name} agent to..."

### Pattern for Dynamic Delegation

```markdown
## Delegating to Project Agents

1. Check `.claude/memory/tasks.md` for task assignment
2. Find agent: `@{agent-name}` in task description
3. Read `.claude/agents/{agent-name}.md` for agent details
4. Delegate with full context:

"Use the {Agent Name} agent to complete task {task-id}.

Task: {task description}
Context: {from memory/context.md}
Rules: Read .claude/docs/RULES.md
Collaborate with: {from agent's collaborates_with}

When complete, update memory and hand off."
```

## 6. Best Practices

### Agent Naming
- Use domain-relevant names: "The Vault Keeper" not "Security Expert"
- Names should be memorable and reflect personality
- Format: "The [Descriptive Name]"

### Emoji Selection
Choose emojis that reflect the agent's role:
- 🔨 Building/creating
- 🔍 Reviewing/analyzing
- 🛡️ Security/protection
- 🚀 Deployment/shipping
- 📊 Data/analytics
- 🧪 Testing/experimentation
- 🏗️ Architecture/design
- 📝 Documentation/writing

### Permission Levels

| Permission | When to Include |
|------------|-----------------|
| `bash` | Agents that run commands |
| `read_file` | All agents |
| `write_file` | Agents that create/modify code |
| `glob` | Agents that search files |
| `grep` | Agents that search content |
| `mcp_*` | Agents needing external services |

### Team Size Guidelines

| Complexity | Team Size | Example |
|------------|-----------|---------|
| Simple | 2-3 agents | Blog, TODO app |
| Medium | 4-5 agents | E-commerce, SaaS |
| Complex | 6-8 agents | Trading platform, Healthcare |

Don't over-engineer - every agent must earn their place.
