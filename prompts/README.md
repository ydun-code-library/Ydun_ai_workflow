# Prompts

Reusable prompt frameworks for audits, methodology, and AI-assisted workflows.

## audit/

Multi-lens codebase audit system. Copy a template, fill the placeholders, feed to your AI assistant.

| File | What it does |
|------|-------------|
| `codebase-audit-prompt.md` | 8-lens codebase audit — the main audit framework |
| `claude-code-audit-prompt.md` | Audit tailored for Claude Code output |
| `claude-code-audit-with-logging.md` | Same as above with detailed logging |
| `dev_audit_prompt.txt` | Quick development velocity check |
| `full_audit_prompt.txt` | Deep dive comprehensive audit |
| `json-sidecar-pattern.md` | Add structured JSON output alongside any AI task |

### audit/templates/

Generic audit MAP templates. Copy and customize for any project.

| File | What it does |
|------|-------------|
| `recon-template.md` | Session 0 — discover file paths, verify assumptions |
| `single-pass-template.md` | Standard audit (1-5 lenses) |
| `multi-pass-orchestrator-template.md` | Complex audit (6+ lenses) — orchestrator prompt |
| `pass-template.md` | Individual pass execution prompt |
| `synthesis-template.md` | Final synthesis — combine findings across passes |

## methodology/

Prompt engineering guides and design patterns.

| File | What it does |
|------|-------------|
| `audit-map-execution-patterns.md` | Field-tested patterns from 4 real audits — start here for audits |
| `god-prompt-methodology.md` | MAP/God Prompt design — building large-scale effective prompts |
| `cap-workflow-methodology.md` | Composable Agentic Prompt — develop in modules, deploy as monolith |
| `prompt-testing-implementation-guide.md` | Testing prompts in Python, TypeScript, and Rust |

## Root-level prompts

| File | What it does |
|------|-------------|
| `dev-blockers-audit.md` | Identify development blockers and bottlenecks |
| `full-production-audit.md` | Production readiness assessment |

**Docs:** [docs.ydun.io/prompts](https://docs.ydun.io/prompts/)
