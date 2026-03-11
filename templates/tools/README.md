# Tools

Shell scripts for template management. Run from inside your project directory.

| Script | What it does |
|--------|-------------|
| `check-version.sh` | Check if your project's templates are up to date |
| `audit-project.sh` | Run a compliance audit — checks AGENTS.md exists, principles present, placeholders filled |
| `sync-templates.sh` | Sync templates to latest version while preserving your customizations |

## Usage

```bash
# From your project directory
~/Ydun_ai_workflow/templates/tools/check-version.sh
~/Ydun_ai_workflow/templates/tools/audit-project.sh
~/Ydun_ai_workflow/templates/tools/sync-templates.sh --dry-run
```

**Docs:** [docs.ydun.io/getting-started/installation](https://docs.ydun.io/getting-started/installation/)
