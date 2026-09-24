# Core Templates

Copy these into your project root and fill the placeholders. Template release 2.1.3 (2026-09-24).

| File | What it does |
|------|-------------|
| `AGENTS.md.template` | Project guide for any AI assistant or human: the eight principles, Jimmy's Workflow, what goes where in Claude Code, project context |
| `CLAUDE.md.template` | Thin per-project file for Claude Code (under 200 lines): commands, conventions, gotchas. Points at AGENTS.md |
| `JIMMYS-WORKFLOW.md` | Full validation system (870+ lines): PRE-FLIGHT, IMPLEMENT, VALIDATE, CHECKPOINT |
| `JIMMYS-WORKFLOW-TEMPLATE.md` | Compact version for embedding in your project |
| `STATUS.md.template` | Project status tracking: phases, metrics, session history |
| `NEXT-SESSION-START-HERE.md.template` | Session continuity: what to do next, key files, quick commands |
| `HOUSEKEEPING.md.template` | Maintenance checklist for "let's do housekeeping": tests, doc accuracy, stale files, security |
| `README.md.template` | Public README skeleton for a project repo |

## Quick start

```bash
cp templates/core/AGENTS.md.template /path/to/your-project/AGENTS.md
cp templates/core/CLAUDE.md.template /path/to/your-project/CLAUDE.md
cp templates/core/JIMMYS-WORKFLOW.md /path/to/your-project/
```

Fill all `[PROJECT_SPECIFIC]` sections. Keep CLAUDE.md short: Claude Code loads it every turn and does not auto-load AGENTS.md when a CLAUDE.md exists.

**Docs:** [docs.ydun.io/templates](https://docs.ydun.io/templates/)
