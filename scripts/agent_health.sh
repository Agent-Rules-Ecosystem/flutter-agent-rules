#!/usr/bin/env bash
# ==============================================================================
# 🩺 Agent Health Linter & Integrity Validator (agent_health.sh)
# Framework: Agent-Rules-Ecosystem (flutter-agent-rules & skills)
# ==============================================================================

set -u

# ANSI Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

ERRORS=0
WARNINGS=0

echo -e "${BOLD}${BLUE}======================================================${NC}"
echo -e "${BOLD}${BLUE} 🩺 Running Agent Health Check (agent_health) ${NC}"
echo -e "${BOLD}${BLUE}======================================================${NC}"

PROJECT_ROOT="$(pwd)"

# ------------------------------------------------------------------------------
# 1. Verification of overview/ Trackers & Control Files
# ------------------------------------------------------------------------------
echo -e "\n${BOLD}[1/5] Auditing overview/ tracker files...${NC}"

REQUIRED_TRACKERS=(
  "overview/session.md"
  "overview/work.md"
  "overview/architecture.md"
  "overview/learning.md"
  "overview/work_review.md"
  "overview/work/tasks.md"
  "overview/work/pendientes.md"
  "overview/work/deuda_tecnica.md"
)

if [ ! -d "$PROJECT_ROOT/overview" ]; then
  echo -e "  ${YELLOW}⚠️ INFO: 'overview/' directory not in project root (Governance Template mode).${NC}"
else
  for file in "${REQUIRED_TRACKERS[@]}"; do
    target="$PROJECT_ROOT/$file"
    if [ -f "$target" ]; then
      if [ ! -s "$target" ]; then
        echo -e "  ${RED}❌ ERROR: Tracker file '$file' is EMPTY (corrupted).${NC}"
        ERRORS=$((ERRORS + 1))
      else
        echo -e "  ${GREEN}✓${NC} $file present and valid."
      fi
    else
      echo -e "  ${YELLOW}⚠️ WARN: Tracker file '$file' missing.${NC}"
      WARNINGS=$((WARNINGS + 1))
    fi
  done
fi

# ------------------------------------------------------------------------------
# 2. Mermaid Diagram Syntax Audit
# ------------------------------------------------------------------------------
echo -e "\n${BOLD}[2/5] Validating Mermaid syntax in documentation...${NC}"

MERMAID_FILES=$(find "$PROJECT_ROOT" -maxdepth 4 -name "*.md" -not -path "*/.git/*" 2>/dev/null || true)

MERMAID_ERRORS=0
for file in $MERMAID_FILES; do
  if [ -f "$file" ] && grep -q '```mermaid' "$file" 2>/dev/null; then
    # Check for unquoted label containing parenthesis inside brackets e.g. node[Label (Extra)]
    MATCHES=$(grep -n -E '\[[^"'\''\n]*\([^"'\''\n]*\]' "$file" 2>/dev/null | grep -v '```' || true)
    if [ -n "$MATCHES" ]; then
      echo -e "  ${RED}❌ MERMAID SYNTAX ERROR in ${file}:${NC}"
      echo -e "     Unquoted parenthesis inside bracket label detected. Use quotes: node[\"Label (Info)\"]"
      echo "$MATCHES" | head -n 3 | sed 's/^/     /'
      MERMAID_ERRORS=$((MERMAID_ERRORS + 1))
      ERRORS=$((ERRORS + 1))
    fi
  fi
done

if [ "$MERMAID_ERRORS" -eq 0 ]; then
  echo -e "  ${GREEN}✓${NC} Mermaid syntax validation passed across all markdown files."
fi

# ------------------------------------------------------------------------------
# 3. Skill Standard Audit (SKILL_STANDARD.md)
# ------------------------------------------------------------------------------
echo -e "\n${BOLD}[3/5] Auditing Agent Skills structure (.skill / skills)...${NC}"

SKILL_COUNT=0
for parent in ".skill" "skills"; do
  if [ -d "$PROJECT_ROOT/$parent" ]; then
    for skill_dir in "$PROJECT_ROOT/$parent"/*; do
      if [ -d "$skill_dir" ]; then
        SKILL_COUNT=$((SKILL_COUNT + 1))
        skill_name="$(basename "$skill_dir")"
        has_skill_md=false
        has_adapters=false
        
        [ -f "$skill_dir/SKILL.md" ] && has_skill_md=true
        [ -d "$skill_dir/adapters" ] && has_adapters=true

        if $has_skill_md || $has_adapters; then
          echo -e "  ${GREEN}✓${NC} Skill '$skill_name' complies with SKILL_STANDARD architecture."
        else
          echo -e "  ${YELLOW}⚠️ WARN: Skill '$skill_name' missing 'SKILL.md' or 'adapters/' folder.${NC}"
          WARNINGS=$((WARNINGS + 1))
        fi
      fi
    done
  fi
done

if [ "$SKILL_COUNT" -eq 0 ]; then
  echo -e "  ${GREEN}ℹ️ No skills submodules/directories found in current root.${NC}"
fi

# ------------------------------------------------------------------------------
# 4. Templates Integrity Check
# ------------------------------------------------------------------------------
echo -e "\n${BOLD}[4/5] Auditing Templates directory integrity...${NC}"

if [ -d "$PROJECT_ROOT/templates" ]; then
  TEMPLATES_FOUND=$(find "$PROJECT_ROOT/templates" -type f | wc -l)
  echo -e "  ${GREEN}✓${NC} 'templates/' directory verified with ${TEMPLATES_FOUND} template files."
else
  echo -e "  ${YELLOW}⚠️ WARN: 'templates/' directory missing.${NC}"
  WARNINGS=$((WARNINGS + 1))
fi

# ------------------------------------------------------------------------------
# 5. Privacy & Secret Scanning Check
# ------------------------------------------------------------------------------
echo -e "\n${BOLD}[5/5] Checking Git staging for exposed credentials...${NC}"

SENSITIVE_FILES=$(git status --porcelain 2>/dev/null | grep -E '\.env$|\.key$|\.pem$|google-services\.json$|key\.jks$' || true)
if [ -n "$SENSITIVE_FILES" ]; then
  echo -e "  ${RED}❌ CRITICAL PRIVACY THREAT: Sensitive file(s) staged or untracked:${NC}"
  echo "$SENSITIVE_FILES" | sed 's/^/     /'
  ERRORS=$((ERRORS + 1))
else
  echo -e "  ${GREEN}✓${NC} Privacy scan passed. No exposed credentials staged."
fi

# ------------------------------------------------------------------------------
# Summary & Exit Status
# ------------------------------------------------------------------------------
echo -e "\n${BOLD}${BLUE}======================================================${NC}"
echo -e "${BOLD}Health Check Summary:${NC}"
echo -e "  Errors   : ${ERRORS}"
echo -e "  Warnings : ${WARNINGS}"

if [ "$ERRORS" -gt 0 ]; then
  echo -e "\n${RED}${BOLD}❌ HEALTH CHECK FAILED: Fix ${ERRORS} error(s) before proceeding.${NC}"
  exit 1
elif [ "$WARNINGS" -gt 0 ]; then
  echo -e "\n${YELLOW}${BOLD}⚠️ HEALTH CHECK PASSED WITH WARNINGS (${WARNINGS} warning(s)).${NC}"
  exit 0
else
  echo -e "\n${GREEN}${BOLD}🎉 ALL HEALTH CHECKS PASSED PERFECTLY!${NC}"
  exit 0
fi
