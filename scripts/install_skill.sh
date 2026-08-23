#!/usr/bin/env bash
# ==============================================================================
# 📦 Smart Skill Installer & Dependency Resolver (install_skill.sh)
# Framework: Agent-Rules-Ecosystem
# ==============================================================================

set -euo pipefail

# ANSI Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m' # No Color

ORG_BASE_URL="https://github.com/Agent-Rules-Ecosystem"
PROJECT_ROOT="$(pwd)"
SKILL_BASE_DIR="$PROJECT_ROOT/.skill"

mkdir -p "$SKILL_BASE_DIR"

if [ $# -eq 0 ]; then
  echo -e "${RED}${BOLD}Error: Missing skill name or URL.${NC}"
  echo -e "Usage: ./scripts/install_skill.sh <skill-name-or-url>"
  echo -e "Example: ./scripts/install_skill.sh flutter-firebase-auth-agent-skill"
  echo -e "Example: ./scripts/install_skill.sh https://github.com/Agent-Rules-Ecosystem/security-agent-skill.git"
  exit 1
fi

INPUT_SKILL="$1"

# Function to extract skill name from URL or argument
get_skill_name() {
  local input="$1"
  local basename
  basename=$(basename "$input" .git)
  echo "$basename"
}

# Function to get git URL from skill input
get_git_url() {
  local input="$1"
  if [[ "$input" =~ ^https:// || "$input" =~ ^git@ ]]; then
    echo "$input"
  else
    echo "${ORG_BASE_URL}/${input}.git"
  fi
}

install_single_skill() {
  local skill_input="$1"
  local skill_name
  skill_name=$(get_skill_name "$skill_input")
  local git_url
  git_url=$(get_git_url "$skill_input")
  local target_dir="$SKILL_BASE_DIR/$skill_name"

  echo -e "\n${BOLD}${BLUE}======================================================${NC}"
  echo -e "${BOLD}${BLUE} 📦 Installing Skill: ${skill_name}${NC}"
  echo -e "${BOLD}${BLUE}======================================================${NC}"

  if [ -d "$target_dir" ]; then
    echo -e "  ${GREEN}✓${NC} Skill '${skill_name}' is already installed at '.skill/${skill_name}'."
  else
    echo -e "  🚀 Adding Git submodule: ${git_url} -> .skill/${skill_name}"
    if git submodule add "$git_url" ".skill/$skill_name" 2>/dev/null; then
      git submodule update --init --recursive ".skill/$skill_name" 2>/dev/null || true
      echo -e "  ${GREEN}✓ Successfully cloned and initialized '.skill/${skill_name}'.${NC}"
    else
      echo -e "  ${YELLOW}⚠️ Submodule add failed or already registered. Initializing directly...${NC}"
      git submodule update --init --recursive ".skill/$skill_name" 2>/dev/null || true
    fi
  fi

  # Resolve dependencies from skill.yaml manifest if present
  local manifest_path="$target_dir/skill.yaml"
  if [ -f "$manifest_path" ]; then
    echo -e "  📄 Reading manifest: ${skill_name}/skill.yaml"
    
    # Extract dependencies using basic parsing
    # Look for dependencies list items
    local deps
    deps=$(awk '/dependencies:/{flag=1; next} /^[a-zA-Z]/{flag=0} flag {print}' "$manifest_path" | grep -E '^\s*-\s+' | sed 's/^\s*-\s*//' | tr -d '\r' || true)

    if [ -n "$deps" ]; then
      echo -e "  🔗 Found dependencies for '${skill_name}':"
      for dep in $deps; do
        if [ "$dep" != "[]" ] && [ -n "$dep" ]; then
          echo -e "     ➡️ ${BOLD}${dep}${NC}"
          # Recursive call to install dependency
          "$PROJECT_ROOT/scripts/install_skill.sh" "$dep"
        fi
      done
    else
      echo -e "  ${GREEN}✓ No additional dependencies required.${NC}"
    fi
  else
    echo -e "  ${YELLOW}ℹ️ No 'skill.yaml' found in '.skill/${skill_name}'. Skipping dependency resolution.${NC}"
  fi
}

install_single_skill "$INPUT_SKILL"

echo -e "\n${GREEN}${BOLD}🎉 Skill installation & dependency resolution completed for '${INPUT_SKILL}'!${NC}"
