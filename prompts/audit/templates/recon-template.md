---
document_type: audit_recon
name: "[PROJECT_NAME] — Session 0: Reconnaissance"
version: "1.0"
generated: "[YYYY-MM-DD]"
target_model: "[MODEL_ID]"
target_project: "[PROJECT_NAME]"
methodology: MAP/CAP v2.2
workflow: Jimmy's Workflow v2.1

purpose: "Discover tools, verify file paths, update pass MAPs in place"
session: 0
produces: "Updated pass MAPs with verified paths, tools, and dependency versions"

related_files:
  pass_maps:
    - "[01-pass1-NAME.md]"
    # - "[02-pass2-NAME.md]"    # uncomment for multi-pass
    # - "[03-pass3-NAME.md]"    # uncomment for multi-pass
  methodology: "methodology/audit-map-execution-patterns.md"
---

# [PROJECT_NAME] — Session 0: Reconnaissance

**This is infrastructure, not auditing. Read everything. Judge nothing.**

**Generated**: [YYYY-MM-DD] | **Model**: [MODEL_ID]
**Methodology**: MAP/CAP v2.2 | **Execution**: Jimmy's Workflow v2.1

---

## What Recon Does

| Task | How | Output |
|------|-----|--------|
| **Tool discovery** | List available MCP servers, test codebase read, test external knowledge | Tool mapping table filled in across all pass MAPs |
| **File structure** | `find . -name "*.[EXT]" -type f` or equivalent | Actual file paths replace approximate paths in pass MAPs |
| **Dependency versions** | Read lockfiles (`Cargo.lock`, `package-lock.json`, `yarn.lock`, `pnpm-lock.yaml`, etc.) | Exact versions in pass MAPs |
| **Existence verification** | Attempt to read each file referenced in pass MAPs | Non-existent files flagged with NOTE, alternatives identified |
| **Domain coverage** | Test which external knowledge domains are available | Coverage gate pre-filled — passes know their status before starting |

## What Recon Does NOT Do

- Does NOT execute lenses or produce findings
- Does NOT read files deeply (skims structure, does not analyze logic)
- Does NOT produce a checkpoint
- Does NOT make audit judgments
- Does NOT assess severity, confidence, or risk

Recon is infrastructure. It makes the passes efficient. It is not an audit pass.

---

## STEP 1: Read Project Context

Read the project CLAUDE.md (if present) for:
- What the project is
- Execution order
- Core principles
- Where outputs go

```
READ: CLAUDE.md
READ: README.md (if CLAUDE.md is absent)
```

---

## STEP 2: Discover Available Tools

### 2.1 Codebase Access

Test that you can read source files from the target codebase.

```
TEST: Read any source file from the project root
  Result: ✅ / ❌
  Tool name: __________
```

If codebase access fails, STOP. Recon cannot proceed without reading files.

### 2.2 External Knowledge

Test which external knowledge sources are available. List all MCP servers or knowledge tools accessible in this session.

| Domain | Tool/Server | Available | Test Query |
|--------|-------------|-----------|------------|
| [DOMAIN_1] | __________ | ✅ / ❌ | "[test query]" |
| [DOMAIN_2] | __________ | ✅ / ❌ | "[test query]" |
| [DOMAIN_3] | __________ | ✅ / ❌ | "[test query]" |
| [DOMAIN_4] | __________ | ✅ / ❌ | "[test query]" |
| [DOMAIN_5] | __________ | ✅ / ❌ | "[test query]" |

### 2.3 Runtime Access

Test whether you can execute commands against the codebase.

```
TEST: Run a basic command (e.g., list files, check test runner)
  Result: ✅ / ❌
  Available commands: [list relevant ones: cargo test, npm test, grep, etc.]
```

---

## STEP 3: Map File Structure

Read the actual file structure of the target codebase. Use `find`, `tree`, `ls`, or equivalent.

```bash
# Adapt these commands to the project's language/framework:
# Rust:
find [PROJECT_ROOT] -name "*.rs" -type f | sort

# TypeScript/JavaScript:
find [PROJECT_ROOT] -name "*.ts" -o -name "*.tsx" -type f | grep -v node_modules | sort

# Python:
find [PROJECT_ROOT] -name "*.py" -type f | sort

# General:
find [PROJECT_ROOT] -type f -not -path "*/node_modules/*" -not -path "*/.git/*" -not -path "*/target/*" | sort
```

Record the output. This is your source of truth for file paths.

---

## STEP 4: Capture Dependency Versions

Read the project's lockfile(s) for exact dependency versions.

```bash
# Adapt to project:
# Rust:    cat Cargo.lock | grep -A1 "[DEPENDENCY_NAME]"
# Node:    cat package-lock.json | grep "[DEPENDENCY_NAME]"
# Python:  cat requirements.txt or poetry.lock
```

Record exact versions for every dependency referenced in the pass MAPs.

| Dependency | Expected Version (from MAP) | Actual Version (from lockfile) |
|------------|---------------------------|-------------------------------|
| [DEP_1] | [expected] | [actual] |
| [DEP_2] | [expected] | [actual] |
| [DEP_3] | [expected] | [actual] |

---

## STEP 5: Update Pass MAPs In Place

For each pass MAP file listed in the frontmatter:

### 5.1 Open the pass MAP file

### 5.2 For each "What To Read" table in every lens:

- Verify each file path exists in the actual file structure (Step 3 output)
- If the path is WRONG: find the correct path and update in place
- If the file does NOT EXIST: add a `NOTE: File does not exist. Nearest equivalent: [path]` warning — do NOT silently remove it (the absence may be a finding)
- If a new relevant file was discovered that is NOT in the MAP: add it to the appropriate lens table

### 5.3 For each "Codebase Verification" section:

- Verify each verification target file exists
- Update file paths to match actual structure
- Note any files that are missing

### 5.4 For each "Dynamic Tests" section:

- Verify the commands are correct for this project's tooling
- Update paths in grep/test commands
- Note which commands are available and which are not

### 5.5 Fill in tool mapping tables:

- In each pass MAP's pre-flight section, fill in the "Agent Maps To" column with the actual tool/server names discovered in Step 2
- Fill in the pre-flight status based on tool availability

### 5.6 Update dependency versions:

- Replace approximate versions with exact versions from Step 4
- Flag any version mismatches between MAP expectations and actual lockfile

### 5.7 Save all changes to each pass MAP file

---

## STEP 6: Verification Summary

After updating all pass MAPs, produce this summary (do NOT write it as a checkpoint — recon does not produce checkpoints):

```
RECON SUMMARY
=============

Project: [PROJECT_NAME]
Date: [ISO date]
Recon agent: [model identifier]

TOOLS DISCOVERED:
  Codebase: [tool name] — ✅
  External knowledge: [list tools and domains]
  Runtime: [available / not available]

FILES VERIFIED:
  Total paths in pass MAPs: [count]
  Correct as written: [count]
  Corrected by recon: [count]
  Non-existent (NOTE added): [count]
  New files added: [count]

DEPENDENCY VERSIONS:
  [list key dependencies with versions]

PASS MAPs UPDATED:
  [list each file updated]

ISSUES FOR HUMAN REVIEW:
  [list anything unusual — missing expected files, version mismatches, etc.]
```

---

## After Recon

1. Human spot-checks the updated pass MAPs
2. Human verifies paths look correct
3. Human runs each pass in a FRESH session (not this session)

Recon is complete. This session ends here.

---

*Session 0: Reconnaissance | MAP/CAP v2.2 | Jimmy's Workflow v2.1*
*Discover everything. Judge nothing. Make the passes efficient.*
