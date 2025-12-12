# Pre-Command Hook: Initialization Gate

This hook runs before any command to ensure Project Genesis has been initialized.

## Gate Logic

Before executing ANY command (except `/idea` and `/help`), check:

```
IF command is NOT /idea AND command is NOT /help:
  CHECK if .claude/memory/context.md exists
  CHECK if .claude/agents/ has at least one .md file

  IF either check fails:
    BLOCK command
    SHOW initialization prompt
    EXIT
```

## Initialization Check

```bash
# Check 1: Memory system exists
if [ ! -f ".claude/memory/context.md" ]; then
  echo "❌ Project not initialized"
  exit 1
fi

# Check 2: At least one agent exists
if [ -z "$(ls -A .claude/agents/*.md 2>/dev/null)" ]; then
  echo "❌ No agents found"
  exit 1
fi

# Check 3: Context shows initialized state
if ! grep -q "Phase:" .claude/memory/context.md 2>/dev/null; then
  echo "❌ Memory not properly initialized"
  exit 1
fi
```

## Blocked Command Response

When a command is blocked, display:

```
┌─────────────────────────────────────────────────────────┐
│  ⚠️  Project Genesis Not Initialized                    │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  This project hasn't been set up with Project Genesis.  │
│                                                         │
│  To get started, run:                                   │
│                                                         │
│    /idea [your project description]                     │
│                                                         │
│  Example:                                               │
│    /idea A task management app with team collaboration  │
│                                                         │
│  This will:                                             │
│    ✓ Analyze your idea                                  │
│    ✓ Create your AI agent team                          │
│    ✓ Set up the development workflow                    │
│    ✓ Initialize project memory                          │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

## Exempt Commands

These commands bypass the initialization check:
- `/idea` - The initialization command itself
- `/help` - Should always be accessible
- `/init` - Manual structure initialization (if added)
