---
document_type: audit_map_single_pass
name: "[PROJECT_NAME] — Single-Pass Audit"
version: "1.0"
generated: "[YYYY-MM-DD]"
target_model: "[MODEL_ID]"
target_project: "[PROJECT_NAME]"
repository: "[REPOSITORY_URL]"
methodology: MAP/CAP v2.2
workflow: Jimmy's Workflow v2.1
audit_type: comprehensive_source_code
audit_context: "[DOMAIN_CONTEXT — e.g., web_application, mobile_app, api_service]"

lenses:
  - "[LENS_1_ID]"
  - "[LENS_2_ID]"
  - "[LENS_3_ID]"
  # Add up to 5 lenses for single-pass. 6+ lenses should use multi-pass.

deployment_context: "[public_internet | private_network | preprod | air_gapped | multi_tenant]"

output_files:
  checkpoint: "checkpoints/audit-checkpoint.md"
  json_sidecar: "checkpoints/audit-checkpoint.json"

methodology_ref: "methodology/audit-map-execution-patterns.md"
---

# [PROJECT_NAME] — Single-Pass Audit

**Lenses**: [LENS_1: NAME], [LENS_2: NAME], [LENS_3: NAME]
**Generated**: [YYYY-MM-DD] | **Model**: [MODEL_ID]
**Methodology**: MAP/CAP v2.2 | **Execution**: Jimmy's Workflow v2.1

---

## SECTION 0: CONFLICT OF INTEREST DISCLOSURE

### Statement

This audit is performed by an AI system ([MODEL_ID]) reviewing source code for [PROJECT_NAME]. [Describe the COI context — e.g., "The codebase was developed with AI coding assistance" or "The auditor has no prior relationship with this codebase."]

### Why This COI Matters

| Factor | Impact |
|--------|--------|
| **[COI_FACTOR_1]** | [How it affects audit objectivity] |
| **[COI_FACTOR_2]** | [How it affects audit objectivity] |
| **AI auditing code** | Shared training biases may cause blind spots in pattern recognition |

### Mitigations

- Structured reasoning (Finding Contract) on every finding
- Dual verification (codebase tool + external knowledge tool) where available
- Confidence calibration with domain-specific guards
- Validation that quotes evidence, not checkbox theater
- **[HUMAN_GATE_IF_REQUIRED]** — [e.g., "HUMAN REVIEW REQUIRED" for regulated domains]

---

## SECTION 1: PRE-FLIGHT CHECK

> **This section must be completed BEFORE any lens executes.**
> **If recon (Session 0) ran first, most of this should already be filled in.**

### 1.1 Tool & MCP Discovery

Discover what tools are available for this audit. Do NOT hardcode tool names — discover them.

**Required capabilities:**

| Domain | Why Needed | Agent Maps To |
|--------|-----------|---------------|
| **Codebase access** | Read source files, verify evidence | __________ |
| **[KNOWLEDGE_DOMAIN_1]** | [Why this lens needs it] | __________ |
| **[KNOWLEDGE_DOMAIN_2]** | [Why this lens needs it] | __________ |
| **[KNOWLEDGE_DOMAIN_3]** | [Why this lens needs it] | __________ |

**Coverage gate:**

```
Core domains covered?
  YES (all required) → CLEAR
  PARTIAL (some missing) → DEGRADED — note gaps, cap confidence at MEDIUM for affected lenses
  NO (codebase access failed) → BLOCKED — STOP
```

### 1.2 Codebase Verification

Read these files to verify codebase access works:

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

### 1.3 Dynamic Tests (If Runtime Available)

If you have access to run commands:

```bash
# Adapt to project — examples:
# Run test suite
[TEST_COMMAND — e.g., cargo test, npm test, pytest]

# Check dependency versions
[VERSION_COMMAND — e.g., grep -A1 "dependency" Cargo.lock]

# Check for common issues
[GREP_COMMAND — e.g., grep -rn "TODO\|FIXME\|HACK" src/]

# Run linter
[LINT_COMMAND — e.g., cargo clippy, eslint, pylint]
```

**If these run, record results. They upgrade confidence on specific findings.**
**If unavailable, note it and proceed with static analysis.**

### 1.4 Pre-Flight Status

```
PRE-FLIGHT STATUS: ____________

Codebase access: __________ (tool name)
Knowledge domains: __________ (tools covering required domains)
Dynamic tests: RAN / NOT AVAILABLE
Exact dependency versions: [from lockfile or "not available"]

CLEAR    — Codebase + required domains verified. Dynamic tests ran.
DEGRADED — Some domains uncovered. Static analysis only.
BLOCKED  — Codebase failed OR critical domains uncovered. STOP.
```

---

## SECTION 2: FINDING CONTRACT

> **Every finding must use this format. No exceptions.**

### Required Fields

```json
{
  "id": "string — [PREFIX]-NNN (e.g., SEC-001, AUTH-001)",
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

### Severity Uplift Table

> **Adapt this table to the project's risk domain. Examples below — replace with domain-appropriate uplifts.**

| Finding Category | Standard Severity | Uplifted Severity |
|-----------------|-------------------|-------------------|
| [UPLIFT_CATEGORY_1] | [STANDARD] | **[UPLIFTED]** |
| [UPLIFT_CATEGORY_2] | [STANDARD] | **[UPLIFTED]** |
| [UPLIFT_CATEGORY_3] | [STANDARD] | **[UPLIFTED]** |

### Deployment Context Modifiers

Deployment context: **[DEPLOYMENT_CONTEXT]**

| Deployment Factor | Modifier | Applies To |
|------------------|----------|------------|
| [FACTOR_1] | [+1 / -1 / none] | [Which finding categories] |
| [FACTOR_2] | [+1 / -1 / none] | [Which finding categories] |

**Rules**: Downward modifiers NEVER apply to auth bypass, data integrity, or design flaws. If deployment context is unknown, assume public internet production.

### Confidence Rules

- **HIGH** requires: code evidence from codebase tool + API/behavior verification from external knowledge tool
- **MEDIUM**: code seen, API not fully verified or inconclusive result
- **LOW**: pattern suspected, cannot confirm from available evidence
- Domain knowledge gaps cap confidence at MEDIUM regardless of code evidence quality

---

## SECTION 3: LENSES

> **Execute each lens in order. Write findings to checkpoint file AFTER EACH LENS (incremental checkpoint pattern).**

---

### [LENS_1: NAME]

**ID Prefix**: [PREFIX]-
**Priority**: [CRITICAL | HIGH | MEDIUM]
**Depth Budget**: [EXHAUSTIVE (for CRITICAL) | STANDARD (for HIGH) | PROPORTIONAL (for MEDIUM)]

#### What To Read

| File | Focus |
|------|-------|
| `[src/path/to/file.ext]` | [What to examine in this file] |
| `[src/path/to/another.ext]` | [What to examine in this file] |
| `[src/path/to/third.ext]` | [What to examine in this file] |

#### What To Verify

| Question | Domain |
|----------|--------|
| "[Specific technical question to verify via external knowledge]" | [DOMAIN] |
| "[Another verification question]" | [DOMAIN] |

#### Detection Criteria

**[SEVERITY] (uplifted if applicable):**
- [Specific condition that constitutes this severity]
- [Another condition]

**[LOWER_SEVERITY]:**
- [Specific condition]
- [Another condition]

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

> **Add [LENS_4: NAME] and [LENS_5: NAME] sections here if needed, following the same structure.**

---

## SECTION 4: EXECUTION PROTOCOL

### PRE-FLIGHT
Complete Section 1 above. Verify codebase access and domain coverage.

### IMPLEMENT
Execute each lens in order (Lens 1 through Lens N). For each finding:

1. **READ** the file via codebase tool
2. **QUERY** external knowledge for API/behavior verification
3. **RUN** dynamic tests if available
4. **ASSESS** against detection criteria
5. **RECORD** using Finding Contract — all fields, no exceptions
6. **CHECK** positive observations — file genuine confirmations with evidence
7. **WRITE** finding to checkpoint file immediately (incremental checkpoint)

### VALIDATE

> **Validation must QUOTE EVIDENCE — not checkbox theater.**
> **For each check, cite a specific finding that demonstrates the check passes.**

```markdown
VALIDATE:

## Tool Summary
| Tool | Domains | Dynamic Tests Run |
|------|---------|-------------------|
| [codebase tool] | All source files | [list or "none"] |
| [external tools] | [domains] | n/a |

## Finding Quality (spot-check required)
| Check | Result | Evidence |
|-------|--------|----------|
| All findings have >=2 reasoning points | ✅/❌ | Spot-checked: [FINDING_ID] has N reasoning points. [FINDING_ID] has N. Lowest: N. |
| All findings have >=1 alternative rejected | ✅/❌ | Spot-checked: [FINDING_ID] rejected "[alternative]". |
| All findings have >=1 weakness acknowledged | ✅/❌ | Spot-checked: [FINDING_ID] acknowledges "[weakness]". |
| All evidence from codebase tool (not memory) | ✅/❌ | Spot-checked: [FINDING_ID] cites [file:line]. |
| Severity uplift applied where required | ✅/❌ | Spot-checked: [FINDING_ID] uplifted from [X] to [Y]. |
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
| Confidence monoculture (all same level) | ✅ No monoculture / ❌ RECALIBRATE |
| HIGH confidence > 50% | ✅ Under 50% / ❌ RE-EXAMINE |
| Zero positive observations | ✅ Positives found / ❌ SUSPICIOUS |
| Dynamic tests available but not run | ✅ All run or none available / ❌ QUALITY GAP |

## What This Audit Covers
- ✅ [Lens 1 scope summary]
- ✅ [Lens 2 scope summary]
- ✅ [Lens 3 scope summary]

## What This Audit Does NOT Cover
- ❌ [Out-of-scope area 1]
- ❌ [Out-of-scope area 2]
```

### CHECKPOINT

Write `checkpoints/audit-checkpoint.md` in the following format:

```markdown
# [PROJECT_NAME] — Audit Checkpoint

## Audit Info
Lenses executed: [list]
Date: [ISO timestamp]
Agent: [model identifier]
Methodology: MAP/CAP v2.2

## Pre-Flight Status
Status: CLEAR / DEGRADED / BLOCKED
Codebase tool: [name]
External knowledge: [tools, domains covered]
Dynamic tests run: [list or "none available"]

## Findings
[Full findings in Finding Contract JSON format — one per finding]

## Positive Observations
[Things verified as correctly implemented — with evidence]

## Confidence Distribution
| Level | Count | Percentage |
|-------|-------|------------|
| HIGH | | |
| MEDIUM | | |
| LOW | | |

## Attack Chain Analysis

After all lenses complete, scan for combined findings that create exploit chains:

### CHAIN-N: [Attack Name]

**Severity**: [highest severity of combined findings, potentially +1 if chain is worse]
**Findings combined**: [FINDING-ID-1] + [FINDING-ID-2]

**Attack scenario**:
1. Attacker does [action exploiting finding 1]
2. This gives attacker [capability]
3. Attacker uses [capability] to exploit [finding 2]
4. Result: [concrete impact]

**Why the chain is worse than individual findings**:
[Explanation]

**Remediation**: Fixing [FINDING-ID] breaks the chain at step [N].

## Validation
[Completed validation from VALIDATE section above]

## Checkpoint Status
Status: COMPLETE / PARTIAL
Confidence: HIGH / MEDIUM / LOW
Findings: [count total, count actionable, count positive]
```

---

## SECTION 5: JSON SIDECAR OUTPUT

In addition to the markdown checkpoint, produce `checkpoints/audit-checkpoint.json`:

```json
{
  "project": "[PROJECT_NAME]",
  "date": "[ISO timestamp]",
  "agent": "[MODEL_ID]",
  "methodology": "MAP/CAP v2.2",
  "deployment_context": "[DEPLOYMENT_CONTEXT]",
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
  "confidence_distribution": {"HIGH": 0, "MEDIUM": 0, "LOW": 0},
  "checkpoint_status": "COMPLETE | PARTIAL"
}
```

---

## SECTION 6: COMPACTION RECOVERY

If context compaction occurs mid-audit:

```
COMPACTION RECOVERY PROTOCOL

1. STOP immediately. Do not continue auditing from memory.

2. Re-read THIS audit MAP file to restore instructions.

3. Re-read the project CLAUDE.md (if present) to restore context.

4. Read the checkpoint file (checkpoints/audit-checkpoint.md) to see what
   findings have already been written.

5. Resume from the last completed lens. Do NOT re-audit lenses that have
   complete findings in the checkpoint.

6. Flag the compaction in the checkpoint:
   "Context compaction occurred during this audit. Findings before
   [FINDING-ID] were written pre-compaction. Findings after were written
   post-compaction with recovered context."

KEY: Write findings to disk AFTER EACH LENS. The disk file survives
compaction. Your context does not.
```

---

*Single-Pass Audit MAP Template | MAP/CAP v2.2 | Jimmy's Workflow v2.1*
*For 1-5 lenses. For 6+ lenses, use multi-pass-orchestrator-template.md.*
