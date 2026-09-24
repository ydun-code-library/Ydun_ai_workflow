# Tools

Shell scripts for template management. Run them from inside your project directory. They find the templates through their own location, so they work from any clone of this repo.

| Script | Version | What it does |
|--------|---------|-------------|
| `check-version.sh` | 1.0.1 | Compares your AGENTS.md `TEMPLATE_VERSION` and JIMMYS-WORKFLOW.md with this repo's `VERSION` and `templates/core/` |
| `audit-project.sh` | 1.5.2 | Compliance audit: AGENTS.md exists, version header, version current, eight principles, placeholders filled, CLAUDE.md, JIMMYS-WORKFLOW.md, optional docs checks |
| `sync-templates.sh` | 1.1.0 | Backs up, then replaces JIMMYS-WORKFLOW.md when its version differs. Never touches CLAUDE.md. AGENTS.md merge stays manual; it lists your protected sections. `--dry-run` writes nothing |

## Usage

```bash
git clone https://github.com/ydun-code-library/Ydun_ai_workflow.git

# From your project directory
path/to/Ydun_ai_workflow/templates/tools/check-version.sh
path/to/Ydun_ai_workflow/templates/tools/audit-project.sh
path/to/Ydun_ai_workflow/templates/tools/sync-templates.sh --dry-run
```

`audit-project.sh` needs bash 4 or newer. On macOS it re-runs itself under Homebrew bash if the system bash is 3.2 (`brew install bash`).

Exit codes: `check-version.sh` 0 up to date, 1 out of date, 2 error. `audit-project.sh` 0 compliant, 1 warnings, 2 critical. `sync-templates.sh` 0 success, 1 cancelled, 2 error.

**Docs:** [docs.ydun.io/getting-started/installation](https://docs.ydun.io/getting-started/installation/)
