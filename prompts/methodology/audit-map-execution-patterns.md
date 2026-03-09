---
document_type: methodology
name: Audit MAP Execution Patterns
version: "1.1"
updated: "2026-02"
target_model: claude-opus-4-5
primary_use: executing_audit_maps
secondary_use: designing_audit_maps_for_executability

load_when:
  - executing an audit MAP against a codebase
  - designing a new audit MAP and deciding pass structure
  - reviewing auditor output for quality
  - training agents on audit execution discipline
  - setting up an audit folder for a new project

skip_when:
  - designing MAP structure from scratch (use part1)
  - building component libraries (use part2)
  - general development tasks (use jimmys-workflow)

requires:
  - god-prompt-methodology-part2-v2.2.md (Finding Contract, Confidence Calibration)
  - jimmys-workflow-v2.1.md (PRE-FLIGHT → RED → GREEN → CHECKPOINT)

enhances:
  - god-prompt-methodology-part1-v2.1.md
  - MAP-CAP-Lite-MVP.md

key_sections:
  - "Recon-First Session Architecture"
  - "Audit Folder Structure"
  - "Multi-Pass Architecture"
  - "Finding Carry-Forward Protocol"
  - "Validation Rigor"
  - "Confidence Calibration Field Rules"
  - "Deployment Context Modifiers"
  - "Attack Chain Analysis"
  - "Context Compaction Handling"
  - "Domain-Specific Execution Patterns"

exports:
  recon_first: "Section: Recon-First Session Architecture"
  folder_structure: "Section: Audit Folder Structure"
  pass_threshold: "Section: When To Split"
  carry_forward: "Section: Finding Carry-Forward Protocol"
  validation_gates: "Section: Validation as a Gate, Not a Formality"
  confidence_field_rules: "Section: Confidence Calibration Field Rules"
  deployment_modifiers: "Section: Deployment Context Modifiers"
  attack_chains: "Section: Attack Chain Analysis"
  compaction_handling: "Section: Context Compaction Handling"

evidence_base:
  audits_executed: 4
  auditor_feedback_sessions: 2
  projects:
    - name: Project A
      domain: health_android
      lenses: 6
      pass_structure: single
    - name: Project B
      domain: children_education
      lenses: 7
      pass_structure: single
    - name: Project C
      domain: financial_blockchain
      lenses: 6
      pass_structure: single (context compaction observed)
    - name: Project D
      domain: cryptographic_protocol
      lenses: 8
      pass_structure: single (v1, context exhaustion) → multi-pass (v2, 3 passes + orchestrator)

changelog:
  v1.1:
    - "Recon-First Session Architecture — Session 0 discovers tools, verifies paths, updates pass MAPs in place"
    - "Audit Folder Structure — standardized folder layout with numbered files"
    - "Context Compaction Handling — recovery protocol when agent hits compaction mid-pass"
    - "File Path Accuracy rewritten — recon replaces accept-and-correct approach"
    - "Session flow updated — recon → passes → synthesis as distinct sessions"
  v1.0:
    - "Initial document — field-tested patterns from 4 audits"
    - "Multi-pass architecture with orchestrator"
    - "Finding carry-forward confidence penalty"
    - "Validation rigor gates"
    - "Confidence field calibration rules"
    - "Deployment context severity modifiers"
    - "Attack chain synthesis"
    - "Domain-specific execution patterns"
---

# Audit MAP Execution Patterns
## *Field-Tested Rules for Running Source Code Audits*

**Version 1.1** | February 2026 | Claude Opus 4.5
**Primary Focus**: Operational knowledge for executing audit MAPs — what works, what breaks, and what the methodology docs don't cover until you've run real audits.

---

## Plain English Introduction

**What is this?**

Part 1 teaches you how to design audit MAPs. Part 2 teaches you how to build component libraries. Jimmy's Workflow gives you execution discipline. This document fills the gap between designing an audit and executing one well.

It contains patterns discovered by running 4 real audits across 4 different risk domains (health, children's education, financial/blockchain, cryptographic protocol) and incorporating honest self-assessment feedback from the executing agents.

**Why does this exist?**

Because every audit we ran surfaced execution problems the design methodology didn't anticipate:

- An 8-lens crypto audit exceeded the context window, and the agent inherited findings it couldn't re-verify
- A 6-lens financial audit had its VALIDATE phase treated as a formality — the agent ticked boxes without re-reading findings
- Confidence levels clustered at 100% HIGH, which is unrealistic and a signal of insufficient self-assessment
- Deployment context (private network, preprod) should have modified severity downward, but the MAP only had upward modifiers
- Combined findings created exploit chains more severe than any individual finding, but synthesis didn't surface them
- File paths written from tech stack docs were wrong in 22+ places — agents spent time in every pass hunting for correct paths instead of auditing

These are operational lessons. They belong in a document that auditors read before execution, not buried in design theory.

**Who is this for?**

- Agents executing audit MAPs (primary audience)
- Prompt architects designing audit MAPs for executability
- Humans reviewing audit output for quality

---

## Recon-First Session Architecture

### The Problem

The Project D auditor corrected 22+ file paths in Pass 1 alone, with more in Passes 2 and 3. Every pass repeated the same work: discover tools, map MCP servers, verify file existence. MAPs written from tech stack documentation have approximate paths — good enough for a starting point, wrong enough to waste audit time.

The Project C auditor hit context compaction partly because the agent was doing path discovery AND auditing in the same context window.

### The Fix: Session 0 Is Reconnaissance

Before any audit pass executes, a dedicated recon session reads the actual codebase and **updates the pass MAPs in place** with verified information.

```
Session 0: RECON
  ├── Discover available tools (MCP servers, codebase access, external knowledge)
  ├── Read actual file structure (tree, find, ls)
  ├── Get real dependency versions (Cargo.lock, package.json, lockfile)
  ├── Map real file paths to each lens's "What To Read" tables
  ├── Verify which files exist and which don't
  ├── UPDATE pass MAPs in place with correct details
  └── Output: pass MAPs are no longer templates — they're verified

Session 1: Execute Pass 1 (paths are correct, tools are known)
Session 2: Execute Pass 2
Session 3: Execute Pass 3 (or combine with synthesis for smaller audits)
Session N: Synthesis (read all checkpoints, produce final report)
```

### What Recon Does

| Task | How | Output |
|------|-----|--------|
| **Tool discovery** | List available MCP servers, test codebase read, test external knowledge | Tool mapping table filled in across all pass MAPs |
| **File structure** | `find . -name "*.rs" -type f` or equivalent | Actual file paths replace approximate paths in pass MAPs |
| **Dependency versions** | Read `Cargo.lock`, `package.json`, `package-lock.json` | Exact versions in pass MAPs (e.g., "clatter 0.1.3" not "clatter 0.1") |
| **Existence verification** | Attempt to read each file referenced in pass MAPs | Non-existent files flagged with NOTE, alternatives identified |
| **Domain coverage** | Test which external knowledge domains are available | Coverage gate pre-filled — passes know their status before starting |

### What Recon Does NOT Do

- Does NOT execute lenses or file findings
- Does NOT read files deeply (skims structure, doesn't analyze logic)
- Does NOT produce a checkpoint
- Does NOT make audit judgments

Recon is infrastructure. It makes the passes efficient. It is not an audit pass.

### The Recon Prompt (00-recon.md)

The recon prompt tells the agent:

1. Read CLAUDE.md for project context
2. Discover all available tools and map them to required knowledge domains
3. Read the file structure of the target codebase
4. Read dependency lockfiles for exact versions
5. Open each pass MAP (01-passN.md, 02-passN.md, etc.)
6. For each "What To Read" table, "Codebase Verification" section, and "Dynamic Tests" section:
   - Verify each file path exists
   - If wrong → find the correct path → update in place
   - If file doesn't exist → add NOTE warning
7. Fill in tool mapping tables in each pass MAP's pre-flight section
8. Save all changes

After recon completes, the human spot-checks the updated MAPs and then runs each pass in a fresh session.

### Why Recon Is a Separate Session

- **Fresh context for each pass.** If recon and Pass 1 share a session, the recon work (file listing, path hunting) consumes context that Pass 1 needs for deep analysis.
- **Recon output persists as files.** The updated MAPs are on disk. They survive session boundaries. No carry-forward risk.
- **Recon can be re-run.** If the codebase changes (new branch, refactor), re-run recon to update paths. Pass MAPs stay current.

---

## Audit Folder Structure

### Standard Layout

Every audit project gets a folder with numbered files that encode execution order:

```
project-name/
├── README.md                         — Points to CLAUDE.md
├── CLAUDE.md                         — Project context, execution order, principles
├── 00-recon.md                       — Session 0: discover, verify, update pass MAPs
├── 01-pass1-[name].md                — Session 1: first audit pass (template → recon fills in)
├── 02-pass2-[name].md                — Session 2: second audit pass
├── 03-pass3-[name].md                — Session 3: third audit pass (if needed)
├── 04-synthesis.md                   — Final session: read checkpoints, produce report
└── checkpoints/                      — Pass outputs land here
    ├── pass1-checkpoint.md           — Written by Session 1
    ├── pass2-checkpoint.md           — Written by Session 2
    ├── pass3-checkpoint.md           — Written by Session 3 (if applicable)
    └── final-audit-report.md         — Written by synthesis session
```

### Naming Convention

- **`00-`** prefix = always recon (runs first)
- **`01-`, `02-`, `03-`** = audit passes in execution order
- **Last numbered file** = synthesis (reads all checkpoints)
- **Numbering encodes dependencies** — higher numbers may reference lower numbers' checkpoints

### CLAUDE.md Content

The CLAUDE.md serves as the project brain for any agent entering the folder. It should contain:

- What the project being audited is (one paragraph)
- The execution order (run 00 first, then 01, 02, etc.)
- Core principles (Finding Contract, confidence rules, severity uplift)
- Where outputs go (`checkpoints/`)
- What NOT to do (don't skip recon, don't run passes out of order)

Keep it concise — under 30 instructions per the CLAUDE.md best practice of progressive disclosure. Point to methodology docs rather than inlining them.

### README.md Content

Minimal. One job: tell the human to read CLAUDE.md. Quick file reference showing what's in the folder.

### Single-Pass Audits

For small audits (≤5 lenses), the folder simplifies:

```
project-name/
├── README.md
├── CLAUDE.md
├── 00-recon.md                       — Still does recon (path verification is always valuable)
├── 01-audit.md                       — Single pass, all lenses
└── checkpoints/
    └── audit-checkpoint.md
```

Recon is still valuable even for single-pass audits — correct paths save time and prevent wasted context on path-hunting during the audit itself.

---

## Multi-Pass Architecture

### When To Split

| Lens Count | Recommendation | Reasoning |
|-----------|----------------|-----------|
| **1-5 lenses** | Single pass | Fits comfortably in one context window. Agent maintains fresh context for all findings. |
| **6 lenses** | Consider multi-pass | Borderline. If the codebase is large, if lenses are CRITICAL priority, or if any lens requires deep crypto analysis — split. If the codebase is small and lenses are standard — single pass may work. |
| **7+ lenses** | Multi-pass recommended | High risk of context exhaustion. A single compaction event destroys verification ability on early lenses. |
| **8+ lenses** | Multi-pass mandatory | Proven to exceed context in practice. The Project D 8-lens audit failed in single pass, succeeded in 3-pass. |

**Additional split triggers** (regardless of lens count):

- Any lens covers cryptographic primitives (deep verification paths, niche APIs)
- Codebase exceeds 50 files or 10,000 lines in audit scope
- Multiple CRITICAL-priority lenses (each demands exhaustive depth budget)
- The audit MAP itself exceeds 800 lines (context budget for the MAP alone is significant)

### The Session Flow

For multi-pass audits, the full session sequence is:

```
Session 0: 00-recon.md        — Discover tools, verify paths, update all pass MAPs in place.
Session 1: 01-pass1-[name].md — Execute pass 1. Paths are correct. Write checkpoint.
Session 2: 02-pass2-[name].md — Execute pass 2. May read pass1 checkpoint. Write checkpoint.
Session 3: 03-pass3-[name].md — Execute pass 3. May read prior checkpoints. Write checkpoint.
Session N: NN-synthesis.md    — Read all checkpoints. Dedup, root cause, attack chains, final report.
```

**Between sessions**: human spot-checks that the checkpoint file was written and is non-empty.

**Key rule**: Each session uses a FRESH context window. No session carries conversation history from a prior session. Checkpoints are the state transfer mechanism.

### Pass Grouping Principles

| Principle | Example |
|-----------|---------|
| **Group tightly-coupled lenses** | Crypto correctness + zero-knowledge + Noise protocol share the same source files and reasoning chain |
| **Separate distinct attack surfaces** | TOFU/DNS security has nothing in common with FFI boundary safety |
| **Put regression check in the last pass** | It benefits from having all other passes' findings available as context |
| **Balance pass size** | 2-3 lenses per pass is ideal. 4 is maximum. 1 is acceptable for a complex CRITICAL lens. |

### Each Pass Must Be Self-Contained

A pass MAP must include everything the agent needs without reading other pass MAPs:

- Its own pre-flight check (scoped to that pass's files and domains)
- The Finding Contract (identical across all passes — consistency for synthesis)
- Only the lenses for that pass
- Its own validation and checkpoint template
- An output filename for the checkpoint

The agent executing Pass 2 should NOT need to read the Pass 1 MAP — only the Pass 1 checkpoint (optionally, for cross-references).

---

## Finding Carry-Forward Protocol

### The Problem

When an agent executes a later pass and references findings from an earlier pass, it's working from a summary — not from the original evidence. Context compaction, session boundaries, and checkpoint summarization all strip nuance. The agent may be trusting conclusions it can no longer verify.

Both the Project D and Project C auditors independently identified this as a quality risk.

### The Rules

**Rule 1: Re-read or penalize.**

If you reference a finding from a prior pass, you MUST re-read the evidence file via codebase tool. If you cannot re-read it (tool unavailable, file not in context), apply a confidence penalty:

| Original Confidence | Inherited Without Re-Verification |
|--------------------|---------------------------------|
| HIGH | → MEDIUM |
| MEDIUM | → LOW |
| LOW | → stays LOW |

Tag the finding: `"⚠️ Inherited from Pass N — not re-verified in this session"`

**Rule 2: Never copy finding text as your own evidence.**

If you carry forward a finding, the evidence must be freshly gathered. Quoting the checkpoint summary as evidence is circular — the summary might be wrong.

**Rule 3: Contradictions are valuable.**

If Pass 3 discovers that a Pass 1 finding was incorrect, that's a feature, not a bug. Record it: `"Contradicts Pass 1: CRYPTO-003 — re-assessment needed"`. The synthesis phase resolves contradictions.

**Rule 4: Cross-references use explicit format.**

`"See Pass 1: CRYPTO-003"` — not `"as previously noted"` or `"per earlier findings"`. The synthesis phase needs to trace every reference.

---

## Validation as a Gate, Not a Formality

### The Problem

The Project C auditor admitted: "I claimed 'All findings have all required fields — PASS' without actually checking. That's exactly the shortcut the MAP warns against." The VALIDATE phase was designed as a quality gate but executed as a rubber stamp.

### The Fix: Validation Must Quote Evidence

The VALIDATE section must not be a checklist of ✅ marks. It must demonstrate that the agent actually re-read the findings. For each quality check, the agent must cite a specific finding.

**Bad validation (theater):**
```
All findings have ≥2 reasoning points — ✅ PASS
```

**Good validation (actual gate):**
```
All findings have ≥2 reasoning points — ✅ PASS
  Spot-checked: PAY-003 has 3 reasoning points (idempotency check, SQLite
  behavior, race window). VAULT-001 has 2 (env var presence, no fallback).
  CHAIN-002 has 4. Lowest count found: 2 (VAULT-001). Contract met.
```

The agent must spot-check at minimum:
- 3 random findings for field completeness
- The finding with the highest severity for evidence quality
- The finding with the highest confidence for calibration accuracy
- Any finding with `cryptographic_impact: true` for uplift correctness

### Hard Gates in Validation

These conditions should BLOCK the checkpoint — not just be noted:

| Condition | Gate |
|-----------|------|
| **Confidence monoculture** | If all findings share the same confidence level (100% HIGH, or 100% MEDIUM), STOP and recalibrate. Uniform confidence is a signal of insufficient self-assessment. Real codebases have a mix. |
| **HIGH confidence > 50%** | Suspicious. Re-examine each HIGH finding — does it truly have code evidence + API verification? |
| **MEDIUM confidence > 60%** | Alert fatigue risk. Are you hedging because you're uncertain, or because you didn't investigate deeply enough? |
| **Zero positive observations** | Suspicious. Did you only look for problems? A real audit finds things that are done correctly too. |
| **Dynamic tests available but not run** | Quality gap. If `cargo test`, `npm audit`, `grep` commands are available and relevant, running them is not optional. Note: "not available" is a legitimate limitation; "available but skipped" is not. |

---

## Confidence Calibration Field Rules

### Lessons from Real Execution

The Part 2 confidence calibration examples define HIGH/MEDIUM/LOW in theory. These rules refine them based on what we observed in practice.

**Rule 1: Domain knowledge gaps cap confidence at MEDIUM.**

If the agent lacks domain knowledge for a specific technology (e.g., Storacha UCAN, clatter Noise hybrid, ML-KEM-768), any finding in that domain is automatically capped at MEDIUM regardless of code evidence quality. The agent cannot properly assess what it doesn't understand.

Tag: `"Domain knowledge limitation: [technology]. Confidence capped at MEDIUM."`

**Rule 2: Depth budget scales with lens priority.**

| Lens Priority | MEDIUM Confidence Means |
|--------------|------------------------|
| **CRITICAL** | "I exhausted all available verification paths and still couldn't confirm." This is acceptable. |
| **CRITICAL** | "I could have verified deeper but chose not to." This is NOT acceptable — go deeper. |
| **HIGH** | "I queried external knowledge and got an inconclusive result." Acceptable. |
| **MEDIUM** | "I pattern-matched without deep investigation." Acceptable for MEDIUM-priority lenses. |

The Project D auditor articulated this distinction perfectly: settling on MEDIUM because you were cautious is different from settling on MEDIUM because you tried everything. The MAP must distinguish between the two.

**Rule 3: Dual verification for HIGH confidence.**

HIGH confidence requires BOTH:
- Code evidence from codebase tool (not from memory, not from tech stack doc)
- API/behavior verification from external knowledge tool

If only one stream is available, confidence caps at MEDIUM.

Exception: purely structural findings (e.g., "file .env committed to git") don't need external knowledge verification — the code evidence alone is sufficient.

**Rule 4: Dynamic test results upgrade confidence.**

| Situation | Confidence Impact |
|-----------|-------------------|
| `grep` confirms no key material in logs | Specific finding upgrades from MEDIUM to HIGH |
| `cargo test` passes — 704 tests | General confidence in codebase stability (not specific findings) |
| `npm audit` finds known CVE in dependency | New finding at HIGH confidence (objective evidence) |
| `cargo clippy` flags unsafe pattern | Specific finding upgrades or new finding at HIGH |
| Dynamic test not available | Note as limitation — no penalty, but no upgrade either |
| Dynamic test available but not run | Quality gap — must be noted in validation. Affected findings stay at lower confidence. |

---

## Deployment Context Modifiers

### The Problem

The Project C auditor correctly identified that several HIGH-severity findings assumed worst-case deployment (public internet, production traffic) when the system actually runs on a private mesh network in Preprod. The MAP had upward severity modifiers (financial uplift, children's uplift, crypto uplift) but no downward modifiers for deployment context.

Severity should be calibrated to the actual threat environment, not the theoretical maximum.

### Deployment Context Table

| Deployment Factor | Severity Modifier | Rationale |
|------------------|-------------------|-----------|
| **Public internet, production traffic** | No modifier (baseline) | Standard threat model applies |
| **Private network (private mesh, VPN)** | Consider -1 for network-exposure findings | Attacker needs mesh access first. Does NOT modify: auth bypass, data integrity, crypto correctness. |
| **Preprod / staging** | Consider -1 for operational findings | Lower blast radius. Does NOT modify: code correctness, crypto, design flaws (these carry to prod). |
| **Air-gapped / local only** | -1 for all network-exposure findings | No remote attack surface. Still apply: local privilege escalation, data integrity, crypto. |
| **Multi-tenant production** | Consider +1 for isolation findings | Tenant boundary failures affect other customers |
| **Regulated industry (health, finance)** | Apply domain-specific uplift table | See domain-specific patterns section |

### Rules for Applying Modifiers

1. **Deployment modifiers are OPTIONAL and must be justified.** The auditor decides whether to apply them based on the stated deployment context. They are never automatic.

2. **Downward modifiers never apply to:**
   - Authentication/authorization bypass (these carry to any deployment)
   - Cryptographic correctness (a nonce reuse is a nonce reuse regardless of network)
   - Data integrity failures (corrupt data is corrupt everywhere)
   - Design flaws (these migrate when code moves to production)

3. **If deployment context is unknown, assume public internet production.** Don't downgrade severity based on assumptions about where the code runs.

4. **Document the modifier.** If severity is adjusted for deployment context, the finding must note: `"Severity adjusted from [original] to [adjusted] due to [deployment context]. Would be [original] in public deployment."`

5. **The original (unmodified) severity must still be recorded.** Stakeholders need to know what the severity would be if deployment context changes.

---

## Attack Chain Analysis

### The Problem

The Project C auditor noted: "PAY-002 + API-001 together means 'anyone can create a lifetime license for free.' I mentioned this inside API-001's reasoning but didn't surface it prominently."

Individual findings are necessary. Combined findings revealing exploit chains are what stakeholders actually need to see.

### When To Produce Attack Chains

After all lenses are complete (in synthesis for multi-pass, or after all lenses in single-pass), scan for combinations:

| Combination Pattern | What To Look For |
|--------------------|------------------|
| **Auth bypass + privileged action** | "No auth on endpoint" + "endpoint performs destructive/valuable action" = anyone can trigger the action |
| **Input validation gap + dangerous sink** | "No validation on field X" + "field X reaches SQL/shell/file path" = injection |
| **Key exposure + encrypted data** | "Key logged/leaked" + "data encrypted with that key" = plaintext recovery |
| **TOFU bypass + relay trust** | "TOFU can be bypassed" + "relay handles all traffic" = full MITM |
| **State inconsistency + financial action** | "Race condition in state" + "state controls payment/issuance" = double-spend |

### Attack Chain Format

```markdown
### CHAIN-N: [Attack Name]

**Severity**: [highest severity of combined findings, potentially +1 if chain is worse]
**Findings combined**: [FINDING-ID-1] + [FINDING-ID-2] + ...

**Attack scenario**:
1. Attacker does [action exploiting finding 1]
2. This gives attacker [capability]
3. Attacker uses [capability] to exploit [finding 2]
4. Result: [concrete impact — "free lifetime license", "plaintext recovery", etc.]

**Why the chain is worse than individual findings**:
[Explain why the combination creates impact beyond what either finding alone suggests]

**Remediation**: Fixing [FINDING-ID] breaks the chain at step [N].
```

### Placement

Attack chains go in the synthesis section (multi-pass: orchestrator synthesis; single-pass: after all lenses). They reference findings by ID — the findings themselves don't change.

---

## Context Compaction Handling

### The Problem

Even with multi-pass architecture, an agent may hit context compaction within a single pass — especially on CRITICAL lenses with exhaustive depth budgets, or when the codebase has many large files.

Both the Project D auditor (cross-session) and Project C auditor (within-session compaction) lost access to earlier reasoning after compaction.

### Recovery Protocol

If the agent detects context compaction (auto-compact event, lost conversation history, or explicit compaction notification):

**1. STOP immediately.** Do not continue auditing from memory.

**2. Re-read the pass MAP.** The MAP is on disk — it survives compaction. Re-read it to restore instructions.

**3. Re-read the CLAUDE.md.** Restore project context and principles.

**4. Check what's been written.** Read the checkpoint file (if any findings have been written) to see what work is complete.

**5. Resume from last written finding.** Do not re-audit lenses that have complete findings in the checkpoint. Start from the next unfinished lens.

**6. Flag the compaction.** In the checkpoint, note: `"⚠️ Context compaction occurred during this pass. Findings before [FINDING-ID] were written pre-compaction. Findings after were written post-compaction with recovered context."`

### Prevention

- Recon session handles all path discovery (reduces pass context usage)
- Multi-pass keeps each session focused (2-3 lenses, not 8)
- Write findings to checkpoint incrementally (after each lens, not at the end)
- If a pass has a CRITICAL lens, consider giving it its own session

### The Incremental Checkpoint Pattern

Instead of writing all findings at the end of a pass, write after each lens completes:

```
Lens 1 complete → append findings to checkpoint file
Lens 2 complete → append findings to checkpoint file
Lens 3 complete → append findings to checkpoint file
VALIDATE → read full checkpoint, verify quality
```

If compaction occurs between Lens 2 and Lens 3, Lenses 1-2 findings are safe on disk. The agent recovers by reading the checkpoint and resuming at Lens 3.

---

## Domain-Specific Execution Patterns

### Pattern: Children's Systems (Project B)

**Severity uplift table:**

| Finding Category | Standard → Uplifted |
|-----------------|---------------------|
| Unencrypted PII storage | MEDIUM → **HIGH** |
| Missing parental consent gate | HIGH → **CRITICAL** |
| Analytics without consent | LOW → **MEDIUM** |
| Age-inappropriate content pathway | MEDIUM → **HIGH** |
| Audio recording without disclosure | MEDIUM → **HIGH** |

**Execution notes:**
- COPPA compliance is not optional — treat as regulatory requirement
- "Children" means under 13 (COPPA) or under 16 (GDPR) depending on jurisdiction
- Voice/audio data from children requires extra scrutiny
- Third-party SDKs that collect data need individual assessment

### Pattern: Financial Systems (Project C)

**Severity uplift table:**

| Finding Category | Standard → Uplifted |
|-----------------|---------------------|
| Webhook signature bypass | HIGH → **CRITICAL** |
| Double-issuance (idempotency failure) | HIGH → **CRITICAL** |
| Wallet/payment private key exposure | HIGH → **CRITICAL** |
| Plaintext credentials in config | MEDIUM → **HIGH** |
| API route without auth (payment-adjacent) | MEDIUM → **HIGH** |
| Blockchain metadata integrity failure | MEDIUM → **HIGH** |
| Missing rate limiting on payment routes | LOW → **MEDIUM** |

**Execution notes:**
- Financial bugs = real money lost. Severity reflects financial impact, not just technical severity.
- Blockchain transactions are irrecoverable — bugs that write bad data on-chain are effectively permanent
- Idempotency is CRITICAL in payment flows — double-charge or double-issuance
- Webhook signature verification is the trust boundary for payment providers (Stripe, etc.)

### Pattern: Cryptographic Protocols (Project D)

**Severity uplift table:**

| Finding Category | Standard → Uplifted |
|-----------------|---------------------|
| Nonce reuse / predictable nonce | HIGH → **CRITICAL** |
| Key material leaked (log, error, FFI) | HIGH → **CRITICAL** |
| Timing side-channel in crypto operation | HIGH → **CRITICAL** |
| Zero-knowledge violation (relay sees plaintext) | HIGH → **CRITICAL** |
| Protocol handshake state machine error | HIGH → **CRITICAL** |
| HMAC comparison not constant-time | MEDIUM → **HIGH** |
| KEM shared secret not zeroed after use | MEDIUM → **HIGH** |
| FFI leaks key material to foreign heap | MEDIUM → **HIGH** |
| TOFU bypass enabling MITM | MEDIUM → **HIGH** |
| Prior audit fix regressed | varies → **+1 severity** |

**Execution notes:**
- AI is notoriously poor at crypto reasoning — plausible-looking code is often subtly wrong
- Niche crypto dependencies (e.g., `clatter` 0.1, `ml-kem` 0.3) have sparse training data — verify everything via external tools
- Zero-knowledge claims require exhaustive evidence (read every relay handler path), not assumption
- Timing side-channels cannot be confirmed by static analysis alone — flag for measurement
- **HUMAN CRYPTOGRAPHER REQUIRED** — crypto audits are never 🔵 COMPLETE without human sign-off
- Multi-pass is mandatory for 6+ lenses in crypto context (deep verification paths consume more context)

### Pattern: Health Systems (Project A)

**Severity uplift table:**

| Finding Category | Standard → Uplifted |
|-----------------|---------------------|
| Health data stored unencrypted | MEDIUM → **HIGH** |
| Health data transmitted unencrypted | HIGH → **CRITICAL** |
| Missing consent for data collection | MEDIUM → **HIGH** |
| GDPR right-to-deletion not implemented | MEDIUM → **HIGH** |
| Third-party SDK receives health data | MEDIUM → **HIGH** |
| Biometric data processing without disclosure | HIGH → **CRITICAL** |

**Execution notes:**
- Health data is special-category under GDPR — higher bar for processing justification
- HIPAA may apply if US users are in scope (even for non-US developers)
- On-device ML models (ONNX) that process health data need assessment for data leakage
- Consent must be granular — blanket consent for "health features" is insufficient

---

## Quality Checklist for MAP Designers

When designing a new audit MAP, verify these execution-readiness criteria:

| Criterion | Check |
|-----------|-------|
| **Recon prompt included** | Does the folder have a 00-recon.md that verifies paths and discovers tools? |
| **Lens count assessed** | Is multi-pass needed? (≥6 lenses → consider, ≥8 → mandatory) |
| **Pre-flight scoped** | Does pre-flight check only the files and domains this pass needs? |
| **Finding Contract included** | Is it identical across all passes? (consistency for synthesis) |
| **Severity uplift table present** | Does the domain have specific uplift rules? |
| **Deployment context noted** | Does the MAP state the expected deployment environment? |
| **Dynamic test hooks included** | Are there specific commands the agent should run if available? |
| **Depth budget specified per lens** | CRITICAL = exhaustive, HIGH = standard, MEDIUM = proportional? |
| **Positive observations prompted** | Does each lens ask "verify this IS correct" alongside "find what's wrong"? |
| **Validation is a gate** | Does VALIDATE require quoting specific findings, not just ✅ marks? |
| **Attack chain synthesis prompted** | Does the synthesis section ask for combined-finding exploit scenarios? |
| **Human gate if needed** | Crypto → HUMAN CRYPTOGRAPHER. Regulated → COMPLIANCE REVIEW. |
| **Carry-forward rules stated** | For multi-pass: inherited findings get confidence penalty? |
| **Compaction handling noted** | Does each pass tell the agent what to do if context compacts? |
| **Incremental checkpoint pattern** | Do passes write findings after each lens, not just at the end? |

---

## File Path Accuracy

### The Lesson

The Project D auditor corrected 22+ file paths in Pass 1, with dozens more across Passes 2 and 3. Paths written from tech stack documentation are approximate — good starting points, but frequently wrong on exact filenames, directory nesting, or module organization.

### The Evolution

**v1.0 approach**: Accept approximate paths, rely on pre-flight verification to correct them during each pass. This worked but wasted audit context on path-hunting.

**v1.1 approach (current)**: Recon session (Session 0) verifies ALL paths before any pass executes. Pass MAPs are updated in place with correct paths. Passes execute with verified paths — no path-hunting, no wasted context.

### The Rules

1. **MAPs are written with best-available paths from tech stack documentation.** These are templates — expected to be approximate.

2. **Recon verifies and corrects all paths.** Session 0 reads the actual file structure and updates every "What To Read" table, "Codebase Verification" block, and "Dynamic Tests" section in place.

3. **After recon, paths should be correct.** If a pass agent discovers a wrong path post-recon, it's a recon quality issue — note it, correct it, and flag for recon improvement.

4. **Non-existent files get NOTE warnings, not removal.** If a file referenced in the MAP doesn't exist, recon adds a `NOTE: File does not exist. Nearest equivalent: [path]` rather than silently removing it. The absence might be a finding (e.g., "expected security middleware doesn't exist").

5. **Specific-but-approximate is better than vague.** When designing MAPs, write `src/middleware/auth.ts` not "somewhere in src/". It gives recon a concrete target to verify or correct.

---

## Integration with Existing Methodology

### Where This Document Fits

```
Part 1 (MAP Design)         — HOW to structure audit prompts
Part 2 (CAP Components)     — HOW to build reusable components
Jimmy's Workflow             — HOW to execute with discipline
Lite MVP                     — HOW to start without tooling
THIS DOCUMENT                — HOW to execute audits well (field-tested)
```

### Cross-References

| Pattern In This Document | Canonical Source |
|-------------------------|-----------------|
| Finding Contract fields | Part 2, Section: "The Finding Contract (CRITICAL)" |
| Confidence Calibration examples | Part 2, Section: "Confidence Calibration Examples" |
| PRE-FLIGHT → RED → GREEN → CHECKPOINT | Jimmy's Workflow v2.1 |
| Lens Component Template | Part 2, Section: "Lens Component Template" |
| Blueprint Configuration | Part 2, Section: "Blueprint Configuration" |
| COI Disclosure | Part 2, Section: "The COI Disclosure Component" |

### What This Document Adds (Not In Other Docs)

| Addition | Why It's Not In Part 1/2/JW |
|----------|---------------------------|
| Recon-first session architecture | New pattern — separate reconnaissance from auditing for path accuracy and tool discovery. |
| Audit folder structure | Standardized layout with numbered files encoding execution order. |
| Multi-pass architecture | Part 1/2 design MAPs as monolithic. This doc handles execution at scale. |
| Carry-forward protocol | New problem — only appears when audits span multiple sessions. |
| Validation rigor gates | Jimmy's Workflow has VALIDATE but doesn't enforce re-reading findings. |
| Context compaction handling | New problem — recovery protocol when agent loses context mid-pass. |
| Deployment context modifiers | Part 2 has severity uplift but not downward adjustment. |
| Attack chain analysis | Part 2 has synthesizers for dedup and root cause but not exploit chains. |
| Domain-specific uplift tables | Consolidated from 4 individual MAPs into reusable patterns. |
| Dynamic test hooks | New pattern — agents can now run commands, not just read code. |
| Confidence field rules (domain cap, depth budget) | Extends Part 2 calibration with operational experience. |

---

## LOAD_ADDITIONAL

```yaml
if_task_involves:
  setting_up_audit_folder:
    load: "This document"
    sections: ["Audit Folder Structure", "Recon-First Session Architecture"]
    reason: "Standardized folder layout and recon-first execution pattern"

  designing_audit_map:
    load: "god-prompt-methodology-part1-v2.1.md"
    reason: "MAP structure patterns"
    also_load: "This document"
    reason: "Execution-readiness checklist, pass splitting, domain uplifts, recon pattern"

  building_components:
    load: "god-prompt-methodology-part2-v2.2.md"
    reason: "Finding Contract, confidence calibration, lens templates"

  executing_audit:
    load: "This document"
    reason: "Execution patterns, carry-forward, validation rigor, compaction handling"
    also_load: "jimmys-workflow-v2.1.md"
    reason: "PRE-FLIGHT → RED → GREEN → CHECKPOINT"

  reviewing_audit_output:
    load: "This document"
    sections: ["Validation as a Gate", "Confidence Calibration Field Rules"]

  choosing_pass_structure:
    load: "This document"
    sections: ["Multi-Pass Architecture", "When To Split", "Recon-First Session Architecture"]

shared_patterns:
  recon_first: "This document, Section: Recon-First Session Architecture"
  folder_structure: "This document, Section: Audit Folder Structure"
  finding_contract: "Part 2, Section: The Finding Contract"
  confidence_calibration: "Part 2, Section: Confidence Calibration Examples"
  confidence_field_rules: "This document, Section: Confidence Calibration Field Rules"
  validation_rigor: "This document, Section: Validation as a Gate"
  carry_forward: "This document, Section: Finding Carry-Forward Protocol"
  compaction_handling: "This document, Section: Context Compaction Handling"
  deployment_modifiers: "This document, Section: Deployment Context Modifiers"
  attack_chains: "This document, Section: Attack Chain Analysis"
  domain_uplifts: "This document, Section: Domain-Specific Execution Patterns"
```

---

*Version 1.1 | February 2026 | Claude Opus 4.5*
*Field-tested across 4 audits, 4 risk domains, 2 auditor feedback sessions.*
*Recon first. Passes second. Synthesis last. Checkpoints carry the state.*
