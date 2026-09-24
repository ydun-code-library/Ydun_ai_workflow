# Ydun AI Workflow - Public templates, prompts and patterns for AI-assisted development

<!--
TEMPLATE_VERSION: 2.1.3
TEMPLATE_SOURCE: templates/core/AGENTS.md.template
LAST_SYNC: 2026-09-24
SYNC_CHECK: This repo publishes the templates. Its own AGENTS.md follows templates/core/AGENTS.md.template
CHANGELOG: See the commit history of templates/core/
-->

**STATUS: PUBLISHED (templates release 2.1.3)** - Last Updated: 2026-09-24

## Repository Information
- **GitHub Repository**: https://github.com/ydun-code-library/Ydun_ai_workflow
- **Local Directory**: `Ydun_ai_workflow/` (your clone)
- **Primary Purpose**: Distribute the Ydun project templates, prompt frameworks and template tools. Pure files: no build, no runtime.
- **Documentation site**: https://docs.ydun.io
- **License**: MIT

## Important Context

<!-- PROJECT_SPECIFIC START: IMPORTANT_CONTEXT -->
- **Everything in this repo is public.** No local paths, machine names, hostnames, IPs, usernames or employer names. No secrets.
- **The templates are maintained in a private source repo** and published here. Publishing replaces local paths with repo paths or GitHub URLs, and replaces personal or employer references with neutral wording. The template bodies otherwise match the source.
- **Templates release 2.1.3** was published on 2026-09-24. It replaced 1.7.0 (January 2026). The main changes: eight principles instead of eleven, a thin CLAUDE.md, a "what goes where" table for Claude Code, and the HOUSEKEEPING and README templates.
- `templates/core/` is at 2.1.3. `templates/init/`, `templates/docs/`, `templates/tools/` and `prompts/` have not been refreshed since 2026-03-11. See Known Issues.
<!-- PROJECT_SPECIFIC END: IMPORTANT_CONTEXT -->

## Core Principles (MANDATORY)

Eight principles, one list, three readers. Claude can load them every turn from `~/.claude/rules/principles.md`; Codex, Gemini and humans read this block. Keep the two copies identical. Decided 2026-09-21 (replaced the eleven of v1.x).

### 1. Measure twice, cut once
Read before editing. Verify the path, the command, the assumption. Plan before content and editorial work too.

### 2. Jimmy's Workflow
PRE-FLIGHT → IMPLEMENT → VALIDATE → CHECKPOINT, for all work. VALIDATE names the test, build or screenshot it ran; a stated confidence with no runnable check is MEDIUM at best. HIGH proceeds, MEDIUM pauses for a human spot-check, LOW stops. Full system below.

### 3. Test-driven, always
RED then GREEN. Never "tests later".

### 4. Don't over-engineer
Simplest thing that works. Question every layer.

### 5. Clean, annotated code
Readable, with good notes for the next session. Private repos annotate freely.

### 6. YAGNIY: you ain't gonna need it yet
Don't build it now. Write it down (STATUS, ADR) so it is queued, not lost.

### 7. Self-healing
Build things that recover: retries with backoff, health checks, safe restarts, nothing that can loop forever. When something breaks, fix the cause so it cannot recur.

### 8. No shortcuts
Finish it. Fix it now. Quality over speed.

**Documentation standard:** dated, factual, structured for humans and AI. No marketing language.
**Voice standard:** short sentences, bullets over prose, no filler, no AI tells. The author's own phrases, not rewrites of them.
**When they clash:** security, then measure twice, then Jimmy's Workflow, then no shortcuts, then the rest.

---

## Jimmy's Workflow v2.1 (Red/Green Checkpoints)
**MANDATORY for all implementation tasks**

Use the four-phase checkpoint system to prevent AI hallucination and ensure robust implementation:

```
🔴 PRE-FLIGHT → 🔴 IMPLEMENT → 🟢 VALIDATE → 🔵 CHECKPOINT
```

- 🔴 **PRE-FLIGHT**: Verify context - do I have all files, requirements, dependencies?
- 🔴 **IMPLEMENT**: Write code, build features, make changes
- 🟢 **VALIDATE**: Run explicit validation with documented reasoning and confidence level. Name the runnable check (test, build, screenshot); a stated confidence with no runnable check is MEDIUM at best
- 🔵 **CHECKPOINT**: Mark completion with confidence level and validity conditions

**Critical Rules:**
- NEVER skip PRE-FLIGHT - always verify context first
- NEVER proceed to IMPLEMENT if PRE-FLIGHT status is 🔴 BLOCKED or 🟡 GAPS
- NEVER proceed to next checkpoint without GREEN passing
- ALWAYS document WHY validation proves correctness (reasoning)
- ALWAYS acknowledge what validation does NOT prove (weaknesses)
- ALWAYS document rollback procedures and validity conditions
- ALWAYS disclose when AI validates AI-generated code (COI)

**Confidence Levels:**
- **HIGH**: Proceed automatically
- **MEDIUM**: Human spot-check recommended
- **LOW**: Human validation required

**Reference**: See **JIMMYS-WORKFLOW.md** for complete workflow system (v2.1)

**Usage**: When working with AI assistants, say: *"Let's use Jimmy's Workflow to execute this plan"*

**Benefits:**
- Prevents "AI says done ≠ Actually done" problem
- PRE-FLIGHT catches missing context before wasted effort
- Confidence levels enable appropriate human involvement
- Reasoning documentation combats circular AI validation
- COI disclosure acknowledges AI blind spots
- Provides clear rollback paths with validity conditions


---

## Claude Code Setup (what goes where)

| Need | Put it in | Loads |
|------|-----------|-------|
| A convention or command Claude got wrong twice | `CLAUDE.md` (project) | every turn, keep under 200 lines |
| A rule scoped to some files | `.claude/rules/<topic>.md` with `paths:` | only when those files are touched |
| A playbook you paste for the third time | `.claude/skills/<name>/SKILL.md` | description every turn, body on use |
| A worker you keep spawning with the same brief | `.claude/agents/<name>.md` | on delegation |
| Something that must happen every time | a hook in `.claude/settings.json` | zero context |
| Project background, stack, commands, status | this file (`AGENTS.md`) | read on demand; Claude Code does not auto-load it when a CLAUDE.md exists |

Employer or client projects can run in a separate Claude Code profile with its own rules.

---

## Documentation Standards


**Documentation Layers**:
- **Layer 1**: Development Phase (AGENTS.md, Architecture docs, Phase plans)
- **Layer 2**: Deployment Phase (DEPLOYMENT-GUIDE.md, OPERATIONS.md, API-REFERENCE.md)
- **Layer 3**: User Phase (USER-GUIDE.md, TROUBLESHOOTING.md, Configuration patterns)

---

**Documentation standards**: Comprehensive documentation standards and templates

**Complete Standards**: See [DOCUMENTATION-STANDARDS.md](https://github.com/ydun-code-library/Ydun_ai_workflow/blob/main/templates/docs/DOCUMENTATION-STANDARDS.md) for comprehensive guidelines, best practices, and anti-patterns.

**Quick Start** (for projects with >5 documentation files):

1. **Add AI Navigation Headers** to core documentation:
   ```bash
   # Download the template
   curl -sO https://raw.githubusercontent.com/ydun-code-library/Ydun_ai_workflow/main/templates/docs/doc-components/AI-NAVIGATION-HEADER.template
   # Add to top of AGENTS.md, CLAUDE.md, major guides
   # Fill all [FILL: ...] placeholders
   ```

2. **Create Master Navigation Map**:
   ```bash
   # If project has >5 documentation files
   curl -so DOCS-MAP.md https://raw.githubusercontent.com/ydun-code-library/Ydun_ai_workflow/main/templates/docs/doc-components/DOCS-MAP.md.template
   # List all documentation files with priorities (⚡📋🔧🎯📚🏛️)
   ```

3. **Document Architecture Decisions**:
   ```bash
   # Create ADR directory
   mkdir -p docs/decisions
   # Use the template for each significant decision
   curl -so docs/decisions/001-decision-name.md https://raw.githubusercontent.com/ydun-code-library/Ydun_ai_workflow/main/templates/docs/doc-components/ADR-TEMPLATE.md
   ```

**Available Templates** (from [Ydun_ai_workflow](https://github.com/ydun-code-library/Ydun_ai_workflow/tree/main/templates/docs/doc-components)):
- [AI-NAVIGATION-HEADER.template](https://github.com/ydun-code-library/Ydun_ai_workflow/blob/main/templates/docs/doc-components/AI-NAVIGATION-HEADER.template) - Help AI know when to read files
- [DOCS-MAP.md.template](https://github.com/ydun-code-library/Ydun_ai_workflow/blob/main/templates/docs/doc-components/DOCS-MAP.md.template) - Master documentation index
- [ADR-TEMPLATE.md](https://github.com/ydun-code-library/Ydun_ai_workflow/blob/main/templates/docs/doc-components/ADR-TEMPLATE.md) - Architecture Decision Records
- [METADATA-BLOCK.template](https://github.com/ydun-code-library/Ydun_ai_workflow/blob/main/templates/docs/doc-components/METADATA-BLOCK.template) - Machine-readable metadata

**When to Apply**:
- ✅ Projects with >5 documentation files (use full standards)
- ✅ Multi-service platforms (essential for navigation)
- ✅ Long-lived projects >3 months (worth the investment)
- ⚠️ Optional for simple scripts (lightweight approach fine)

**Validation** (requires a [Ydun_ai_workflow](https://github.com/ydun-code-library/Ydun_ai_workflow) clone):
```bash
# Check documentation quality (optional Check #8), from your project directory
path/to/Ydun_ai_workflow/templates/tools/audit-project.sh --full
```

All documentation follows these principles to maximize AI assistant effectiveness.

## GitHub Workflow

### Use GitHub CLI (gh) for All GitHub Operations

**Standard Tool**: Use `gh` CLI for all GitHub interactions (issues, PRs, CI/CD monitoring, releases)

**Installation**: `gh` should already be installed. Verify with `gh --version`

**Common Operations:**

**Pull Requests:**
```bash
gh pr create --title "Feature" --body "Description"
gh pr list                          # View open PRs
gh pr checks                        # Check CI/CD status
gh pr view [number]                 # View PR details
gh pr merge [number]                # Merge PR
```

**CI/CD Monitoring:**
```bash
gh run list                         # List workflow runs
gh run view [id]                    # View run details
gh run watch                        # Watch current run (live updates)
gh workflow list                    # List workflows
```

**Issues:**
```bash
gh issue create --title "Bug" --body "Description"
gh issue list                       # View open issues
gh issue view [number]              # View issue details
gh issue close [number]             # Close issue
```

**Releases:**
```bash
gh release create v1.0.0            # Create release
gh release list                     # List releases
gh release view [tag]               # View release details
```

**Why GitHub CLI:**
- ✅ Scriptable and automation-friendly
- ✅ Consistent across all projects
- ✅ Works seamlessly with AI assistants
- ✅ Faster than web UI for most operations
- ✅ Built-in CI/CD monitoring
- ✅ Integrates with Jimmy's Workflow checkpoints

**AI Assistant Note**: Always use `gh` commands instead of suggesting "check the GitHub web UI" or manual git operations for GitHub-specific tasks.

## Service Overview

<!-- PROJECT_SPECIFIC START: SERVICE_OVERVIEW -->
A distribution repo. People clone it or download single files, copy a template into their own project and fill the placeholders.

**Key Responsibilities:**
- Publish the core project templates (`templates/core/`)
- Publish the setup guides, documentation standards and doc components (`templates/init/`, `templates/docs/`)
- Publish the template tools (`templates/tools/`) and prompt frameworks (`prompts/`)

**Important Distinctions:**
- This file (`AGENTS.md`) is the guide for working on this repo. `templates/core/AGENTS.md.template` is the file people copy into their own projects.
- `JIMMYS-WORKFLOW.md` at the root and `templates/core/JIMMYS-WORKFLOW.md` are the same workflow (v2.1). The root copy serves this repo.
<!-- PROJECT_SPECIFIC END: SERVICE_OVERVIEW -->

## Current Status

<!-- PROJECT_SPECIFIC START: CURRENT_STATUS -->
**Published** (2026-09-24)

- ✅ `templates/core/`: 2.1.3 (AGENTS 2.1.3, CLAUDE 2.0.0, JIMMYS-WORKFLOW 2.1, STATUS, NEXT-SESSION, HOUSEKEEPING, README)
- ✅ `prompts/`: audit system (5 templates), CAP, prompt testing, audit execution patterns
- ⚠️ `templates/tools/`: scripts report 2.1.3 projects as out of date (see Known Issues)
- ⚠️ `templates/init/`: still describes the 1.x templates (eleven principles)
<!-- PROJECT_SPECIFIC END: CURRENT_STATUS -->

## Technology Stack

- Markdown and plain-text templates
- Bash scripts in `templates/tools/` (need bash 4 or later)
- No build step, no dependencies, no CI

## Build & Test Commands

There is nothing to build. Before committing, run the publication checks:

```bash
# No em dashes in anything touched
grep -rn "$(printf '\342\200\224')" --exclude-dir=.git .

# House wording: no "blockchain" or "consultancy" in visible text
grep -rniE "blockchain|consultancy" --exclude-dir=.git .

# No local paths or private hosts in published templates (~/.claude/ is fine: it is Claude Code's standard location)
grep -rnE "~/[^.]|/home/|/Users/|[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" templates/core

# Template tools: exercise them from a scratch project copied from templates/core
bash templates/tools/check-version.sh      # from the scratch project directory
bash templates/tools/audit-project.sh      # needs bash 4 or later
```

## Repository Structure

```
Ydun_ai_workflow/
├── templates/
│   ├── core/                    # Templates people copy into projects (2.1.3)
│   │   ├── AGENTS.md.template
│   │   ├── CLAUDE.md.template
│   │   ├── JIMMYS-WORKFLOW.md   # Full workflow v2.1
│   │   ├── JIMMYS-WORKFLOW-TEMPLATE.md
│   │   ├── STATUS.md.template
│   │   ├── NEXT-SESSION-START-HERE.md.template
│   │   ├── HOUSEKEEPING.md.template
│   │   ├── README.md.template
│   │   └── README.md            # What is in this folder
│   ├── init/                    # init-project.md, AGENTS-TEMPLATE-GUIDE.md
│   ├── docs/                    # Documentation standards, doc components
│   └── tools/                   # audit-project.sh, check-version.sh, sync-templates.sh
├── prompts/
│   ├── audit/                   # Multi-lens audit system (templates/ holds 5)
│   └── methodology/             # CAP, prompt testing, audit patterns, god prompt
├── AGENTS.md                    # This file
├── CLAUDE.md                    # Claude Code notes for this repo
├── JIMMYS-WORKFLOW.md           # Workflow v2.1
├── README.md                    # Public front page
├── VERSION                      # Read by the template tools (see Known Issues)
├── llms.txt                     # AI discoverability
└── LICENSE                      # MIT
```

## Development Workflow

### Starting Work on a Task
1. Read this AGENTS.md file for context
2. Check current implementation status above
3. Review known issues and TODOs below
4. **Use Jimmy's Workflow**: Plan → Implement → Validate → Checkpoint
5. Follow TDD approach - write tests first
6. Implement minimal code to pass tests
7. Refactor while maintaining green tests

### Housekeeping
When someone says "let's do housekeeping", read **HOUSEKEEPING.md** and follow the checklist. It covers: tests passing, documentation accuracy, stale files, git state, security checks, and more. Every check is a PRE-FLIGHT → VALIDATE → CHECKPOINT cycle.

This repo has no HOUSEKEEPING.md of its own yet. Until it does, housekeeping here means the publication checks under Build & Test Commands.

### Before Committing
1. Run the publication checks (Build & Test Commands)
2. For a template release: diff `templates/core/` against the source and confirm every difference is a path or wording neutralisation
3. Update README.md, `templates/core/README.md` and llms.txt if the file list changed
4. Ensure no credentials, local paths or private names are exposed
5. Use Jimmy's Workflow checkpoints to validate completeness

### Documentation Updates
1. Update README.md with any template or file changes
2. Update this AGENTS.md if the publishing approach changes
3. Document all decisions with dates

## Known Issues & Technical Debt

<!-- PROJECT_SPECIFIC START: KNOWN_ISSUES -->
Recorded 2026-09-24.

### 🔴 Critical Issues
1. **`VERSION` says 3.0.0; the templates are 2.1.3.** `check-version.sh` and `sync-templates.sh` compare a project's `TEMPLATE_VERSION` with this file, so a project built from the current templates reads "out of date (2.1.3 → 3.0.0)".
2. **The tools look for `projects/core/`, which does not exist here** (the templates are in `templates/core/`). `check-version.sh` cannot compare JIMMYS-WORKFLOW.md; `sync-templates.sh` cannot find the master templates.
3. **The tools and templates point at a `CHANGELOG.md` this repo does not have.**

### 🟡 Important Issues
1. `templates/tools/audit-project.sh` (1.5.1) needs bash 4 or later. macOS ships bash 3.2; run it with a newer bash (`brew install bash`).
2. `templates/init/init-project.md` and `templates/init/AGENTS-TEMPLATE-GUIDE.md` still describe the 1.x templates (eleven principles).
3. `templates/docs/AI-DRIVEN-SEO-BEST-PRACTICES.md` is January 2026 guidance and has not been reviewed since.
4. Some pages on docs.ydun.io describe the earlier multi-agent practice.

### 📝 Technical Debt
1. House wording: "blockchain" in `prompts/methodology/audit-map-execution-patterns.md` (lines 66, 106, 607, 612); "consultancy" in `templates/docs/AI-DRIVEN-SEO-BEST-PRACTICES.md:99`.
2. Em dashes remain in `prompts/` and in the READMEs under `templates/init/`, `templates/docs/` and `templates/tools/`.
3. `llms.txt` still says "Production-tested".
4. No DOCS-MAP.md; each folder has its own README instead.
<!-- PROJECT_SPECIFIC END: KNOWN_ISSUES -->

## Project-Specific Guidelines

<!-- PROJECT_SPECIFIC START: PROJECT_SPECIFIC_GUIDELINES -->
### Public output rules
- Short sentences. No em dashes. No filler. No marketing language ("production-ready", "battle-tested", "world-class").
- Say decentralised systems, verifiable systems or smart contracts, not "blockchain".
- Ydun.io is an R&D practice, not a consultancy.
- Date every statement of status.

### Publishing a template release
- Copy each file from the source templates. Do not edit the template bodies here.
- Replace local paths: `TEMPLATE_SOURCE` becomes `templates/core/<file>`; tool calls become `path/to/Ydun_ai_workflow/templates/tools/<script>`; doc components become GitHub or raw URLs.
- Replace private references (machines, hosts, usernames, employer names, internal scripts) with neutral wording ("your build server", "a separate Claude Code profile").
- Leave `~/.claude/...` paths: they are Claude Code's standard locations.
- Workflow files stay at the same version as the source; only the header path differs.

### Security Considerations
- Never commit secrets, `.env` files, private hostnames or IPs.
<!-- PROJECT_SPECIFIC END: PROJECT_SPECIFIC_GUIDELINES -->

## Dependencies & Integration

<!-- PROJECT_SPECIFIC START: DEPENDENCIES -->
### External Services
- **docs.ydun.io**: the documentation site. README and llms.txt link to it for guides and research.
- **GitHub raw URLs**: `templates/core/AGENTS.md.template` downloads doc components from `raw.githubusercontent.com/ydun-code-library/Ydun_ai_workflow/main/`. Moving files under `templates/docs/doc-components/` breaks those links.
<!-- PROJECT_SPECIFIC END: DEPENDENCIES -->

## Environment Variables

None.

## Troubleshooting

<!-- PROJECT_SPECIFIC START: TROUBLESHOOTING -->
**Issue**: `audit-project.sh: declare: -A: invalid option`
**Solution**: The system bash is 3.2 (macOS). Run it with bash 4 or later: `/opt/homebrew/bin/bash path/to/Ydun_ai_workflow/templates/tools/audit-project.sh`.

**Issue**: `check-version.sh` says a fresh 2.1.3 project is out of date.
**Solution**: Known issue (see Critical Issues 1 and 2). Compare the `TEMPLATE_VERSION` in your AGENTS.md with `templates/core/AGENTS.md.template` by hand.
<!-- PROJECT_SPECIFIC END: TROUBLESHOOTING -->

## Resources & References

- Documentation site: https://docs.ydun.io
- agents.md standard: https://agents.md/

## Template Version Management

**Current Template Version**: See `<!-- TEMPLATE_VERSION -->` comment at top of this file

**This project uses versioned templates** from the [Ydun AI Workflow](https://github.com/ydun-code-library/Ydun_ai_workflow) repository.

> **Note:** The tool scripts below live in the templates repo, not in your project. Clone it once and keep it alongside your projects:
> ```bash
> git clone https://github.com/ydun-code-library/Ydun_ai_workflow.git
> ```
> Run the scripts from your project directory.

### Check if Templates are Up to Date

```bash
path/to/Ydun_ai_workflow/templates/tools/check-version.sh
```

**What it does:**
- Compares your AGENTS.md version with master template version
- Exit code 0 = up to date ✅
- Exit code 1 = out of date ⚠️

### View Template Changelog

```bash
git -C path/to/Ydun_ai_workflow log --oneline -- templates/core/
```

See what's new in each version and migration instructions.

### Sync to Latest Version (Manual for now)

```bash
path/to/Ydun_ai_workflow/templates/tools/sync-templates.sh --dry-run   # Preview changes
path/to/Ydun_ai_workflow/templates/tools/sync-templates.sh             # Apply changes (with confirmation)
path/to/Ydun_ai_workflow/templates/tools/sync-templates.sh --auto      # Auto-apply without confirmation
```

**What gets preserved during sync:**
- ✅ All `<!-- PROJECT_SPECIFIC -->` sections (your customizations)
- ✅ All placeholder values (PROJECT_NAME, commands, etc.)
- ✅ Custom additions to Known Issues, Technical Debt, etc.
- ✅ Project-specific guidelines and patterns

**What gets updated during sync:**
- 🔄 Core Development Principles (if new ones added)
- 🔄 Template structure improvements
- 🔄 Standard sections and formatting
- 🔄 Tool integrations (GitHub CLI, etc.)

**Important Notes:**
- Always review the diff before applying
- Backups are created automatically in `.template-sync-backup/`
- If sync fails, restore from backup
- Commit template updates separately from feature work

### Template Compliance Checking

**AI Assistant Behavior**: When user asks "check templates" or "are we up to date?", automatically:
1. Run: `path/to/Ydun_ai_workflow/templates/tools/audit-project.sh` OR manually execute checks
2. Generate compliance report
3. Offer remediation based on findings

**User can also run manually:**
```bash
path/to/Ydun_ai_workflow/templates/tools/audit-project.sh          # Full audit
path/to/Ydun_ai_workflow/templates/tools/audit-project.sh --quick  # Quick check
```

**Quick Manual Check:**
```bash
# Are we up to date?
path/to/Ydun_ai_workflow/templates/tools/check-version.sh

# What's new?
git -C path/to/Ydun_ai_workflow log --oneline -- templates/core/
```

## Important Reminders for AI Assistants

1. **Always use Jimmy's Workflow** for implementation tasks
2. **Follow TDD** - Write tests before implementation
3. **Don't over-engineer** - Simplest thing that works. Question every layer
4. **Apply YAGNI** - Only implement what's needed now, not future "might need" features
5. **Use GitHub CLI** - Use `gh` for all GitHub operations (PRs, issues, CI/CD monitoring)
6. **Fix Now** - Never defer fixes for vulnerabilities, warnings, or test failures. No suppressions without documented justification
7. **Document dates** - Include actual dates in all documentation
8. **Validate explicitly** - Run commands, don't assume
9. **Never skip checkpoints** - Each phase must complete before proceeding
10. **Update this file** - Keep AGENTS.md current as project evolves
11. **Measure Twice, Cut Once** - Verify before executing. Double-check paths, commands, and assumptions
12. **No Shortcuts** - Complete the job properly. No half-arsed work or "good enough" hacks
13. **Principles persist** - The eight principles remain in effect after auto-compact. Re-read this file if uncertain
14. **Housekeeping** - When asked for "housekeeping", read HOUSEKEEPING.md and follow the checklist. Don't improvise. Use the defined process

---

**This document follows the [agents.md](https://agents.md/) standard for AI coding assistants.**

**Template Version**: 2.1.3
**Last Updated**: 2026-09-24
