#!/bin/bash

# sync-templates.sh - Intelligently sync templates while preserving customizations
# Usage: Run from project root directory
# Exit codes: 0 = success, 1 = cancelled, 2 = error

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0;0m'

# Resolve paths relative to this script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Paths
TEMPLATE_DIR="$REPO_ROOT"
MASTER_VERSION_FILE="$TEMPLATE_DIR/VERSION"
MASTER_AGENTS_TEMPLATE="$TEMPLATE_DIR/projects/core/AGENTS.md.template"
MASTER_CLAUDE_TEMPLATE="$TEMPLATE_DIR/projects/core/CLAUDE.md.template"
MASTER_WORKFLOW_FILE="$TEMPLATE_DIR/projects/core/JIMMYS-WORKFLOW.md"
PROJECT_AGENTS_FILE="./AGENTS.md"
PROJECT_CLAUDE_FILE="./CLAUDE.md"
PROJECT_WORKFLOW_FILE="./JIMMYS-WORKFLOW.md"
BACKUP_DIR="./.template-sync-backup"

# Usage
show_usage() {
    echo "Usage: sync-templates.sh [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --auto, -y    Auto-apply without confirmation"
    echo "  --dry-run     Show what would change without applying"
    echo "  --help, -h    Show this help"
    echo ""
    echo "Run from project root directory"
}

# Parse arguments
AUTO_APPLY=false
DRY_RUN=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --auto|-y)
            AUTO_APPLY=true
            shift
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --help|-h)
            show_usage
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            show_usage
            exit 2
            ;;
    esac
done

# Check prerequisites
if [ ! -f "$PROJECT_AGENTS_FILE" ]; then
    echo -e "${RED}❌ Error: AGENTS.md not found in current directory${NC}"
    echo "Run this script from your project root directory"
    exit 2
fi

if [ ! -f "$MASTER_VERSION_FILE" ]; then
    echo -e "${RED}❌ Error: Master VERSION file not found${NC}"
    exit 2
fi

# Read versions
MASTER_VERSION=$(cat "$MASTER_VERSION_FILE" | tr -d '[:space:]')
PROJECT_VERSION=$(grep "TEMPLATE_VERSION:" "$PROJECT_AGENTS_FILE" | head -1 | sed 's/.*TEMPLATE_VERSION: *//' | tr -d '[:space:]')

# Banner
echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}   Template Sync Tool${NC}"
echo -e "${BLUE}======================================${NC}"
echo ""
echo "Project version:  ${PROJECT_VERSION:-unknown}"
echo "Master version:   $MASTER_VERSION"
echo ""

# Check if update needed
if [ "$PROJECT_VERSION" = "$MASTER_VERSION" ]; then
    echo -e "${GREEN}✅ Already up to date!${NC}"
    exit 0
fi

echo -e "${YELLOW}⚠️  Templates are out of date${NC}"
echo ""
echo "What's new in v$MASTER_VERSION:"
grep -A 20 "## Version $MASTER_VERSION" "$TEMPLATE_DIR/CHANGELOG.md" | head -20
echo ""

# Create backup
echo -e "${BLUE}Creating backup...${NC}"
mkdir -p "$BACKUP_DIR"
BACKUP_TIMESTAMP=$(date +%Y%m%d-%H%M%S)
cp "$PROJECT_AGENTS_FILE" "$BACKUP_DIR/AGENTS.md.backup-$BACKUP_TIMESTAMP"
if [ -f "$PROJECT_CLAUDE_FILE" ]; then
    cp "$PROJECT_CLAUDE_FILE" "$BACKUP_DIR/CLAUDE.md.backup-$BACKUP_TIMESTAMP"
fi
if [ -f "$PROJECT_WORKFLOW_FILE" ]; then
    cp "$PROJECT_WORKFLOW_FILE" "$BACKUP_DIR/JIMMYS-WORKFLOW.md.backup-$BACKUP_TIMESTAMP"
fi
echo "✅ Backup created in $BACKUP_DIR"
echo ""

# Extract protected sections from current AGENTS.md
echo -e "${BLUE}Extracting protected sections...${NC}"
TEMP_SECTIONS=$(mktemp)

# Use awk to extract content between PROJECT_SPECIFIC markers
awk '
/<!-- PROJECT_SPECIFIC START: ([A-Z_]+) -->/ {
    capturing=1
    section=$4
    gsub(/ -->/, "", section)
    content=""
    next
}
/<!-- PROJECT_SPECIFIC END: ([A-Z_]+) -->/ {
    if (capturing) {
        print "SECTION:" section
        print content
        print "---"
    }
    capturing=0
    next
}
capturing { content = content $0 "\n" }
' "$PROJECT_AGENTS_FILE" > "$TEMP_SECTIONS"

echo "✅ Extracted $(grep -c '^SECTION:' $TEMP_SECTIONS) protected sections"
echo ""

# Dry run mode
if [ "$DRY_RUN" = true ]; then
    echo -e "${YELLOW}DRY RUN MODE - No changes will be made${NC}"
    echo ""
    echo "Protected sections that would be preserved:"
    grep "^SECTION:" "$TEMP_SECTIONS" | sed 's/SECTION:/  - /'
    echo ""
    echo "To apply changes, run without --dry-run"
    rm "$TEMP_SECTIONS"
    exit 0
fi

# Confirmation
if [ "$AUTO_APPLY" = false ]; then
    echo -e "${YELLOW}This will update your AGENTS.md and CLAUDE.md to v$MASTER_VERSION${NC}"
    echo "Your customizations in protected sections will be preserved"
    echo ""
    read -p "Continue? (y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Sync cancelled"
        rm "$TEMP_SECTIONS"
        exit 1
    fi
fi

echo ""
echo -e "${BLUE}Syncing templates...${NC}"
echo ""

# Sync JIMMYS-WORKFLOW.md (simple replacement - no protected sections)
if [ -f "$PROJECT_WORKFLOW_FILE" ]; then
    WORKFLOW_VERSION=$(grep "TEMPLATE_VERSION:" "$PROJECT_WORKFLOW_FILE" | head -1 | sed 's/.*TEMPLATE_VERSION: *//' | tr -d '[:space:]')
    MASTER_WORKFLOW_VERSION=$(grep "TEMPLATE_VERSION:" "$MASTER_WORKFLOW_FILE" | head -1 | sed 's/.*TEMPLATE_VERSION: *//' | tr -d '[:space:]')

    if [ "$WORKFLOW_VERSION" != "$MASTER_WORKFLOW_VERSION" ]; then
        echo "📄 JIMMYS-WORKFLOW.md: $WORKFLOW_VERSION → $MASTER_WORKFLOW_VERSION"

        if [ "$DRY_RUN" = false ]; then
            echo "  Replacing with latest version (no customizations in this file)"
            cp "$MASTER_WORKFLOW_FILE" "$PROJECT_WORKFLOW_FILE"
            echo "  ✅ JIMMYS-WORKFLOW.md updated to v$MASTER_WORKFLOW_VERSION"
        else
            echo "  Would replace with latest version"
        fi
        echo ""
    else
        echo "📄 JIMMYS-WORKFLOW.md: Already up to date (v$WORKFLOW_VERSION)"
        echo ""
    fi
fi

# TODO: Phase 2 implementation for AGENTS.md smart merge
# For now, show what would happen
echo "📄 AGENTS.md: Smart merge not yet implemented (Phase 2)"
echo "⚠️  Manual sync required for AGENTS.md"
echo ""
echo "Manual sync instructions for AGENTS.md:"
echo "1. Review: cat $TEMPLATE_DIR/CHANGELOG.md"
echo "2. Compare: diff $PROJECT_AGENTS_FILE $MASTER_AGENTS_TEMPLATE"
echo "3. Manually update Core Development Principles section"
echo "4. Update TEMPLATE_VERSION to $MASTER_VERSION"
echo "5. Update LAST_SYNC to $(date +%Y-%m-%d)"
echo ""
echo "Protected sections to preserve (already extracted to $TEMP_SECTIONS):"
grep "^SECTION:" "$TEMP_SECTIONS" | sed 's/SECTION:/  - /'
echo ""
echo -e "${GREEN}Backups available at: $BACKUP_DIR${NC}"

rm "$TEMP_SECTIONS"
exit 0
