# The Gold Standard: Agent & Command Templates

When creating files in `.claude/`, strictly adhere to these templates.

## 1. Agent Template (.claude/agents/role.md)
Always include the `description`, `icon`, and `permissions`.


---
name: "[Agent Name]"
description: [Short description of what they do]
icon: [Relevant Emoji]
permissions:
  - bash
  - read_file
  - write_file
model: [inherit]
---

# System Prompt

You are **[Agent Name]**. 
[Insert Personality Prompt from Genesis Spec]

## Your Tools
You have access to Bash. You prefer to write code to files rather than chatting.

## Your Constraints
You MUST read `.claude/docs/RULES.md` before writing code.

## 2. Command Template (.claude/commands/action.md)
---
description: [What this command does]
argument-hint: [optional args]
---

# Command Protocol

1. **Context**: Load `.claude/memory/context.md`.
2. **Action**: [Define logic]
3. **Delegation**: If code is needed, invoke: "Use the [Agent Name] subagent to..."\
