# FULL PRODUCTION AUDIT - Tauri/Rust/SolidJS
## MCP-Enhanced Comprehensive Audit with Jimmy's Workflow

**Version:** 1.0.0
**Focus:** Complete risk assessment, security, architecture
**Frequency:** Weekly, before releases

---

## PHILOSOPHY

### Ultrathink: Measure Twice, Cut Once

This is a COMPREHENSIVE audit. Take your time. Think deeply before each phase.

**BEFORE scanning:** Understand what you're looking for and why
**BEFORE recording:** Verify EVERY finding with evidence
**BEFORE reporting:** Cross-reference with MCP documentation

### Jimmy's Workflow: RED → GREEN → CHECKPOINT

Every analytical lens follows this pattern:

```
🔴 RED (Implement)    → Execute scans, gather raw data
🟢 GREEN (Validate)   → Verify findings, check MCP docs, prove existence
🔵 CHECKPOINT (Gate)  → Record ONLY verified findings, block if unverified
```

**CRITICAL:** Never proceed to next lens until current lens reaches 🔵 CHECKPOINT.

---

## MCP TOOLS - YOUR VERIFICATION ENGINE

You have specialized RAG tools. **USE THEM EXTENSIVELY** to verify findings.

### Tauri & CrabNebula Documentation
```
Tool: mcp__tauri-rag__tauri_dev_search
```

**Query Examples:**
- `"tauri 2 migration deprecated apis"`
- `"tauri capabilities permissions"`
- `"tauri csp content security policy"`
- `"tauri command state management"`
- `"tauri plugin shell process"`
- `"crabnebula devtools debugging"`

**Use for:**
- Tauri 2.x API verification
- Deprecated API identification
- Capabilities/permissions requirements
- CSP configuration best practices
- Plugin architecture patterns
- Security recommendations
- Desktop/mobile compatibility

### Vanilla Rust Documentation
```
Tool: mcp__rust-rag__rust_dev_search
```

**Query Examples:**
- `"rust error handling Result Option"`
- `"rust async tokio patterns"`
- `"rust memory safety ownership"`
- `"rust thiserror anyhow"`
- `"rust serde serialization"`
- `"rust testing mockall"`

**Use for:**
- Memory safety patterns
- Error handling best practices
- Async/Tokio patterns
- Serialization with Serde
- Testing strategies
- Performance patterns

### MCP Verification Protocol

```
🔴 Find potential issue in code
   ↓
🟢 Query MCP: mcp__tauri-rag__tauri_dev_search "[relevant query]"
   ↓
🟢 Confirm finding matches MCP documentation
   ↓
🔵 Record with mcp_verified: true
```

**If MCP doesn't confirm:** Mark as `mcp_verified: false` and note manual verification method.

---

## PHASE 1: REPOSITORY INDEXING (15 minutes)

### 🔴 IMPLEMENT: Full Repository Scan

```bash
# Create audit workspace
mkdir -p /tmp/audit_$(date +%Y%m%d)
AUDIT_DIR="/tmp/audit_$(date +%Y%m%d)"

# Capture baseline
git rev-parse HEAD > $AUDIT_DIR/commit.txt
git branch --show-current > $AUDIT_DIR/branch.txt
date -u +"%Y-%m-%dT%H:%M:%SZ" > $AUDIT_DIR/started.txt

# Index all source files
find apps/web/src -type f \( -name "*.ts" -o -name "*.tsx" \) > $AUDIT_DIR/web_files.txt
find apps/desktop/src -type f -name "*.rs" > $AUDIT_DIR/rust_files.txt
find apps/sync-server -type f -name "*.ts" > $AUDIT_DIR/server_files.txt

# Count metrics
echo "Web files: $(wc -l < $AUDIT_DIR/web_files.txt)"
echo "Rust files: $(wc -l < $AUDIT_DIR/rust_files.txt)"
echo "Server files: $(wc -l < $AUDIT_DIR/server_files.txt)"

# Line counts
wc -l $(cat $AUDIT_DIR/web_files.txt) | tail -1
wc -l $(cat $AUDIT_DIR/rust_files.txt) | tail -1

# Test file count
find . -name "*.test.*" -o -name "*.spec.*" | wc -l > $AUDIT_DIR/test_count.txt

# Dependencies
cat apps/web/package.json | jq '.dependencies | keys | length'
cat apps/web/package.json | jq '.devDependencies | keys | length'
```

### 🟢 VALIDATE: Verify Indexing

```bash
# Verify all counts are non-zero
[ $(wc -l < $AUDIT_DIR/web_files.txt) -gt 0 ] && echo "✅ Web files indexed"
[ $(wc -l < $AUDIT_DIR/rust_files.txt) -gt 0 ] && echo "✅ Rust files indexed"

# Verify commit captured
[ -s $AUDIT_DIR/commit.txt ] && echo "✅ Commit recorded: $(cat $AUDIT_DIR/commit.txt)"

# Spot check: verify file paths exist
head -3 $AUDIT_DIR/web_files.txt | xargs ls -la
```

### 🔵 CHECKPOINT: Repository Indexed

**Status:** 🔵 COMPLETE

| Metric | Value |
|--------|-------|
| Web Source Files | [N] |
| Rust Source Files | [N] |
| Test Files | [N] |
| Test/Source Ratio | [N]% |
| Total LOC | [N] |
| Commit | [hash] |
| Branch | [name] |

**Proceed to Phase 2:** ✅

---

## PHASE 2: ANALYTICAL LENSES (8 Sequential Checkpoints)

### LENS 1: CODE COMPLEXITY & QUALITY (15 min)

#### 🔴 IMPLEMENT: Complexity Scan

```bash
# Large files (>500 lines)
for f in $(cat $AUDIT_DIR/web_files.txt); do
  lines=$(wc -l < "$f")
  [ $lines -gt 500 ] && echo "$f: $lines lines"
done > $AUDIT_DIR/large_files.txt

# Deep nesting (>4 levels)
grep -rn "^\s\{16,\}" apps/web/src --include="*.tsx" > $AUDIT_DIR/deep_nesting.txt

# Console.logs
grep -rn "console\.\(log\|warn\|error\)" apps/web/src --include="*.ts" --include="*.tsx" > $AUDIT_DIR/console_logs.txt

# TODO/FIXME comments
grep -rn "TODO\|FIXME\|HACK\|XXX" apps/web/src > $AUDIT_DIR/todos.txt

# Magic numbers
grep -rn "[^a-zA-Z0-9_]\d\{3,\}[^a-zA-Z0-9_]" apps/web/src --include="*.ts" --include="*.tsx" | grep -v "test\|spec" > $AUDIT_DIR/magic_numbers.txt
```

#### 🟢 VALIDATE: Verify Findings

For each large file found:
- Verify line count manually: `wc -l [file]`
- Identify primary responsibility
- Note if genuinely complex or needs splitting

For console.logs:
- Count total: `wc -l < $AUDIT_DIR/console_logs.txt`
- Identify data exposure risks

#### 🔵 CHECKPOINT: Complexity Analysis

| Finding | Count | Severity | Evidence |
|---------|-------|----------|----------|
| Large files (>500 LOC) | [N] | HIGH | $AUDIT_DIR/large_files.txt |
| Deep nesting (>4) | [N] | MEDIUM | $AUDIT_DIR/deep_nesting.txt |
| Console.logs | [N] | LOW | $AUDIT_DIR/console_logs.txt |
| TODOs/FIXMEs | [N] | INFO | $AUDIT_DIR/todos.txt |

---

### LENS 2: TAURI 2.x COMPLIANCE (20 min) ⭐ MCP-HEAVY

#### 🔴 IMPLEMENT: Tauri API Scan

```bash
# Deprecated Tauri 1.x APIs
grep -rn "tauri::api::" apps/desktop/src/ > $AUDIT_DIR/deprecated_tauri_api.txt
grep -rn "get_window()" apps/desktop/src/ > $AUDIT_DIR/deprecated_get_window.txt
grep -rn "Menu::new\|Menu::with_items" apps/desktop/src/ > $AUDIT_DIR/deprecated_menu.txt

# Capabilities check
ls -la apps/desktop/capabilities/ 2>&1 > $AUDIT_DIR/capabilities_check.txt

# CSP configuration
grep -A5 '"security"' apps/desktop/tauri.conf.json > $AUDIT_DIR/csp_config.txt
grep '"csp"' apps/desktop/tauri.conf.json >> $AUDIT_DIR/csp_config.txt

# Plugin usage
grep -rn "tauri_plugin_" apps/desktop/src/ > $AUDIT_DIR/plugins.txt
grep -rn "@tauri-apps/plugin-" apps/web/src/ > $AUDIT_DIR/frontend_plugins.txt

# Icon files
ls -la apps/desktop/icons/ > $AUDIT_DIR/icons.txt
find apps/desktop/icons -size 0 > $AUDIT_DIR/empty_icons.txt
```

#### 🟢 VALIDATE: MCP Cross-Reference

**For each deprecated API found:**

```
mcp__tauri-rag__tauri_dev_search "tauri 2 migration [api name]"
```

**Specific Verifications:**

1. `tauri::api::process` deprecation:
   ```
   mcp__tauri-rag__tauri_dev_search "tauri 2 process api shell plugin"
   ```
   Expected: Should use `tauri-plugin-shell` instead

2. `get_window()` deprecation:
   ```
   mcp__tauri-rag__tauri_dev_search "tauri 2 get_window get_webview_window"
   ```
   Expected: Renamed to `get_webview_window()`

3. Menu API changes:
   ```
   mcp__tauri-rag__tauri_dev_search "tauri 2 menu MenuBuilder"
   ```
   Expected: Use `tauri::menu::MenuBuilder`

4. Capabilities requirement:
   ```
   mcp__tauri-rag__tauri_dev_search "tauri 2 capabilities permissions"
   ```
   Expected: `capabilities/` directory with JSON permission files

5. CSP configuration:
   ```
   mcp__tauri-rag__tauri_dev_search "tauri csp content security policy"
   ```
   Expected: CSP should NOT be null

#### 🔵 CHECKPOINT: Tauri Compliance

| Check | Status | MCP Verified | Evidence |
|-------|--------|--------------|----------|
| No deprecated APIs | ✅/❌ | ✅/❌ | [file:line] |
| Capabilities present | ✅/❌ | ✅ | [directory status] |
| CSP configured | ✅/❌ | ✅ | [value] |
| Correct plugins | ✅/❌ | ✅ | [plugin list] |
| Valid icons | ✅/❌ | N/A | [file sizes] |

---

### LENS 3: RUST BACKEND QUALITY (15 min) ⭐ MCP-HEAVY

#### 🔴 IMPLEMENT: Rust Analysis

```bash
# Error handling patterns
grep -rn "\.unwrap()" apps/desktop/src/ > $AUDIT_DIR/unwraps.txt
grep -rn "\.expect(" apps/desktop/src/ > $AUDIT_DIR/expects.txt
grep -rn "Result<" apps/desktop/src/ > $AUDIT_DIR/results.txt
grep -rn "Option<" apps/desktop/src/ > $AUDIT_DIR/options.txt

# Error libraries
grep -rn "thiserror\|anyhow" apps/desktop/ > $AUDIT_DIR/error_libs.txt

# Async patterns
grep -rn "async fn\|\.await" apps/desktop/src/ > $AUDIT_DIR/async_usage.txt
grep -rn "tokio::" apps/desktop/src/ > $AUDIT_DIR/tokio_usage.txt

# Dead code
grep -rn "#\[allow(dead_code)\]" apps/desktop/src/ > $AUDIT_DIR/dead_code.txt

# Unsafe blocks
grep -rn "unsafe" apps/desktop/src/ > $AUDIT_DIR/unsafe_blocks.txt

# Module structure
grep -n "^mod \|^pub mod " apps/desktop/src/main.rs > $AUDIT_DIR/modules.txt
```

#### 🟢 VALIDATE: MCP Cross-Reference

**Error Handling:**
```
mcp__rust-rag__rust_dev_search "rust error handling Result unwrap"
```

**Async Patterns:**
```
mcp__rust-rag__rust_dev_search "rust async tokio tauri"
```

**Memory Safety:**
```
mcp__rust-rag__rust_dev_search "rust unsafe memory safety"
```

#### 🔵 CHECKPOINT: Rust Quality

| Check | Count | Severity | MCP Verified |
|-------|-------|----------|--------------|
| unwrap() usage | [N] | HIGH | ✅ |
| Result types | [N] | INFO | ✅ |
| Dead code markers | [N] | MEDIUM | N/A |
| Unsafe blocks | [N] | CRITICAL | ✅ |
| Async patterns | [N] | INFO | ✅ |

---

### LENS 4: SECURITY ANALYSIS (20 min)

#### 🔴 IMPLEMENT: Security Scan

```bash
# Credential patterns
grep -rn "API_KEY\|SECRET\|PASSWORD\|TOKEN" apps/ --include="*.ts" --include="*.tsx" --include="*.rs" > $AUDIT_DIR/credentials.txt

# Hardcoded strings (potential secrets)
grep -rn "sk_\|pk_\|api_" apps/web/src/ > $AUDIT_DIR/potential_keys.txt

# localStorage sensitive data
grep -rn "localStorage\.\(setItem\|getItem\)" apps/web/src/ | grep -i "token\|key\|secret\|password" > $AUDIT_DIR/sensitive_storage.txt

# XSS risks
grep -rn "innerHTML\|dangerouslySetInnerHTML" apps/web/src/ > $AUDIT_DIR/xss_risks.txt

# SQL/injection patterns (if applicable)
grep -rn "query\|execute" apps/ --include="*.rs" | grep -v "test" > $AUDIT_DIR/query_patterns.txt

# CSP status (from Lens 2)
cat $AUDIT_DIR/csp_config.txt
```

#### 🟢 VALIDATE: MCP Cross-Reference

**CSP Security:**
```
mcp__tauri-rag__tauri_dev_search "tauri security csp xss"
```

**Storage Security:**
```
mcp__tauri-rag__tauri_dev_search "tauri secure storage credentials"
```

#### 🔵 CHECKPOINT: Security Analysis

| Risk | Found | Severity | MCP Verified |
|------|-------|----------|--------------|
| Exposed credentials | [N] | CRITICAL | N/A |
| CSP disabled | ✅/❌ | HIGH | ✅ |
| XSS vulnerabilities | [N] | HIGH | ✅ |
| Sensitive localStorage | [N] | MEDIUM | ✅ |

---

### LENS 5: TESTING INTEGRITY (15 min)

#### 🔴 IMPLEMENT: Test Analysis

```bash
# Test file inventory
find . -name "*.test.*" -o -name "*.spec.*" > $AUDIT_DIR/test_files.txt

# Test coverage (if configured)
pnpm test --coverage 2>&1 | tee $AUDIT_DIR/coverage.txt || echo "Coverage not configured"

# Assertion density
for f in $(cat $AUDIT_DIR/test_files.txt 2>/dev/null); do
  assertions=$(grep -c "expect\|assert" "$f" 2>/dev/null || echo 0)
  echo "$f: $assertions assertions"
done > $AUDIT_DIR/assertion_density.txt

# Critical paths untested
ls apps/web/src/utils/*.ts | while read f; do
  base=$(basename "$f" .ts)
  test_exists=$(find . -name "*${base}*.test.*" | wc -l)
  [ $test_exists -eq 0 ] && echo "UNTESTED: $f"
done > $AUDIT_DIR/untested_utils.txt
```

#### 🟢 VALIDATE: Test Quality

For each test file:
- Verify assertions are meaningful (not just `toBeDefined`)
- Check for proper isolation
- Identify mocking quality

#### 🔵 CHECKPOINT: Testing Integrity

| Metric | Value | Target | Status |
|--------|-------|--------|--------|
| Test files | [N] | >10 | 🔴/🟡/🟢 |
| Test/Source ratio | [N]% | >20% | 🔴/🟡/🟢 |
| Line coverage | [N]% | >60% | 🔴/🟡/🟢 |
| Untested utils | [N] | 0 | 🔴/🟡/🟢 |

---

### LENS 6: SOLIDJS REACTIVITY (15 min)

#### 🔴 IMPLEMENT: Reactivity Analysis

```bash
# Signal usage
grep -rn "createSignal" apps/web/src/ --include="*.tsx" > $AUDIT_DIR/signals.txt

# Store usage
grep -rn "createStore" apps/web/src/ --include="*.tsx" > $AUDIT_DIR/stores.txt

# Effect usage
grep -rn "createEffect" apps/web/src/ --include="*.tsx" > $AUDIT_DIR/effects.txt

# Memo usage
grep -rn "createMemo" apps/web/src/ --include="*.tsx" > $AUDIT_DIR/memos.txt

# Batch usage
grep -rn "batch(" apps/web/src/ --include="*.tsx" > $AUDIT_DIR/batches.txt

# Potential reactivity violations (signals in event handlers without proper handling)
grep -rn "onClick.*=.*().*=>" apps/web/src/ --include="*.tsx" | head -20 > $AUDIT_DIR/click_handlers.txt
```

#### 🟢 VALIDATE: Reactivity Patterns

**SolidJS Rules:**
1. Signals read ONLY in reactive contexts
2. Event handlers are NOT reactive contexts
3. `createEffect` for side effects
4. `createMemo` for derived state
5. `batch()` for multiple updates

Review each signal usage for proper reactive context.

#### 🔵 CHECKPOINT: Reactivity Health

| Pattern | Count | Proper Usage |
|---------|-------|--------------|
| Signals | [N] | ✅/❌ |
| Stores | [N] | ✅/❌ |
| Effects | [N] | ✅/❌ |
| Memos | [N] | ✅/❌ |
| Batches | [N] | ✅/❌ |

---

### LENS 7: DEPENDENCY ANALYSIS (15 min)

#### 🔴 IMPLEMENT: Dependency Scan

```bash
# Security audit
pnpm audit 2>&1 > $AUDIT_DIR/npm_audit.txt

# Outdated packages
pnpm outdated 2>&1 > $AUDIT_DIR/outdated.txt

# Dependency count
cat apps/web/package.json | jq '.dependencies | length' > $AUDIT_DIR/dep_count.txt
cat apps/web/package.json | jq '.devDependencies | length' >> $AUDIT_DIR/dep_count.txt

# Unused dependencies (if depcheck available)
npx depcheck apps/web 2>&1 > $AUDIT_DIR/unused_deps.txt || echo "depcheck not available"

# Duplicate utilities
grep -l "lodash\|underscore\|ramda" apps/web/package.json > $AUDIT_DIR/util_libs.txt

# Tauri package versions
grep "@tauri-apps" apps/web/package.json > $AUDIT_DIR/tauri_versions.txt
```

#### 🟢 VALIDATE: MCP Cross-Reference

**Tauri versions:**
```
mcp__tauri-rag__tauri_dev_search "tauri 2 package versions compatibility"
```

#### 🔵 CHECKPOINT: Dependency Health

| Check | Status | Severity |
|-------|--------|----------|
| Security vulnerabilities | [N] critical, [N] high | 🔴/🟡/🟢 |
| Outdated packages | [N] major behind | 🔴/🟡/🟢 |
| Unused dependencies | [N] | LOW |
| Tauri version correct | ✅/❌ | HIGH |

---

### LENS 8: ARCHITECTURE & HYGIENE (15 min)

#### 🔴 IMPLEMENT: Architecture Scan

```bash
# File organization
ls -la apps/web/src/
ls -la apps/web/src/components/ | wc -l
ls -la apps/web/src/utils/ | wc -l

# Import consistency
grep -rn "from '\.\." apps/web/src/ --include="*.tsx" | wc -l > $AUDIT_DIR/relative_imports.txt
grep -rn "from '@/" apps/web/src/ --include="*.tsx" | wc -l > $AUDIT_DIR/absolute_imports.txt

# Naming consistency
ls apps/web/src/components/*.tsx | xargs -I{} basename {} | grep -v "^[A-Z]" > $AUDIT_DIR/naming_violations.txt

# Dead files
find apps/web/src -name "*.tsx" | while read f; do
  base=$(basename "$f" .tsx)
  imports=$(grep -r "import.*$base" apps/web/src --include="*.tsx" | wc -l)
  [ $imports -eq 0 ] && [ "$base" != "App" ] && echo "Potentially dead: $f"
done > $AUDIT_DIR/dead_files.txt

# Storage patterns
grep -rn "lastModified" apps/web/src/ > $AUDIT_DIR/last_modified.txt
grep -rn "toISOString" apps/web/src/ > $AUDIT_DIR/date_serialization.txt
```

#### 🟢 VALIDATE: Pattern Consistency

Check for:
- Consistent use of absolute imports (`@/`)
- PascalCase component names
- camelCase utility names
- Proper date serialization
- lastModified always updated

#### 🔵 CHECKPOINT: Architecture Health

| Check | Status | Notes |
|-------|--------|-------|
| Absolute imports | [N]% | Target: >90% |
| Naming consistency | ✅/❌ | [violations] |
| Date patterns | ✅/❌ | [issues] |
| lastModified | ✅/❌ | [missing] |

---

## PHASE 3: FINDING DEDUPLICATION (10 min)

### 🔴 IMPLEMENT: Consolidate Findings

```python
# Pseudocode for deduplication
findings = []
for lens in range(1, 9):
    findings.extend(lens_findings[lens])

# Remove duplicates by file:line:type
seen = {}
unique = []
for f in findings:
    key = f"{f.file}:{f.line}:{f.type}"
    if key not in seen:
        seen[key] = f
        unique.append(f)
    elif f.severity > seen[key].severity:
        seen[key] = f  # Keep higher severity
```

### 🟢 VALIDATE: Verify Deduplication

- Count raw findings vs unique findings
- Verify no legitimate findings were removed
- Check severity assignments are correct

### 🔵 CHECKPOINT: Findings Consolidated

| Metric | Count |
|--------|-------|
| Raw findings | [N] |
| Unique findings | [N] |
| Duplicates removed | [N] |

---

## PHASE 4: REPORT GENERATION (15 min)

### Output: AUDIT_RESULTS.md

```markdown
# CODEBASE AUDIT RESULTS

**Timestamp**: [ISO 8601]
**Repository**: /path/to/your/project
**Commit**: [hash]
**Branch**: [branch]
**Version**: [increment]
**Model**: Claude [version]
**Methodology**: Jimmy's Workflow + 8 Analytical Lenses
**MCP Knowledge Base**: tauri-rag, rust-rag

---

## EXECUTIVE SUMMARY

### Verdict

| Category | Status | Severity |
|----------|--------|----------|
| Tauri 2.x Compliance | [status] | [severity] |
| Rust Backend | [status] | [severity] |
| Security Posture | [status] | [severity] |
| Test Coverage | [N]% | [severity] |
| SolidJS Reactivity | [status] | [severity] |

### Severity Distribution

| Severity | Count |
|----------|-------|
| CRITICAL | [N] |
| HIGH | [N] |
| MEDIUM | [N] |
| LOW | [N] |
| INFO | [N] |
| **TOTAL** | **[N]** |

### Top 5 Issues Requiring Attention

1. **[SEVERITY]** - [file:line] - [issue] (MCP: ✅/❌)
2. ...

---

## DETAILED FINDINGS BY LENS

### Lens 1: Code Complexity
[findings table]

### Lens 2: Tauri 2.x Compliance
[findings table with MCP verification]

### Lens 3: Rust Backend Quality
[findings table with MCP verification]

### Lens 4: Security Analysis
[findings table]

### Lens 5: Testing Integrity
[findings table]

### Lens 6: SolidJS Reactivity
[findings table]

### Lens 7: Dependency Analysis
[findings table]

### Lens 8: Architecture & Hygiene
[findings table]

---

## METRICS DASHBOARD

| Metric | Current | Previous | Change | Status |
|--------|---------|----------|--------|--------|
| Total LOC | [N] | [N] | [+/-] | - |
| Test Coverage | [N]% | [N]% | [+/-] | 🔴/🟡/🟢 |
| Tauri Compliance | [N]% | [N]% | [+/-] | 🔴/🟡/🟢 |
| Security Issues | [N] | [N] | [+/-] | 🔴/🟡/🟢 |

---

## VERIFICATION SUMMARY

| Metric | Value |
|--------|-------|
| Total Findings | [N] |
| MCP Verified | [N] |
| Manual Verified | [N] |
| False Positives Removed | [N] |

---

*Audit complete. All findings verified via Jimmy's Workflow checkpoints.*
*MCP verification used for Tauri and Rust findings.*
```

### Output: audit_log.json

```json
{
  "audit": {
    "version": "1.0.0",
    "methodology": "Jimmy's Workflow + 8 Analytical Lenses",
    "started": "[ISO 8601]",
    "completed": "[ISO 8601]",
    "repository": "/path/to/your/project",
    "commit": "[hash]",
    "branch": "[branch]",
    "model": "Claude [version]",
    "mcp_knowledge_bases": ["tauri-rag", "rust-rag"],
    "status": "COMPLETE"
  },
  "metrics": { ... },
  "phases": { ... },
  "findings_summary": { ... },
  "findings": [ ... ],
  "verification": { ... }
}
```

---

## REMEMBER

- **Ultrathink:** Measure twice, cut once - think before every action
- **MCP First:** Verify ALL Tauri/Rust findings against documentation
- **Evidence Required:** Every finding needs file:line and measurement
- **No Hallucinations:** If you can't prove it, don't report it
- **Jimmy's Workflow:** 🔴 → 🟢 → 🔵 for EVERY lens
- **Checkpoint Gates:** Never proceed on unverified findings
- **Time Investment:** 2-3 hours is appropriate for thorough analysis

---

**NOT:** Quick scan | Superficial review | Blame tool
**IS:** Comprehensive risk assessment | Security audit | Architecture review | Monthly health check
