# DEV BLOCKERS AUDIT - Tauri/Rust/SolidJS
## MCP-Enhanced Fast Audit with Jimmy's Workflow

**Version:** 1.0.0
**Focus:** Velocity blockers, build issues, API compliance
**Frequency:** Daily (after major coding sessions), before PRs

---

## PHILOSOPHY

### Ultrathink: Measure Twice, Cut Once

**BEFORE you scan:** Think about what you're looking for
**BEFORE you record:** Verify the finding exists
**BEFORE you report:** Confirm with MCP documentation

This is NOT a "find everything" audit. This is a "find what's blocking us NOW" audit.

### Jimmy's Workflow

Every finding MUST pass through:
```
🔴 RED (Scan)       → Execute search, gather evidence
🟢 GREEN (Verify)   → Validate finding, check MCP docs
🔵 CHECKPOINT (Gate) → Record ONLY verified findings
```

**Zero hallucinated findings.** If you can't prove it, don't report it.

---

## MCP TOOLS AVAILABLE

You have access to specialized RAG search tools. **USE THEM** to verify findings.

### Tauri & CrabNebula Documentation
```
Tool: mcp__tauri-rag__tauri_dev_search
Query: "search for [topic]"
```
**Use for:**
- Tauri 2.x API patterns
- Deprecated API verification
- Capabilities/permissions
- CSP configuration
- Plugin architecture
- `#[tauri::command]` patterns
- `State<T>`, `AppHandle` usage

### Vanilla Rust Documentation
```
Tool: mcp__rust-rag__rust_dev_search
Query: "search for [topic]"
```
**Use for:**
- Core Rust patterns
- Error handling (Result, Option, thiserror, anyhow)
- Async patterns (Tokio, futures)
- Memory safety concerns
- Serde serialization
- Testing patterns

### MCP Verification Pattern
```
🔴 Find potential issue in code
🟢 Search MCP: mcp__tauri-rag__tauri_dev_search "tauri 2 [api name]"
🔵 Record finding with mcp_verified: true/false
```

---

## PHASE 1: RECON (5 minutes)

### 🔴 SCAN: Quick Metrics

```bash
# File counts
find apps/web/src -name "*.ts" -o -name "*.tsx" | wc -l
find apps/desktop/src -name "*.rs" | wc -l

# Test coverage indicator
find . -name "*.test.*" -o -name "*.spec.*" | wc -l

# Quick health checks
grep -r "console.log" apps/web/src --include="*.ts" --include="*.tsx" | wc -l
grep -r "TODO\|FIXME" apps/web/src --include="*.ts" --include="*.tsx" | wc -l
grep -r "any" apps/web/src --include="*.ts" --include="*.tsx" | wc -l
```

### 🟢 VERIFY: Assess Results

| Metric | Healthy | Warning | Critical |
|--------|---------|---------|----------|
| Test ratio | >0.3 | 0.1-0.3 | <0.1 |
| Console.logs | <10 | 10-50 | >50 |
| TODOs | <5 | 5-20 | >20 |
| `any` types | 0 | 1-10 | >10 |

### 🔵 CHECKPOINT: Recon Complete

Record baseline metrics before proceeding.

---

## PHASE 2: BLOCKERS (25-35 minutes)

### BLOCKER 1: Tauri 2.x Compliance (10 min)

#### 🔴 SCAN: Deprecated APIs

```bash
# Check for Tauri 1.x deprecated patterns
grep -rn "tauri::api::" apps/desktop/src/
grep -rn "get_window()" apps/desktop/src/
grep -rn "Menu::" apps/desktop/src/ | grep -v "tauri::menu::"

# Check capabilities
ls apps/desktop/capabilities/ 2>/dev/null || echo "MISSING: capabilities directory"

# Check CSP
grep -n '"csp"' apps/desktop/tauri.conf.json
```

#### 🟢 VERIFY: MCP Cross-Reference

For each potential deprecated API found:
```
mcp__tauri-rag__tauri_dev_search "tauri 2 migration [api name]"
```

**Verify against MCP:**
- `tauri::api::process` → Should use `tauri-plugin-shell`
- `get_window()` → Should be `get_webview_window()`
- `Menu::new()` → Should be `tauri::menu::MenuBuilder`

#### 🔵 CHECKPOINT: Tauri Compliance

| Check | Status | Evidence |
|-------|--------|----------|
| No deprecated APIs | ✅/❌ | [file:line or "clean"] |
| Capabilities present | ✅/❌ | [directory exists] |
| CSP configured | ✅/❌ | [not null] |
| Tauri 2.x plugins | ✅/❌ | [plugin list] |

---

### BLOCKER 2: Rust Backend Health (5 min)

#### 🔴 SCAN: Rust Issues

```bash
# Check for unwrap() abuse
grep -rn "\.unwrap()" apps/desktop/src/

# Check for proper error handling
grep -rn "Result<" apps/desktop/src/
grep -rn "anyhow\|thiserror" apps/desktop/

# Dead code detection
grep -rn "#\[allow(dead_code)\]" apps/desktop/src/

# Check if all modules are imported
grep -n "mod " apps/desktop/src/main.rs
```

#### 🟢 VERIFY: MCP Cross-Reference

```
mcp__rust-rag__rust_dev_search "rust error handling best practices"
mcp__rust-rag__rust_dev_search "tauri command error handling"
```

#### 🔵 CHECKPOINT: Rust Health

| Check | Status | Evidence |
|-------|--------|----------|
| No unwrap() in commands | ✅/❌ | [count or "clean"] |
| Result types used | ✅/❌ | [file:line] |
| No dead code | ✅/❌ | [file:line] |
| All modules imported | ✅/❌ | [missing modules] |

---

### BLOCKER 3: SolidJS Reactivity (5 min)

#### 🔴 SCAN: Reactivity Violations

```bash
# Signals outside reactive contexts (common mistake)
grep -rn "createSignal\|createStore" apps/web/src/ --include="*.tsx" | head -20

# Effect dependencies
grep -rn "createEffect" apps/web/src/ --include="*.tsx" | wc -l

# Batch usage
grep -rn "batch(" apps/web/src/ --include="*.tsx" | wc -l
```

#### 🟢 VERIFY: Pattern Check

**SolidJS Rules:**
- Signals read ONLY in reactive contexts (components, effects, memos)
- Event handlers are NOT reactive contexts
- `createEffect` for side effects
- `batch()` for multiple signal updates

#### 🔵 CHECKPOINT: Reactivity Health

| Check | Status | Evidence |
|-------|--------|----------|
| Signals in components | ✅/❌ | [violations] |
| Effects have deps | ✅/❌ | [count] |
| Batch for multi-update | ✅/❌ | [usage count] |

---

### BLOCKER 4: Build & Type Safety (5 min)

#### 🔴 SCAN: Type Issues

```bash
# Run type check
pnpm typecheck 2>&1 | tail -20

# Check for any types
grep -rn ": any" apps/web/src/ --include="*.ts" --include="*.tsx"
grep -rn "as any" apps/web/src/ --include="*.ts" --include="*.tsx"

# Check for ts-ignore
grep -rn "@ts-ignore\|@ts-expect-error" apps/web/src/
```

#### 🟢 VERIFY: Build Status

```bash
# Attempt build
pnpm build 2>&1 | grep -E "error|warning" | head -20
```

#### 🔵 CHECKPOINT: Build Health

| Check | Status | Evidence |
|-------|--------|----------|
| TypeScript clean | ✅/❌ | [error count] |
| No `any` abuse | ✅/❌ | [count] |
| No ts-ignore | ✅/❌ | [count] |
| Build succeeds | ✅/❌ | [status] |

---

### BLOCKER 5: Storage & Data (5 min)

#### 🔴 SCAN: Storage Issues

```bash
# localStorage usage
grep -rn "localStorage" apps/web/src/ | wc -l

# lastModified updates
grep -rn "lastModified" apps/web/src/ | wc -l

# Date serialization
grep -rn "toISOString\|new Date(" apps/web/src/ | head -10
```

#### 🟢 VERIFY: Storage Patterns

**Required Patterns:**
- `lastModified: new Date()` on every CashTable update
- Dates serialized as ISO strings for storage
- Cross-tab sync via `makePersisted`

#### 🔵 CHECKPOINT: Storage Health

| Check | Status | Evidence |
|-------|--------|----------|
| lastModified updated | ✅/❌ | [pattern present] |
| Date serialization | ✅/❌ | [pattern present] |
| Cross-tab sync | ✅/❌ | [makePersisted usage] |

---

## PHASE 3: REPORT (5 minutes)

### Output Format

```markdown
# DEV BLOCKERS AUDIT REPORT

**Date:** [YYYY-MM-DD]
**Duration:** [X] minutes
**Commit:** [hash]
**Branch:** [branch]

## 🔴 CRITICAL BLOCKERS (Fix Today)

1. **[BLOCKER]** [file:line] - [issue]
   - Evidence: [measurement/output]
   - MCP Verified: [yes/no]
   - Fix Priority: IMMEDIATE

## 🟡 HIGH PRIORITY (Fix This Week)

1. **[ISSUE]** [file:line] - [issue]
   - Evidence: [measurement]
   - MCP Verified: [yes/no]

## 📊 METRICS

| Metric | Value | Status |
|--------|-------|--------|
| Tauri 2.x Compliance | [%] | 🔴/🟡/🟢 |
| Type Safety | [%] | 🔴/🟡/🟢 |
| Test Coverage | [%] | 🔴/🟡/🟢 |
| Build Status | [pass/fail] | 🔴/🟢 |

## 🎯 TOP 3 PRIORITIES

1. [Most critical blocker]
2. [Second priority]
3. [Third priority]

---
*Audit complete. Findings verified via MCP where applicable.*
```

---

## REMEMBER

- **Ultrathink:** Measure twice, cut once
- **MCP First:** Verify Tauri/Rust findings against documentation
- **Evidence Required:** Every finding needs file:line
- **No Hallucinations:** If you can't prove it, don't report it
- **Jimmy's Workflow:** 🔴 → 🟢 → 🔵 for every finding
- **Time-Boxed:** 30-45 minutes max

---

**NOT:** Comprehensive risk assessment | One-time audit | Blame tool
**IS:** Velocity optimizer | Weekly health check | Blocker identifier
