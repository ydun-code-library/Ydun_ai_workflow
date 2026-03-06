# Ydun AI Workflow - Public documentation site and template repository for AI-assisted development

<!--
TEMPLATE_VERSION: 1.7.0
TEMPLATE_SOURCE: ~/templates/projects/core/AGENTS.md.template
LAST_SYNC: 2026-03-06
SYNC_CHECK: Run ~/templates/tools/check-version.sh to verify you have the latest template version
AUTO_SYNC: Run ~/templates/tools/sync-templates.sh to update (preserves your customizations)
CHANGELOG: See ~/templates/CHANGELOG.md for version history
-->

**STATUS: IN DEVELOPMENT** - Last Updated: 2026-03-06

## Repository Information
- **GitHub Repository**: https://github.com/ydun-code-library/Ydun_ai_workflow
- **Local Directory**: `~/Projects/public-templates-guide`
- **Primary Purpose**: Public documentation site and template repository sharing Ydun's AI development workflow, principles, and multi-agent coordination patterns

## Important Context

<!-- PROJECT_SPECIFIC START: IMPORTANT_CONTEXT -->
This is a **PUBLIC** repository. It is a curated extract from the private `~/templates/` working repo.

**Critical privacy rules:**
- NEVER include private infrastructure data (Tailscale IPs, SSH configs, machine names, hardware specs)
- NEVER reference internal team members by machine name (Beast, Guardian, Q, Moneypenny) in committed content
- ALWAYS anonymise examples from the internal system (use "Machine A", "Machine B", etc.)
- ALWAYS run the private data grep check before every commit (see Build & Test Commands below)
- Source material lives in `~/templates/` — that repo is NOT modified by this project

**Relationship to ~/templates/:**
- This repo is a one-way curated extract, not a sync
- Content is copied, edited for public consumption, then maintained independently
- The private repo continues to be the working system; this is the public showcase

**Full implementation plan**: See `IMPLEMENTATION-PLAN.md` for phases, content map, quality gates, and risk register.
<!-- PROJECT_SPECIFIC END: IMPORTANT_CONTEXT -->

## Core Development Principles (MANDATORY)

### 1. KISS (Keep It Simple, Stupid)
- Avoid over-complication and over-engineering
- Choose simple solutions over complex ones
- Question every abstraction layer
- If a feature seems complex, ask: "Is there a simpler way?"

### 2. TDD (Test-Driven Development)
- Write tests first
- Run tests to ensure they fail (Red phase)
- Write minimal code to pass tests (Green phase)
- Refactor while keeping tests green
- Never commit code without tests

### 3. Separation of Concerns (SOC)
- Each module/component has a single, well-defined responsibility
- Clear boundaries between different parts of the system
- Services should be loosely coupled
- Avoid mixing business logic with UI or data access code

### 4. DRY (Don't Repeat Yourself)
- Eliminate code duplication
- Extract common functionality into reusable components
- Use configuration files for repeated settings
- Create shared libraries for common operations

### 5. Documentation Standards
- Always include the actual date when writing documentation
- Use objective, factual language only
- Avoid marketing terms like "production-ready", "world-class", "highly sophisticated", "cutting-edge", etc.
- State current development status clearly
- Document what IS, not what WILL BE

### 5.5. AI-Optimized Documentation
**CRITICAL**: Documentation is structured data for both humans AND AI consumption

**Added**: v1.5.0 | **Enhanced**: v1.5.1

**Purpose**: Enable AI assistants to effectively help during:
- **Development** (now) - Building the system
- **Deployment** (later) - Setting up and configuring
- **Operations** (ongoing) - Monitoring, troubleshooting
- **User Support** (ongoing) - Helping users use the system

**The 7 Principles**:
1. **Structured Data Over Prose** - Use tables, JSON, YAML instead of paragraphs
2. **Explicit Context** - Never assume prior knowledge
3. **Cause-Effect Relationships** - Clear "if X then Y" statements
4. **Machine-Readable Formats** - Consistent, parseable metadata (dates, versions, status)
5. **Searchable Content** - Keywords, anchors, consistent terminology
6. **Version-Stamped** - Date all documentation updates
7. **Cross-Referenced** - Explicit links between related docs

**Example** (Good AI-optimized documentation):
```markdown
## Database Configuration

**Required Environment Variables**:
| Variable | Format | Example | Required |
|----------|--------|---------|----------|
| DATABASE_URL | postgresql://... | postgresql://postgres:secret@localhost:5432/db | Yes |

**Validation**:
\```bash
npm run db:test-connection
# Expected output: "Connected successfully"
\```
```

**Documentation Layers**:
- **Layer 1**: Development Phase (AGENTS.md, Architecture docs, Phase plans)
- **Layer 2**: Deployment Phase (DEPLOYMENT-GUIDE.md, OPERATIONS.md, API-REFERENCE.md)
- **Layer 3**: User Phase (USER-GUIDE.md, TROUBLESHOOTING.md, Configuration patterns)

---

**New in v1.5.1**: Comprehensive documentation standards and templates

**Complete Standards**: See `templates/docs/DOCUMENTATION-STANDARDS.md` for comprehensive guidelines, best practices, and anti-patterns.

**Quick Start** (for projects with >5 documentation files):

1. **Add AI Navigation Headers** to core documentation:
   ```bash
   # Copy template
   cat templates/docs/doc-components/AI-NAVIGATION-HEADER.template
   # Add to top of AGENTS.md, CLAUDE.md, major guides
   # Fill all [FILL: ...] placeholders
   ```

2. **Create Master Navigation Map**:
   ```bash
   # If project has >5 documentation files
   cp templates/docs/doc-components/DOCS-MAP.md.template ./DOCS-MAP.md
   # List all documentation files with priorities
   ```

3. **Document Architecture Decisions**:
   ```bash
   # Create ADR directory
   mkdir -p docs/decisions
   # Use template for each significant decision
   cp templates/docs/doc-components/ADR-TEMPLATE.md ./docs/decisions/001-decision-name.md
   ```

**Available Templates**:
- `templates/docs/doc-components/AI-NAVIGATION-HEADER.template` - Help AI know when to read files
- `templates/docs/doc-components/DOCS-MAP.md.template` - Master documentation index
- `templates/docs/doc-components/ADR-TEMPLATE.md` - Architecture Decision Records
- `templates/docs/doc-components/METADATA-BLOCK.template` - Machine-readable metadata

**When to Apply**:
- Projects with >5 documentation files (use full standards)
- Multi-service platforms (essential for navigation)
- Long-lived projects >3 months (worth the investment)
- Optional for simple scripts (lightweight approach fine)

**Validation**:
```bash
# Check documentation quality (optional Check #8)
~/templates/tools/audit-project.sh --full
```

All documentation follows these principles to maximize AI assistant effectiveness.

### 6. Jimmy's Workflow v2.1 (Red/Green Checkpoints)
**MANDATORY for all implementation tasks**

Use the four-phase checkpoint system to prevent AI hallucination and ensure robust implementation:

```
PRE-FLIGHT -> IMPLEMENT -> VALIDATE -> CHECKPOINT
```

- **PRE-FLIGHT**: Verify context - do I have all files, requirements, dependencies?
- **IMPLEMENT**: Write code, build features, make changes
- **VALIDATE**: Run explicit validation with documented reasoning and confidence level
- **CHECKPOINT**: Mark completion with confidence level and validity conditions

**Critical Rules:**
- NEVER skip PRE-FLIGHT - always verify context first
- NEVER proceed to IMPLEMENT if PRE-FLIGHT status is BLOCKED or GAPS
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
- Prevents "AI says done = Actually done" problem
- PRE-FLIGHT catches missing context before wasted effort
- Confidence levels enable appropriate human involvement
- Reasoning documentation combats circular AI validation
- COI disclosure acknowledges AI blind spots
- Provides clear rollback paths with validity conditions

### 7. YAGNI (You Ain't Gonna Need It)
- Don't implement features until they're actually needed
- Resist the urge to "future-proof" or add "might be useful later" code
- Build for current requirements, not hypothetical future ones
- Question every feature: "Do we need this NOW?"
- Refactor when requirements change, don't pre-optimize
- Every line of code is a liability - only write what's necessary

**Why This Matters:**
- Prevents scope creep and over-engineering
- Reduces technical debt (unused code is still debt)
- Speeds up development (focus on actual requirements)
- Forces clear prioritization of features

**AI Assistant Reminder:** Don't add "helpful" features like caching, abstraction layers, or config systems unless explicitly required by current needs.

### 8. Fix Now, Not Later
- Fix vulnerabilities immediately when discovered (npm audit, security warnings)
- Fix warnings immediately (don't suppress or accumulate)
- Fix failing tests immediately (understand root cause, don't skip)
- Fix linter errors immediately (don't disable rules without reason)
- Address build errors and deprecation warnings as they appear
- Don't use suppressions (@ts-ignore, eslint-disable, etc.) without documented justification

**Exception Clause:**
- If you MUST defer or bypass an issue:
  1. Investigate the root cause thoroughly
  2. Weigh multiple solution options
  3. Make an explicit decision
  4. DOCUMENT why (in code comments, KNOWN_ISSUES.md, or technical debt tracker)
  5. Create a tracking issue/ticket

**Why This Matters:**
- Prevents technical debt accumulation
- Keeps codebase healthy and maintainable
- Vulnerabilities don't ship to production
- Warnings don't become noise
- Tests remain meaningful

**AI Assistant Reminder:** Never suggest "we'll fix this later" or "skip for now". Always investigate root cause and fix immediately. If deferring is necessary, document comprehensively.

### 9. Measure Twice, Cut Once
- Always verify your understanding before executing
- Double-check file paths, command syntax, and target locations
- Review the plan before implementation begins
- Confirm assumptions with explicit checks (read the file, run the test)
- When in doubt, investigate first - don't guess

**Why This Matters:**
- Prevents "oops, wrong file" disasters
- Catches misunderstandings before they become bugs
- Saves time by avoiding rework
- Builds confidence in changes

**AI Assistant Reminder:** Before making changes, explicitly verify: Is this the right file? Is this the right approach? Did I understand the requirement correctly? Run verification commands, don't assume.

### 10. No Shortcuts (Do It Right)
- Complete the job properly - no half-arsed work
- Don't skip steps to save time
- Implement the full solution, not a "good enough" hack
- If something needs 5 steps, do all 5 steps
- Quality over speed - cutting corners creates debt

**Why This Matters:**
- Half-finished work creates more work later
- Shortcuts compound into technical debt
- "Quick fixes" become permanent problems
- Professional work means complete work

**AI Assistant Reminder:** Never say "we can skip this for now" or "this should be good enough". Complete the task fully. If scope needs reducing, discuss with user first - don't silently cut corners.

### 11. Rules Persist (Context Compression Immunity)
- **ALL rules remain in effect after auto-compact/context summarization**
- Core principles are NEVER optional, regardless of context length
- If you can't remember a rule, re-read AGENTS.md
- Summarization does not equal permission to skip validation
- Jimmy's Workflow gates apply to EVERY task, not just "important" ones

**Why This Matters:**
- Context compression can cause AI to "forget" constraints
- Long sessions drift from initial guidelines
- Rules exist for good reasons - they don't expire
- Consistency requires explicit reinforcement

**AI Assistant Reminder:** After context summarization, you may feel "freer" - this is an illusion. Re-read AGENTS.md if uncertain. All 11 principles apply with full force regardless of conversation length. NEVER skip Jimmy's Workflow checkpoints just because "we've been doing this for a while".

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
- Scriptable and automation-friendly
- Consistent across all projects
- Works seamlessly with AI assistants
- Faster than web UI for most operations
- Built-in CI/CD monitoring
- Integrates with Jimmy's Workflow checkpoints

**AI Assistant Note**: Always use `gh` commands instead of suggesting "check the GitHub web UI" or manual git operations for GitHub-specific tasks.

## Service Overview

<!-- PROJECT_SPECIFIC START: SERVICE_OVERVIEW -->
Ydun AI Workflow is a public documentation site and template repository that shares production-tested patterns for AI-assisted development. It extracts and curates content from Ydun's private template system (in use since October 2025, iterated through 4 major versions) into a public resource.

The project has two delivery surfaces:
1. **Astro Starlight docs site** at `docs.ydun.io` — browse, learn, search
2. **Raw template files** in `templates/`, `prompts/`, `guides/` — clone, copy, use

**Key Responsibilities:**
- Serve as public showcase of Ydun's AI development methodology
- Provide usable project templates anyone can clone and adapt (AGENTS.md, CLAUDE.md, Jimmy's Workflow)
- Share prompt engineering frameworks (audit prompts, CAP methodology)
- Document multi-agent coordination patterns (anonymised from internal v1-v4 evolution)
- Publish research findings (Haiku 4.5 performance, orchestrator patterns)

**Important Distinctions:**
- **This repo vs ~/templates/**: This is a curated PUBLIC extract. The private repo is the working system. Content flows one way only (private -> public). No auto-sync.
- **Docs site vs raw files**: The docs site explains and contextualises. The raw files are what people actually copy into their projects.
- **Templates vs guides**: Templates are fill-in-the-blank files for new projects. Guides are narrative documentation about methodology and patterns.
<!-- PROJECT_SPECIFIC END: SERVICE_OVERVIEW -->

## Current Status

<!-- PROJECT_SPECIFIC START: CURRENT_STATUS -->
**Active Development — Phase 1: Foundation** - 15% Complete

- [x] PRE-FLIGHT: Requirements, dependencies, access verified
- [x] Implementation plan written (IMPLEMENTATION-PLAN.md)
- [x] Project templates set up via init-project.md checklist
- [ ] Astro Starlight scaffolded with Bun
- [ ] Starlight configured (sidebar, theme, metadata)
- [ ] Git init + GitHub repo created (public)
- [ ] Initial commit + push
- [ ] Content migration from ~/templates/ (Phase 2)
- [ ] New anonymised guides (Phase 3)
- [ ] Infrastructure on Beast (Phase 5, separate session)
<!-- PROJECT_SPECIFIC END: CURRENT_STATUS -->

## Technology Stack

### Documentation Site (Astro Starlight)

**Frontend:**
- **Framework**: Astro 5.x + Starlight (docs theme)
- **Build Tool**: Astro built-in (Vite under the hood)
- **Styling**: Starlight default theme
- **Search**: Pagefind (included with Starlight)

**Infrastructure:**
- **Package Manager**: Bun
- **Hosting**: Caddy on Beast via Cloudflare Tunnel
- **Domain**: docs.ydun.io
- **CI/CD**: GitHub push -> Guardian webhook -> NATS -> Beast rebuild script
- **Build Output**: Static HTML

### Templates & Prompts

- **Format**: Markdown with HTML comment placeholders (`<!-- PROJECT_SPECIFIC -->`)
- **Tools**: Bash scripts (check-version.sh, audit-project.sh, sync-templates.sh)
- **Version Control**: TEMPLATE_VERSION headers in HTML comments

## Build & Test Commands

### Development
```bash
# Install dependencies
cd docs && bun install

# Start development server
cd docs && bun run dev

# Run tests (Astro check)
cd docs && bun run astro check

# Type checking
cd docs && bun run astro check

# Linting
cd docs && bun run astro check
```

### Production
```bash
# Build for production
cd docs && bun run build

# Run production build locally
cd docs && bun run preview

# Deploy (automated via webhook pipeline, or manual)
# Push to GitHub -> auto-deploys to docs.ydun.io
```

### Privacy Checks (MANDATORY before every commit)
```bash
# Check for Tailscale IPs
grep -rn "100\.\(71\|114\|115\|116\)" . --include="*.md" --include="*.mdx" --include="*.ts" --include="*.mjs"

# Check for machine names and usernames
grep -rn "beast\|guardian\|penguin\|jamess-mac-mini\|jimmyb\|jamesb" . --include="*.md" --include="*.mdx" --include="*.ts" --include="*.mjs" | grep -vi "example\|template\|anonymi"

# Both commands must return EMPTY results
```

## Repository Structure

```
Ydun_ai_workflow/
├── docs/                           # Astro Starlight documentation site
│   ├── astro.config.mjs            # Astro + Starlight configuration
│   ├── package.json                # Dependencies (Bun)
│   ├── tsconfig.json               # TypeScript config
│   └── src/
│       ├── content/docs/           # All documentation pages (.md/.mdx)
│       │   ├── index.mdx           # Landing page
│       │   ├── getting-started/    # Overview, installation, philosophy
│       │   ├── templates/          # Template deep dives
│       │   ├── workflow/           # Jimmy's Workflow, principles
│       │   ├── prompts/            # Audit & methodology
│       │   ├── guides/             # Multi-agent, role cards, evolution
│       │   ├── tech/               # Cardano, Solidity
│       │   └── research/           # Haiku findings, orchestrator pattern
│       └── assets/                 # Images, diagrams
│
├── templates/                      # Raw template files (clone and use)
│   ├── core/                       # AGENTS.md, CLAUDE.md, workflow, session files
│   ├── init/                       # Project initialization guides
│   ├── docs/                       # Documentation standards + components
│   │   └── doc-components/         # Reusable doc templates
│   ├── tech/                       # Technology-specific templates
│   │   ├── cardano/                # Cardano/Aiken development
│   │   └── solidity/               # Solidity/EVM development
│   └── tools/                      # Bash scripts (version check, audit, sync)
│
├── prompts/                        # Prompt templates
│   ├── audit/                      # Codebase audit frameworks
│   └── methodology/                # CAP workflow, prompt testing
│
├── guides/                         # Anonymised methodology guides
│   ├── evolution.md                # v1->v4 journey narrative
│   ├── multi-agent-setup.md        # Running multiple AI instances
│   ├── role-cards.md               # Writing AI agent role definitions
│   ├── handoff-protocol.md         # Team coordination patterns
│   ├── 11-core-principles.md       # Standalone principles reference
│   └── research/                   # Production-validated research findings
│
├── AGENTS.md                       # AI assistant guidelines (this file)
├── CLAUDE.md                       # Claude quick reference
├── JIMMYS-WORKFLOW.md              # Validation system v2.1
├── STATUS.md                       # Project progress tracking
├── NEXT-SESSION-START-HERE.md      # Session continuity
├── IMPLEMENTATION-PLAN.md          # Full implementation plan (5 phases)
├── LICENSE                         # MIT
├── README.md                       # Public-facing README
└── CHANGELOG.md                    # Version history
```

## Development Workflow

### Starting Work on a Task
1. Read this AGENTS.md file for context
2. Check current implementation status above
3. Review IMPLEMENTATION-PLAN.md for phase details
4. Review known issues and TODOs below
5. **Use Jimmy's Workflow**: PRE-FLIGHT -> IMPLEMENT -> VALIDATE -> CHECKPOINT
6. Follow TDD approach - write tests first
7. Implement minimal code to pass tests
8. Refactor while maintaining green tests

### Before Committing Code
1. Run privacy checks (see Build & Test Commands — MANDATORY)
2. Run build: `cd docs && bun run build`
3. Run astro check: `cd docs && bun run astro check`
4. Update documentation if needed
5. Ensure no private data is exposed
6. Verify build succeeds
7. Use Jimmy's Workflow checkpoints to validate completeness

### Documentation Updates
1. Update README.md with any structural changes
2. Add inline comments for complex logic
3. Update this AGENTS.md if development approach changes
4. Document all decisions with dates
5. Keep STATUS.md and NEXT-SESSION-START-HERE.md current

## Known Issues & Technical Debt

<!-- PROJECT_SPECIFIC START: KNOWN_ISSUES -->
### Critical Issues
None — project is new (2026-03-06).

### Important Issues
1. Template files from ~/templates/ contain hardcoded `~/templates/` and `/home/jimmyb/templates/` paths that need replacing with relative paths before public release
2. Shell scripts (`tools/*.sh`) reference `~/templates/` — need adaptation for standalone use from cloned repo

### Technical Debt
None — greenfield project.
<!-- PROJECT_SPECIFIC END: KNOWN_ISSUES -->

## Project-Specific Guidelines

<!-- PROJECT_SPECIFIC START: PROJECT_SPECIFIC_GUIDELINES -->
### Content Curation Rules
- Source material comes from `~/templates/` only
- All systemconfig content must be anonymised before inclusion
- Machine names -> generic roles ("Orchestrator", "Compute Server", "Dev Workstation", etc.)
- IP addresses -> removed entirely
- SSH configs -> never included
- Team member names -> generic descriptions

### Writing Style (Docs Site Pages)
- Direct, practical, no fluff
- Show don't tell — include code examples and real template snippets
- Every page should answer: "What is this?" and "How do I use it?"
- No marketing language (per Principle 5)
- Use tables for structured information
- Include validation commands where applicable

### File Organisation
- Docs site pages go in `docs/src/content/docs/`
- Raw template files go in `templates/`
- Prompt files go in `prompts/`
- Anonymised methodology guides go in `guides/`
- Keep docs pages and raw files in sync but not identical — docs explain, raw files are for copying

### Security Considerations
- This is a public repo — treat every file as world-readable
- Run privacy grep before every commit (hardcoded in Build & Test Commands)
- Never commit .env files, SSH keys, or infrastructure configs
- Review all new content for unintentional information leakage
<!-- PROJECT_SPECIFIC END: PROJECT_SPECIFIC_GUIDELINES -->

## Common Patterns & Examples

<!-- PROJECT_SPECIFIC START: COMMON_PATTERNS -->
### Privacy Check Pattern
Run before every commit to verify no private data has leaked:

```bash
# Check for Tailscale IPs
grep -rn "100\.\(71\|114\|115\|116\)" . --include="*.md" --include="*.mdx"
# Check for machine names
grep -rn "beast\|guardian\|penguin\|jamess-mac-mini\|jimmyb\|jamesb" . --include="*.md" --include="*.mdx" | grep -vi "example\|template\|anonymi"
# Both must return empty
```

### Content Migration Pattern
When copying files from ~/templates/ to this repo:

```bash
# 1. Copy the file
cp ~/templates/projects/core/SOME-FILE.md ./templates/core/SOME-FILE.md

# 2. Replace hardcoded paths
sed -i '' 's|~/templates/|./|g' ./templates/core/SOME-FILE.md
sed -i '' 's|/home/jimmyb/templates/|./|g' ./templates/core/SOME-FILE.md

# 3. Run privacy check
grep -rn "100\.\(71\|114\|115\|116\)\|jimmyb\|jamesb\|beast\|guardian\|penguin" ./templates/core/SOME-FILE.md

# 4. Review the diff manually
```
<!-- PROJECT_SPECIFIC END: COMMON_PATTERNS -->

## Dependencies & Integration

<!-- PROJECT_SPECIFIC START: DEPENDENCIES -->
### External Services
- **GitHub (ydun-code-library org)**: Repository hosting. Public repo, MIT licence.
- **Cloudflare**: DNS and tunnel for docs.ydun.io (infrastructure managed separately in ydun-infra)

### Related Services (part of ydun.io platform)
- **ydun.io (main site)**: SolidStart SSG, same hosting pattern on Beast
- **releases.ydun.io**: App distribution, same hosting pattern on Beast
- **ydun-infra**: Docker Compose, Caddy, cloudflared configs (separate repo, manages all hosting)
<!-- PROJECT_SPECIFIC END: DEPENDENCIES -->

## Environment Variables

<!-- PROJECT_SPECIFIC START: ENVIRONMENT_VARIABLES -->
```bash
# None required for local development
# Astro Starlight runs with zero configuration

# Production (Beast rebuild script only)
# SITE_DIR=/srv/sites/docs.ydun.io/public  # Where built files are copied
```
<!-- PROJECT_SPECIFIC END: ENVIRONMENT_VARIABLES -->

## Troubleshooting

<!-- PROJECT_SPECIFIC START: TROUBLESHOOTING -->
### Common Issues

**Issue**: `bun run build` fails with missing dependency
**Solution**: Run `cd docs && bun install` first. Ensure Bun >= 1.0.

**Issue**: Privacy grep finds matches in template example text
**Solution**: Check context — matches inside code examples explaining the privacy check itself are expected. Only flag matches in actual content.

**Issue**: GitHub CLI uses wrong account (james-crabnebula instead of Jimmyh-world)
**Solution**: `gh auth switch --user Jimmyh-world` — ydun-code-library org requires this account.

**Issue**: Astro dev server port conflict
**Solution**: `cd docs && bun run dev -- --port 4322` (default is 4321)
<!-- PROJECT_SPECIFIC END: TROUBLESHOOTING -->

## Resources & References

### Documentation
- IMPLEMENTATION-PLAN.md — Full project plan with 5 phases
- STATUS.md — Phase tracking and session history
- NEXT-SESSION-START-HERE.md — Quick context for session continuity

### External Resources
- [Astro Starlight Documentation](https://starlight.astro.build/)
- [agents.md Standard](https://agents.md/)
- [Astro Documentation](https://docs.astro.build/)

## Template Version Management

**Current Template Version**: See `<!-- TEMPLATE_VERSION -->` comment at top of this file

**This project uses versioned templates** from `~/templates/`

### Check if Templates are Up to Date

```bash
~/templates/tools/check-version.sh
```

**What it does:**
- Compares your AGENTS.md version with master template version
- Exit code 0 = up to date
- Exit code 1 = out of date

### View Template Changelog

```bash
cat ~/templates/CHANGELOG.md
```

See what's new in each version and migration instructions.

### Sync to Latest Version (Manual for now)

```bash
~/templates/tools/sync-templates.sh --dry-run   # Preview changes
~/templates/tools/sync-templates.sh             # Apply changes (with confirmation)
~/templates/tools/sync-templates.sh --auto      # Auto-apply without confirmation
```

**What gets preserved during sync:**
- All `<!-- PROJECT_SPECIFIC -->` sections (your customizations)
- All placeholder values (PROJECT_NAME, commands, etc.)
- Custom additions to Known Issues, Technical Debt, etc.
- Project-specific guidelines and patterns

**What gets updated during sync:**
- Core Development Principles (if new ones added)
- Template structure improvements
- Standard sections and formatting
- Tool integrations (GitHub CLI, etc.)

**Important Notes:**
- Always review the diff before applying
- Backups are created automatically in `.template-sync-backup/`
- If sync fails, restore from backup
- Commit template updates separately from feature work

### Template Compliance Checking

**AI Assistant Behavior**: When user asks "check templates" or "are we up to date?", automatically:
1. Run: `~/templates/tools/audit-project.sh` OR manually execute checks
2. Generate compliance report
3. Offer remediation based on findings

**User can also run manually:**
```bash
~/templates/tools/audit-project.sh          # Full audit
~/templates/tools/audit-project.sh --quick  # Quick check
```

**Quick Manual Check:**
```bash
# Are we up to date?
~/templates/tools/check-version.sh

# What's new?
cat ~/templates/CHANGELOG.md
```

## Important Reminders for AI Assistants

1. **PUBLIC REPO** - Never include private infrastructure data. Run privacy grep before every commit
2. **Always use Jimmy's Workflow** for implementation tasks
3. **Follow TDD** - Write tests before implementation
4. **Keep it KISS** - Simplicity over complexity
5. **Apply YAGNI** - Only implement what's needed now, not future "might need" features
6. **Use GitHub CLI** - Use `gh` for all GitHub operations (PRs, issues, CI/CD monitoring)
7. **Fix Now** - Never defer fixes for vulnerabilities, warnings, or test failures. No suppressions without documented justification
8. **Document dates** - Include actual dates in all documentation
9. **Validate explicitly** - Run commands, don't assume
10. **Never skip checkpoints** - Each phase must complete before proceeding
11. **Update this file** - Keep AGENTS.md current as project evolves
12. **Measure Twice, Cut Once** - Verify before executing. Double-check paths, commands, and assumptions
13. **No Shortcuts** - Complete the job properly. No half-arsed work or "good enough" hacks
14. **Rules Persist** - ALL principles remain in effect after auto-compact. Re-read AGENTS.md if uncertain

---

**This document follows the [agents.md](https://agents.md/) standard for AI coding assistants.**

**Template Version**: 1.7.0
**Last Updated**: 2026-03-06
