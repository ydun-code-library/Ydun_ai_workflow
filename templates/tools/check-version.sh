#!/bin/bash

# check-version.sh - Check if project templates are up to date
# Usage: Run from project root directory
# Exit codes: 0 = up to date, 1 = out of date, 2 = error

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Resolve paths relative to this script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Paths
TEMPLATE_DIR="$REPO_ROOT"
MASTER_VERSION_FILE="$TEMPLATE_DIR/VERSION"
PROJECT_AGENTS_FILE="./AGENTS.md"
PROJECT_WORKFLOW_FILE="./JIMMYS-WORKFLOW.md"
MASTER_WORKFLOW_FILE="$TEMPLATE_DIR/projects/core/JIMMYS-WORKFLOW.md"

# Check if we're in a project directory
if [ ! -f "$PROJECT_AGENTS_FILE" ]; then
    echo -e "${RED}❌ Error: AGENTS.md not found in current directory${NC}"
    echo "Run this script from your project root directory"
    exit 2
fi

# Check if master VERSION file exists
if [ ! -f "$MASTER_VERSION_FILE" ]; then
    echo -e "${RED}❌ Error: Master VERSION file not found at $MASTER_VERSION_FILE${NC}"
    exit 2
fi

# Read master version
MASTER_VERSION=$(cat "$MASTER_VERSION_FILE" | tr -d '[:space:]')

# Extract project template version from AGENTS.md
# Look for: TEMPLATE_VERSION: X.X in HTML comment
PROJECT_VERSION=$(grep "TEMPLATE_VERSION:" "$PROJECT_AGENTS_FILE" | head -1 | sed 's/.*TEMPLATE_VERSION: *//' | tr -d '[:space:]')

if [ -z "$PROJECT_VERSION" ]; then
    echo -e "${YELLOW}⚠️  Warning: No TEMPLATE_VERSION found in $PROJECT_AGENTS_FILE${NC}"
    echo "This project may be using an old template format (pre-v1.4)"
    echo ""
    echo "Current master version: $MASTER_VERSION"
    echo "Recommendation: Run $SCRIPT_DIR/sync-templates.sh to update"
    exit 1
fi

# Check JIMMYS-WORKFLOW.md if it exists in project (optional - some projects reference it)
WORKFLOW_STATUS="N/A"
WORKFLOW_VERSION=""
WORKFLOW_OUT_OF_DATE=false

if [ -f "$PROJECT_WORKFLOW_FILE" ]; then
    # Extract workflow version
    WORKFLOW_VERSION=$(grep "TEMPLATE_VERSION:" "$PROJECT_WORKFLOW_FILE" | head -1 | sed 's/.*TEMPLATE_VERSION: *//' | tr -d '[:space:]')

    if [ -z "$WORKFLOW_VERSION" ]; then
        WORKFLOW_STATUS="Unknown (pre-v1.1 format)"
        WORKFLOW_OUT_OF_DATE=true
    else
        # Get master workflow version
        MASTER_WORKFLOW_VERSION=$(grep "TEMPLATE_VERSION:" "$MASTER_WORKFLOW_FILE" | head -1 | sed 's/.*TEMPLATE_VERSION: *//' | tr -d '[:space:]')

        if [ "$WORKFLOW_VERSION" = "$MASTER_WORKFLOW_VERSION" ]; then
            WORKFLOW_STATUS="✅ Up to date ($WORKFLOW_VERSION)"
        else
            WORKFLOW_STATUS="⚠️  Out of date ($WORKFLOW_VERSION → $MASTER_WORKFLOW_VERSION)"
            WORKFLOW_OUT_OF_DATE=true
        fi
    fi
else
    WORKFLOW_STATUS="Not present (may be referenced from platform root)"
fi

# Compare versions and display results
echo "Template Version Check"
echo "======================"
echo ""
echo "AGENTS.md:"
echo "  Project version:  $PROJECT_VERSION"
echo "  Master version:   $MASTER_VERSION"
echo "  Status:           $([ "$PROJECT_VERSION" = "$MASTER_VERSION" ] && echo "✅ Up to date" || echo "⚠️  Out of date")"
echo ""
echo "JIMMYS-WORKFLOW.md:"
echo "  Status:           $WORKFLOW_STATUS"
echo ""

# Determine overall status
AGENTS_OUT_OF_DATE=false
if [ "$PROJECT_VERSION" != "$MASTER_VERSION" ]; then
    AGENTS_OUT_OF_DATE=true
fi

if [ "$AGENTS_OUT_OF_DATE" = false ] && [ "$WORKFLOW_OUT_OF_DATE" = false ]; then
    echo -e "${GREEN}✅ All templates are up to date!${NC}"
    exit 0
else
    echo -e "${YELLOW}⚠️  Some templates are OUT OF DATE${NC}"
    echo ""
    echo "What's new in v$MASTER_VERSION:"
    echo "  - See: $TEMPLATE_DIR/CHANGELOG.md"
    echo ""
    echo "To update (preserves your customizations):"
    echo "  $SCRIPT_DIR/sync-templates.sh"
    echo ""
    echo "To view changelog:"
    echo "  cat $REPO_ROOT/CHANGELOG.md"
    exit 1
fi
