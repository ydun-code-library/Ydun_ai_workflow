# New Project Initialization Checklist

**Purpose**: Step-by-step checklist for initializing new projects with AI assistant guidelines

**Template Version**: 1.7.0
**Last Updated**: 2026-01-22
**Changelog**: v1.7.0 - Added Jimmy's Workflow execution requirement, updated to workflow v2.1 (4-phase), added DOCUMENTATION-STANDARDS.md reference, added principles 9-11

---

## ⚠️ CRITICAL: Use Jimmy's Workflow for Project Initialization

**Project initialization is an implementation task.** It MUST follow Jimmy's Workflow v2.1:

```
🔴 PRE-FLIGHT → 🔴 IMPLEMENT → 🟢 VALIDATE → 🔵 CHECKPOINT
```

### Before Starting (PRE-FLIGHT)

**Context Inventory:**
- [ ] Project name and purpose defined
- [ ] Tech stack chosen
- [ ] GitHub repository URL known (or decision to create)
- [ ] Local directory path determined
- [ ] Templates directory accessible (cloned repo)

**Pre-flight Status:**
- 🟢 **CLEAR**: All context available → Proceed to IMPLEMENT
- 🟡 **GAPS**: Missing info → Gather before proceeding
- 🔴 **BLOCKED**: Critical blockers → Resolve first

### During Execution (IMPLEMENT)

Follow the checklist steps below. Each major section is a sub-task that should be validated before proceeding.

### After Each Section (VALIDATE)

Run explicit validation commands. Document:
- **Confidence Level**: HIGH / MEDIUM / LOW
- **Reasoning**: Why this proves correctness
- **Weaknesses**: What validation does NOT prove

### At Completion (CHECKPOINT)

```
🔵 CHECKPOINT: Project Initialization Complete
- Confidence: [HIGH/MEDIUM/LOW]
- Validated: [List what was checked]
- Validity Conditions: [When this becomes invalid - e.g., "template updates"]
- Rollback: `rm -rf [project-dir] && restore from backup`
```

**Reference**: See **JIMMYS-WORKFLOW.md** (v2.1) for complete workflow system

---

## 🎯 Pre-Initialization

- [ ] Project name decided
- [ ] GitHub repository created (or ready to create)
- [ ] Local directory structure planned
- [ ] Tech stack chosen
- [ ] Development environment set up

---

## 📋 Step 1: Copy Template Files

### Required Files

- [ ] Copy `AGENTS.md.template` to project root as `AGENTS.md`
  ```bash
  cp templates/core/AGENTS.md.template /path/to/project/AGENTS.md
  ```

- [ ] Copy `CLAUDE.md.template` to project root as `CLAUDE.md`
  ```bash
  cp templates/core/CLAUDE.md.template /path/to/project/CLAUDE.md
  ```

### Workflow Documentation (Choose One)

- [ ] **Option A** (Standalone Project): Copy JIMMYS-WORKFLOW.md to project root
  ```bash
  cp templates/core/JIMMYS-WORKFLOW.md /path/to/project/
  ```

- [ ] **Option B** (Multi-Service Platform): Reference from platform root
  ```markdown
  # In AGENTS.md, update reference:
  **Reference**: See **../JIMMYS-WORKFLOW.md** for complete workflow
  ```

### Session Continuity Files (Recommended for All Projects)

- [ ] Copy `STATUS.md.template` to project root as `STATUS.md`
  ```bash
  cp templates/core/STATUS.md.template /path/to/project/STATUS.md
  ```
  **Purpose**: Track project progress, metrics, and status across sessions
  **Benefits**: AI assistants can quickly understand project state, human developers get quick status overview

- [ ] Copy `NEXT-SESSION-START-HERE.md.template` to project root as `NEXT-SESSION-START-HERE.md`
  ```bash
  cp templates/core/NEXT-SESSION-START-HERE.md.template /path/to/project/NEXT-SESSION-START-HERE.md
  ```
  **Purpose**: Provide quick context and next steps for session continuity
  **Benefits**: Never lose context between sessions, immediate orientation on session start

### Optional Files

- [ ] Copy `JIMMYS-WORKFLOW-TEMPLATE.md` to `docs/` for task planning
  ```bash
  cp templates/core/JIMMYS-WORKFLOW-TEMPLATE.md /path/to/project/docs/
  ```

---

## ✏️ Step 2: Replace Basic Placeholders in AGENTS.md

### Project Information

- [ ] Replace `[PROJECT_NAME]` with actual project name
  - Example: "Todo API Service"

- [ ] Replace `[SERVICE_DESCRIPTION]` with one-line description
  - Example: "Backend REST API for todo management"

- [ ] Replace `[GITHUB_URL]` with repository URL
  - Example: "https://github.com/username/todo-api"

- [ ] Replace `[LOCAL_PATH]` with local directory path
  - Example: "`~/projects/todo-api`"

- [ ] Replace `[PRIMARY_PURPOSE_DESCRIPTION]` with purpose statement
  - Example: "Provides REST API endpoints for CRUD operations on todo items"

### Status Information

- [ ] Replace `[IN DEVELOPMENT / READY FOR TESTING / PRODUCTION]` with current status
  - Choose: "IN DEVELOPMENT" or "READY FOR TESTING" or "PRODUCTION"

- [ ] Replace all `[YYYY-MM-DD]` with today's date
  - Format: ISO 8601 (e.g., "2025-10-02")

- [ ] Replace `[STATUS_EMOJI]` with appropriate emoji
  - 🔄 for in progress
  - ✅ for complete
  - ⚪ for not started
  - ⚠️ for issues

- [ ] Replace `[STATUS_DESCRIPTION]` with status text
  - Example: "Active Development - 30% Complete"

- [ ] Replace `[COMPLETION_PERCENTAGE]` with current completion
  - Example: "30% Complete"

---

## 🛠️ Step 3: Update Commands in AGENTS.md

### Development Commands

- [ ] Replace `[INSTALL_COMMAND]` with dependency installation command
  - Examples: `npm install`, `pip install -r requirements.txt`, `go mod download`

- [ ] Replace `[DEV_COMMAND]` with dev server command
  - Examples: `npm run dev`, `python manage.py runserver`, `go run main.go`

- [ ] Replace `[TEST_COMMAND]` with test runner command
  - Examples: `npm test`, `pytest`, `go test ./...`

- [ ] Replace `[TYPECHECK_COMMAND]` with type checking command
  - Examples: `npm run typecheck`, `mypy .`, `tsc --noEmit`

- [ ] Replace `[LINT_COMMAND]` with linter command
  - Examples: `npm run lint`, `flake8 .`, `golangci-lint run`

### Production Commands

- [ ] Replace `[BUILD_COMMAND]` with build command
  - Examples: `npm run build`, `docker build .`, `go build`

- [ ] Replace `[PREVIEW_COMMAND]` with preview command
  - Examples: `npm run preview`, `docker run -p 3000:3000 image`

- [ ] Replace `[DEPLOY_COMMAND]` with deployment command
  - Examples: `vercel deploy`, `git push heroku main`, `kubectl apply -f k8s/`

---

## 📝 Step 4: Customize Content Sections in AGENTS.md

### Important Context

- [ ] Write project-specific context (2-5 sentences)
  - Background information
  - Why this project exists
  - Any non-obvious decisions
  - Project history (if applicable)

### Service Overview

- [ ] Write comprehensive service overview (1-2 paragraphs)
  - What the project does
  - How it fits into larger system (if applicable)
  - Target users/audience

- [ ] List key responsibilities (3-5 bullet points)
  - Main features
  - Core functionality
  - Service boundaries

- [ ] Add important distinctions (if applicable)
  - Clarify confusing terminology
  - Explain concepts that might be misunderstood

### Current Status

- [ ] List implemented features with ✅
  - Example: "✅ User authentication"

- [ ] List in-progress features with 🔄
  - Example: "🔄 Email notifications"

- [ ] List planned features with ⚪
  - Example: "⚪ Admin dashboard"

- [ ] List features with issues with ⚠️
  - Example: "⚠️ Payment integration (blocked by API access)"

---

## 🔧 Step 5: Update Technology Stack

### Choose Relevant Section

- [ ] Keep **Frontend** section if frontend project
- [ ] Keep **Backend** section if backend project
- [ ] Keep **Both** if full-stack project
- [ ] Delete irrelevant sections

### Fill In Technology Details

- [ ] Update framework/runtime
- [ ] Update build tools
- [ ] Update styling approach (if frontend)
- [ ] Update database (if backend)
- [ ] Update authentication method
- [ ] Update testing framework
- [ ] Update hosting platform
- [ ] Update CI/CD platform
- [ ] Update monitoring tools (if applicable)

---

## 📁 Step 6: Update Repository Structure

- [ ] Update directory structure to match actual project
  ```
  [PROJECT_ROOT]/
  ├── src/                    # [Your description]
  ├── tests/                  # [Your description]
  ├── docs/                   # [Your description]
  └── [your-directories]/     # [Your descriptions]
  ```

- [ ] Add descriptions for each directory
- [ ] Note any unconventional structure choices

---

## 🔴 Step 7: Document Known Issues & Technical Debt

### Critical Issues

- [ ] List any blocking issues
- [ ] Link to issue tracker tickets (if applicable)
- [ ] Add security vulnerabilities (if known)

### Important Issues

- [ ] List non-blocking but important issues
- [ ] Note any workarounds in place

### Technical Debt

- [ ] Document areas needing refactoring
- [ ] Estimate effort (optional)
- [ ] Note priority (optional)

---

## 🎨 Step 8: Add Project-Specific Guidelines (Optional but Recommended)

### Code Style

- [ ] Document naming conventions
- [ ] Note file organization preferences
- [ ] Add import ordering rules
- [ ] Set component/function size limits

### Testing Requirements

- [ ] Set coverage requirements
- [ ] List required test types
- [ ] Document test data management approach

### Security Considerations

- [ ] Note sensitive data handling procedures
- [ ] Document authentication/authorization patterns
- [ ] List security review requirements

---

## 🔗 Step 9: Update Environment Variables

- [ ] List all required environment variables
  ```bash
  REQUIRED_VAR_1=description
  ```

- [ ] List optional environment variables with defaults
  ```bash
  OPTIONAL_VAR_1=description # Default: value
  ```

- [ ] Add example `.env.example` file to project

---

## 📚 Step 10: Update CLAUDE.md Commands

### Quick Reference Commands

- [ ] Replace `[DEV_COMMAND]` with actual command
- [ ] Replace `[TEST_COMMAND]` with actual command
- [ ] Replace `[BUILD_COMMAND]` with actual command
- [ ] Replace `[TYPECHECK_COMMAND]` with actual command
- [ ] Replace `[LINT_COMMAND]` with actual command

### Update Date

- [ ] Replace `[YYYY-MM-DD]` with today's date

---

## 📊 Step 11: Customize Session Continuity Files

### STATUS.md Setup

- [ ] Replace `[PROJECT_NAME]` with actual project name

- [ ] Replace `[RESEARCH/DESIGN/DEVELOPMENT/TESTING/PRODUCTION]` with current phase

- [ ] Replace `[XX]%` with current completion percentage

- [ ] Update project overview section:
  - Replace `[Research/Implementation/etc.]` with project type
  - Replace `[One-sentence description]` with project goal
  - Replace `[Where this will be deployed]` with deployment target

- [ ] Add Phase 1 information (or delete phase structure if not applicable):
  - Replace `[Phase Name]` with actual phase name
  - Add accomplishments
  - Add key findings/decisions
  - Add relevant metrics

- [ ] Customize metrics sections:
  - For research projects: Document lines, coverage, time invested
  - For code projects: LOC, test coverage, components
  - Delete non-applicable metric categories

- [ ] Fill in timeline section:
  - Add completed milestones with dates
  - Define current milestone
  - List upcoming milestones

- [ ] Document known issues and technical debt

- [ ] Add session history entries (at minimum, initial session)

### NEXT-SESSION-START-HERE.md Setup

- [ ] Replace all `[YYYY-MM-DD]` with today's date

- [ ] Replace `[Brief description]` with last session accomplishment

- [ ] Replace `[RESEARCH/DESIGN/DEVELOPMENT/etc.]` with current phase

- [ ] Fill "What This Project Is" section:
  - Replace `[PROJECT_NAME]` and description
  - Replace `[Chromebook Orchestrator/Developer/etc.]` with your role
  - Add primary responsibilities

- [ ] Update current status summary:
  - Add completed categories with ✅ items
  - Add current work with 🔄 status
  - Add next milestones with ⚪ status

- [ ] Fill current task section:
  - Replace `[Task Name]` with what's being worked on
  - Add completed and remaining steps

- [ ] List key project files with purposes

- [ ] Add 2-3 "Immediate Next Steps" options:
  - Option 1 (recommended): What to do first
  - Option 2: Alternative path
  - Option 3: Another option

- [ ] Customize quick reference commands for your project

- [ ] Add key insights/decisions recap

- [ ] Add important reminders specific to your project

### Update Frequency for Session Files

**STATUS.md:**
- Update at end of each session (mark completions, add metrics)
- Weekly review of health indicators
- Monthly review of all sections

**NEXT-SESSION-START-HERE.md:**
- Update at end of each session (context for next time)
- Review and refresh "Immediate Next Steps"
- Keep quick reference commands current

---

## ✅ Step 12: Validate Template Completion

### Check for Unfilled Placeholders

- [ ] Run placeholder check:
  ```bash
  grep -r "\[" AGENTS.md CLAUDE.md | grep -v "http" | grep -v "example"
  ```
  - Result should be empty (no placeholders left)

### Verify File Existence

- [ ] Confirm `AGENTS.md` exists
  ```bash
  ls -la AGENTS.md
  ```

- [ ] Confirm `CLAUDE.md` exists
  ```bash
  ls -la CLAUDE.md
  ```

- [ ] Confirm `JIMMYS-WORKFLOW.md` exists or is referenced
  ```bash
  ls -la JIMMYS-WORKFLOW.md
  # OR check reference in AGENTS.md
  ```

- [ ] Confirm `STATUS.md` exists (recommended)
  ```bash
  ls -la STATUS.md
  ```

- [ ] Confirm `NEXT-SESSION-START-HERE.md` exists (recommended)
  ```bash
  ls -la NEXT-SESSION-START-HERE.md
  ```

### Check File Sizes

- [ ] Verify AGENTS.md is substantial (200+ lines)
  ```bash
  wc -l AGENTS.md
  ```

- [ ] Verify CLAUDE.md is complete (50+ lines)
  ```bash
  wc -l CLAUDE.md
  ```

- [ ] Verify STATUS.md is substantial (100+ lines recommended)
  ```bash
  wc -l STATUS.md
  ```

- [ ] Verify NEXT-SESSION-START-HERE.md is complete (100+ lines recommended)
  ```bash
  wc -l NEXT-SESSION-START-HERE.md
  ```

---

## 🧪 Step 12: Test with AI Assistant

### Start AI Assistant

- [ ] Open terminal in project directory
- [ ] Start Claude Code or preferred AI assistant
  ```bash
  claude
  ```

### Test AGENTS.md Reading

- [ ] Ask: "Please read AGENTS.md and summarize this project"
- [ ] Verify summary is accurate based on your customizations
- [ ] Check that all 11 core principles are recognized:
  - 1-6: KISS, TDD, SOC, DRY, Documentation Standards, Jimmy's Workflow
  - 7-8: YAGNI, Fix Now
  - 9-11: Measure Twice Cut Once, No Shortcuts, Rules Persist

### Test Jimmy's Workflow v2.1

- [ ] Say: "Let's use Jimmy's Workflow to plan a new feature"
- [ ] Verify AI uses 🔴 PRE-FLIGHT → 🔴 IMPLEMENT → 🟢 VALIDATE → 🔵 CHECKPOINT structure
- [ ] Verify AI asks for confidence level (HIGH/MEDIUM/LOW)
- [ ] Check that validation commands are explicit

### Test Command Recognition

- [ ] Ask: "How do I run tests in this project?"
- [ ] Verify AI responds with correct command from AGENTS.md

---

## 📦 Step 13: Commit Template Files

### Add Files to Git

- [ ] Stage template files
  ```bash
  git add AGENTS.md CLAUDE.md JIMMYS-WORKFLOW.md STATUS.md NEXT-SESSION-START-HERE.md
  ```

### Create Commit

- [ ] Commit with descriptive message
  ```bash
  git commit -m "docs: add AI assistant guidelines with session continuity files"
  ```

### Push to Remote

- [ ] Push to GitHub
  ```bash
  git push origin main
  ```

---

## 📚 Step 13.5: Create Documentation Navigation (Updated v1.7.0)

**When to use**: Projects with >5 documentation files

**Purpose**: Improve documentation discoverability for both AI and human developers

**📖 REQUIRED READING**: Before proceeding, read **templates/docs/DOCUMENTATION-STANDARDS.md** for comprehensive AI-optimized documentation guidelines, including:
- The 7 principles of AI-optimized documentation
- Best practices and anti-patterns
- Integration with Jimmy's Workflow
- Validation checklists

### Assess Documentation Complexity

- [ ] Count total documentation files (`.md` files)
  ```bash
  find . -name "*.md" | wc -l
  ```

### If Project Has >5 Documentation Files

- [ ] **Create DOCS-MAP.md** from template
  ```bash
  cp templates/docs/doc-components/DOCS-MAP.md.template ./DOCS-MAP.md
  ```

- [ ] **Fill DOCS-MAP.md** with inventory
  - [ ] List all root documentation files (AGENTS.md, README.md, etc.)
  - [ ] List all docs/ subdirectories and files
  - [ ] Categorize by priority: ⚡📋🔧🎯📚🏛️
    - ⚡ High Priority (read first)
    - 📋 Planning (strategic decisions)
    - 🔧 Execution (implementation guides)
    - 🎯 Current Work (active development)
    - 📚 Reference (technical specs)
    - 🏛️ Historical (decision records)
  - [ ] Add "Read When" guidance for each file
  - [ ] Update "Last Updated" date

- [ ] **Add AI Navigation Headers** to core files
  ```bash
  # Copy header template
  cat templates/docs/doc-components/AI-NAVIGATION-HEADER.template
  # Add to top of: AGENTS.md, CLAUDE.md, major guides
  # Fill all [FILL: ...] placeholders
  ```

- [ ] **Update parent references**
  - [ ] CLAUDE.md references AGENTS.md as parent
  - [ ] Subdirectory docs reference parent documentation
  - [ ] All files link to DOCS-MAP.md

### If Creating Architecture Decision Records (ADRs)

- [ ] **Create docs/decisions/ directory**
  ```bash
  mkdir -p docs/decisions
  ```

- [ ] **Copy ADR template** for first decision
  ```bash
  cp templates/docs/doc-components/ADR-TEMPLATE.md ./docs/decisions/001-first-decision.md
  ```

- [ ] **Fill ADR** with decision details
  - [ ] Context (why decision needed)
  - [ ] Decision (what was chosen)
  - [ ] Consequences (positive and negative)
  - [ ] Alternatives considered (minimum 2)
  - [ ] Each alternative has "Why Rejected"

### Validation

- [ ] Check for broken links in DOCS-MAP.md
  ```bash
  # All links should point to existing files
  grep -o '\[.*\](\..*\.md)' DOCS-MAP.md | sed 's/.*(\(.*\))/\1/' | while read link; do
    [ ! -f "$link" ] && echo "Broken: $link"
  done
  ```

- [ ] Verify all [FILL: ...] placeholders replaced
  ```bash
  grep -r "\[FILL:" *.md docs/**/*.md
  # Should return no results
  ```

- [ ] Test with AI
  - [ ] Ask: "Where is [topic] documented?"
  - [ ] Expected: AI references DOCS-MAP.md and finds correct file

### If Project Has <5 Documentation Files

- [ ] Skip DOCS-MAP.md (not needed yet)
- [ ] Add AI Navigation Header to AGENTS.md only (optional but recommended)
- [ ] When project grows, revisit this step

---

## 🎉 Step 14: Final Checklist

### Documentation

- [ ] AGENTS.md is complete and accurate
- [ ] CLAUDE.md references AGENTS.md correctly
- [ ] JIMMYS-WORKFLOW.md is accessible
- [ ] STATUS.md tracks current progress
- [ ] NEXT-SESSION-START-HERE.md provides session context
- [ ] All placeholders replaced
- [ ] Commands are correct for this project
- [ ] Environment variables documented
- [ ] **DOCS-MAP.md created** (if project has >5 docs) [v1.5.1]
- [ ] **AI Navigation Headers added** to core files (if using DOCS-MAP) [v1.5.1]
- [ ] **ADRs created** for architecture decisions (if applicable) [v1.5.1]

### Validation

- [ ] No unclosed `[PLACEHOLDER]` markers
- [ ] No unclosed `[FILL: ...]` markers [v1.5.1]
- [ ] AI assistant reads files correctly
- [ ] Jimmy's Workflow is recognized
- [ ] All sections are relevant (deleted N/A sections)
- [ ] **No broken links** in DOCS-MAP.md (if created) [v1.5.1]
- [ ] **AI can find documentation** (test: "where is X documented?") [v1.5.1]

### Git

- [ ] Template files committed
- [ ] Pushed to remote repository
- [ ] Visible in GitHub

---

## 📋 Post-Initialization Maintenance

### After Each Session

- [ ] Update STATUS.md with progress
- [ ] Update NEXT-SESSION-START-HERE.md for next time
- [ ] Mark completed tasks
- [ ] Add new session to history
- [ ] Document key decisions made

### Weekly Review

- [ ] Update current status section in AGENTS.md
- [ ] Update completion percentage in STATUS.md
- [ ] Review and refresh "Immediate Next Steps" in NEXT-SESSION-START-HERE.md
- [ ] Add new known issues
- [ ] Remove resolved issues

### Per-Feature Updates

- [ ] Update status when features complete
- [ ] Add new patterns to common patterns section
- [ ] Update troubleshooting with new issues/solutions

### Monthly Review

- [ ] Review STATUS.md health indicators
- [ ] Update technology stack (if changed)
- [ ] Review session history and metrics
- [ ] Update milestones in STATUS.md

### Per-Milestone Updates

- [ ] Update repository structure (if changed)
- [ ] Review and update project-specific guidelines
- [ ] Update environment variables
- [ ] Update "Last Updated" date in all files
- [ ] Update completion percentage
- [ ] Document milestone achievement in STATUS.md

---

## 🆘 Troubleshooting

### Issue: Too Many Placeholders

**Solution**: Use project type template instead of base template
```bash
cp templates/core/frontend-service.agents.md ./AGENTS.md
```

### Issue: Don't Know What to Put for Some Sections

**Solution**: Start with minimal viable template
- Fill required placeholders only
- Add "TODO" for unknown sections
- Complete over time as project develops

### Issue: Commands Don't Match My Stack

**Solution**: Just replace them! Templates are starting points
- Python project? Replace `npm` with `pip`
- Go project? Replace with `go` commands
- Custom build? Add your custom commands

### Issue: AI Not Using Jimmy's Workflow

**Solution**: Explicit prompting
```
"Please use Jimmy's Workflow v2.1 (PRE-FLIGHT → IMPLEMENT → VALIDATE → CHECKPOINT) for this implementation"
```

**Note**: Ensure AI runs PRE-FLIGHT check first and provides confidence levels at validation.

---

## ✨ Quick Start (Minimal Setup - 10 Minutes)

**For getting started fast:**

1. [ ] Copy AGENTS.md.template → AGENTS.md
2. [ ] Copy CLAUDE.md.template → CLAUDE.md
3. [ ] Copy STATUS.md.template → STATUS.md
4. [ ] Copy NEXT-SESSION-START-HERE.md.template → NEXT-SESSION-START-HERE.md
5. [ ] Copy JIMMYS-WORKFLOW.md
6. [ ] Replace in all files: PROJECT_NAME, GITHUB_URL, LOCAL_PATH, dates
7. [ ] Replace command placeholders
8. [ ] Add 2-3 sentence service overview
9. [ ] Add current phase and 1-2 next steps
10. [ ] Commit

**Everything else can be filled in later!**

**Benefits of including STATUS.md and NEXT-SESSION-START-HERE.md from the start:**
- ✅ Never lose context between sessions
- ✅ AI assistants immediately understand project state
- ✅ Clear tracking of progress and decisions
- ✅ Easy to pick up work after days/weeks away

---

## 📚 Resources

- **Full Guide**: See `AGENTS-TEMPLATE-GUIDE.md`
- **Template Collection**: See `TEMPLATE-COLLECTION-README.md`
- **Workflow Documentation**: See `JIMMYS-WORKFLOW.md` (v2.1)
- **Task Template**: See `JIMMYS-WORKFLOW-TEMPLATE.md` (v2.1)
- **Documentation Standards**: See `DOCUMENTATION-STANDARDS.md`
- **Project Types**: See `project-types/` directory

---

**Checklist Version**: 1.7.0
**Template System Version**: 1.7.0
**Last Updated**: 2026-01-22
