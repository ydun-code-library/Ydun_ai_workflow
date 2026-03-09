#!/bin/bash
# audit-project.sh - Comprehensive template compliance audit
# Version: 1.5.1
# Usage: Run from project root directory
# Exit codes: 0 = compliant, 1 = issues, 2 = critical

set -e

# Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Resolve paths relative to this script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Configuration
MODE="full"
OUTPUT_FORMAT="text"
TEMPLATES_DIR="$REPO_ROOT"
PROJECT_AGENTS_FILE="./AGENTS.md"
PROJECT_CLAUDE_FILE="./CLAUDE.md"
PROJECT_WORKFLOW_FILE="./JIMMYS-WORKFLOW.md"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --quick)
            MODE="quick"
            shift
            ;;
        --full)
            MODE="full"
            shift
            ;;
        --json)
            OUTPUT_FORMAT="json"
            shift
            ;;
        --help|-h)
            echo "Usage: audit-project.sh [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --quick     Show summary only"
            echo "  --full      Show detailed report (default)"
            echo "  --json      Output in JSON format"
            echo "  --help      Show this help message"
            echo ""
            echo "Exit codes:"
            echo "  0 = Fully compliant"
            echo "  1 = Issues found (warnings)"
            echo "  2 = Critical issues (missing AGENTS.md)"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information"
            exit 2
            ;;
    esac
done

# Check if we're in a project directory (not the templates directory itself)
if [[ "$(pwd)" == "$TEMPLATES_DIR" ]]; then
    echo -e "${RED}❌ ERROR: Cannot audit the templates directory itself${NC}"
    echo "This script should be run from a project directory, not the templates directory itself"
    exit 2
fi

# Initialize check results
declare -A checks
checks[agents_exists]="pending"
checks[version_header]="pending"
checks[version_current]="pending"
checks[principles]="pending"
checks[placeholders]="pending"
checks[claude_md]="pending"
checks[workflow]="pending"
checks[documentation]="pending"

issues=()
warnings=()
exit_code=0
principle_count=0
project_version="unknown"

# Check 1: Does AGENTS.md exist?
if [[ -f "$PROJECT_AGENTS_FILE" ]]; then
    checks[agents_exists]="pass"
else
    checks[agents_exists]="fail"
    issues+=("AGENTS.md not found - project needs initialization")
    exit_code=2
fi

# Only run remaining checks if AGENTS.md exists
if [[ "${checks[agents_exists]}" == "pass" ]]; then
    # Check 2: Does AGENTS.md have version header?
    if grep -q "TEMPLATE_VERSION:" "$PROJECT_AGENTS_FILE"; then
        checks[version_header]="pass"
        project_version=$(grep "TEMPLATE_VERSION:" "$PROJECT_AGENTS_FILE" | head -1 | sed 's/.*TEMPLATE_VERSION: //' | sed 's/ .*//')
    else
        checks[version_header]="fail"
        warnings+=("No TEMPLATE_VERSION header - using old format (pre-v1.4)")
        project_version="unknown"
        exit_code=1
    fi

    # Check 3: Are templates up to date?
    if [[ -f "$TEMPLATES_DIR/VERSION" ]]; then
        master_version=$(cat "$TEMPLATES_DIR/VERSION")
        if [[ "$project_version" == "$master_version" ]]; then
            checks[version_current]="pass"
        elif [[ "$project_version" == "unknown" ]]; then
            checks[version_current]="warn"
            warnings+=("Cannot verify version - no header found")
            exit_code=1
        else
            checks[version_current]="warn"
            warnings+=("Template version out of date ($project_version → $master_version)")
            exit_code=1
        fi
    else
        checks[version_current]="warn"
        warnings+=("Cannot check version - $TEMPLATES_DIR/VERSION not found")
        exit_code=1
    fi

    # Check 4: Are 8 core principles present?
    principle_count=$(grep -c "^### [1-8]\." "$PROJECT_AGENTS_FILE" || true)
    if [[ $principle_count -eq 8 ]]; then
        checks[principles]="pass"
    else
        checks[principles]="warn"
        warnings+=("Only $principle_count of 8 principles found")
        exit_code=1
    fi

    # Check 5: Are placeholders filled?
    unfilled=$(grep -E "\[PROJECT_NAME\]|\[GITHUB_URL\]|PROJECT_SPECIFIC_CONTEXT - Replace with" "$PROJECT_AGENTS_FILE" || true)
    if [[ -z "$unfilled" ]]; then
        checks[placeholders]="pass"
    else
        unfilled_count=$(echo "$unfilled" | wc -l)
        checks[placeholders]="warn"
        warnings+=("$unfilled_count unfilled placeholders found")
        exit_code=1
    fi

    # Check 6: Is CLAUDE.md present?
    if [[ -f "$PROJECT_CLAUDE_FILE" ]]; then
        checks[claude_md]="pass"
    else
        checks[claude_md]="warn"
        warnings+=("CLAUDE.md not found")
        exit_code=1
    fi

    # Check 7: Is JIMMYS-WORKFLOW.md present or referenced?
    if [[ -f "$PROJECT_WORKFLOW_FILE" ]] || grep -q "JIMMYS-WORKFLOW" "$PROJECT_AGENTS_FILE"; then
        checks[workflow]="pass"
    else
        checks[workflow]="warn"
        warnings+=("JIMMYS-WORKFLOW.md not found or referenced")
        exit_code=1
    fi

    # Check 8: Documentation Quality (v1.5.1 - optional)
    doc_warnings=()
    doc_count=$(find . -maxdepth 3 -name "*.md" -not -path "./node_modules/*" -not -path "./.git/*" 2>/dev/null | wc -l)

    # Only run documentation checks if project has more than 5 docs
    if [[ $doc_count -gt 5 ]]; then
        # Check for DOCS-MAP.md
        if [[ ! -f "./DOCS-MAP.md" ]]; then
            doc_warnings+=("Project has $doc_count docs but no DOCS-MAP.md (recommended for >5 docs)")
        fi

        # Check for AI Navigation Headers in main files
        for file in AGENTS.md CLAUDE.md; do
            if [[ -f "./$file" ]] && ! grep -q "<!-- AI NAVIGATION -->" "./$file"; then
                doc_warnings+=("$file missing AI Navigation Header (optional but recommended)")
            fi
        done

        # Check for ADRs if docs/decisions/ exists
        if [[ -d "./docs/decisions" ]]; then
            adr_count=$(find ./docs/decisions -name "*.md" 2>/dev/null | wc -l)
            if [[ $adr_count -eq 0 ]]; then
                doc_warnings+=("docs/decisions/ directory exists but is empty")
            fi
        fi
    fi

    # Set check status (documentation quality is optional, so warnings don't affect compliance)
    if [[ ${#doc_warnings[@]} -eq 0 ]]; then
        checks[documentation]="pass"
    else
        checks[documentation]="info"
        # Don't set exit_code=1 for documentation warnings (they're optional)
        for warning in "${doc_warnings[@]}"; do
            warnings+=("📚 Docs: $warning")
        done
    fi
fi

# Generate output based on format
if [[ "$OUTPUT_FORMAT" == "json" ]]; then
    # JSON output
    echo "{"
    echo "  \"project\": \"$(basename $(pwd))\","
    echo "  \"location\": \"$(pwd)\","
    echo "  \"audit_date\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\","
    echo "  \"exit_code\": $exit_code,"
    echo "  \"checks\": {"
    echo "    \"agents_exists\": \"${checks[agents_exists]}\","
    echo "    \"version_header\": \"${checks[version_header]}\","
    echo "    \"version_current\": \"${checks[version_current]}\","
    echo "    \"principles\": \"${checks[principles]}\","
    echo "    \"placeholders\": \"${checks[placeholders]}\","
    echo "    \"claude_md\": \"${checks[claude_md]}\","
    echo "    \"workflow\": \"${checks[workflow]}\","
    echo "    \"documentation\": \"${checks[documentation]}\""
    echo "  },"
    echo "  \"issues\": ["
    for i in "${!issues[@]}"; do
        echo "    \"${issues[$i]}\"$([ $i -lt $((${#issues[@]}-1)) ] && echo ",")"
    done
    echo "  ],"
    echo "  \"warnings\": ["
    for i in "${!warnings[@]}"; do
        echo "    \"${warnings[$i]}\"$([ $i -lt $((${#warnings[@]}-1)) ] && echo ",")"
    done
    echo "  ]"
    echo "}"
elif [[ "$MODE" == "quick" ]]; then
    # Quick mode - summary only
    if [[ $exit_code -eq 0 ]]; then
        echo -e "${GREEN}✅ Project is template-compliant!${NC}"
    elif [[ $exit_code -eq 2 ]]; then
        echo -e "${RED}❌ CRITICAL: ${issues[0]}${NC}"
        echo "Run without --quick for details"
    else
        echo -e "${YELLOW}⚠️  Issues found (${#warnings[@]} warning(s))${NC}"
        echo "Run without --quick for details"
    fi
else
    # Full mode - detailed report
    echo "========================================"
    echo "  Template Compliance Audit"
    echo "========================================"
    echo ""
    echo "Project: $(basename $(pwd))"
    echo "Location: $(pwd)"
    echo "Audit Date: $(date '+%Y-%m-%d %H:%M')"
    echo ""
    echo "CHECKS:"
    echo "-------"

    # Function to display check status
    display_check() {
        local name="$1"
        local status="$2"
        local message="$3"

        if [[ "$status" == "pass" ]]; then
            echo -e "✅ $name: ${GREEN}Pass${NC} $message"
        elif [[ "$status" == "info" ]]; then
            echo -e "ℹ️  $name: ${BLUE}Info${NC} $message"
        elif [[ "$status" == "warn" ]]; then
            echo -e "⚠️  $name: ${YELLOW}Warning${NC} $message"
        elif [[ "$status" == "fail" ]]; then
            echo -e "❌ $name: ${RED}Failed${NC} $message"
        else
            echo -e "⏺  $name: Pending $message"
        fi
    }

    if [[ "${checks[agents_exists]}" == "pass" ]]; then
        display_check "AGENTS.md" "${checks[agents_exists]}" "(v$project_version)"
    else
        display_check "AGENTS.md" "${checks[agents_exists]}" ""
    fi

    display_check "Template Version" "${checks[version_current]}" "$([ "${checks[version_current]}" == "pass" ] && echo "(up to date)" || echo "")"
    display_check "CLAUDE.md" "${checks[claude_md]}" ""
    display_check "JIMMYS-WORKFLOW" "${checks[workflow]}" ""
    display_check "8 Core Principles" "${checks[principles]}" "$([ $principle_count -eq 8 ] && echo "(all present)" || echo "($principle_count found)")"
    display_check "Placeholders Filled" "${checks[placeholders]}" ""
    display_check "Version Header" "${checks[version_header]}" ""

    # Display documentation check (optional, v1.5.1+)
    if [[ $doc_count -gt 5 ]]; then
        display_check "Documentation Quality (optional)" "${checks[documentation]}" "($doc_count docs found)"
    fi

    echo ""
    echo "SUMMARY:"
    echo "--------"

    if [[ $exit_code -eq 0 ]]; then
        echo -e "Status: ${GREEN}✅ FULLY COMPLIANT${NC}"
        echo ""
        echo "Great work! This project follows all template standards."
    elif [[ $exit_code -eq 2 ]]; then
        echo -e "Status: ${RED}❌ CRITICAL ISSUES${NC}"
        echo ""
        echo "Issues Found:"
        for issue in "${issues[@]}"; do
            echo "  • $issue"
        done
    else
        echo -e "Status: ${YELLOW}⚠️  NEEDS UPDATE${NC}"
        echo ""
        if [[ ${#issues[@]} -gt 0 ]]; then
            echo "Issues Found:"
            for issue in "${issues[@]}"; do
                echo "  • $issue"
            done
            echo ""
        fi
        if [[ ${#warnings[@]} -gt 0 ]]; then
            echo "Warnings:"
            for warning in "${warnings[@]}"; do
                echo "  • $warning"
            done
        fi
    fi

    echo ""
    echo "RECOMMENDATIONS:"
    echo "----------------"

    if [[ $exit_code -eq 2 ]]; then
        echo "1. Initialize project with templates:"
        echo "   cp $REPO_ROOT/projects/core/AGENTS.md.template ./AGENTS.md"
        echo "   cp $REPO_ROOT/projects/core/CLAUDE.md.template ./CLAUDE.md"
        echo "   cp $REPO_ROOT/projects/core/JIMMYS-WORKFLOW.md ./JIMMYS-WORKFLOW.md"
        echo ""
        echo "2. Fill in project-specific placeholders in AGENTS.md"
        echo ""
        echo "3. Customize protected sections with project details"
    elif [[ $exit_code -eq 1 ]]; then
        if [[ "${checks[version_current]}" == "warn" ]]; then
            echo "1. Update to latest template version:"
            echo "   $SCRIPT_DIR/sync-templates.sh"
            echo "   (Your customizations will be preserved)"
            echo ""
            echo "2. Review what's new:"
            echo "   cat $REPO_ROOT/CHANGELOG.md"
            echo ""
        fi

        if [[ "${checks[placeholders]}" == "warn" ]]; then
            echo "3. Fill remaining placeholders in AGENTS.md"
            echo "   (Search for [PROJECT_NAME], [GITHUB_URL], etc.)"
            echo ""
        fi

        if [[ "${checks[claude_md]}" == "warn" ]]; then
            echo "4. Add CLAUDE.md quick reference:"
            echo "   cp $REPO_ROOT/projects/core/CLAUDE.md.template ./CLAUDE.md"
            echo ""
        fi

        if [[ "${checks[workflow]}" == "warn" ]]; then
            echo "5. Add Jimmy's Workflow documentation:"
            echo "   cp $REPO_ROOT/projects/core/JIMMYS-WORKFLOW.md ./"
            echo ""
        fi

        # Documentation quality recommendations (v1.5.1+)
        if [[ $doc_count -gt 5 ]] && [[ "${checks[documentation]}" == "info" ]]; then
            echo ""
            echo "📚 Documentation Quality Recommendations (optional):"
            echo ""
            if [[ ! -f "./DOCS-MAP.md" ]]; then
                echo "   • Create master documentation map:"
                echo "     cp $REPO_ROOT/projects/docs/doc-components/DOCS-MAP.md.template ./DOCS-MAP.md"
                echo ""
            fi
            if [[ -f "./AGENTS.md" ]] && ! grep -q "<!-- AI NAVIGATION -->" "./AGENTS.md"; then
                echo "   • Add AI Navigation Headers to documentation:"
                echo "     cat $REPO_ROOT/projects/docs/doc-components/AI-NAVIGATION-HEADER.template"
                echo ""
            fi
            if [[ -d "./docs/decisions" ]]; then
                adr_count=$(find ./docs/decisions -name "*.md" 2>/dev/null | wc -l)
                if [[ $adr_count -eq 0 ]]; then
                    echo "   • Document architecture decisions:"
                    echo "     cp $REPO_ROOT/projects/docs/doc-components/ADR-TEMPLATE.md ./docs/decisions/001-decision.md"
                    echo ""
                fi
            fi
            echo "   💡 See $REPO_ROOT/projects/docs/DOCUMENTATION-STANDARDS.md for complete guidelines"
            echo ""
        fi
    else
        echo "No actions needed - keep up the great work!"
    fi

    echo ""
    echo "========================================"
fi

exit $exit_code
