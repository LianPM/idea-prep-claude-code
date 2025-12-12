---
description: Bootstraps a project using the Project Genesis skill.
argument-hint: [project_description]
model: inherit
---

# Project Genesis Protocol

**Goal**: Scaffold the project "$ARGUMENTS".

**Step 1: Expand**
Use the `Project Genesis` skill. Read `prompts/expand-idea.md` and pass "$ARGUMENTS" to it to generate the "Genesis Specification" JSON.

**Step 2: Scaffold**
1. Run `init-structure.sh` from the skill tools.
2. Read the `cookbook/agent-architecture.md` to learn the correct file formats.

**Step 3: Build**
Using the JSON from Step 1 and the Templates from Step 2:
1. Write the **Docs** (`ARCHITECTURE.md`, `RULES.md`).
2. Write the **Agents** (`.claude/agents/*.md`).
3. Write the **Commands** (`.claude/commands/develop.md`).

**Step 4: Handoff**
Summarize the team you have created and ask to run `/develop`.