#!/bin/bash
# Ensures the standard .claude structure exists with correct permissions

DIRS=(
  ".claude/agents"
  ".claude/commands"
  ".claude/docs"
  ".claude/memory"
)

echo "🏗️  Initializing Project Genesis Structure..."

for dir in "${DIRS[@]}"; do
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
    echo "  ✅ Created $dir"
  else
    echo "  ok $dir exists"
  fi
done

# Create a .gitignore for the memory folder if it doesn't exist
if [ ! -f ".claude/memory/.gitignore" ]; then
  echo "*" > .claude/memory/.gitignore
  echo "!.gitignore" >> .claude/memory/.gitignore
  echo "  ✅ Secured memory folder"
fi