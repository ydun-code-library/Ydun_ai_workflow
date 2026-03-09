# AGENTS.md Template System - Usage Guide

**Created**: 2025-10-02
**Version**: 1.0
**Purpose**: Guide for using the AGENTS.md template system across all projects

---

## Table of Contents

1. [What This Template System Provides](#what-this-template-system-provides)
2. [Quick Start](#quick-start)
3. [Template Files Explained](#template-files-explained)
4. [Step-by-Step Initialization](#step-by-step-initialization)
5. [Placeholder Reference](#placeholder-reference)
6. [Customization Guide](#customization-guide)
7. [Project Type Templates](#project-type-templates)
8. [Best Practices](#best-practices)
9. [Troubleshooting](#troubleshooting)

---

## What This Template System Provides

### Core Benefits

✅ **Consistency**: All projects follow same AI assistant guidelines
✅ **Speed**: New projects start with best practices built-in
✅ **Quality**: Jimmy's Workflow integrated from day one
✅ **Maintainability**: Standard structure across all codebases
✅ **AI-Optimized**: Every project speaks same language to assistants
✅ **Scalability**: Easy to add new project types

### What's Included

**Template Files:**
- `AGENTS.md.template` - Main AI assistant guidelines (comprehensive)
- `CLAUDE.md.template` - Claude-specific quick reference
- `JIMMYS-WORKFLOW.md` - Complete Red/Green checkpoint system
- `JIMMYS-WORKFLOW-TEMPLATE.md` - Task-specific workflow starter

**Documentation:**
- This guide (AGENTS-TEMPLATE-GUIDE.md)
- Template collection README
- Project initialization checklist
- Project type-specific variants

**Standards:**
- 11 Core Development Principles (KISS, TDD, SOC, DRY, Documentation, Jimmy's Workflow v2.1, YAGNI, Fix Now, Measure Twice, No Shortcuts, Rules Persist)
- Jimmy's Workflow v2.1 with PRE-FLIGHT, Confidence Levels, COI Disclosure
- GitHub CLI (`gh`) for all GitHub operations
- Consistent structure across all projects
- Built-in validation patterns with reasoning documentation
- Anti-hallucination safeguards with explicit context verification

---

## Quick Start

### 30-Second Setup

```bash
# 1. Navigate to your new project
cd /path/to/new-project

# 2. Copy templates
cp templates/core/AGENTS.md.template ./AGENTS.md
cp templates/core/CLAUDE.md.template ./CLAUDE.md

# 3. Copy or reference workflow (choose one)
# Option A: Copy to project (standalone projects)
cp templates/core/JIMMYS-WORKFLOW.md ./

# Option B: Reference from platform root (multi-service projects)
# Just update references in AGENTS.md to point to ../JIMMYS-WORKFLOW.md

# 4. Replace placeholders
# Search and replace all [PLACEHOLDER] values in AGENTS.md and CLAUDE.md

# 5. Commit
git add AGENTS.md CLAUDE.md JIMMYS-WORKFLOW.md
git commit -m "docs: add AI assistant guidelines"
```

---

## Template Files Explained

### AGENTS.md.template

**Purpose**: Comprehensive AI assistant guidelines for the project

**What It Contains:**
- Repository information (GitHub URL, local path, purpose)
- All 8 Core Development Principles
- Jimmy's Workflow integration
- Service/project overview
- Technology stack details
- Build & test commands
- Development workflow
- Known issues & technical debt
- Project-specific guidelines
- Common patterns & examples
- Environment variables
- Troubleshooting guide

**When to Use**: Every project needs this file in its root directory

**Customization Level**: High - many placeholders to fill

---

### CLAUDE.md.template

**Purpose**: Quick reference card for Claude (and other AI assistants)

**What It Contains:**
- Reference to AGENTS.md (single source of truth)
- Quick reference for 8 core principles
- Jimmy's Workflow overview
- Critical rules
- Common commands

**When to Use**: Every project, placed in root directory

**Customization Level**: Low - mainly just update commands

---

### JIMMYS-WORKFLOW.md

**Purpose**: Complete Red/Green checkpoint validation system with assessment rigor

**Current Version**: 2.1 (see templates/core/JIMMYS-WORKFLOW.md header)

**What It Contains:**
- Four-phase workflow: PRE-FLIGHT → IMPLEMENT → VALIDATE → CHECKPOINT
- PRE-FLIGHT context verification (NEW in v2.1)
- Confidence levels (HIGH/MEDIUM/LOW)
- Validation reasoning documentation
- COI disclosure for AI-validating-AI
- Validity conditions for checkpoint staleness
- Machine-readable checkpoint formats
- Rollback procedures with validity triggers
- Autonomous execution rules with confidence-based gates

**When to Use**:
- **Standalone projects**: Copy to project root (check version with templates/tools/check-version.sh)
- **Multi-service platforms**: Reference from platform root (always up to date automatically)

**Customization Level**: None - use as-is, reference from AGENTS.md

**Version Control**:
- ✅ Version tracked (currently v2.1)
- ✅ Auto-sync supported (simple replacement, no customizations)
- ⚠️ If you copied this file, run check-version.sh to ensure you have latest
- ⚠️ v2.1 is a major update from v1.1 - review CHANGELOG.md for migration notes

---

### JIMMYS-WORKFLOW-TEMPLATE.md

**Purpose**: Quick-start template for specific tasks/features

**Current Version**: 2.1 (matches JIMMYS-WORKFLOW.md v2.1)

**What It Contains:**
- Four-phase workflow structure: 🔴 PRE-FLIGHT → 🔴 IMPLEMENT → 🟢 VALIDATE → 🔵 CHECKPOINT
- PRE-FLIGHT context inventory template
- Confidence level tracking per checkpoint
- Validation reasoning sections
- COI disclosure template for AI-generated code
- Validity conditions and re-validation triggers
- Machine-readable JSON state format

**When to Use**: When planning a new feature or complex task

**Customization Level**: High - fill in for each specific task

**Version Control**:
- ✅ Version tracked (currently v2.1)
- ✅ Matches main workflow version
- Copy to project docs/ when needed for task planning

---

## Step-by-Step Initialization

### Step 1: Create New Project Repository

```bash
# Create project directory
mkdir my-new-project
cd my-new-project

# Initialize git
git init

# Create basic structure
mkdir src tests docs
```

---

### Step 2: Copy Template Files

```bash
# Copy main templates
cp templates/core/AGENTS.md.template ./AGENTS.md
cp templates/core/CLAUDE.md.template ./CLAUDE.md

# Copy workflow documentation (if standalone project)
cp templates/core/JIMMYS-WORKFLOW.md ./

# Optional: Copy task template for immediate use
cp templates/core/JIMMYS-WORKFLOW-TEMPLATE.md ./docs/
```

---

### Step 3: Replace Placeholders

**Required Replacements in AGENTS.md:**

| Placeholder | Example Value | Where to Find |
|-------------|---------------|---------------|
| `[PROJECT_NAME]` | "Todo API Service" | Your project name |
| `[SERVICE_DESCRIPTION]` | "Backend REST API" | Short description |
| `[IN DEVELOPMENT / READY FOR TESTING / PRODUCTION]` | "IN DEVELOPMENT" | Current status |
| `[YYYY-MM-DD]` | "2025-10-02" | Today's date |
| `[GITHUB_URL]` | "https://github.com/user/repo" | GitHub repo URL |
| `[LOCAL_PATH]` | "~/projects/todo-api" | Local directory path |
| `[PRIMARY_PURPOSE_DESCRIPTION]` | "Provides REST API for todo items" | Purpose statement |
| `[PROJECT_SPECIFIC_CONTEXT]` | Your project context | Background info |
| `[SERVICE_OVERVIEW]` | Detailed overview | Comprehensive description |
| `[STATUS_EMOJI]` | 🔄 or ✅ or ⚪ | Status indicator |
| `[STATUS_DESCRIPTION]` | "Active Development" | Status text |
| `[COMPLETION_PERCENTAGE]` | "30% Complete" | Progress |
| `[INSTALL_COMMAND]` | "npm install" | Install command |
| `[DEV_COMMAND]` | "npm run dev" | Dev server command |
| `[TEST_COMMAND]` | "npm test" | Test command |
| `[TYPECHECK_COMMAND]` | "npm run typecheck" | Type check command |
| `[LINT_COMMAND]` | "npm run lint" | Lint command |
| `[BUILD_COMMAND]` | "npm run build" | Build command |
| `[PREVIEW_COMMAND]` | "npm run preview" | Preview command |
| `[DEPLOY_COMMAND]` | "vercel deploy" | Deploy command |

**Quick Replace Method:**

```bash
# Use your editor's find-and-replace
# In VS Code: Cmd/Ctrl + Shift + H
# In Vim: :%s/\[PLACEHOLDER\]/value/g

# Or use sed (macOS/Linux)
sed -i '' 's/\[PROJECT_NAME\]/My Project/g' AGENTS.md
sed -i '' 's/\[YYYY-MM-DD\]/2025-10-02/g' AGENTS.md
# ... repeat for all placeholders
```

---

### Step 4: Customize Project-Specific Sections

**Sections Requiring Custom Content:**

1. **Important Context**
   - Add relevant background
   - Explain any non-obvious decisions
   - Document project history if applicable

2. **Service Overview**
   - Describe what the project does
   - List key responsibilities
   - Clarify any terminology

3. **Technology Stack**
   - List actual frameworks/tools used
   - Include version numbers
   - Note any specific configurations

4. **Repository Structure**
   - Match your actual directory structure
   - Add descriptions for each directory
   - Update as project evolves

5. **Known Issues & Technical Debt**
   - List current blockers
   - Document technical debt
   - Link to issues/tickets

6. **Project-Specific Guidelines**
   - Add your code style rules
   - Document naming conventions
   - Note any special patterns

---

### Step 5: Update CLAUDE.md Commands

**Replace command placeholders:**

```markdown
# Before
[DEV_COMMAND]          # Start dev server
[TEST_COMMAND]         # Run tests

# After
npm run dev            # Start dev server
npm test               # Run tests
```

---

### Step 6: Validate Template Completion

**Checklist:**

```bash
# Run these checks
grep -r "\[" AGENTS.md CLAUDE.md | grep -v "http" | grep -v "example"
# Should return 0 results (no unclosed brackets = no placeholders)

# Verify files exist
ls -la AGENTS.md CLAUDE.md JIMMYS-WORKFLOW.md

# Check file sizes (should be substantial)
wc -l AGENTS.md  # Should be 200+ lines
```

---

### Step 7: Test with AI Assistant

```bash
# Start Claude Code in project directory
claude

# Test invocation
# Say: "Please read AGENTS.md and summarize the project"
# Should get accurate summary based on your customizations

# Test workflow
# Say: "Let's use Jimmy's Workflow to add a new feature"
# Should get proper 🔴 RED → 🟢 GREEN → 🔵 CHECKPOINT structure
```

---

### Step 8: Commit Templates

```bash
git add AGENTS.md CLAUDE.md JIMMYS-WORKFLOW.md
git commit -m "docs: add AI assistant guidelines with Jimmy's Workflow"
git push
```

---

## Placeholder Reference

### Complete Placeholder List

**Basic Information:**
- `[PROJECT_NAME]` - Full project name
- `[SERVICE_DESCRIPTION]` - One-line description
- `[GITHUB_URL]` - GitHub repository URL
- `[LOCAL_PATH]` - Local filesystem path
- `[PRIMARY_PURPOSE_DESCRIPTION]` - Purpose statement
- `[YYYY-MM-DD]` - Current date (ISO format)

**Status:**
- `[IN DEVELOPMENT / READY FOR TESTING / PRODUCTION]` - Choose one
- `[STATUS_EMOJI]` - 🔄 / ✅ / ⚪ / ⚠️
- `[STATUS_DESCRIPTION]` - Text description
- `[COMPLETION_PERCENTAGE]` - e.g., "75% Complete"

**Commands:**
- `[INSTALL_COMMAND]` - Dependency installation
- `[DEV_COMMAND]` - Development server
- `[TEST_COMMAND]` - Test runner
- `[TYPECHECK_COMMAND]` - Type checking
- `[LINT_COMMAND]` - Linter
- `[BUILD_COMMAND]` - Production build
- `[PREVIEW_COMMAND]` - Preview production build
- `[DEPLOY_COMMAND]` - Deployment

**Content Sections:**
- `[PROJECT_SPECIFIC_CONTEXT]` - Background information
- `[SERVICE_OVERVIEW]` - Comprehensive description
- `[Responsibility 1/2/3]` - Key responsibilities
- `[Pattern Name 1/2]` - Common code patterns
- `[REQUIRED_VAR_1/2]` - Environment variables
- `[Frontend/Backend/Full-Stack]` - Choose relevant section

---

## Customization Guide

### Minimal Customization (5 minutes)

**For simple projects:**

1. Replace basic info placeholders (name, URL, paths)
2. Update command placeholders
3. Add 2-3 sentence service overview
4. Done!

**Result**: Functional AGENTS.md with standard structure

---

### Standard Customization (15-30 minutes)

**For most projects:**

1. All minimal customizations
2. Fill in technology stack
3. List current status with checkmarks
4. Add repository structure
5. Document environment variables
6. Add 1-2 common patterns
7. Write troubleshooting section

**Result**: Comprehensive AGENTS.md tailored to your project

---

### Advanced Customization (1-2 hours)

**For complex/critical projects:**

1. All standard customizations
2. Detailed project context/history
3. Comprehensive known issues list
4. Project-specific coding guidelines
5. Multiple code pattern examples
6. Detailed integration documentation
7. Custom workflow patterns in docs/
8. Project-specific JIMMYS-WORKFLOW variants

**Result**: Complete documentation system with project-specific extensions

---

## Project Type Templates

### Frontend Service

**Use**: `project-types/frontend-service.agents.md`

**Pre-configured for:**
- React/Vue/Angular
- Vite/Webpack build tools
- Component-based architecture
- Frontend testing (Vitest, Jest)
- SASS/Tailwind styling

---

### Backend Service

**Use**: `project-types/backend-service.agents.md`

**Pre-configured for:**
- Node.js/Python/Go
- REST/GraphQL APIs
- Database integration
- API testing
- Authentication patterns

---

### Full-Stack Application

**Use**: `project-types/fullstack-app.agents.md`

**Pre-configured for:**
- Combined frontend/backend
- Monorepo structure
- End-to-end testing
- Deployment strategies

---

### Database Service

**Use**: `project-types/database-service.agents.md`

**Pre-configured for:**
- Schema management
- Migrations
- Seeding
- RLS policies (Supabase)

---

### Documentation Hub

**Use**: `project-types/documentation-hub.agents.md`

**Pre-configured for:**
- Pure documentation repos
- Multi-service documentation
- Architecture diagrams
- Cross-repository references

---

## Best Practices

### 1. Keep AGENTS.md Current

**Update when:**
- Adding new features (update status section)
- Changing tech stack (update technology section)
- Finding issues (update known issues)
- Changing workflow (update development workflow)
- Adding patterns (update common patterns)

**Frequency**: Update at each major milestone or monthly

---

### 2. Use Project Type Templates

Don't start from scratch - use the closest project type template:

```bash
# Choose template that matches your project
cp templates/core/frontend-service.agents.md ./AGENTS.md

# Customize from there
```

**Saves time and ensures you don't miss important sections**

---

### 3. Reference vs Copy JIMMYS-WORKFLOW.md

**Copy when:**
- Standalone project
- Not part of larger platform
- Want project-specific workflow modifications

**Reference when:**
- Part of multi-service platform
- Want consistent workflow across services
- Central updates should propagate

**Reference example in AGENTS.md:**
```markdown
**Reference**: See **../JIMMYS-WORKFLOW.md** for complete workflow system
```

---

### 4. Commit Templates Early

```bash
# Commit templates in first commit
git add AGENTS.md CLAUDE.md
git commit -m "docs: initialize AI assistant guidelines"

# OR as second commit (after initial setup)
git commit -m "docs: add AI assistant documentation"
```

**Why**: Establishes standards from the start, helps AI assistants immediately

---

### 5. Test Template Completeness

```bash
# Check for unfilled placeholders
grep "\[.*\]" AGENTS.md | grep -v "http" | grep -v "example"

# Should return nothing if all placeholders filled
```

---

### 6. Version Your Templates

Add at bottom of AGENTS.md:

```markdown
**Template Version**: 1.0
**Last Updated**: 2025-10-02
```

Helps track which version of template was used, useful for migrations

---

## Troubleshooting

### Issue: AI Assistant Not Reading AGENTS.md

**Symptoms**: AI doesn't follow principles or use Jimmy's Workflow

**Solutions**:
1. Verify file exists: `ls -la AGENTS.md`
2. Check file size: `wc -l AGENTS.md` (should be 200+ lines)
3. Explicitly prompt: "Please read AGENTS.md in this directory"
4. Check CLAUDE.md references AGENTS.md correctly
5. Restart AI assistant session

---

### Issue: Too Many Placeholders to Fill

**Symptoms**: Overwhelmed by `[PLACEHOLDER]` markers

**Solutions**:
1. Use project type template instead of base template
2. Do minimal customization first (5 minutes)
3. Fill remaining sections over time
4. Use find-and-replace for repeated placeholders
5. Some sections are optional - delete if not applicable

---

### Issue: Workflow Documentation Too Long

**Symptoms**: JIMMYS-WORKFLOW.md seems overwhelming

**Solutions**:
1. AI assistants handle long docs well - don't worry
2. Use JIMMYS-WORKFLOW-TEMPLATE.md for specific tasks
3. Reference sections as needed, not all at once
4. Keep in project root but don't read daily - it's reference material

---

### Issue: Unsure Which Project Type Template to Use

**Decision Tree**:

```
Is it primarily UI/frontend?
├─ Yes → Use frontend-service.agents.md
└─ No
   └─ Is it primarily API/backend?
      ├─ Yes → Use backend-service.agents.md
      └─ No
         └─ Does it have both frontend AND backend?
            ├─ Yes → Use fullstack-app.agents.md
            └─ No
               └─ Is it only database/schemas?
                  ├─ Yes → Use database-service.agents.md
                  └─ No → Use base AGENTS.md.template
```

---

### Issue: Commands Don't Match My Project

**Symptoms**: Template has `npm` but you use `pip`

**Solution**: Just replace! Templates are starting points:

```markdown
# Change from:
[INSTALL_COMMAND - e.g., npm install]

# To:
pip install -r requirements.txt
```

---

## Quick Reference Card

### Minimum Viable Template Setup

1. Copy `AGENTS.md.template` → `AGENTS.md`
2. Replace: PROJECT_NAME, GITHUB_URL, LOCAL_PATH, dates
3. Replace: All command placeholders
4. Add 2-3 sentence service overview
5. Commit

**Time**: 5 minutes
**Result**: Functional AI assistant documentation

---

### Full Template Setup

1. Copy all template files
2. Choose appropriate project type template (optional)
3. Replace all placeholders
4. Customize all sections
5. Add project-specific guidelines
6. Test with AI assistant
7. Commit

**Time**: 30 minutes
**Result**: Comprehensive AI-optimized documentation

---

## Template Version Control

**Master Templates**: This repository (single source of truth)
**Current Version**: See `VERSION` in repo root
**Changelog**: `CHANGELOG.md` in repo root

### Keeping Projects Up to Date

**Problem**: Templates evolve (new principles, tools, standards) but existing projects become outdated.

**Solution**: Version-controlled templates with smart sync tools.

### How It Works

**1. Version Tracking**
- Master templates have version number in header: `<!-- TEMPLATE_VERSION: 1.4 -->`
- Master VERSION file: `VERSION` in repo root contains current version
- Each project's AGENTS.md tracks its template version
- JIMMYS-WORKFLOW.md also version tracked (v1.1) if copied to project
- JIMMYS-WORKFLOW-TEMPLATE.md version tracked (v1.0)

**2. Protected Sections**
- Project-specific content wrapped in `<!-- PROJECT_SPECIFIC START/END -->` markers
- These sections are NEVER overwritten during sync
- Includes: SERVICE_OVERVIEW, KNOWN_ISSUES, CUSTOM_GUIDELINES, etc.

**3. Version Check**
```bash
# From any project directory
templates/tools/check-version.sh

# Output:
# ✅ Templates are up to date!
# OR
# ⚠️  Templates are OUT OF DATE (v1.2 → v1.4)
```

**4. Smart Sync (Phase 1)**
```bash
templates/tools/sync-templates.sh --dry-run   # Preview
templates/tools/sync-templates.sh             # Apply with confirmation
templates/tools/sync-templates.sh --auto      # Auto-apply
```

**What Gets Preserved:**
- ✅ All PROJECT_SPECIFIC sections
- ✅ Placeholder values (PROJECT_NAME, commands, etc.)
- ✅ Custom patterns and guidelines
- ✅ Known issues and technical debt

**What Gets Updated:**
- 🔄 Core Development Principles (when new ones added)
- 🔄 Standard sections (GitHub Workflow, etc.)
- 🔄 Template structure improvements
- 🔄 JIMMYS-WORKFLOW.md (if copied to project - full file replacement)
- 🔄 CLAUDE.md (standard sections)

### When to Check/Sync

**Check version:**
- Monthly (add to routine maintenance)
- When starting new features
- Before major releases
- When AI assistants behave unexpectedly

**Sync to latest:**
- When new principles added (e.g., v1.3 added YAGNI)
- When critical tools added (e.g., GitHub CLI)
- When template structure improves
- After reviewing CHANGELOG.md

### Integration with AI Assistants

**Ask AI to check version:**
> "Please run templates/tools/check-version.sh and tell me if templates are up to date"

**Ask AI to sync:**
> "Templates are out of date. Please run sync-templates.sh --dry-run first, then sync if safe"

**AI will:**
- Run version check automatically (if prompted)
- Review CHANGELOG.md for breaking changes
- Execute sync with validation checkpoints
- Preserve all your customizations

### Future: Phase 2 Auto-Sync

**Coming later:**
- Full smart merge implementation in sync-templates.sh
- Automatic placeholder extraction and re-application
- Pre-commit hooks to warn if out of date
- CI/CD integration for template version checks

**For now:** Manual sync with preservation guidance (Phase 1 complete)

---

## Template Version History

**Current Version**: 1.7.0 (see VERSION in repo root)

**Major Versions:**
- **v1.7.0** - Major Jimmy's Workflow update (v1.1 → v2.1): PRE-FLIGHT check, confidence levels, COI disclosure, validity conditions
- **v1.6.0** - Added principles 9, 10, 11 (Measure Twice, No Shortcuts, Rules Persist)
- **v1.5.1** - AI-Optimized Documentation standards and templates
- **v1.5.0** - Added Principle 5.5 (AI-Optimized Documentation)
- **v1.4** - Added "Fix Now, Not Later" principle, version control system
- **v1.3** - Added YAGNI principle, GitHub CLI workflow
- **v1.2** - Enhanced Jimmy's Workflow (micro-checkpoints, time tracking)
- **v1.1** - Removed project-specific examples
- **v1.0** - Initial release

**See full changelog**: `CHANGELOG.md` in repo root

---

**Template System Version**: 1.7.0
**Last Updated**: 2026-01-19
**Maintained By**: Jimmy + AI Coding Assistants
