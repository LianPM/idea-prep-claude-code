---
description: Main development workflow - coordinates agents to build features
argument-hint: [task-id | feature-name | "next"]
---

# Development Protocol

**Goal**: Execute the development workflow for "$ARGUMENTS"

## Phase Detection

First, read `.claude/memory/context.md` to determine current project phase:
- **planning** → Run planning workflow
- **building** → Run build workflow
- **reviewing** → Run review workflow
- **shipping** → Run ship workflow

## Workflow: Planning Phase

When `$ARGUMENTS` is empty or "plan":

1. **Load Context**
   - Read `.claude/memory/context.md` for project state
   - Read `.claude/memory/tasks.md` for current task board
   - Read `.claude/docs/ARCHITECTURE.md` for technical design

2. **Task Breakdown**
   - Identify the next MVP feature to implement
   - Break it into atomic tasks (max 30 min each)
   - Assign each task to appropriate agent role
   - Update `.claude/memory/tasks.md` with new tasks

3. **Handoff**
   - Summarize the plan
   - Ask: "Ready to start building? Run `/develop next`"

## Workflow: Building Phase

When `$ARGUMENTS` is a task-id or "next":

1. **Select Task**
   - If "next": Pick the first task from Backlog with no pending dependencies
   - If task-id: Validate it exists and dependencies are met
   - Move task to "In Progress" in `.claude/memory/tasks.md`

2. **Delegate to Builder**
   ```
   Use the Builder agent to implement task: {task-id}

   Context:
   - Task: {task description}
   - Artifacts: {expected files}
   - Rules: Read .claude/docs/RULES.md first

   When complete, list all files created/modified.
   ```

3. **Update Memory**
   - Record what was built in `.claude/memory/context.md`
   - Update task status in `.claude/memory/tasks.md`

4. **Handoff to Review**
   - Summarize what was built
   - Ask: "Ready for review? Run `/develop review`"

## Workflow: Review Phase

When `$ARGUMENTS` is "review":

1. **Identify Changes**
   - Read `.claude/memory/context.md` for recently built items
   - Gather list of modified files

2. **Delegate to Critic**
   ```
   Use the Critic agent to review the recent changes:

   Files to review: {list of files}

   Check for:
   - Code quality and readability
   - Security vulnerabilities
   - Performance issues
   - Adherence to .claude/docs/RULES.md
   - Missing error handling
   - Missing tests

   Provide specific feedback with file:line references.
   ```

3. **Process Feedback**
   - If issues found: Create fix tasks, return to building phase
   - If approved: Move task to "Done", advance to next task

4. **Update Memory**
   - Log review results in `.claude/memory/decisions.md`
   - Update task board

5. **Handoff**
   - Summarize review outcome
   - If more tasks: "Run `/develop next` to continue"
   - If feature complete: "Feature complete! Run `/develop status`"

## Workflow: Status Check

When `$ARGUMENTS` is "status":

1. **Gather State**
   - Read all memory files
   - Count tasks by status

2. **Report**
   ```
   ## Project Status: {project_name}

   **Phase**: {current phase}
   **Feature**: {current feature}

   ### Task Board
   - Backlog: {count}
   - In Progress: {count}
   - Done: {count}

   ### Recent Activity
   {last 3 completed tasks}

   ### Blockers
   {any issues or dependencies}

   ### Next Steps
   {recommended action}
   ```

## Memory File Formats

### context.md
```markdown
# Project Context

**Project**: {name}
**Phase**: planning | building | reviewing | shipping
**Current Feature**: {feature name}
**Last Updated**: {timestamp}

## Recent Changes
- {what was done}
- {what was done}

## Current Focus
{what we're working on now}
```

### tasks.md
```markdown
# Task Board

## Backlog
- [ ] `task-id`: Description (@agent-role) [depends: none]

## In Progress
- [~] `task-id`: Description (@agent-role) [started: timestamp]

## Done
- [x] `task-id`: Description (@agent-role) [completed: timestamp]
```

### decisions.md
```markdown
# Decision Log

## ADR-{number}: {title}
- **Date**: {timestamp}
- **Status**: proposed | accepted | deprecated
- **Context**: {why this decision was needed}
- **Decision**: {what was decided}
- **Consequences**: {impact of this decision}
```

## Error Handling

- **No tasks in backlog**: Prompt to run `/develop plan`
- **Dependencies not met**: Show blocking tasks, suggest order
- **Agent failure**: Log error, suggest manual intervention
- **Memory file missing**: Run `init-structure.sh` to repair
