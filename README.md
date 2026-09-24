# Ydun AI Workflow

Templates, principles, and patterns for AI-assisted development. In daily use on our own projects since October 2025.

**Templates release:** 2.1.3 (2026-09-24). Eight principles replaced the eleven of 1.x; CLAUDE.md is now thin and AGENTS.md carries the project context.

**Documentation site:** [docs.ydun.io](https://docs.ydun.io)

## Find what you need

| I want to... | Go here |
|-------------|---------|
| Set up AI templates in my project | [`templates/core/`](templates/core/): copy AGENTS.md and CLAUDE.md into your project |
| Follow a step-by-step setup guide | [`templates/init/init-project.md`](templates/init/init-project.md): 14-step checklist (still describes the 1.x templates; update pending) |
| Run a codebase audit | [`prompts/audit/`](prompts/audit/): multi-lens audit system |
| Learn prompt engineering patterns | [`prompts/methodology/`](prompts/methodology/): CAP, MAP, testing |
| Check if my templates are current | [`templates/tools/check-version.sh`](templates/tools/check-version.sh) |
| Read the full documentation | [docs.ydun.io](https://docs.ydun.io) |
| Download a single file | Right-click any file above, "Save link as", or use the raw GitHub links on [docs.ydun.io](https://docs.ydun.io) |

## What's inside

### Templates

Drop-in project files for AI-assisted development:

| Template | Purpose | Download |
|----------|---------|----------|
| `AGENTS.md` | AI assistant guidelines following the [agents.md](https://agents.md/) standard | [Download](templates/core/AGENTS.md.template) |
| `CLAUDE.md` | Thin per-project file for Claude Code: commands, conventions, gotchas | [Download](templates/core/CLAUDE.md.template) |
| `JIMMYS-WORKFLOW.md` | Four-phase validation system (PRE-FLIGHT, IMPLEMENT, VALIDATE, CHECKPOINT) | [Download](templates/core/JIMMYS-WORKFLOW-TEMPLATE.md) |
| `STATUS.md` | Project progress tracking | [Download](templates/core/STATUS.md.template) |
| `NEXT-SESSION-START-HERE.md` | Session continuity between AI conversations | [Download](templates/core/NEXT-SESSION-START-HERE.md.template) |
| `HOUSEKEEPING.md` | Maintenance checklist: tests, doc accuracy, stale files, security | [Download](templates/core/HOUSEKEEPING.md.template) |
| `README.md` | Public README skeleton for a project repo | [Download](templates/core/README.md.template) |

### Eight Principles

1. Measure twice, cut once
2. Jimmy's Workflow
3. Test-driven, always
4. Don't over-engineer
5. Clean, annotated code
6. YAGNIY: you ain't gonna need it yet
7. Self-healing
8. No shortcuts

The full text is in [`AGENTS.md.template`](templates/core/AGENTS.md.template).

### Prompt Frameworks

- **[Multi-lens audit system](prompts/audit/)**: 5 specialised audit templates (recon, single-pass, multi-pass orchestrator, pass execution, synthesis)
- **[CAP methodology](prompts/methodology/cap-workflow-methodology.md)**: Composable, Auditable, Portable prompt design
- **[JSON sidecar pattern](prompts/audit/json-sidecar-pattern.md)**: machine-readable findings alongside human-readable reports
- **[Prompt testing guide](prompts/methodology/prompt-testing-implementation-guide.md)**: validation patterns in Python, TypeScript, and Rust
- **[Audit execution patterns](prompts/methodology/audit-map-execution-patterns.md)**: patterns from 4 real audits

### Documentation Standards

- **[Documentation Standards](templates/docs/DOCUMENTATION-STANDARDS.md)**: 7 principles for AI-optimised documentation
- **[SEO Best Practices](templates/docs/AI-DRIVEN-SEO-BEST-PRACTICES.md)**: SEO for AI/LLM discovery (January 2026)
- **[Doc components](templates/docs/doc-components/)**: reusable templates for ADRs, navigation headers, metadata blocks

### Guides

Longer guides live on [docs.ydun.io](https://docs.ydun.io). Some pages there, including the [multi-agent setup guide](https://docs.ydun.io/guides/multi-agent-setup/), describe the earlier multi-agent practice and predate the 2.x templates. The current practice is one Claude Code session, sub agents for research and verification, and a reviewer from a different model family on the diffs that matter.

### Research

Field-tested findings on [docs.ydun.io](https://docs.ydun.io/research/):

- **Haiku 4.5 + structured workflow**: 1.8x faster, 67% cheaper, 5% better quality than premium models on well-defined tasks
- **Orchestrator + Specialist pattern**: 50%+ cost reduction with no quality loss using tiered model architecture

## Quick start

### Use the templates

Clone the repo and copy template files into your project:

```bash
git clone https://github.com/ydun-code-library/Ydun_ai_workflow.git
cd Ydun_ai_workflow

# Copy core templates
cp templates/core/AGENTS.md.template /path/to/your-project/AGENTS.md
cp templates/core/CLAUDE.md.template /path/to/your-project/CLAUDE.md
cp templates/core/JIMMYS-WORKFLOW.md /path/to/your-project/

# Fill the [PROJECT_SPECIFIC] sections with your project details
```

Or download individual files directly from [docs.ydun.io](https://docs.ydun.io/templates/). No clone needed.

### Check template compliance

```bash
# From your project directory (needs bash 4 or later; on macOS: brew install bash)
bash path/to/Ydun_ai_workflow/templates/tools/audit-project.sh
```

`check-version.sh` and `sync-templates.sh` currently report 2.1.3 projects as out of date. See Known Issues in [`AGENTS.md`](AGENTS.md).

## Repository structure

```
.
├── templates/
│   ├── core/                # AGENTS, CLAUDE, workflow, session, housekeeping, README templates
│   ├── init/                # Project initialisation guides
│   ├── docs/                # Documentation standards + component templates
│   └── tools/               # Version check, audit, sync scripts
├── prompts/
│   ├── audit/               # Multi-lens audit system
│   │   └── templates/       # Reusable audit MAP templates
│   └── methodology/         # CAP workflow, prompt testing, audit patterns
├── AGENTS.md                # AI assistant guidelines for this repo
├── CLAUDE.md                # Claude Code notes for this repo
├── JIMMYS-WORKFLOW.md       # Validation system v2.1
├── llms.txt                 # AI/LLM discoverability file
└── LICENSE                  # MIT
```

Each directory has its own README with file descriptions.

## About

Built by [Ydun.io](https://ydun.io), an R&D practice working on decentralised architecture, local-first design, and AI workflows.

These patterns come from AI-assisted development in daily use since October 2025. Each release is applied to our own projects before it is published here.

## Licence

MIT
