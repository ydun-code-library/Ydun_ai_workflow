---
document_type: audit_orchestrator
name: "[PROJECT_NAME] — Multi-Pass Audit Orchestrator"
version: "1.0"
generated: "[YYYY-MM-DD]"
target_model: "[MODEL_ID]"
target_project: "[PROJECT_NAME]"
repository: "[REPOSITORY_URL]"
methodology: MAP/CAP v2.2
workflow: Jimmy's Workflow v2.1
audit_type: comprehensive_source_code
audit_context: "[DOMAIN_CONTEXT]"

pass_maps:
  - file: "[01-pass1-NAME.md]"
    name: "Pass 1: [NAME]"
    lenses: ["[LENS_1_ID]", "[LENS_2_ID]", "[LENS_3_ID]"]
    priority: "[CRITICAL | HIGH]"
  - file: "[02-pass2-NAME.md]"
    name: "Pass 2: [NAME]"
    lenses: ["[LENS_4_ID]", "[LENS_5_ID]"]
    priority: "[HIGH | MEDIUM]"
  # - file: "[03-pass3-NAME.md]"
  #   name: "Pass 3: [NAME]"
  #   lenses: ["[LENS_6_ID]", "[LENS_7_ID]", "[LENS_8_ID]"]
  #   priority: "[HIGH | MEDIUM]"

checkpoint_dir: "checkpoints/"

methodology_ref: "methodology/audit-map-execution-patterns.md"
---

# [PROJECT_NAME] — Multi-Pass Audit Orchestrator

**READ THIS FIRST — Before opening any pass MAP.**

**Generated**: [YYYY-MM-DD] | **Model**: [MODEL_ID]
**Methodology**: MAP/CAP v2.2 | **Execution**: Jimmy's Workflow v2.1

---

## Why Multi-Pass?

This audit covers [N] lenses across [describe scope — e.g., "multiple crates/packages, cross-language boundaries, complex domain logic"]. A single-pass audit risks context window exhaustion, which degrades verification quality on later lenses and forces the agent to inherit its own earlier findings from summaries rather than fresh evidence.

**The fix: [N] focused passes, each self-contained, each producing its own checkpoint.**

Reference: `methodology/audit-map-execution-patterns.md` -- "When To Split"

| Lens Count | Recommendation |
|-----------|----------------|
| 1-5 lenses | Single pass |
| 6 lenses | Consider multi-pass |
| 7+ lenses | Multi-pass recommended |
| 8+ lenses | Multi-pass mandatory |

---

## SECTION 0: CONFLICT OF INTEREST DISCLOSURE

### Statement

This audit is performed by an AI system ([MODEL_ID]) reviewing [PROJECT_NAME]. [Describe the COI context — relationship between auditor and codebase, AI-assisted development history, domain-specific COI factors.]

### Why This COI Matters

| Factor | Impact |
|--------|--------|
| **[COI_FACTOR_1]** | [How it affects audit objectivity] |
| **[COI_FACTOR_2]** | [How it affects audit objectivity] |
| **AI auditing code** | Shared training biases may cause blind spots |

### Mitigations

- Structured reasoning (Finding Contract) on every finding
- Dual verification (codebase tool + external knowledge tool)
- Confidence calibration with domain-specific guards
- Multi-pass execution prevents context exhaustion
- Validation that quotes evidence, not checkbox theater
- **[HUMAN_GATE_IF_REQUIRED]** — [describe required human review gate, if any]

### Human Review Gate (if applicable)

> Remove this section if no domain-specific human gate is required.
> Include it for: cryptographic protocols, regulated industries (health, finance, children),
> safety-critical systems, or any domain where AI assessment alone is insufficient.

```
This audit produces FINDINGS, not CONCLUSIONS.

The findings are structured input for [HUMAN_SPECIALIST_TYPE].
They are NOT a replacement for [HUMAN_REVIEW_TYPE].

This audit is NOT ACTIONABLE until a qualified human has:
1. [Review requirement 1]
2. [Review requirement 2]
3. [Review requirement 3]

Without sign-off, audit status remains: PENDING
```

---

## SECTION 1: PASS ARCHITECTURE

### The Passes

```
PASS 1: [PASS_1_NAME] ([PRIORITY])                    Lenses [N-M]
  [LENS_1: NAME]                                       [Brief scope]
  [LENS_2: NAME]                                       [Brief scope]
  [LENS_3: NAME]                                       [Brief scope]
  Key files: [list primary source files for this pass]
  Shared domains: [list knowledge domains needed]
  Output: checkpoints/pass1-checkpoint.md

PASS 2: [PASS_2_NAME] ([PRIORITY])                    Lenses [N-M]
  [LENS_4: NAME]                                       [Brief scope]
  [LENS_5: NAME]                                       [Brief scope]
  Key files: [list primary source files]
  Shared domains: [list knowledge domains]
  Output: checkpoints/pass2-checkpoint.md

# PASS 3: [PASS_3_NAME] ([PRIORITY])                  Lenses [N-M]  (if needed)
#   [LENS_6: NAME]                                     [Brief scope]
#   [LENS_7: NAME]                                     [Brief scope]
#   Key files: [list primary source files]
#   Shared domains: [list knowledge domains]
#   Output: checkpoints/pass3-checkpoint.md

SYNTHESIS (this document)                              Cross-pass analysis
  Read all checkpoint files
  Cross-lens deduplication
  Root cause analysis
  Attack chain analysis
  Final report
  Output: checkpoints/final-audit-report.md
```

### Why This Grouping

| Pass | Rationale |
|------|-----------|
| **Pass 1** | [Why these lenses are grouped — shared files, coupled reasoning, same domain] |
| **Pass 2** | [Why these lenses are grouped] |
| **Pass 3** (if applicable) | [Why these lenses are grouped] |

### Pass Dependencies

```
Pass 1 ([PASS_1_NAME])
  |
  |  No dependencies — executes first, standalone
  |
  v
Pass 2 ([PASS_2_NAME])
  |
  |  [OPTIONAL | REQUIRED] dependency on Pass 1:
  |  [Describe what Pass 2 might need from Pass 1's checkpoint]
  |  Carry forward: Pass 1 checkpoint file (read-only reference)
  |
  v
Pass 3 ([PASS_3_NAME]) — if applicable
  |
  |  [OPTIONAL | REQUIRED] dependency on Pass 1 + Pass 2:
  |  [Describe what Pass 3 might need from prior checkpoints]
  |  Carry forward: Prior checkpoint files (read-only)
  |
  v
Synthesis (This Document)
  |
  |  REQUIRED: All checkpoint files
  |  Cross-lens deduplication, root cause analysis, final report
```

### Session Flow

```
Session 0: 00-recon.md             — Discover tools, verify paths, update pass MAPs
Session 1: 01-pass1-[NAME].md      — Execute Pass 1. Write checkpoint.
Session 2: 02-pass2-[NAME].md      — Execute Pass 2. Read Pass 1 checkpoint (optional). Write checkpoint.
Session 3: 03-pass3-[NAME].md      — Execute Pass 3 (if applicable). Write checkpoint.
Session N: This orchestrator       — Read all checkpoints. Synthesis. Final report.
```

**Do NOT run multiple passes in the same session.** Fresh context per pass is the entire point.
**Between sessions**: verify the checkpoint file was written and is non-empty.

---

## SECTION 2: EXECUTION RULES

### Rule 1: Each Pass Is Self-Contained

Each pass MAP includes its own:
- Pre-flight check (scoped to that pass's files and domains)
- Finding Contract (identical across all passes — consistency for synthesis)
- Only the lenses for that pass
- Validation and checkpoint template
- Output filename for the checkpoint

The agent executing Pass 2 does NOT need to read the Pass 1 MAP — only the Pass 1 checkpoint (optionally, for cross-references).

### Rule 2: Finding Carry-Forward Protocol

When a later pass references findings from an earlier pass:

```
CARRY-FORWARD RULES

1. READ the earlier pass's checkpoint file
2. For any finding you reference, RE-READ the evidence file
   via codebase tool. If you cannot, apply confidence penalty:
   HIGH -> MEDIUM, MEDIUM -> LOW, LOW -> stays LOW
3. Do NOT copy finding text from the checkpoint as your own
   evidence — re-verify independently.
4. If you discover the earlier finding was WRONG, note it:
   "Contradicts [FINDING-ID] from Pass N — re-assessment needed"
5. Cross-references use format: "See Pass 1: [FINDING-ID]"

Tag inherited findings:
"Inherited from Pass N — not re-verified in this session"
```

### Rule 3: Depth Budget by Lens Priority

| Lens Priority | Depth Expectation |
|--------------|-------------------|
| **CRITICAL** | Exhaust all available verification paths before settling on MEDIUM confidence. If you can read the lockfile, read it. If you can fetch dependency source, fetch it. MEDIUM confidence on a CRITICAL lens means "I tried everything available and still couldn't confirm." |
| **HIGH** | Standard verification. Query external knowledge. If inconclusive, MEDIUM is acceptable with documented reasoning. |
| **MEDIUM** | Proportional effort. If external knowledge is unavailable, note it and proceed. LOW confidence acceptable for pattern-matching findings. |

### Rule 4: Dynamic Testing Hooks

If the executing agent has runtime access:

| Test | When To Run | What It Upgrades |
|------|-------------|-----------------|
| [TEST_COMMAND_1] | [Which pass/lens] | [Which findings get upgraded] |
| [TEST_COMMAND_2] | [Which pass/lens] | [Which findings get upgraded] |
| [GREP_COMMAND] | [Which pass/lens] | [Which findings get upgraded] |
| [LINT_COMMAND] | Pre-flight of every pass | Catches lint-level issues |

**If available, RUN THEM.** If unavailable, note it — the MAP still works as static analysis.

### Rule 5: Checkpoint File Format

Every pass produces a checkpoint file. See pass-template.md for the full checkpoint format.

### Rule 6: Context Compaction Handling

Each pass includes its own compaction recovery instructions. See pass-template.md.

**Prevention**:
- Recon session handles all path discovery (reduces pass context usage)
- Multi-pass keeps each session focused (2-3 lenses, not 6+)
- Write findings to checkpoint incrementally (after each lens, not at the end)
- If a pass has a CRITICAL lens, consider giving it its own session

### Rule 7: Session Management (For the Human)

```
SESSION 0: Run 00-recon.md
           Agent discovers tools, verifies paths, updates pass MAPs in place.
           Session ends.

SESSION 1: Run [01-pass1-NAME.md] in fresh session
           Agent executes Pass 1 -> writes checkpoints/pass1-checkpoint.md
           Session ends.

SESSION 2: Run [02-pass2-NAME.md] in fresh session
           Agent reads checkpoints/pass1-checkpoint.md (optional reference)
           Agent executes Pass 2 -> writes checkpoints/pass2-checkpoint.md
           Session ends.

SESSION N: Run [NN-passN-NAME.md] or this orchestrator for synthesis
           Agent reads all checkpoint files
           Agent produces checkpoints/final-audit-report.md
           Session ends.
```

**Between sessions**: Open the checkpoint file. Check the status line. Confirm findings are complete.

---

## SECTION 3: SYNTHESIS PROTOCOL

> **Execute this section AFTER all passes are complete.**
> **Read all checkpoint files. Do NOT re-execute the lenses.**

### 3.1 Cross-Pass Deduplication

Read all findings from all passes. Identify duplicates:

| Duplicate Type | Action |
|----------------|--------|
| Same file + same line + same issue across passes | Merge — keep the finding with strongest evidence and highest confidence |
| Same root cause, different manifestations | Keep both, link them — they become the root cause group |
| Contradictory findings across passes | Flag for human review — "Pass N says X, Pass M says Y" |

### 3.2 Root Cause Analysis

Group findings by systemic root cause. For each root cause:

```markdown
### RC-N: [Root Cause Name]

**Related findings**: [FINDING-IDs from all passes]
**Systemic issue**: [What underlying pattern causes all these findings]
**Single-fix description**: [One change that addresses all related findings]
**Confidence in root cause**: HIGH / MEDIUM / LOW
```

### 3.3 Attack Chain Analysis

After reading all findings, scan for combinations that create exploit chains:

| Combination Pattern | What To Look For |
|--------------------|------------------|
| **Auth bypass + privileged action** | "No auth on endpoint" + "endpoint performs destructive/valuable action" |
| **Input validation gap + dangerous sink** | "No validation on field X" + "field X reaches SQL/shell/file path" |
| **Key exposure + encrypted data** | "Key logged/leaked" + "data encrypted with that key" |
| **State inconsistency + critical action** | "Race condition in state" + "state controls [critical operation]" |

For each chain found:

```markdown
### CHAIN-N: [Attack Name]

**Severity**: [highest severity of combined findings, potentially +1 if chain is worse]
**Findings combined**: [FINDING-ID-1] + [FINDING-ID-2] + ...

**Attack scenario**:
1. Attacker does [action exploiting finding 1]
2. This gives attacker [capability]
3. Attacker uses [capability] to exploit [finding 2]
4. Result: [concrete impact]

**Why the chain is worse than individual findings**:
[Explanation]

**Remediation**: Fixing [FINDING-ID] breaks the chain at step [N].
```

### 3.4 Cross-Pass Contradiction Resolution

For any contradictions found during deduplication:

```markdown
### CONTRADICTION-N: [Description]

**Pass [X] says**: [Finding ID and claim]
**Pass [Y] says**: [Finding ID and claim]
**Resolution**: [Which is correct based on evidence, or "REQUIRES HUMAN REVIEW"]
**Confidence in resolution**: HIGH / MEDIUM / LOW
```

### 3.5 Priority Matrix

```
                    HIGH Confidence    MEDIUM Confidence    LOW Confidence
CRITICAL severity   FIX NOW            FIX (verify first)   INVESTIGATE
HIGH severity       FIX SOON           REVIEW               NOTE
MEDIUM severity     PLAN FIX           NOTE                 BACKLOG
LOW severity        BACKLOG            BACKLOG              IGNORE
```

**Domain-specific overrides** (adapt to your domain):
- `[DOMAIN_UPLIFT_FIELD]: true` -- move up one row
- `[REGRESSION_FIELD]: [finding]` -- move up one additional row

### 3.6 Remediation Roadmap

| Priority | Criteria | Action |
|----------|----------|--------|
| **Immediate** | CRITICAL + any confidence | Block deployment |
| **Before next release** | HIGH + HIGH confidence | Fix before release |
| **Next sprint** | HIGH + MEDIUM confidence, or CRITICAL + LOW confidence | Schedule promptly |
| **Tech debt** | MEDIUM findings | Backlog |
| **Informational** | LOW findings | Document only |

### 3.7 Final Report

Write `checkpoints/final-audit-report.md`:

```markdown
# [PROJECT_NAME] — Final Audit Report

## Audit Summary
| Metric | Value |
|--------|-------|
| Passes completed | [N] of [N] |
| Lenses executed | [N] of [N] |
| Total findings | [count] |
| Actionable findings | [count] |
| Positive observations | [count] |
| Root causes identified | [count] |
| Attack chains identified | [count] |

## Pass Status
| Pass | Status | Confidence | Findings |
|------|--------|------------|----------|
| 1: [NAME] | COMPLETE/PARTIAL | H/M/L | [count] |
| 2: [NAME] | COMPLETE/PARTIAL | H/M/L | [count] |

## Severity Summary
| Severity | Count |
|----------|-------|
| CRITICAL | |
| HIGH | |
| MEDIUM | |
| LOW | |

## Top Findings
1. [ID] — [decision] — [severity] — [confidence]
2. [ID] — [decision] — [severity] — [confidence]
3. [ID] — [decision] — [severity] — [confidence]

## Root Causes
1. RC-1: [name] — affects [N] findings — single fix: [description]

## Attack Chains
1. CHAIN-1: [name] — [severity] — combines [FINDING-IDs]

## Contradictions Resolved
[List or "None"]

## Remediation Roadmap
[Immediate / Before next release / Next sprint / Tech debt / Informational]

## Human Review Status
Status: [PENDING HUMAN REVIEW | COMPLETE]
[Describe any required human sign-off]

## Validity Conditions
This audit remains valid UNTIL:
- [ ] [Condition that invalidates the audit — e.g., major dependency update]
- [ ] [Another invalidation condition]
- [ ] [Time-based expiry — e.g., 90 days elapsed]
```

### 3.8 JSON Sidecar for Final Report

Write `checkpoints/final-audit-report.json`:

```json
{
  "project": "[PROJECT_NAME]",
  "date": "[ISO timestamp]",
  "agent": "[MODEL_ID]",
  "methodology": "MAP/CAP v2.2",
  "passes_completed": 0,
  "passes_total": 0,
  "lenses_executed": [],
  "total_findings": 0,
  "actionable_findings": 0,
  "positive_observations": 0,
  "findings": [],
  "root_causes": [],
  "attack_chains": [],
  "contradictions": [],
  "remediation_roadmap": {
    "immediate": [],
    "before_next_release": [],
    "next_sprint": [],
    "tech_debt": [],
    "informational": []
  },
  "human_review_status": "PENDING | COMPLETE",
  "validity_conditions": []
}
```

---

## SECTION 4: HUMAN GATES

| Gate | When | Who |
|------|------|-----|
| **Post-recon spot-check** | After Session 0 | Human verifies updated pass MAPs look correct |
| **Between-pass checkpoint review** | After each pass session | Human opens checkpoint, verifies findings are written |
| **Synthesis review** | After final report | Human reviews top findings, attack chains, contradictions |
| **[DOMAIN_SPECIALIST_GATE]** | Before marking COMPLETE | [Specialist type] reviews [specific aspects] |

---

## SECTION 5: EXECUTION CHECKLIST

```
CHECKPOINT DIR: checkpoints/

[ ] 1. Read this orchestrator document
[ ] 2. SESSION 0: Run 00-recon.md — tools discovered, paths verified
[ ] 3. VERIFY: Pass MAPs updated with correct paths
[ ] 4. SESSION 1: Run [01-pass1-NAME.md] in fresh session
[ ] 5. Agent writes: checkpoints/pass1-checkpoint.md (incremental)
[ ] 6. VERIFY: Open checkpoint, confirm all lenses marked complete
[ ] 7. SESSION 2: Run [02-pass2-NAME.md] in fresh session
[ ] 8. Agent writes: checkpoints/pass2-checkpoint.md
[ ] 9. VERIFY: Open checkpoint, confirm all lenses marked complete
     # Add steps for additional passes as needed
[ ] N. SESSION N: Run this orchestrator — "Execute Section 3: Synthesis"
[ ] N+1. Agent reads all checkpoints, executes synthesis
[ ] N+2. Agent writes: checkpoints/final-audit-report.md + .json sidecar
[ ] N+3. Human reviews final report
[ ] N+4. Mark status: [PENDING HUMAN REVIEW | COMPLETE]
```

---

*Multi-Pass Orchestrator Template | MAP/CAP v2.2 | Jimmy's Workflow v2.1*
*Split when context would exhaust. Checkpoint between passes. Synthesize at the end.*
