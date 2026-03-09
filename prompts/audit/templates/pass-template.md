---
document_type: audit_map_pass
name: "[PROJECT_NAME] — Pass [N]: [PASS_NAME]"
version: "1.0"
generated: "[YYYY-MM-DD]"
target_model: "[MODEL_ID]"
target_project: "[PROJECT_NAME]"
pass: "[N]"
pass_name: "[PASS_NAME]"
lenses: ["[LENS_1_ID]", "[LENS_2_ID]", "[LENS_3_ID]"]
priority: "[CRITICAL | HIGH | MEDIUM]"
methodology: MAP/CAP v2.2
workflow: Jimmy's Workflow v2.1
orchestrator: "[PROJECT_NAME]-orchestrator.md"

output_files:
  checkpoint: "checkpoints/pass[N]-checkpoint.md"
  json_sidecar: "checkpoints/pass[N]-checkpoint.json"

methodology_ref: "methodology/audit-map-execution-patterns.md"
---

# [PROJECT_NAME] — Pass [N]: [PASS_NAME]

**Lenses**: [LENS_1: NAME], [LENS_2: NAME], [LENS_3: NAME]

**Pass**: [N] of [TOTAL] | **Priority**: [CRITICAL | HIGH | MEDIUM]
**Orchestrator**: Read `[PROJECT_NAME]-orchestrator.md` first for multi-pass context.

---

## COI DISCLOSURE (Abbreviated)

Full disclosure in orchestrator. Key points for this pass:

- [COI point relevant to this pass's domain]
- [COI point relevant to this pass's lenses]
- **Depth budget: [PRIORITY]** — [depth expectation for this priority level]
- [Any human gate relevant to this pass]

---

## PRE-FLIGHT CHECK

> **This pass covers [PASS_SCOPE_DESCRIPTION]. If codebase access fails, this pass is BLOCKED.**
> **If recon (Session 0) ran first, tool mapping and paths should already be filled in.**

### Tool & MCP Discovery

Discover tools that cover THESE specific domains for Pass [N]:

| Domain | Why Critical For This Pass | Agent Maps To |
|--------|---------------------------|---------------|
| **[DOMAIN_1]** | [Why this pass needs it] | __________ |
| **[DOMAIN_2]** | [Why this pass needs it] | __________ |
| **[DOMAIN_3]** | [Why this pass needs it] | __________ |

**Coverage gate:**

```
Core domains for this pass covered?
  NO  -> BLOCKED — Cannot verify [critical aspect]. STOP.
  YES -> Check remaining domains
         5+ of N -> CLEAR
         3-4 of N -> DEGRADED — note gaps, cap affected confidence at MEDIUM
         Core only -> DEGRADED (proceed cautiously)
```

### Codebase Verification (Pass [N] Scope)

Read these files to verify codebase access works for this pass:

```
VERIFICATION 1: Read [src/path/to/file.ext]
  Expected: [what you expect to find — module purpose, key functions]
  Result: ✅ / ❌

VERIFICATION 2: Read [src/path/to/another-file.ext]
  Expected: [what you expect to find]
  Result: ✅ / ❌

VERIFICATION 3: Read [src/path/to/third-file.ext]
  Expected: [what you expect to find]
  Result: ✅ / ❌
```

### Dynamic Tests (If Runtime Available)

If you have access to run commands:

```bash
# Adapt to project and this pass's scope:
[TEST_COMMAND — scoped to this pass's crates/packages]

# Check for issues specific to this pass's domain
[GREP_COMMAND — e.g., grep for patterns this pass cares about]

# Verify dependency versions relevant to this pass
[VERSION_COMMAND — e.g., grep specific deps from lockfile]
```

**If these run, record results. They upgrade confidence on specific findings.**
**If unavailable, note it and proceed with static analysis.**

### Pre-Flight Status

```
PRE-FLIGHT STATUS: ____________

Codebase access: __________ (tool name)
Pass-specific domains: __________ (tools covering this pass's required domains)
Dynamic tests: RAN / NOT AVAILABLE
Exact dependency versions: [from lockfile or "not available"]

CLEAR    — Codebase + required domains verified.
DEGRADED — Some domains uncovered. Note gaps.
BLOCKED  — Codebase failed OR critical domains uncovered. STOP.
```

---

## FINDING CONTRACT

> **Identical across all passes — ensures consistency for synthesis.**

### Required Fields

```json
{
  "id": "string — [PREFIX]-NNN (unique within this pass)",
  "lens": "string — which lens produced this finding",
  "decision": "string — clear statement of what is wrong",
  "severity": "CRITICAL | HIGH | MEDIUM | LOW",
  "confidence": "HIGH | MEDIUM | LOW",
  "reasoning": ["string (minimum 2 points)"],
  "alternatives_rejected": [{"alternative": "string", "rejection_reason": "string"}],
  "weaknesses_acknowledged": ["string (minimum 1)"],
  "evidence": {
    "file": "string — FROM CODEBASE TOOL, not from memory",
    "line": "number — exact, FROM CODEBASE TOOL",
    "snippet": "string — max 10 lines, COPIED FROM CODEBASE TOOL"
  },
  "remediation_hint": "string — direction for fix, not implementation",
  "verified_by": {
    "codebase_tool": "string — tool name used",
    "external_tool": "string or 'none available'",
    "dynamic_test": "string or 'not available'"
  }
}
```

### Severity Uplift Table (Domain-Specific)

> **Replace with domain-appropriate uplifts for this project.**

| Finding Category | Standard Severity | Uplifted Severity |
|-----------------|-------------------|-------------------|
| [UPLIFT_CATEGORY_1] | [STANDARD] | **[UPLIFTED]** |
| [UPLIFT_CATEGORY_2] | [STANDARD] | **[UPLIFTED]** |
| [UPLIFT_CATEGORY_3] | [STANDARD] | **[UPLIFTED]** |

### Confidence Rules

- **HIGH** requires: code evidence from codebase tool + API/behavior verification from external knowledge
- **MEDIUM**: code seen, API not fully verified or inconclusive
- **LOW**: pattern suspected, cannot confirm
- **[PRIORITY] lens depth budget**: [Depth expectation — e.g., "exhaust all verification paths before settling on MEDIUM" for CRITICAL]
- Domain knowledge gaps cap confidence at MEDIUM

---

## LENSES

> **Execute each lens in order. Write findings to checkpoint file AFTER EACH LENS (incremental checkpoint pattern).**

---

### [LENS_1: NAME]

**ID Prefix**: [PREFIX]-
**Priority**: [CRITICAL | HIGH | MEDIUM]
**Depth Budget**: [EXHAUSTIVE | STANDARD | PROPORTIONAL]

#### What To Read

| File | Focus |
|------|-------|
| `[src/path/to/file.ext]` | [What to examine in this file — specific functions, patterns, data flows] |
| `[src/path/to/another.ext]` | [What to examine] |
| `[src/path/to/third.ext]` | [What to examine] |

#### What To Verify

| Question | Domain |
|----------|--------|
| "[Specific technical question to verify via external knowledge]" | [DOMAIN] |
| "[Another verification question]" | [DOMAIN] |

#### Detection Criteria

**[SEVERITY] (uplifted if applicable):**
- [Specific condition that constitutes this severity level]
- [Another condition]

**[LOWER_SEVERITY]:**
- [Specific condition]
- [Another condition]

**[EVEN_LOWER_SEVERITY]:**
- [Specific condition]

#### Positive Observations To Check

- [ ] [Something the project claims to do correctly — verify with evidence]
- [ ] [Another positive claim to verify]

---

### [LENS_2: NAME]

**ID Prefix**: [PREFIX]-
**Priority**: [CRITICAL | HIGH | MEDIUM]
**Depth Budget**: [EXHAUSTIVE | STANDARD | PROPORTIONAL]

#### What To Read

| File | Focus |
|------|-------|
| `[src/path/to/file.ext]` | [What to examine] |
| `[src/path/to/another.ext]` | [What to examine] |

#### What To Verify

| Question | Domain |
|----------|--------|
| "[Verification question]" | [DOMAIN] |

#### Detection Criteria

**[SEVERITY]:**
- [Condition]

#### Positive Observations To Check

- [ ] [Positive claim to verify]

---

### [LENS_3: NAME]

**ID Prefix**: [PREFIX]-
**Priority**: [CRITICAL | HIGH | MEDIUM]
**Depth Budget**: [EXHAUSTIVE | STANDARD | PROPORTIONAL]

#### What To Read

| File | Focus |
|------|-------|
| `[src/path/to/file.ext]` | [What to examine] |

#### What To Verify

| Question | Domain |
|----------|--------|
| "[Verification question]" | [DOMAIN] |

#### Detection Criteria

**[SEVERITY]:**
- [Condition]

#### Positive Observations To Check

- [ ] [Positive claim to verify]

---

> **Add additional lens sections here if this pass covers more than 3 lenses.**
> **Maximum 4 lenses per pass. If more are needed, split into additional passes.**

---

## EXECUTION PROTOCOL

### PRE-FLIGHT
Complete pre-flight above. Verify codebase access and domain coverage.

### IMPLEMENT
Execute each lens in order. For each finding:

1. **READ** the file via codebase tool
2. **QUERY** external knowledge for API/behavior verification
3. **RUN** dynamic tests if available
4. **ASSESS** against detection criteria
5. **RECORD** using Finding Contract — all fields, no exceptions
6. **CHECK** positive observations — file genuine confirmations with evidence
7. **WRITE** finding to checkpoint file immediately (incremental checkpoint)
8. **DEPTH BUDGET**: Respect the priority level. CRITICAL = exhaust all paths.

### VALIDATE

> **Validation must QUOTE EVIDENCE — not checkbox theater.**

```markdown
VALIDATE (Pass [N]):

## Tool Summary
| Tool | Domains | Dynamic Tests Run |
|------|---------|-------------------|
| [codebase tool] | All source files | [list or "none"] |
| [external tools] | [domains] | n/a |

## Finding Quality (spot-check required)
| Check | Result | Evidence |
|-------|--------|----------|
| All findings have >=2 reasoning points | ✅/❌ | Spot-checked: [FINDING_ID] has N points. Lowest: N. |
| All findings have >=1 alternative rejected | ✅/❌ | Spot-checked: [FINDING_ID] rejected "[alt]". |
| All findings have >=1 weakness acknowledged | ✅/❌ | Spot-checked: [FINDING_ID] acknowledges "[weakness]". |
| All evidence from codebase tool (not memory) | ✅/❌ | Spot-checked: [FINDING_ID] cites [file:line]. |
| Severity uplift applied where required | ✅/❌ | Spot-checked: [FINDING_ID] uplifted [X]->[Y]. |
| Depth budget met for lens priority | ✅/❌ | [CRITICAL lenses: no MEDIUM where deeper was available] |
| Positive observations filed with evidence | ✅/❌ | [count] positive observations recorded. |

## Confidence Distribution
| Level | Count | % |
|-------|-------|---|
| HIGH | | |
| MEDIUM | | |
| LOW | | |

## Hard Gates
| Gate | Status |
|------|--------|
| Confidence monoculture (all same level) | ✅ / ❌ RECALIBRATE |
| HIGH confidence > 50% | ✅ / ❌ RE-EXAMINE |
| Zero positive observations | ✅ / ❌ SUSPICIOUS |
| Dynamic tests available but not run | ✅ / ❌ QUALITY GAP |

## What This Pass Covers
- [Lens 1 scope summary]
- [Lens 2 scope summary]
- [Lens 3 scope summary]

## What This Pass Does NOT Cover (handled by other passes)
- [Scope handled by Pass X]
- [Scope handled by Pass Y]
```

### CHECKPOINT

Write `checkpoints/pass[N]-checkpoint.md`:

```markdown
# [PROJECT_NAME] — Pass [N] Checkpoint

## Pass Info
Pass: [N] of [TOTAL]
Name: [PASS_NAME]
Lenses executed: [list]
Date: [ISO timestamp]
Agent: [model identifier]

## Pre-Flight Status
Status: CLEAR / DEGRADED / BLOCKED
Codebase tool: [name]
External knowledge: [tools, domains covered]
Dynamic tests run: [list or "none available"]

## Findings
[Full findings in Finding Contract format — one per finding]

## Positive Observations
[Things verified as correctly implemented — with evidence]

## Confidence Distribution
| Level | Count | Percentage |
|-------|-------|------------|
| HIGH | | |
| MEDIUM | | |
| LOW | | |

## Pass Validation
[Completed validation from VALIDATE section above]

## Checkpoint Status
Status: COMPLETE / PARTIAL
Confidence: HIGH / MEDIUM / LOW
Findings: [count total, count actionable, count positive]
```

---

## JSON SIDECAR OUTPUT

Write `checkpoints/pass[N]-checkpoint.json`:

```json
{
  "project": "[PROJECT_NAME]",
  "pass": "[N]",
  "pass_name": "[PASS_NAME]",
  "date": "[ISO timestamp]",
  "agent": "[MODEL_ID]",
  "methodology": "MAP/CAP v2.2",
  "pre_flight_status": "CLEAR | DEGRADED",
  "lenses_executed": ["[LENS_1_ID]", "[LENS_2_ID]", "[LENS_3_ID]"],
  "findings": [
    {
      "id": "[PREFIX]-001",
      "lens": "[LENS_ID]",
      "decision": "...",
      "severity": "CRITICAL | HIGH | MEDIUM | LOW",
      "confidence": "HIGH | MEDIUM | LOW",
      "reasoning": ["...", "..."],
      "alternatives_rejected": [{"alternative": "...", "rejection_reason": "..."}],
      "weaknesses_acknowledged": ["..."],
      "evidence": {"file": "...", "line": 0, "snippet": "..."},
      "remediation_hint": "...",
      "verified_by": {"codebase_tool": "...", "external_tool": "...", "dynamic_test": "..."}
    }
  ],
  "positive_observations": [
    {"lens": "...", "observation": "...", "evidence_file": "...", "evidence_line": 0}
  ],
  "confidence_distribution": {"HIGH": 0, "MEDIUM": 0, "LOW": 0},
  "checkpoint_status": "COMPLETE | PARTIAL"
}
```

---

## COMPACTION RECOVERY

If context compaction occurs mid-pass:

```
COMPACTION RECOVERY PROTOCOL

1. STOP immediately. Do not continue auditing from memory.

2. Re-read THIS pass MAP file to restore instructions.

3. Re-read the project CLAUDE.md (if present) to restore context.

4. Read the checkpoint file (checkpoints/pass[N]-checkpoint.md) to see
   what findings have already been written.

5. Resume from the last completed lens. Do NOT re-audit lenses that have
   complete findings in the checkpoint.

6. Flag the compaction in the checkpoint:
   "Context compaction occurred during this pass. Findings before
   [FINDING-ID] were written pre-compaction. Findings after were written
   post-compaction with recovered context."

KEY: Write findings to disk AFTER EACH LENS. The disk file survives
compaction. Your context does not.
```

### Incremental Checkpoint Pattern

Instead of writing all findings at the end, write after each lens:

```
Lens 1 complete -> append findings to checkpoint file
Lens 2 complete -> append findings to checkpoint file
Lens 3 complete -> append findings to checkpoint file
VALIDATE -> read full checkpoint, verify quality
```

Update the status line at the top of the checkpoint as each lens completes:

```markdown
## Status: LENS 1 ✅ | LENS 2 ❌ | LENS 3 ❌
```

If compaction occurs between lenses, completed lens findings are safe on disk. The agent recovers by reading the checkpoint and resuming at the next unfinished lens.

---

**This pass's checkpoint is input to subsequent passes (optional) and Synthesis (required).**

---

*Pass [N] of [TOTAL] | [PASS_NAME] | MAP/CAP v2.2 | Jimmy's Workflow v2.1*
*[PRIORITY] depth budget: [depth expectation summary].*
