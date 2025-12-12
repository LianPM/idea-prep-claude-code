# Agent Collaboration Protocol

This document defines how agents communicate, hand off work, and resolve conflicts.

## Core Principles

1. **Single Responsibility**: Each agent owns their domain
2. **Explicit Handoffs**: Never assume another agent knows context
3. **Shared Memory**: All state lives in `.claude/memory/`
4. **Escalate Early**: When uncertain, ask the human

## Agent Roles & Boundaries

| Agent | Owns | Triggers | Hands Off To |
|-------|------|----------|--------------|
| **Manager** | Context, planning, coordination | Start of session, confusion, blockers | Builder, Critic |
| **Builder** | Code implementation | "build", "implement", "create", "fix" | Critic (for review) |
| **Critic** | Quality, security, review | "review", "check", after builds | Builder (for fixes), Manager (if approved) |

## Handoff Protocol

### Builder → Critic Handoff

When Builder completes implementation:

```markdown
## Handoff: Build Complete

**Task**: {task-id}
**Files Modified**:
- `path/to/file.ts` - {what changed}
- `path/to/other.ts` - {what changed}

**Testing Done**:
- [ ] Compiles without errors
- [ ] Basic functionality verified
- [ ] No obvious security issues

**Review Focus**:
- {specific areas of concern}
- {any shortcuts taken}

**Ready for**: Critic review
```

### Critic → Builder Handoff (Issues Found)

When Critic finds problems:

```markdown
## Handoff: Review Feedback

**Task**: {task-id}
**Verdict**: Changes Required

**Issues**:
1. **[HIGH]** `file.ts:42` - SQL injection vulnerability
   - Current: `query = "SELECT * FROM users WHERE id = " + id`
   - Required: Use parameterized queries

2. **[MEDIUM]** `file.ts:67` - Missing error handling
   - Add try/catch around database operations

3. **[LOW]** `file.ts:15` - Inconsistent naming
   - Rename `getData` to `fetchUserData` for clarity

**Ready for**: Builder fixes
```

### Critic → Manager Handoff (Approved)

When Critic approves:

```markdown
## Handoff: Review Approved

**Task**: {task-id}
**Verdict**: Approved

**Quality Assessment**:
- Code Quality: 8/10
- Security: 9/10
- Performance: 7/10
- Test Coverage: 6/10

**Notes**:
- {any observations for future work}

**Ready for**: Next task or feature completion
```

## Shared Memory Protocol

### Reading Memory

Before starting any work:
1. Read `.claude/memory/context.md` for current state
2. Read `.claude/memory/tasks.md` for task board
3. Check `.claude/memory/decisions.md` for relevant ADRs

### Writing Memory

After completing work:
1. Update task status in `tasks.md`
2. Log significant changes in `context.md`
3. Record architectural decisions in `decisions.md`

### Memory Lock Convention

To prevent conflicts, agents should:
```markdown
<!-- LOCK: agent-name, timestamp -->
{content being modified}
<!-- UNLOCK -->
```

## Conflict Resolution

### Disagreement Between Agents

When Builder and Critic disagree:

1. **Document the conflict** in `decisions.md`:
   ```markdown
   ## Conflict: {description}
   - Builder position: {argument}
   - Critic position: {argument}
   - Evidence: {relevant facts}
   ```

2. **Escalate to Manager** with summary

3. **Manager decides** based on:
   - Project priorities (speed vs quality)
   - Risk assessment
   - Precedent from previous decisions

4. **If still unresolved**: Ask the human

### Priority Hierarchy

When goals conflict:
1. **Security** > Performance > Features
2. **Working code** > Perfect code
3. **User needs** > Technical elegance
4. **Explicit rules** > Implicit conventions

## Communication Patterns

### Requesting Help

```markdown
## Request: {type}

**From**: {agent-name}
**To**: {target-agent}
**Priority**: high | medium | low

**Context**: {what I'm working on}
**Question**: {specific ask}
**Attempted**: {what I already tried}
```

### Status Updates

```markdown
## Status: {agent-name}

**Working On**: {task-id}
**Progress**: {percentage or description}
**Blockers**: {none | description}
**ETA**: {estimate if known}
```

### Completion Signals

```markdown
## Complete: {task-id}

**Agent**: {name}
**Duration**: {time spent}
**Outcome**: success | partial | blocked
**Artifacts**: {files created/modified}
**Next**: {recommended next step}
```

## Error Handling

### Agent Failure Recovery

If an agent encounters an unrecoverable error:

1. **Stop immediately** - Don't make it worse
2. **Document the state**:
   ```markdown
   ## Error Report

   **Agent**: {name}
   **Task**: {task-id}
   **Error**: {description}
   **State**: {what was in progress}
   **Files affected**: {list}
   **Recovery suggestion**: {how to fix}
   ```
3. **Notify Manager** for coordination
4. **Wait for human** if destructive action needed

### Rollback Protocol

When changes need to be undone:

1. Manager initiates rollback request
2. Builder identifies affected files
3. Use git to revert: `git checkout HEAD~1 -- {files}`
4. Critic verifies rollback success
5. Update memory to reflect current state

## Session Continuity

### Starting a New Session

1. Manager reads all memory files
2. Summarizes current state to human
3. Recommends next action
4. Awaits confirmation before proceeding

### Ending a Session

1. Current agent completes atomic unit of work
2. Updates all memory files
3. Documents stopping point:
   ```markdown
   ## Session End

   **Last Action**: {what was done}
   **Next Action**: {what should happen next}
   **Open Questions**: {anything unresolved}
   ```
