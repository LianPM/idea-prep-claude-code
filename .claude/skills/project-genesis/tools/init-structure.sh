#!/bin/bash
# Ensures the standard .claude structure exists with correct permissions

DIRS=(
  ".claude/agents"
  ".claude/commands"
  ".claude/docs"
  ".claude/memory"
  ".claude/skills"
  ".claude/hooks"
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

# Create settings.json if it doesn't exist (team-shared hooks)
if [ ! -f ".claude/settings.json" ]; then
  cat > .claude/settings.json << 'EOF'
{
  "hooks": {}
}
EOF
  echo "  ✅ Created settings.json (team-shared)"
fi

# Create settings.local.json template if it doesn't exist (personal hooks)
if [ ! -f ".claude/settings.local.json" ]; then
  cat > .claude/settings.local.json << 'EOF'
{
  "hooks": {}
}
EOF
  echo "  ✅ Created settings.local.json (personal)"

  # Add settings.local.json to .gitignore if not already there
  if [ -f ".gitignore" ]; then
    if ! grep -q "settings.local.json" .gitignore 2>/dev/null; then
      echo ".claude/settings.local.json" >> .gitignore
      echo "  ✅ Added settings.local.json to .gitignore"
    fi
  fi
fi

echo "✨ Structure ready!"