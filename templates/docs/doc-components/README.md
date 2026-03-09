# Documentation Components

**Version**: 1.5.1
**Purpose**: Reusable templates for AI-optimized documentation
**Added**: 2025-11-14

<!-- AI NAVIGATION -->
**For AI Assistants**:
- **Read this when**: User asks how to use documentation templates or improve documentation quality
- **Parent context**: [../DOCUMENTATION-STANDARDS.md](../DOCUMENTATION-STANDARDS.md) - Complete documentation standards
- **Related docs**: [../init-project.md](../init-project.md) - See Step 13.5 for usage in new projects
- **Use for**: Understanding how to apply documentation templates
- **Don't use for**: Documentation standards themselves (see DOCUMENTATION-STANDARDS.md)

---

## Overview

This directory contains reusable templates for creating AI-optimized documentation. These templates implement the standards defined in [DOCUMENTATION-STANDARDS.md](../DOCUMENTATION-STANDARDS.md) and support Principle 5.5 (AI-Optimized Documentation).

**When to Use**: Projects with >5 documentation files, multi-service platforms, or long-lived projects (>3 months)

**Core Philosophy**: Documentation is structured data for AI consumption, not just human reading.

---

## Available Components

### 1. AI-NAVIGATION-HEADER.template

**Purpose**: Help AI assistants understand when to read a file and how it fits in documentation hierarchy

**Use When**: Creating any documentation file that AI assistants will read

**How to Use**:

```bash
# Method 1: Add to top of new documentation file (after title)
cat templates/docs/doc-components/AI-NAVIGATION-HEADER.template >> YOUR-DOC.md

# Then edit placeholders: [FILL: ...]
vim YOUR-DOC.md
```

**Example Output**:
```markdown
<!-- AI NAVIGATION -->
**For AI Assistants**:
- **Read this when**: User asks about deployment procedures
- **Parent context**: [AGENTS.md](./AGENTS.md) - Main project guidelines
- **Related docs**: [ARCHITECTURE.md](./docs/ARCHITECTURE.md)
- **Use for**: Step-by-step deployment instructions
- **Don't use for**: Architecture decisions (see docs/decisions/)
- **Navigation**: See [DOCS-MAP.md](./DOCS-MAP.md)
```

**Validation**:
- [ ] All [FILL: ...] placeholders replaced
- [ ] DOCS-MAP.md link is correct
- [ ] Parent context link works
- [ ] Test: Ask AI "When should you read this file?" - it should know

**Benefits**:
- ✅ AI loads correct context without trial-and-error
- ✅ Reduces unnecessary file reads (saves tokens)
- ✅ Explicit anti-use cases prevent misapplication

---

### 2. DOCS-MAP.md.template

**Purpose**: Master navigation for all project documentation (like sitemap for docs)

**Use When**: Project has >5 documentation files

**How to Use**:

```bash
# Copy to project root
cp templates/docs/doc-components/DOCS-MAP.md.template ./DOCS-MAP.md

# Edit to list all documentation files
vim DOCS-MAP.md

# Categorize by priority:
# ⚡ High Priority - Read first
# 📋 Planning - Strategic decisions
# 🔧 Execution - Implementation guides
# 🎯 Current Work - Active development
# 📚 Reference - Technical specs
# 🏛️ Historical - Decision records
```

**What to Include**:
- All .md files in root directory
- All docs/ subdirectories and files
- Context level for each file (Main, Quick Reference, Deep Dive, etc.)
- "Read When" guidance for each file
- Navigation shortcuts by audience and task type

**Validation**:
- [ ] All documentation files listed
- [ ] No broken links (all files exist)
- [ ] Categories make sense (⚡📋🔧🎯📚🏛️)
- [ ] "Last Updated" date current
- [ ] Test: Ask AI "Where is X documented?" - it should find it in DOCS-MAP

**Benefits**:
- ✅ Both AI and humans can instantly find documentation
- ✅ Onboarding faster (clear starting points)
- ✅ Documentation gaps visible (what's missing?)
- ✅ Reduces "where was that again?" questions

**Update Frequency**: Update whenever you add/remove/move documentation files

---

### 3. ADR-TEMPLATE.md

**Purpose**: Document WHY architecture decisions were made, not just WHAT was decided

**Use When**: Making significant architecture, technology, or design decisions

**How to Use**:

```bash
# Create docs/decisions/ directory if it doesn't exist
mkdir -p docs/decisions

# Copy template with sequential numbering
cp templates/docs/doc-components/ADR-TEMPLATE.md ./docs/decisions/001-your-decision-name.md

# Fill all sections, especially "Alternatives Considered"
vim docs/decisions/001-your-decision-name.md
```

**Critical Sections**:
1. **Context**: Why is this decision needed NOW?
2. **Decision**: What did we choose? (Be specific)
3. **Consequences**: Positive, negative, neutral (be honest)
4. **Alternatives Considered**: What else did we consider? Why rejected?

**Naming Convention**:
- `001-first-decision.md`
- `002-second-decision.md`
- Use sequential numbering
- Use descriptive kebab-case names

**Validation**:
- [ ] All [FILL: ...] placeholders replaced
- [ ] At least 2 alternatives considered and documented
- [ ] Each alternative has explicit "Why Rejected" reasoning
- [ ] Consequences include both positive AND negative
- [ ] Status at top matches status at bottom
- [ ] Date is in ISO 8601 format (YYYY-MM-DD)

**Benefits**:
- ✅ Future developers understand WHY (not just WHAT)
- ✅ Prevents revisiting already-rejected alternatives
- ✅ Documents trade-offs explicitly
- ✅ AI can explain decision rationale accurately

**Status Values**:
- **Proposed**: Decision under discussion
- **Accepted**: Decision made and active
- **Rejected**: Proposed but not chosen
- **Deprecated**: Was active, now outdated
- **Superseded by ADR-XXX**: Replaced by newer decision

---

### 4. METADATA-BLOCK.template

**Purpose**: Machine-readable metadata for documentation files

**Use When**: Creating structured documentation that AI will parse

**How to Use**:

```bash
# Add to top of documentation file (after AI Navigation Header)
cat templates/docs/doc-components/METADATA-BLOCK.template >> YOUR-DOC.md

# Update all fields
vim YOUR-DOC.md
```

**Fields Explanation**:

| Field | Values | Description |
|-------|--------|-------------|
| **Purpose** | One sentence | What is this document for? |
| **Context Level** | Main / Quick Reference / Deep Dive / Historical / Reference | How detailed is this? |
| **Last Updated** | YYYY-MM-DD | When was this last modified? |
| **Status** | Active / Draft / Deprecated / Archived | Is this current? |
| **Template Version** | 1.5.1 | Which template version? |

**Context Levels**:
- **Main**: Core project guidelines (AGENTS.md)
- **Quick Reference**: Summaries and command lookups (CLAUDE.md)
- **Deep Dive**: Implementation details, guides (docs/guides/)
- **Historical**: Decision records, past context (docs/decisions/)
- **Reference**: Technical specs, API docs (docs/api/)

**Validation**:
- [ ] Date format is YYYY-MM-DD (ISO 8601)
- [ ] Template version matches project template version
- [ ] Context level appropriate for document depth
- [ ] Status reflects current state (update if deprecated)

**Benefits**:
- ✅ AI can parse metadata programmatically
- ✅ Detects stale documentation (check Last Updated)
- ✅ Filters by context level (load summary vs full detail)
- ✅ Version tracking enables sync detection

---

## Usage Patterns

### Pattern 1: New Project Initialization

**When**: Starting a new project with comprehensive documentation

**Steps**:
1. Copy core templates (AGENTS.md, CLAUDE.md, STATUS.md, etc.)
2. Create DOCS-MAP.md from template
3. Add AI Navigation Headers to all core files
4. Add Metadata Blocks to all files
5. Validate with `templates/tools/audit-project.sh --full`

**Time**: 15-20 minutes for initial setup

---

### Pattern 2: Enhancing Existing Project

**When**: Existing project needs better documentation structure

**Steps**:
1. Create DOCS-MAP.md (inventory existing documentation)
2. Add AI Navigation Headers to 3-5 most-read files first
3. Create docs/decisions/ directory if architecture decisions exist
4. Migrate informal decisions to ADR format
5. Test with AI: "Where is X documented?" - validate it works

**Time**: 30-60 minutes depending on project size

---

### Pattern 3: Ongoing Maintenance

**When**: Regular documentation updates

**Best Practices**:
- Update DOCS-MAP.md when adding/removing documentation
- Update "Last Updated" date in metadata when modifying files
- Create ADRs for significant decisions as they're made (not retroactively)
- Review DOCS-MAP.md monthly for gaps
- Run audit quarterly: `templates/tools/audit-project.sh --full`

**Time**: 5-10 minutes per documentation change

---

## Integration with Jimmy's Workflow

Documentation updates follow RED/GREEN/CHECKPOINT:

### 🔴 RED: IMPLEMENT
- Write documentation
- Add AI Navigation Headers
- Fill metadata blocks
- Update DOCS-MAP.md

### 🟢 GREEN: VALIDATE
**Validation Command**:
```bash
# Test AI can find documentation
# Ask AI: "Where is [topic] documented?"
# AI should reference DOCS-MAP.md and find correct file

# Check for broken links
grep -r "](\./" *.md docs/**/*.md | while read line; do
  file=$(echo "$line" | cut -d: -f1)
  link=$(echo "$line" | grep -o '](\..*\.md)' | sed 's/](\(.*\))/\1/')
  [ ! -f "$link" ] && echo "Broken link in $file: $link"
done

# Validate all placeholders filled
grep -r "\[FILL:" *.md docs/**/*.md
# Should return no results

# Run audit
templates/tools/audit-project.sh --full
```

**Pass Criteria**:
- [ ] AI correctly identifies when to read each file
- [ ] No broken internal links
- [ ] All [FILL: ...] placeholders replaced
- [ ] Audit passes (or only optional warnings)

### 🔵 CHECKPOINT: GATE
- Commit documentation changes
- Document rollback: `git log -1` (note commit hash)
- Update DOCS-MAP.md "Last Updated" date

**Rollback Procedure**:
```bash
# If documentation changes need reverting
git revert [commit-hash]
# Or
git reset --hard [previous-commit-hash]
```

---

## Validation Checklist

Use this checklist for all documentation:

**AI Navigation Header**:
- [ ] "Read this when" is specific (not generic)
- [ ] Parent context link works
- [ ] Related docs listed
- [ ] Anti-use cases specified
- [ ] DOCS-MAP.md link correct

**Metadata Block**:
- [ ] Purpose is one clear sentence
- [ ] Context level appropriate
- [ ] Date format: YYYY-MM-DD
- [ ] Status reflects reality
- [ ] Template version matches project

**Content Quality**:
- [ ] Uses structured data (tables, lists) over prose
- [ ] Examples provided for complex concepts
- [ ] Cross-references working
- [ ] No marketing language ("world-class", "cutting-edge")
- [ ] Objective and factual

**DOCS-MAP.md** (if used):
- [ ] All documentation files listed
- [ ] Categories make sense
- [ ] No broken links
- [ ] "Last Updated" current

**ADRs** (if used):
- [ ] Context explains WHY decision needed
- [ ] Decision is specific and clear
- [ ] At least 2 alternatives documented
- [ ] Each alternative has "Why Rejected"
- [ ] Consequences honest (positive AND negative)

---

## Examples

### Example 1: dev-hunting Project

**Implementation**: Full AI-optimized documentation

**What They Did**:
- ✅ AI Navigation Headers in all core files
- ✅ Comprehensive DOCS-MAP.md with 40+ files indexed
- ✅ Machine-readable metadata in AGENTS.md, CLAUDE.md, STATUS.md
- ✅ ADRs for infrastructure decisions (docs/decisions/)
- ✅ Clear parent/child relationships (CLAUDE.md → AGENTS.md)

**Result**: AI can navigate 40+ documentation files accurately, loads correct context first time

**See**: `./your-project/` for a project implementing this pattern

---

### Example 2: Minimal Project

**Implementation**: Lightweight documentation (5 files)

**What to Do**:
- ✅ Add AI Navigation Header to AGENTS.md
- ✅ Add Metadata Block to AGENTS.md
- ⚠️ Skip DOCS-MAP.md (only 5 files - not needed)
- ⚠️ Skip ADRs (no complex decisions yet)

**Result**: Basic AI optimization without overhead

---

### Example 3: Multi-Service Platform

**Implementation**: Full documentation hierarchy

**What to Do**:
- ✅ Root DOCS-MAP.md (master index)
- ✅ Service-level AGENTS.md files (reference root)
- ✅ Shared docs/ directory (guides, decisions)
- ✅ ADRs for platform-wide decisions
- ✅ Service-specific guides in service directories

**Structure**:
```
platform/
├── DOCS-MAP.md (master)
├── AGENTS.md (platform guidelines)
├── docs/
│   ├── guides/ (platform guides)
│   └── decisions/ (ADRs)
├── service-auth/
│   ├── AGENTS.md (auth-specific, references ../AGENTS.md)
│   └── docs/ (auth documentation)
└── service-api/
    ├── AGENTS.md (api-specific, references ../AGENTS.md)
    └── docs/ (api documentation)
```

---

## Troubleshooting

### AI Not Reading Correct File

**Symptom**: AI reads wrong file or multiple files unnecessarily

**Solution**:
1. Check AI Navigation Header "Read this when" is specific
2. Verify DOCS-MAP.md lists file correctly
3. Add anti-use cases to prevent misuse
4. Test: Ask AI directly "When should you read X.md?"

---

### Broken Links in DOCS-MAP.md

**Symptom**: Links don't work or point to wrong files

**Solution**:
```bash
# Validate all links
grep -o '\[.*\](\..*\.md)' DOCS-MAP.md | sed 's/.*(\(.*\))/\1/' | while read link; do
  [ ! -f "$link" ] && echo "Broken: $link"
done
```

---

### Audit Failing Check #8

**Symptom**: `audit-project.sh` reports documentation issues

**Solution**:
1. Run: `templates/tools/audit-project.sh --full`
2. Read specific recommendations
3. Check if >5 docs and DOCS-MAP.md missing
4. Add AI Navigation Headers to main files
5. Re-run audit to confirm

---

## Best Practices

1. **Start Small**: Add AI Navigation Headers to 3-5 most-read files first, not everything at once
2. **Iterate**: Create DOCS-MAP.md early (even if incomplete), update as you go
3. **Test with AI**: Always validate that AI understands your documentation structure
4. **Update Regularly**: When adding documentation, immediately update DOCS-MAP.md
5. **Be Specific**: "Read this when user asks about deployment" > "Read this for deployment info"
6. **Document WHY**: In ADRs, "Why Rejected" is as important as "Decision"
7. **Use Examples**: Show don't tell (code examples, command examples)
8. **Link Everything**: Cross-reference related docs (AI follows links)

---

## Anti-Patterns to Avoid

1. ❌ **Generic Navigation**: "Read this for general information" - too vague!
2. ❌ **Skipping Alternatives**: ADRs must document what was considered and rejected
3. ❌ **Broken Links**: Always validate links after moving/renaming files
4. ❌ **Stale Dates**: Update "Last Updated" when modifying documentation
5. ❌ **Prose over Structure**: Use tables/lists, not paragraphs of text
6. ❌ **Marketing Language**: "World-class", "cutting-edge" - be objective
7. ❌ **Orphan Docs**: Every doc should be referenced in DOCS-MAP.md or parent doc

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.5.1 | 2025-11-14 | Initial release of doc-components/ |

---

## Related Documentation

- [../DOCUMENTATION-STANDARDS.md](../DOCUMENTATION-STANDARDS.md) - Complete documentation standards
- [../AGENTS-TEMPLATE-GUIDE.md](../AGENTS-TEMPLATE-GUIDE.md) - Template usage guide
- [../init-project.md](../init-project.md) - Project initialization (see Step 13.5)
- [../tools/audit-project.sh](../tools/audit-project.sh) - Compliance auditing (Check #8)

---

**Template Version**: 1.5.1
**Last Updated**: 2025-11-14
**Status**: Active

<!-- END OF README -->
