# Claude AI Assistant Instructions

<!--
TEMPLATE_VERSION: 1.7.0
TEMPLATE_SOURCE: ~/templates/projects/core/CLAUDE.md.template
-->

Please refer to **AGENTS.md** for complete development guidelines and project context.

This project follows the [agents.md](https://agents.md/) standard for AI coding assistants.

All AI assistants (Claude, Cursor, GitHub Copilot, Gemini, etc.) should use AGENTS.md as the primary source of project information and development guidelines.

## Quick Reference

### Core Development Principles
1. **KISS** - Keep It Simple, Stupid
2. **TDD** - Test-Driven Development
3. **SOC** - Separation of Concerns
4. **DRY** - Don't Repeat Yourself
5. **Documentation Standards** - Factual, dated, objective
5.5. **AI-Optimized Docs** - Structured, machine-readable
6. **Jimmy's Workflow** - Red/Green Checkpoints (MANDATORY)
7. **YAGNI** - You Ain't Gonna Need It
8. **Fix Now** - Never defer known issues
9. **Measure Twice, Cut Once** - Verify before executing
10. **No Shortcuts** - Complete the job properly
11. **Rules Persist** - All rules apply after context compression

### Jimmy's Workflow v2.1
Use for all implementation tasks:

```
PRE-FLIGHT -> IMPLEMENT -> VALIDATE -> CHECKPOINT
```

- **PRE-FLIGHT**: Verify context (files, requirements, dependencies)
- **IMPLEMENT**: Write code, build features
- **VALIDATE**: Run tests with reasoning + confidence level (HIGH/MEDIUM/LOW)
- **CHECKPOINT**: Mark complete with validity conditions

**Confidence Levels**: HIGH (proceed) | MEDIUM (human spot-check) | LOW (human required)

**Invoke**: *"Let's use Jimmy's Workflow to execute this plan"*

**Reference**: See **JIMMYS-WORKFLOW.md** for complete system (v2.1)

### Documentation Navigation

**Key project files:**
| File | Purpose |
|------|---------|
| `AGENTS.md` | Complete project guidelines, privacy rules, all 11 principles |
| `IMPLEMENTATION-PLAN.md` | Full plan: 5 phases, content map, quality gates, risk register |
| `STATUS.md` | Phase tracking, session history, health indicators |
| `NEXT-SESSION-START-HERE.md` | Quick context and next steps for session continuity |
| `JIMMYS-WORKFLOW.md` | Complete validation system v2.1 |

**Finding Documentation**:
```bash
# Check if DOCS-MAP.md exists
ls DOCS-MAP.md

# If yes: Read it for complete navigation
# If no: Read AGENTS.md for project context
```

### Template Discovery & Compliance Auditing

**When user says** "check templates" OR "check if we're following the rules" OR mentions ~/templates/:

1. **Read AGENTS.md FIRST** (not just README.md)
2. **Execute** `~/templates/tools/audit-project.sh` OR run manual checks
3. **Generate** compliance report (formatted)
4. **Offer** remediation (initialize, sync, fill placeholders, etc.)

**Don't just read and ask - actively execute the audit workflow!**

### Critical Rules
- **PUBLIC REPO** — never include private infrastructure data (IPs, machine names, SSH keys)
- Write tests FIRST (TDD)
- Run explicit validation commands
- Never skip checkpoints
- Document rollback procedures
- Include actual dates in documentation
- Use `gh` CLI for all GitHub operations
- Apply YAGNI — only build what's needed NOW
- Fix vulnerabilities, warnings, test failures IMMEDIATELY
- Proactively run compliance audit when user asks about "templates" or "up to date"
- Run privacy grep before every commit (see below)
- Never proceed without GREEN validation passing
- Never assume — always verify
- Never use marketing language in docs
- Never add "helpful" features not explicitly required
- Never suggest "fix this later" or add suppressions without documented justification

### Privacy Check (MANDATORY before every commit)
```bash
# Tailscale IPs
grep -rn "100\.\(71\|114\|115\|116\)" . --include="*.md" --include="*.mdx" --include="*.ts" --include="*.mjs"
# Machine names and usernames
grep -rn "beast\|guardian\|penguin\|jamess-mac-mini\|jimmyb\|jamesb" . --include="*.md" --include="*.mdx" --include="*.ts" --include="*.mjs" | grep -vi "example\|template\|anonymi"
# BOTH must return EMPTY
```

### GitHub Operations
```bash
# Ensure correct account
gh auth status
# Switch if needed
gh auth switch --user Jimmyh-world

# Pull Requests & CI/CD
gh pr create --title "Title" --body "Description"
gh pr checks                # Monitor CI/CD status
gh pr list                  # View open PRs

# Issues
gh issue create --title "Bug" --body "Description"
gh issue list               # View open issues

# Workflow Monitoring
gh run list                 # List workflow runs
gh run watch                # Watch current run (live)
```

### Common Commands
```bash
# Development
cd docs && bun run dev          # Start dev server
cd docs && bun run build        # Build for production
cd docs && bun run preview      # Preview production build
cd docs && bun run astro check  # Type checking

# Template Compliance
~/templates/tools/audit-project.sh     # Full compliance audit
~/templates/tools/check-version.sh     # Quick version check
```

---

*Last updated: 2026-03-06*
*Template Version: 1.7.0*
