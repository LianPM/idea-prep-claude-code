# Hook Patterns

Use this reference when configuring hooks in `.claude/settings.json` or `.claude/settings.local.json`.

## Hook Configuration Location

| File | Scope | Git Tracked |
|------|-------|-------------|
| `.claude/settings.json` | Team-shared | Yes |
| `.claude/settings.local.json` | Personal | No (gitignored) |

## Available Hook Events

| Event | When It Fires | Common Uses |
|-------|---------------|-------------|
| `UserPromptSubmit` | User sends a message | Load context, apply guardrails |
| `PreToolUse` | Before tool execution | Block/modify tool calls |
| `PostToolUse` | After tool execution | Format, log, validate |
| `Stop` | Agent finishes responding | Update state, cleanup |
| `SubagentStop` | Subagent finishes | Coordinate multi-agent work |
| `SessionEnd` | Session terminates | Final cleanup |

## Configuration Structure

```json
{
  "hooks": {
    "EventName": [
      {
        "matcher": "pattern (for tool events)",
        "hooks": [
          {
            "type": "command",
            "command": "shell command to run"
          }
        ]
      }
    ]
  }
}
```

## UserPromptSubmit Hook

**Purpose**: Runs when the user submits any message. Use for context loading and guardrails.

### Pattern: Load Project Context

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "cat .claude/memory/context.md 2>/dev/null || echo 'No context loaded'"
          }
        ]
      }
    ]
  }
}
```

### Pattern: Remind About Rules

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "echo '⚠️ Remember: Check .claude/docs/RULES.md before making changes'"
          }
        ]
      }
    ]
  }
}
```

### Pattern: Load Context + Rules Reminder

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "echo '--- Project Context ---' && cat .claude/memory/context.md 2>/dev/null && echo '' && echo '--- Current Phase ---' && grep 'Phase:' .claude/memory/context.md 2>/dev/null || echo 'Project not initialized. Run /idea first.'"
          }
        ]
      }
    ]
  }
}
```

### Pattern: Domain-Specific Reminder (Healthcare)

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "echo '🏥 HIPAA Reminder: Never log PHI. Always encrypt patient data. Check .claude/skills/hipaa-enforcer/ for guidelines.'"
          }
        ]
      }
    ]
  }
}
```

### Pattern: Domain-Specific Reminder (Fintech)

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "echo '💰 Fintech Reminder: All transactions require audit logs. Check SEC compliance. See .claude/skills/sec-compliance/ for rules.'"
          }
        ]
      }
    ]
  }
}
```

## PreToolUse Hook

**Purpose**: Runs before a tool executes. Can block or modify tool calls.

### Pattern: Require Lint Before Write

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Reminder: Run linter after making changes'"
          }
        ]
      }
    ]
  }
}
```

### Pattern: Block Dangerous Commands

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Bash commands are logged for audit purposes'"
          }
        ]
      }
    ]
  }
}
```

## PostToolUse Hook

**Purpose**: Runs after a tool completes. Use for formatting, logging, validation.

### Pattern: Auto-Format After Edit

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Consider running: npm run format'"
          }
        ]
      }
    ]
  }
}
```

### Pattern: Run Tests After Code Change

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "npm test --passWithNoTests 2>/dev/null || echo 'Tests not configured'"
          }
        ]
      }
    ]
  }
}
```

## Stop Hook

**Purpose**: Runs when Claude finishes responding. Use for state updates.

### Pattern: Update Context Timestamp

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "date '+Last activity: %Y-%m-%d %H:%M:%S' >> .claude/memory/activity.log 2>/dev/null || true"
          }
        ]
      }
    ]
  }
}
```

## Combining Multiple Hooks

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "cat .claude/memory/context.md 2>/dev/null || echo 'No context'"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "echo '✅ File modified - consider running tests'"
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "echo \"$(date '+%Y-%m-%d %H:%M'): Session activity\" >> .claude/memory/activity.log 2>/dev/null || true"
          }
        ]
      }
    ]
  }
}
```

## Project Genesis Default Hook

For all projects generated by Project Genesis, use this UserPromptSubmit hook:

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "if [ -f .claude/memory/context.md ]; then echo '📋 Project Context:' && head -20 .claude/memory/context.md && echo '' && echo '---'; fi"
          }
        ]
      }
    ]
  }
}
```

## Domain-Specific Hook Templates

### Healthcare Project
```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "echo '🏥 Healthcare Project - HIPAA compliance required' && cat .claude/memory/context.md 2>/dev/null"
          }
        ]
      }
    ]
  }
}
```

### Fintech Project
```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "echo '💰 Fintech Project - SEC/FINRA compliance required' && cat .claude/memory/context.md 2>/dev/null"
          }
        ]
      }
    ]
  }
}
```

### E-commerce Project
```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "echo '🛒 E-commerce Project - PCI-DSS for payment data' && cat .claude/memory/context.md 2>/dev/null"
          }
        ]
      }
    ]
  }
}
```

## Best Practices

1. **Keep hooks fast** - Long-running hooks slow down every interaction
2. **Use `2>/dev/null || true`** - Gracefully handle missing files
3. **Team hooks in settings.json** - Personal tweaks in settings.local.json
4. **Test hooks manually first** - Run the command in terminal before configuring
5. **Don't block unnecessarily** - Use PreToolUse blocking sparingly
