---
document_type: audit_synthesis
name: "[PROJECT_NAME] — Synthesis"
version: "1.0"
generated: "[YYYY-MM-DD]"
target_model: "[MODEL_ID]"
target_project: "[PROJECT_NAME]"
methodology: MAP/CAP v2.2
workflow: Jimmy's Workflow v2.1

checkpoint_files:
  - "checkpoints/pass1-checkpoint.md"
  - "checkpoints/pass2-checkpoint.md"
  # - "checkpoints/pass3-checkpoint.md"  # add as needed

output_files:
  final_report: "checkpoints/final-audit-report.md"
  json_sidecar: "checkpoints/final-audit-report.json"

methodology_ref: "methodology/audit-map-execution-patterns.md"
---

# [PROJECT_NAME] — Synthesis

**This is the final session. All passes are complete. Do NOT re-execute lenses.**

**Generated**: [YYYY-MM-DD] | **Model**: [MODEL_ID]
**Methodology**: MAP/CAP v2.2 | **Execution**: Jimmy's Workflow v2.1

---

## PRE-FLIGHT

### 1. Read All Checkpoint Files

Read every checkpoint file listed in the frontmatter. For each one, verify:

| Checkpoint | Status | Findings Count | Confidence Distribution |
|------------|--------|----------------|------------------------|
| Pass 1: `checkpoints/pass1-checkpoint.md` | COMPLETE / PARTIAL | _____ | H:__ M:__ L:__ |
| Pass 2: `checkpoints/pass2-checkpoint.md` | COMPLETE / PARTIAL | _____ | H:__ M:__ L:__ |

If any checkpoint is PARTIAL, note which lenses are incomplete. Synthesis proceeds but flags the gap.

If any checkpoint file is missing or empty, STOP. That pass must be re-run.

### 2. Collect All Findings

Extract every finding from every checkpoint into a working list. Count totals:

```
Total findings across all passes: _____
  CRITICAL: _____
  HIGH: _____
  MEDIUM: _____
  LOW: _____
Positive observations: _____
```

---

## STEP 1: CROSS-PASS DEDUPLICATION

Read all findings. Identify duplicates:

| Duplicate Type | Action |
|----------------|--------|
| Same file + same line + same issue across passes | Merge — keep the finding with strongest evidence and highest confidence |
| Same root cause, different manifestations | Keep both, link them — they form a root cause group |
| Contradictory findings across passes | Flag for human review — "Pass N says X, Pass M says Y" |

### Deduplication Results

```
Findings before deduplication: _____
Duplicates merged: _____
Contradictions found: _____
Findings after deduplication: _____
```

---

## STEP 2: ROOT CAUSE ANALYSIS

Group findings by systemic root cause. Not every finding has a root cause group — only group when multiple findings share an underlying pattern.

For each root cause:

```markdown
### RC-N: [Root Cause Name]

**Related findings**: [FINDING-IDs from all passes]
**Systemic issue**: [What underlying pattern causes all these findings]
**Single-fix description**: [One change that addresses all related findings]
**Confidence in root cause**: HIGH / MEDIUM / LOW
```

---

## STEP 3: ATTACK CHAIN ANALYSIS

Scan ALL deduplicated findings for combinations that create exploit chains:

| Combination Pattern | What To Look For |
|--------------------|------------------|
| **Auth bypass + privileged action** | "No auth on endpoint" + "endpoint performs destructive/valuable action" |
| **Input validation gap + dangerous sink** | "No validation on field X" + "field X reaches SQL/shell/file path" |
| **Key exposure + encrypted data** | "Key logged/leaked" + "data encrypted with that key" |
| **State inconsistency + critical action** | "Race condition in state" + "state controls [critical operation]" |
| **Missing rate limit + expensive operation** | "No rate limiting" + "operation consumes significant resources" |

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

---

## STEP 4: CONTRADICTION RESOLUTION

For any contradictions found during deduplication:

```markdown
### CONTRADICTION-N: [Description]

**Pass [X] says**: [Finding ID and claim]
**Pass [Y] says**: [Finding ID and claim]
**Resolution**: [Which is correct based on evidence, or "REQUIRES HUMAN REVIEW"]
**Confidence in resolution**: HIGH / MEDIUM / LOW
```

If you can re-read the relevant source file to resolve the contradiction, do so. If not, flag for human review.

---

## STEP 5: PRIORITY MATRIX

Map all deduplicated findings:

```
                    HIGH Confidence    MEDIUM Confidence    LOW Confidence
CRITICAL severity   FIX NOW            FIX (verify first)   INVESTIGATE
HIGH severity       FIX SOON           REVIEW               NOTE
MEDIUM severity     PLAN FIX           NOTE                 BACKLOG
LOW severity        BACKLOG            BACKLOG              IGNORE
```

**Domain-specific overrides**:
- Severity uplift applied: move up one row
- Attack chain member: move up one additional row

---

## STEP 6: REMEDIATION ROADMAP

| Priority | Criteria | Findings |
|----------|----------|----------|
| **Immediate** | CRITICAL + any confidence | [list FINDING-IDs] |
| **Before next release** | HIGH + HIGH confidence | [list FINDING-IDs] |
| **Next sprint** | HIGH + MEDIUM, or CRITICAL + LOW | [list FINDING-IDs] |
| **Tech debt** | MEDIUM findings | [list FINDING-IDs] |
| **Informational** | LOW findings | [list FINDING-IDs] |

---

## STEP 7: WRITE FINAL REPORT

Write `checkpoints/final-audit-report.md`:

```markdown
# [PROJECT_NAME] — Final Audit Report

## Audit Summary
| Metric | Value |
|--------|-------|
| Passes completed | [N] of [N] |
| Lenses executed | [N] of [N] |
| Total findings (after dedup) | [count] |
| Actionable findings | [count] |
| Positive observations | [count] |
| Root causes identified | [count] |
| Attack chains identified | [count] |
| Contradictions | [count resolved] / [count requiring human review] |

## COI Disclosure
[Brief — reference orchestrator for full disclosure]

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

## All Findings
[Full deduplicated findings in Finding Contract format]

## Root Causes
[RC-N entries from Step 2]

## Attack Chains
[CHAIN-N entries from Step 3]

## Contradictions
[CONTRADICTION-N entries from Step 4, or "None"]

## Positive Observations
[Aggregated from all passes]

## Remediation Roadmap
[From Step 6]

## Human Review Status
Status: PENDING HUMAN REVIEW
[Describe any required human sign-off — domain specialist, security team, etc.]

## Validity Conditions
This audit remains valid UNTIL:
- [ ] Major dependency version change
- [ ] Significant architectural refactor
- [ ] New attack surface added (new API endpoints, new user roles)
- [ ] 90 days elapsed since audit date
```

---

## STEP 8: JSON SIDECAR

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
  "positive_observations_count": 0,
  "findings": [],
  "root_causes": [
    {
      "id": "RC-1",
      "name": "...",
      "related_findings": ["...", "..."],
      "systemic_issue": "...",
      "single_fix": "...",
      "confidence": "HIGH | MEDIUM | LOW"
    }
  ],
  "attack_chains": [
    {
      "id": "CHAIN-1",
      "name": "...",
      "severity": "...",
      "findings_combined": ["...", "..."],
      "scenario": "...",
      "remediation": "..."
    }
  ],
  "contradictions": [
    {
      "id": "CONTRADICTION-1",
      "pass_x": "...",
      "pass_y": "...",
      "resolution": "...",
      "confidence": "HIGH | MEDIUM | LOW"
    }
  ],
  "remediation_roadmap": {
    "immediate": [],
    "before_next_release": [],
    "next_sprint": [],
    "tech_debt": [],
    "informational": []
  },
  "human_review_status": "PENDING",
  "validity_conditions": []
}
```

---

## VALIDATE

```markdown
VALIDATE (Synthesis):

## Completeness
| Check | Result |
|-------|--------|
| All checkpoint files read | Pass/Fail |
| All findings extracted | Pass/Fail — [count] findings from [count] passes |
| Deduplication performed | Pass/Fail — [count] duplicates merged |

## Cross-Pass Quality
| Check | Result | Evidence |
|-------|--------|----------|
| Contradictions addressed | Pass/Fail | [count] resolved, [count] flagged for human |
| Root causes identified | Pass/Fail | [count] root causes covering [count] findings |
| Attack chains analyzed | Pass/Fail | [count] chains found (or "none — no combinable findings") |
| Priority matrix populated | Pass/Fail | FIX NOW: [count], FIX SOON: [count] |
| Remediation roadmap complete | Pass/Fail | All findings assigned a priority tier |

## Output Files
| File | Written | Non-Empty |
|------|---------|-----------|
| checkpoints/final-audit-report.md | Pass/Fail | Pass/Fail |
| checkpoints/final-audit-report.json | Pass/Fail | Pass/Fail |
```

---

*Synthesis Session | MAP/CAP v2.2 | Jimmy's Workflow v2.1*
*Read all checkpoints. Deduplicate. Analyze. Synthesize. Report.*
