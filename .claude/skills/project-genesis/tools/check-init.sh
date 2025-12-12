#!/bin/bash
# Project Genesis: Check if project is initialized
# Returns 0 if initialized, 1 if not
# Usage: ./check-init.sh [--quiet]

QUIET=${1:-""}

check_failed() {
  if [ "$QUIET" != "--quiet" ]; then
    echo ""
    echo "┌─────────────────────────────────────────────────────────┐"
    echo "│  ⚠️  Project Genesis Not Initialized                    │"
    echo "├─────────────────────────────────────────────────────────┤"
    echo "│                                                         │"
    echo "│  This project hasn't been set up with Project Genesis.  │"
    echo "│                                                         │"
    echo "│  To get started, run:                                   │"
    echo "│                                                         │"
    echo "│    /idea [your project description]                     │"
    echo "│                                                         │"
    echo "│  Example:                                               │"
    echo "│    /idea A task management app with team collaboration  │"
    echo "│                                                         │"
    echo "│  This will:                                             │"
    echo "│    ✓ Analyze your idea                                  │"
    echo "│    ✓ Create your AI agent team                          │"
    echo "│    ✓ Set up the development workflow                    │"
    echo "│    ✓ Initialize project memory                          │"
    echo "│                                                         │"
    echo "└─────────────────────────────────────────────────────────┘"
    echo ""
  fi
  exit 1
}

check_passed() {
  if [ "$QUIET" != "--quiet" ]; then
    echo "✅ Project Genesis initialized"
  fi
  exit 0
}

# Check 1: .claude directory exists
if [ ! -d ".claude" ]; then
  check_failed
fi

# Check 2: Memory system exists
if [ ! -f ".claude/memory/context.md" ]; then
  check_failed
fi

# Check 3: At least one agent exists
AGENT_COUNT=$(ls -1 .claude/agents/*.md 2>/dev/null | wc -l)
if [ "$AGENT_COUNT" -eq 0 ]; then
  check_failed
fi

# Check 4: Context file has required fields
if ! grep -q "Phase:" .claude/memory/context.md 2>/dev/null; then
  check_failed
fi

# All checks passed
check_passed
