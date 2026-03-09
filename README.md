# Ydun AI Workflow

Production-tested templates, principles, and patterns for AI-assisted development. Built from real-world experience running multiple AI instances across machines since October 2025.

**Documentation site:** [docs.ydun.io](https://docs.ydun.io)

## What's inside

### Templates

Drop-in project files for AI-assisted development:

| Template | Purpose |
|----------|---------|
| `AGENTS.md` | AI assistant guidelines following the [agents.md](https://agents.md/) standard |
| `CLAUDE.md` | Quick-reference for Claude instances |
| `JIMMYS-WORKFLOW.md` | Four-phase validation system (PRE-FLIGHT, IMPLEMENT, VALIDATE, CHECKPOINT) |
| `STATUS.md` | Project progress tracking |
| `NEXT-SESSION.md` | Session continuity between AI conversations |

### 11 Core Principles

KISS, TDD, Separation of Concerns, DRY, Documentation Standards, AI-Optimised Docs, Jimmy's Workflow, YAGNI, Fix Now, Measure Twice Cut Once, No Shortcuts, Rules Persist.

### Prompt Frameworks

- **Multi-lens audit system** — 5 specialised audit templates (recon, single-pass, multi-pass orchestrator, pass execution, synthesis)
- **CAP methodology** — Composable, Auditable, Portable prompt design
- **JSON sidecar pattern** — Machine-readable findings alongside human-readable reports
- **Prompt testing guide** — Validation patterns in Python, TypeScript, and Rust

### Multi-Agent Guides

How to coordinate multiple AI instances as a development team:

- Team orchestration and personality assignment
- Role cards with responsibilities, personality, and success criteria
- Handoff protocols for file-based coordination between agents
- The evolution from single IDE rules to multi-agent teams (v1-v4)

### Research

Field-tested findings from production use:

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

### Browse the documentation

Visit [docs.ydun.io](https://docs.ydun.io) for the full documentation site with guides, research findings, and methodology deep-dives.

## Repository structure

```
.
├── templates/               # Raw template files (copy into your projects)
│   ├── core/                # AGENTS.md, CLAUDE.md, workflow, session files
│   ├── init/                # Project initialisation guides
│   ├── docs/                # Documentation standards + component templates
│   └── tools/               # Version check, audit, sync scripts
├── prompts/                 # Prompt frameworks
│   ├── audit/               # Multi-lens audit system + templates
│   └── methodology/         # CAP workflow, prompt testing
├── AGENTS.md                # AI assistant guidelines for this repo
├── CLAUDE.md                # Claude quick reference for this repo
├── JIMMYS-WORKFLOW.md       # Validation system v2.1
└── LICENSE                  # MIT
```

## About

Built by [Ydun.io](https://ydun.io) — applied R&D consultancy specialising in decentralised architecture, local-first design, and AI workflows.

These patterns emerged from running a coordinated team of AI instances across 4 machines since October 2025, iterating through 4 major versions. Every template, principle, and pattern in this repository is production-tested.

## Licence

MIT
