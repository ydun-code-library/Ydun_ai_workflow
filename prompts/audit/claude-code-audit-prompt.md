# CODEBASE AUDIT PROMPT FOR CLAUDE CODE (OPUS 4.1)

## CONTEXT
You are performing a comprehensive codebase audit using Claude Code's capabilities. You will analyze the repository through multiple analytical lenses sequentially, maintaining state across all analyses to produce a comprehensive audit report.

## CORE DIRECTIVES
- ANALYZE: Every file, every line, every configuration
- HONESTY: Report issues without softening - brutal transparency required
- EVIDENCE: Every finding must include file:line reference and objective measurement
- NO_FIXES: Identify problems only - zero solution suggestions

## ANALYTICAL FRAMEWORK

### PHASE 1: REPOSITORY INDEXING
```yaml
actions:
  1. map_structure: 
     - find . -type f -name "*.{js,ts,py,java,go,rs,cpp,c,cs,rb,php,swift}"
     - identify primary languages
     - count total files and lines
     - detect framework/platform
  
  2. read_configurations:
     - package.json, requirements.txt, pom.xml, go.mod, Cargo.toml
     - .env.example, config files
     - CI/CD configurations
     - build scripts
  
  3. establish_baseline:
     - check for existing AUDIT_RESULTS.md
     - note current commit hash
     - timestamp audit start
```

### PHASE 2: SEQUENTIAL DEEP ANALYSIS

Execute each analytical lens in order, accumulating findings:

#### LENS 1: CODE COMPLEXITY & QUALITY
```python
for each source_file:
    measure:
        - function_length: flag if >20 lines
        - cyclomatic_complexity: flag if >10
        - nesting_depth: flag if >3
        - parameter_count: flag if >3
        - class_responsibilities: count distinct concerns
    
    detect:
        - duplicate_code_blocks: hash similarity >0.8
        - dead_code: unreachable or never called
        - magic_numbers: literals without constants
        - console_logs: especially with data exposure
        - commented_code: version control antipattern
        - empty_catches: swallowed exceptions
    
    ai_specific_checks:
        - verbose_solutions: LOC ratio vs problem complexity
        - inconsistent_naming: edit distance between similar vars
        - redundant_implementations: multiple solutions same problem
        - hallucinated_complexity: overengineered simple tasks
```

#### LENS 2: DOCUMENTATION VERIFICATION
```python
for each doc_file:
    verify:
        - README.md:
            * run setup instructions in order
            * execute code examples
            * validate prerequisites listed
        
        - API_DOCS:
            * match endpoints against actual routes
            * verify request/response schemas
            * check authentication requirements
        
        - CODE_COMMENTS:
            * semantic similarity to implementation
            * check for "wishful documentation"
            * flag TODO/FIXME without context
        
    detect_lies:
        - words: ["will", "should", "planned", "upcoming"]
        - missing_features: documented but not implemented
        - wrong_parameters: docs vs actual function signatures
```

#### LENS 3: TESTING INTEGRITY
```python
analyze_test_suite:
    coverage:
        - run coverage tool for language
        - identify uncovered critical paths
        - check branch coverage
    
    quality_indicators:
        - test_names: behavioral description present?
        - assertions: present and meaningful?
        - isolation: shared state between tests?
        - mocking: over-mocked or under-mocked?
    
    tdd_evidence:
        - git log analysis: tests committed before implementation?
        - complexity_comparison: tests simpler than code?
        - failure_quality: specific error messages?
```

#### LENS 4: DEPENDENCY ANALYSIS
```python
examine_dependencies:
    health:
        - run: npm audit, pip check, etc.
        - check: deprecated packages
        - verify: license compatibility
    
    necessity:
        for each dependency:
            - is_imported: grep -r "import.*package"
            - is_used: check actual usage
            - has_alternative: native or simpler option?
            - is_duplicate: same functionality as another?
    
    ai_patterns:
        - multiple_http_clients: axios + fetch + request
        - utility_explosion: lodash + underscore + ramda
        - framework_confusion: express + fastify + koa
```

#### LENS 5: SECURITY SCANNING
```python
security_check:
    credentials:
        - regex_scan: API_KEY, SECRET, PASSWORD, TOKEN
        - entropy_check: high entropy strings
        - git_history: git log -p | grep -E "password|secret"
    
    vulnerabilities:
        - sql_injection: string concatenation with user input
        - xss_risks: innerHTML, dangerouslySetInnerHTML
        - path_traversal: user_input in file paths
        - eval_usage: eval, exec, Function constructor
    
    configuration:
        - production_flags: DEBUG=true in prod
        - cors_settings: Access-Control-Allow-Origin: *
        - security_headers: missing CSP, HSTS, etc.
```

#### LENS 6: ARCHITECTURE EVALUATION
```python
check_principles:
    SOLID:
        S: count responsibilities per class
        O: check modification history frequency
        L: verify subtype behavior consistency
        I: measure unused interface methods
        D: check dependency direction
    
    separation_of_concerns:
        - UI with SQL queries
        - business logic in controllers
        - data access in services
        
    coupling_analysis:
        - import cycles detection
        - coupling between modules
        - shared mutable state
```

#### LENS 7: PERFORMANCE ANALYSIS
```python
identify_bottlenecks:
    algorithmic:
        for each function:
            - detect nested loops
            - analyze big-O complexity
            - check recursive depth
    
    resource_usage:
        - unclosed: files, connections, streams
        - memory: large objects held in memory
        - queries: N+1 problems
        - missing_indexes: full table scans
```

#### LENS 8: CODEBASE HYGIENE
```python
evaluate_organization:
    structure:
        - consistency in folder organization
        - file naming patterns
        - build artifacts in repo
    
    style:
        - inconsistent formatting
        - mixed indentation
        - line length violations
```

### PHASE 3: FINDING DEDUPLICATION
```python
# After all lenses complete
findings = all_accumulated_findings

# Remove duplicates
deduplicated = []
seen_issues = {}

for finding in findings:
    issue_key = f"{finding.file}:{finding.line}:{finding.type}"
    
    if issue_key not in seen_issues:
        seen_issues[issue_key] = finding
        deduplicated.append(finding)
    else:
        # Keep higher severity
        if finding.severity > seen_issues[issue_key].severity:
            seen_issues[issue_key] = finding
```

### PHASE 4: REPORT GENERATION

Create/update `AUDIT_RESULTS.md` in repository root:

```markdown
# CODEBASE AUDIT RESULTS

**Timestamp**: [ISO 8601]
**Repository**: [path]
**Commit**: [git rev-parse HEAD]
**Version**: [increment from previous]
**Claude Code Model**: Opus 4.1
**Duration**: [seconds]

## EXECUTIVE SUMMARY

### Severity Distribution
- 🔴 CRITICAL: [count]
- 🟠 HIGH: [count]
- 🟡 MEDIUM: [count]
- 🔵 LOW: [count]
- ⚪ INFO: [count]

### Top Issues Requiring Attention
1. [CRITICAL] [file:line] - [issue description with evidence]
2. [HIGH] [file:line] - [issue description with evidence]
[... up to 10]

## CHANGE TRACKING

### Since Last Audit [date]
#### ✅ Improvements
- [issue resolved] - was [severity], now fixed

#### ⚠️ Regressions  
- [new issue] at [location] - severity: [level]

#### 🔄 Persistent Issues
- [unresolved issue] - [age in days] days - [location]

## DETAILED FINDINGS

### CODE COMPLEXITY & QUALITY

#### Critical Complexity Issues
[file:line] - [metric]:[value] exceeds threshold:[limit]
Example: `auth.js:234 - cyclomatic_complexity:18 > threshold:10 - 8 branches, 3 loops`

#### Code Smells
[file:line] - [smell type] - [evidence]

#### AI-Generated Artifacts
Console.logs found: [count]
- [file:line] - exposes [data type]

Redundant implementations: [count]
- [description] - files: [list]

### DOCUMENTATION ACCURACY

#### Documentation Lies
[file:line] - Claims: "[documented]" - Reality: "[actual]"

#### Missing Documentation
[count] public APIs undocumented
- [function/class] - [file:line]

### TESTING ANALYSIS

#### Coverage Metrics
- Line Coverage: [n]%
- Branch Coverage: [n]%  
- Critical Path Coverage: [n]%

#### Test Quality Issues
[file:line] - [issue] - [evidence]

#### TDD Evidence
- Test-first commits: [found/not found]
- Test complexity < Implementation: [yes/no]
- Meaningful failures: [n]%

### DEPENDENCY HEALTH

#### Security Vulnerabilities
[package] - [severity] - [CVE if applicable]

#### Unnecessary Dependencies
[package] - Reason: [never used/has native alternative/duplicate]

#### AI-Specific Patterns
Multiple packages for same purpose:
- HTTP clients: [list]
- Utility libraries: [list]

### SECURITY FINDINGS

#### 🔴 Critical Security Issues
[file:line] - [vulnerability type] - CWE-[number]
Evidence: [specific code pattern found]

#### Exposed Secrets [REDACTED]
[file:line] - [type of secret] - Entropy: [score]

### ARCHITECTURE VIOLATIONS

#### SOLID Principle Violations
[class/module] - [principle] - Evidence: [specific violation]
Example: `UserService - SRP - 4 responsibilities: auth, validation, storage, email`

#### Coupling Issues
Module coupling scores:
- [module A] <-> [module B]: [score]

### PERFORMANCE BOTTLENECKS

#### Algorithm Complexity Issues  
[file:line] - Complexity: O([notation]) - Impact: [description]

#### Resource Leaks
[file:line] - [resource type] not closed

### CODEBASE HYGIENE

#### Organization Score: [n]/10
Issues:
- [issue type] - [locations affected]

#### Naming Consistency Score: [n]/10  
Pattern violations:
- Mixed: camelCase and snake_case in [files]

## METRICS DASHBOARD

| Metric | Current | Previous | Change | Status |
|--------|---------|----------|--------|--------|
| Total LOC | [n] | [n] | [+/-n%] | - |
| Test Coverage | [n]% | [n]% | [+/-n%] | 🔴/🟡/🟢 |
| Duplication | [n]% | [n]% | [+/-n%] | 🔴/🟡/🟢 |
| Avg Complexity | [n] | [n] | [+/-n] | 🔴/🟡/🟢 |
| Dependencies | [n] | [n] | [+/-n] | - |
| Security Issues | [n] | [n] | [+/-n] | 🔴/🟡/🟢 |

## AI CODEBASE INDICATORS

### Confidence Score: [n]% AI-generated
Evidence:
- Verbose implementations: [n] instances
- Inconsistent patterns: [n] variations
- Over-engineered solutions: [n] cases
- Unused dependencies: [n] packages

## AUDIT INTEGRITY

✓ All files scanned: [n/total]
✓ Evidence provided: [all findings/total]
✓ Objective measurements: [yes/no]
✓ Version control tracked: [yes/no]

---
*Audit complete. No recommendations provided per specification.*
*Each finding includes file:line reference and objective evidence.*
```

## EXECUTION WORKFLOW IN CLAUDE CODE

```bash
# Claude Code will execute this workflow:

1. Open repository
2. Read and index all files
3. For each lens (1-8):
   - Systematically analyze relevant files
   - Record findings with evidence
   - Add to accumulator
4. Deduplicate findings
5. Calculate severity scores
6. Generate/update AUDIT_RESULTS.md
7. Commit to version control (if enabled)
```

## SEVERITY CLASSIFICATION

```python
def classify_severity(finding):
    if any([
        "exposed_password" in finding,
        "sql_injection" in finding,
        "security_vulnerability" in finding,
        "production_break" in finding
    ]):
        return "CRITICAL"
    
    elif any([
        finding.complexity > 15,
        "SOLID_violation" in finding,
        finding.coverage < 20,
        "data_leak" in finding
    ]):
        return "HIGH"
    
    elif any([
        finding.duplication > 20_lines,
        "missing_documentation" in finding,
        finding.outdated_major_version
    ]):
        return "MEDIUM"
    
    elif any([
        "formatting" in finding,
        "naming_inconsistency" in finding,
        finding.could_be_optimized
    ]):
        return "LOW"
    
    else:
        return "INFO"
```

## CLAUDE CODE SPECIFIC OPTIMIZATIONS

1. **Use built-in commands efficiently**:
   - `find` for file discovery
   - `grep -r` for pattern searching  
   - `git log` for history analysis
   - Native language tools (npm, pip, cargo)

2. **Maintain context between phases**:
   - Keep running tally of findings
   - Reference previous findings to avoid duplicates
   - Build cumulative understanding

3. **Leverage Opus 4.1 strengths**:
   - Deep reasoning about architecture
   - Pattern recognition across files
   - Complex state management
   - Nuanced severity assessment

## REMEMBER

- You are ONE agent with MULTIPLE analytical perspectives
- Execute sequentially but maintain global state
- Every finding needs FILE:LINE and EVIDENCE
- Be BRUTALLY HONEST about code quality
- AI-generated code has UNIQUE problems - find them
- Documentation often LIES - verify everything
- Tests can be DECORATIVE - check actual quality
- Dependencies ACCUMULATE - audit necessity
- NO SOLUTIONS - only identify problems

## VALIDATION CHECKLIST

Before finalizing AUDIT_RESULTS.md, verify:
□ Every finding has file:line reference
□ Every finding has objective measurement
□ No duplicate findings across lenses
□ Severity justified by evidence
□ Change tracking from previous audit
□ No recommendations or fixes suggested
□ Metrics calculated and compared
□ AI indicators assessed