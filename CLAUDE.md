# Claude AI Assistant Instructions

<!--
TEMPLATE_VERSION: 2.0.0
TEMPLATE_SOURCE: templates/core/CLAUDE.md.template
RULE: keep this file under 200 lines. It loads every turn. Anything Claude can read from the code or from AGENTS.md on demand does not belong here.
-->

**AGENTS.md** holds the project context, structure, known issues and publishing rules. Read it at the start of a task. Claude Code does not load it automatically when this file exists, so this file says what must be in every turn and points at the rest.

The eight principles are in `AGENTS.md`. Keep them and your global rules in `~/.claude/rules/principles.md` and `~/.claude/CLAUDE.md` so they load every turn; they are not repeated here.

## This project

- **What it is**: the public distribution of the Ydun project templates, prompt frameworks and template tools
- **Stack**: Markdown templates, bash tools. No build, no dependencies, no CI
- **Status**: templates release 2.1.3, published 2026-09-24 (see Current Status and Known Issues in `AGENTS.md`)
- **Profile**: personal

## Commands Claude cannot guess

```bash
grep -rn "$(printf '\342\200\224')" --exclude-dir=.git .            # em dashes (must be none in anything touched)
grep -rniE "block[c]hain|consult[a]ncy" --exclude-dir=.git .   # house wording; bracketed so it does not match itself
grep -rnE "~/[^.]|/home/|/Users/|[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" templates/core   # local paths, IPs
```

`templates/tools/audit-project.sh` refuses to run on this repo (it is the templates directory). Test the tools from a scratch project copied from `templates/core/`.

## Conventions that differ from defaults

- **Everything is public.** No local paths, machine names, hostnames, IPs, usernames, employer names or secrets. House rules apply to every file.
- Template bodies come from the private source templates. Publishing changes only paths and private references (rules in `AGENTS.md`, "Publishing a template release").
- `TEMPLATE_SOURCE` in published templates is repo-relative (`templates/core/<file>`).
- Say decentralised systems, verifiable systems or smart contracts; never the protocol-brand word. Ydun.io is an R&D practice; never the services-firm word.

## Gotchas

- `VERSION` (2.1.4) is read by the tools as the master template version. Bump it with the `TEMPLATE_VERSION` in `templates/core/AGENTS.md.template`, or every project reads out of date.
- The tools in `templates/tools/` resolve the repo from their own location (`templates/core/`, root `VERSION`). Keep that layout.
- `templates/core/AGENTS.md.template` links doc components by raw GitHub URL. Moving `templates/docs/doc-components/` breaks them.
- `templates/init/` still describes the 1.x templates.

## Jimmy's Workflow

🔴 PRE-FLIGHT → 🔴 IMPLEMENT → 🟢 VALIDATE → 🔵 CHECKPOINT, for all work. VALIDATE names the runnable check. HIGH proceed | MEDIUM human spot-check | LOW stop. Full system: `JIMMYS-WORKFLOW.md` (v2.1).

## Where things go

| Need | Put it in |
|------|-----------|
| Rule Claude got wrong twice | here |
| Rule for some files only | `.claude/rules/<topic>.md` with `paths:` |
| Playbook pasted three times | `.claude/skills/<name>/SKILL.md` |
| Worker spawned repeatedly | `.claude/agents/<name>.md` |
| Must happen every time | hook in `.claude/settings.json` |
| Background, structure, status | `AGENTS.md` |

## GitHub

`gh` for everything: `gh pr create`, `gh pr checks`, `gh issue list`.

## Never

- Proceed without GREEN validation. Assume instead of verify. Marketing language in docs. Features nobody asked for. "Fix later" without a written reason.

---

*Last updated: 2026-09-24* · *Template Version: 2.0.0*
