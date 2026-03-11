# Ydun AI Workflow

Production-tested templates, principles, and patterns for AI-assisted development. Built from real-world experience running multiple AI instances across machines since October 2025.

**Documentation site:** [docs.ydun.io](https://docs.ydun.io)

## Find what you need

| I want to... | Go here |
|-------------|---------|
| Set up AI templates in my project | [`templates/core/`](templates/core/) — copy AGENTS.md + CLAUDE.md into your project |
| Follow a step-by-step setup guide | [`templates/init/init-project.md`](templates/init/init-project.md) — 14-step checklist |
| Run a codebase audit | [`prompts/audit/`](prompts/audit/) — multi-lens audit system |
| Learn prompt engineering patterns | [`prompts/methodology/`](prompts/methodology/) — CAP, MAP, testing |
| Check if my templates are current | [`templates/tools/check-version.sh`](templates/tools/check-version.sh) |
| Read the full documentation | [docs.ydun.io](https://docs.ydun.io) |
| Download a single file | Right-click any file above, "Save link as", or use the raw GitHub links on [docs.ydun.io](https://docs.ydun.io) |

## What's inside

### Templates

Drop-in project files for AI-assisted development:

| Template | Purpose | Download |
|----------|---------|----------|
| `AGENTS.md` | AI assistant guidelines following the [agents.md](https://agents.md/) standard | [Download](templates/core/AGENTS.md.template) |
| `CLAUDE.md` | Quick-reference for Claude instances | [Download](templates/core/CLAUDE.md.template) |
| `JIMMYS-WORKFLOW.md` | Four-phase validation system (PRE-FLIGHT, IMPLEMENT, VALIDATE, CHECKPOINT) | [Download](templates/core/JIMMYS-WORKFLOW-TEMPLATE.md) |
| `STATUS.md` | Project progress tracking | [Download](templates/core/STATUS.md.template) |
| `NEXT-SESSION.md` | Session continuity between AI conversations | [Download](templates/core/NEXT-SESSION-START-HERE.md.template) |

### 11 Core Principles

KISS, TDD, Separation of Concerns, DRY, Documentation Standards, AI-Optimised Docs, Jimmy's Workflow, YAGNI, Fix Now, Measure Twice Cut Once, No Shortcuts, Rules Persist.

### Prompt Frameworks

- **[Multi-lens audit system](prompts/audit/)** — 5 specialised audit templates (recon, single-pass, multi-pass orchestrator, pass execution, synthesis)
- **[CAP methodology](prompts/methodology/cap-workflow-methodology.md)** — Composable, Auditable, Portable prompt design
- **[JSON sidecar pattern](prompts/audit/json-sidecar-pattern.md)** — Machine-readable findings alongside human-readable reports
- **[Prompt testing guide](prompts/methodology/prompt-testing-implementation-guide.md)** — Validation patterns in Python, TypeScript, and Rust
- **[Audit execution patterns](prompts/methodology/audit-map-execution-patterns.md)** — Field-tested patterns from 4 real audits

### Documentation Standards

- **[Documentation Standards](templates/docs/DOCUMENTATION-STANDARDS.md)** — 7 principles for AI-optimized documentation
- **[SEO Best Practices](templates/docs/AI-DRIVEN-SEO-BEST-PRACTICES.md)** — SEO optimized for AI/LLM discovery
- **[Doc components](templates/docs/doc-components/)** — Reusable templates for ADRs, navigation headers, metadata blocks

### Multi-Agent Guides

These guides live on [docs.ydun.io](https://docs.ydun.io/guides/multi-agent-setup/):

- Team orchestration and personality assignment
- Role cards with responsibilities, personality, and success criteria
- Handoff protocols for file-based coordination between agents
- The evolution from single IDE rules to multi-agent teams (v1-v4)

### Research

Field-tested findings on [docs.ydun.io](https://docs.ydun.io/research/):

- **Haiku 4.5 + structured workflow** — 1.8x faster, 67% cheaper, 5% better quality than premium models on well-defined tasks
- **Orchestrator + Specialist pattern** — 50%+ cost reduction with no quality loss using tiered model architecture

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

Or download individual files directly from [docs.ydun.io](https://docs.ydun.io/templates/) — no clone needed.

### Check template compliance

```bash
# From your project directory
path/to/Ydun_ai_workflow/templates/tools/audit-project.sh
```

## Repository structure

```
.
├── templates/
│   ├── core/                # AGENTS.md, CLAUDE.md, workflow, session files
│   ├── init/                # Project initialisation guides
│   ├── docs/                # Documentation standards + component templates
│   └── tools/               # Version check, audit, sync scripts
├── prompts/
│   ├── audit/               # Multi-lens audit system
│   │   └── templates/       # Reusable audit MAP templates
│   └── methodology/         # CAP workflow, prompt testing, audit patterns
├── AGENTS.md                # AI assistant guidelines for this repo
├── CLAUDE.md                # Claude quick reference for this repo
├── JIMMYS-WORKFLOW.md       # Validation system v2.1
├── llms.txt                 # AI/LLM discoverability file
└── LICENSE                  # MIT
```

Each directory has its own README with file descriptions.

## About

Built by [Ydun.io](https://ydun.io) — applied R&D consultancy specialising in decentralised architecture, local-first design, and AI workflows.

These patterns emerged from running a coordinated team of AI instances across 4 machines since October 2025, iterating through 4 major versions. Every template, principle, and pattern in this repository is production-tested.

## Licence

MIT
