---
description: Bootstraps a project with a custom AI development team based on your idea.
argument-hint: [project_description]
model: inherit
---

# Project Genesis Protocol

**Goal**: Analyze "$ARGUMENTS" and create a custom-designed AI team to build it.

## Step 1: Team Architecture

Use the `Project Genesis` skill. Read `prompts/expand-idea.md` and pass "$ARGUMENTS" to generate the "Genesis Specification" JSON.

**IMPORTANT**: The prompt instructs you to:
- Deeply analyze the idea's domain, challenges, and complexity
- Design agents with domain-relevant names (NOT generic "Builder", "Critic", "Manager")
- Scale team size to complexity (2-3 for simple, 4-5 for medium, 6-8 for complex)
- Define clear workflows showing how agents collaborate

Generate the full Genesis Specification JSON before proceeding.

## Step 2: Scaffold Structure

Run `init-structure.sh` from the skill tools to create:
- `.claude/agents/` - Will hold your custom agents
- `.claude/commands/` - Workflow commands
- `.claude/docs/` - Project documentation
- `.claude/memory/` - Shared context system

## Step 3: Create the Team

Read `cookbook/agent-architecture.md` for the agent file template.

For **each agent** in the Genesis Specification:

1. Create `.claude/agents/{filename}` using this structure:

```markdown
---
name: "{agent.name}"
description: "{agent.expertise}"
icon: "{appropriate emoji}"
model: inherit
permissions:
  - bash
  - read_file
  - write_file
  - glob
  - grep
---

# {agent.name}

{agent.system_prompt}

## Expertise
{agent.expertise}

## Responsibilities
{list agent.responsibilities}

## Triggers
Invoke me when:
{list agent.triggers}

## Collaboration
I work with:
{list agent.collaborates_with with context on handoffs}

## Constraints
1. ALWAYS read `.claude/docs/RULES.md` before writing code
2. ALWAYS update `.claude/memory/context.md` after completing work
3. Follow the collaboration protocol in `.claude/memory/handoffs.md`
```

## Step 4: Create Skills

Read `cookbook/skill-template.md` for the skill file format.

For **each skill** in the Genesis Specification `skills` array:

1. Create `.claude/skills/{skill.name}/SKILL.md`:

```yaml
---
name: "{skill.name}"
description: >
  {skill.description}
---

# {Skill Name (title case)}

{skill.purpose}

## When to Use

This skill activates when:
{list skill.triggers}

## Instructions

{list skill.instructions as numbered steps}

## Reference

{Domain-specific content based on the skill's purpose}

## Constraints

- Follow .claude/docs/RULES.md
- Update .claude/memory/context.md when relevant
```

**Note**: Scale skills to complexity:
- Simple projects: 1 skill (code-standards)
- Medium projects: 2-3 skills
- Complex projects: 3-5 domain-specific skills

## Step 5: Configure Hooks

Read `cookbook/hook-patterns.md` for hook configuration patterns.

Update `.claude/settings.json` with the UserPromptSubmit hook:

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "{domain-appropriate command from Genesis Spec hooks}"
          }
        ]
      }
    ]
  }
}
```

**Default hook command** (if no domain-specific hook defined):
```bash
if [ -f .claude/memory/context.md ]; then echo '📋 Project Context:' && head -20 .claude/memory/context.md && echo '' && echo '---'; fi
```

**Domain-specific examples**:
- Healthcare: `echo '🏥 HIPAA Reminder: Never log PHI' && cat .claude/memory/context.md 2>/dev/null`
- Fintech: `echo '💰 Compliance: Audit all transactions' && cat .claude/memory/context.md 2>/dev/null`
- E-commerce: `echo '🛒 PCI-DSS: Secure payment data' && cat .claude/memory/context.md 2>/dev/null`

## Step 6: Create Documentation

Using the Genesis Specification:

1. **Create `.claude/docs/ARCHITECTURE.md`**
   - Project summary from `project_summary`
   - Tech stack details
   - Key challenges and how they're addressed
   - Agent team overview with responsibilities

2. **Create `.claude/docs/RULES.md`**
   - All items from `critical_rules`
   - Domain-specific constraints
   - Code standards based on tech stack

3. **Update `.claude/memory/context.md`**
   ```markdown
   # Project Context

   **Project**: {project_name}
   **Phase**: planning
   **Complexity**: {analysis.complexity}
   **Domain**: {analysis.domain}
   **Last Updated**: {timestamp}

   ## Team
   {list each agent with one-line description}

   ## Key Challenges
   {list analysis.key_challenges}

   ## Current Focus
   Ready for feature planning. Run `/develop plan` to begin.
   ```

4. **Update `.claude/memory/tasks.md`** with features as initial backlog

## Step 7: Create Workflow Command

The `/develop` command already exists and will work with any agent team.

It uses dynamic agent invocation based on task assignments, so it doesn't need to know agent names in advance.

## Step 8: Handoff

Present a summary to the user:

```
┌─────────────────────────────────────────────────────────┐
│  ✨ Project Genesis Complete                            │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Project: {project_name}                                │
│  Complexity: {complexity}                               │
│  Domain: {domain}                                       │
│                                                         │
├─────────────────────────────────────────────────────────┤
│  🤖 Your Team                                           │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  {For each agent:}                                      │
│  • {agent.name} - {agent.expertise}                     │
│                                                         │
├─────────────────────────────────────────────────────────┤
│  🧠 Skills Installed                                    │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  {For each skill:}                                      │
│  • {skill.name} - {skill.purpose}                       │
│                                                         │
├─────────────────────────────────────────────────────────┤
│  🪝 Hooks Configured                                    │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  • UserPromptSubmit - {hooks.UserPromptSubmit.purpose}  │
│                                                         │
├─────────────────────────────────────────────────────────┤
│  📋 Initial Backlog                                     │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  {List MVP features}                                    │
│                                                         │
├─────────────────────────────────────────────────────────┤
│  🚀 Next Steps                                          │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Run: /develop plan                                     │
│  This will break features into tasks and start building │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

## Error Handling

- If idea is too vague: Ask for more detail about the problem being solved
- If idea is too broad: Suggest focusing on MVP scope first
- If domain is unclear: Ask clarifying questions before generating team
