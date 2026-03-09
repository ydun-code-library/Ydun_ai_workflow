---
document_type: pattern
name: JSON Sidecar Pattern
version: "1.0"
updated: "2026-03"
primary_use: structured_output_alongside_human_readable
secondary_use: ci_cd_integration_audit_tracking

load_when:
  - designing audit MAPs that need machine-readable output
  - building CI/CD pipelines that consume audit findings
  - tracking findings across audit runs
  - any AI task where structured data is needed alongside prose

skip_when:
  - quick one-off questions to AI
  - pure documentation tasks with no structured data needs
---

# JSON Sidecar Pattern

## What It Is

The JSON sidecar pattern instructs an AI assistant to produce **two outputs simultaneously**:

1. **Human-readable**: Markdown report, prose analysis, narrative findings
2. **Machine-readable**: Structured JSON file written alongside the markdown

The AI writes both during the same task. No post-processing needed.

## Why People Don't Know About This

Most people treat AI output as "the response" — whatever appears in the conversation. They don't realise you can instruct the AI to:

- Write structured data to a file while also explaining it in prose
- Append JSON objects to a growing file as it works through a task
- Maintain a consistent schema across dozens of findings
- Produce output that feeds directly into tools, dashboards, and CI/CD

It's a prompt instruction, not a feature. You just tell the AI to do it.

---

## The Core Instruction

Add this to any audit MAP, prompt, or task instruction:

```markdown
## Output Requirements

For each finding, produce TWO outputs:

1. **Human-readable**: Append the finding in markdown to `checkpoints/passN-checkpoint.md`
2. **Machine-readable**: Append a JSON object to `checkpoints/passN-findings.json`

Write the JSON file as an array of objects. Start with `[` on first finding, add `,` between objects, close with `]` at checkpoint completion.
```

---

## Audit Finding Schema

```json
{
  "id": "SEC-001",
  "lens": "security",
  "pass": 1,
  "severity": "HIGH",
  "confidence": "MEDIUM",
  "decision": "SQL injection via string concatenation in user endpoint",
  "file": "src/api/users.ts",
  "line": 47,
  "evidence": "query = 'SELECT * FROM users WHERE id=' + userId",
  "reasoning": [
    "User input reaches SQL query directly without sanitisation",
    "No parameterised query or ORM abstraction in this code path"
  ],
  "alternatives_rejected": [
    "Considered whether ORM might sanitise — confirmed raw SQL usage via db.query()"
  ],
  "weaknesses": [
    "Only tested GET endpoint; POST endpoint uses same pattern but untested"
  ],
  "remediation_hint": "Use parameterised queries: db.query('SELECT * FROM users WHERE id = $1', [userId])",
  "domain_uplift": null,
  "deployment_modifier": null,
  "inherited_from_pass": null,
  "coi_flagged": true,
  "timestamp": "2026-03-06T14:30:00Z"
}
```

### Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `id` | string | Unique finding ID (e.g., SEC-001, CRYPTO-003) |
| `lens` | string | Which audit lens produced this finding |
| `pass` | number | Which audit pass (1, 2, 3...) |
| `severity` | enum | CRITICAL, HIGH, MEDIUM, LOW |
| `confidence` | enum | HIGH, MEDIUM, LOW |
| `decision` | string | What is wrong — one sentence |
| `file` | string | File path where the issue exists |
| `line` | number | Line number (0 if not applicable) |
| `evidence` | string | Code snippet or observable evidence |
| `reasoning` | string[] | Minimum 2 points explaining why this is a finding |
| `alternatives_rejected` | string[] | Minimum 1 alternative considered and ruled out |
| `weaknesses` | string[] | Minimum 1 thing this finding doesn't verify |
| `remediation_hint` | string | Direction for fix (not a full solution) |

### Optional Fields

| Field | Type | Description |
|-------|------|-------------|
| `domain_uplift` | object/null | If severity was uplifted: `{"from": "MEDIUM", "to": "HIGH", "reason": "financial"}` |
| `deployment_modifier` | object/null | If severity was adjusted for deployment: `{"from": "HIGH", "to": "MEDIUM", "reason": "private network"}` |
| `inherited_from_pass` | number/null | If carried forward from a prior pass |
| `coi_flagged` | boolean | Whether AI-auditing-AI conflict was flagged |
| `timestamp` | string | ISO 8601 timestamp |
| `attack_chain` | string/null | Chain ID if part of an attack chain (e.g., "CHAIN-001") |
| `positive_observation` | boolean | True if this is a "done correctly" note, not a finding |

---

## Checkpoint Summary Schema

At the end of each pass, also write a summary object:

```json
{
  "pass": 1,
  "pass_name": "Crypto Core",
  "lenses_executed": ["crypto_correctness", "zero_knowledge", "noise_protocol"],
  "findings_count": 12,
  "severity_distribution": {
    "CRITICAL": 2,
    "HIGH": 4,
    "MEDIUM": 5,
    "LOW": 1
  },
  "confidence_distribution": {
    "HIGH": 3,
    "MEDIUM": 7,
    "LOW": 2
  },
  "positive_observations": 4,
  "compaction_occurred": false,
  "human_review_required": true,
  "human_review_reason": "Cryptographic findings require human cryptographer sign-off",
  "timestamp": "2026-03-06T15:45:00Z"
}
```

---

## Beyond Audits: Other Uses

The JSON sidecar pattern works for any AI task that produces structured findings:

### Compliance Checks

```json
{
  "id": "GDPR-001",
  "regulation": "GDPR",
  "article": "Art. 17 — Right to erasure",
  "status": "NON_COMPLIANT",
  "evidence": "No deletion endpoint exists for user data",
  "file": "src/api/users.ts",
  "remediation": "Add DELETE /api/users/:id endpoint with cascade deletion"
}
```

### Code Review Findings

```json
{
  "id": "CR-001",
  "type": "suggestion",
  "category": "performance",
  "file": "src/services/search.ts",
  "line": 89,
  "current": "Array.filter().map() creates intermediate array",
  "suggested": "Single reduce() pass or for-loop",
  "impact": "Reduces allocations on large datasets"
}
```

### Test Gap Analysis

```json
{
  "id": "GAP-001",
  "untested_function": "processPayment",
  "file": "src/services/payment.ts",
  "risk": "HIGH",
  "reason": "Financial operation with no unit tests",
  "suggested_tests": [
    "Happy path: valid payment succeeds",
    "Invalid card: returns error, no charge",
    "Idempotency: duplicate request doesn't double-charge"
  ]
}
```

### Documentation Drift

```json
{
  "id": "DRIFT-001",
  "doc_file": "README.md",
  "doc_line": 45,
  "claim": "Run `npm start` to launch the server",
  "reality": "package.json uses `bun run dev`, npm start is not defined",
  "severity": "MEDIUM"
}
```

### Migration/Upgrade Tracking

```json
{
  "id": "MIG-001",
  "dependency": "express",
  "current_version": "4.18.2",
  "target_version": "5.0.0",
  "breaking_changes": [
    "req.host no longer includes port",
    "app.del() removed — use app.delete()"
  ],
  "files_affected": ["src/server.ts", "src/middleware/cors.ts"],
  "estimated_effort": "LOW"
}
```

---

## Implementation Checklist

When adding JSON sidecar to an audit MAP:

- [ ] JSON schema defined in the MAP's output requirements section
- [ ] File path specified (e.g., `checkpoints/passN-findings.json`)
- [ ] Agent instructed to write JSON incrementally (after each finding, not at end)
- [ ] Schema includes all Finding Contract fields
- [ ] Optional fields documented (agent knows what's optional)
- [ ] Summary object written at pass completion
- [ ] Human told where to find JSON output

---

## Tips

- **Tell the AI explicitly**: "Write each finding as a JSON object to findings.json AND as markdown to checkpoint.md"
- **Incremental writes**: "Append after each finding" prevents data loss on context compaction
- **Schema enforcement**: Include the schema in the prompt — the AI follows it consistently
- **Validation**: After the audit, you can validate JSON with `jq . findings.json` or any JSON validator
- **Aggregation**: For multi-pass audits, combine: `jq -s 'add' pass1-findings.json pass2-findings.json > all-findings.json`

---

*Version 1.0 | March 2026*
*The pattern is simple: tell the AI to write JSON. It does.*
