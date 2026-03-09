# AI-Optimized Documentation Standards

**Version**: 1.5.1
**Status**: Active
**Last Updated**: 2025-11-14
**Parent Context**: Core Development Principles (Principle 5.5)

<!-- AI NAVIGATION -->
**For AI Assistants**:
- **Read this when**: User asks about documentation quality, structure, or how to make documentation AI-friendly
- **Parent context**: [AGENTS.md.template](./AGENTS.md.template) - See Principle 5 (Documentation Standards) and 5.5 (AI-Optimized Documentation)
- **Related docs**: [doc-components/README.md](./doc-components/README.md), [init-project.md](./init-project.md)
- **Use for**: Understanding how to create documentation that both humans and AI can effectively use
- **Don't use for**: Project-specific documentation (apply these standards to project docs)
- **Navigation**: This is a comprehensive reference guide

---

## Table of Contents

1. [Introduction](#introduction)
2. [The 7 Principles of AI-Optimized Documentation](#the-7-principles)
3. [Documentation Components](#documentation-components)
4. [File Types and Templates](#file-types-and-templates)
5. [Best Practices](#best-practices)
6. [Anti-Patterns](#anti-patterns)
7. [Validation Checklist](#validation-checklist)
8. [Examples](#examples)
9. [Integration with Jimmy's Workflow](#integration-with-jimmys-workflow)

---

## Introduction

### Why AI-Optimized Documentation?

Traditional documentation is written for human readers who:
- Can infer context from domain knowledge and experience
- Remember previous conversations and decisions
- Navigate documentation intuitively through search and exploration
- Understand implied relationships between documents

AI assistants are fundamentally different:
- Start with **zero context** each session
- Need **explicit relationships** between documents
- Benefit from **structured, machine-readable data**
- Cannot infer implied information
- Must load context efficiently (token limits)

**Goal**: Documentation that serves BOTH humans (readable, clear) AND AI (parseable, navigable)

**Core Philosophy**: *Documentation is structured data for AI consumption, not just human reading.*

---

### When to Use These Standards

**✅ Use These Standards For**:
- All project documentation (AGENTS.md, guides, ADRs, etc.)
- Multi-file documentation systems
- Long-lived projects (>3 months)
- Projects with AI assistant collaboration
- Multi-service platforms
- Complex systems requiring onboarding

**⚠️ Optional For**:
- Single-file scripts with minimal documentation
- Internal tools with 1-2 users
- Prototypes (<1 week lifespan)

**❌ Not Needed For**:
- Code comments (use standard commenting conventions)
- Throwaway experiments
- Auto-generated documentation (API docs, etc.)

---

### Benefits of AI-Optimized Documentation

**For AI Assistants**:
- ✅ Loads correct context on first try (reduces token waste)
- ✅ Understands when NOT to read a file (anti-use cases)
- ✅ Navigates complex documentation hierarchies accurately
- ✅ Provides accurate answers based on documented decisions

**For Human Developers**:
- ✅ Faster onboarding (clear starting points)
- ✅ Easier to find information (master navigation map)
- ✅ Understand WHY decisions were made (ADRs)
- ✅ Confident documentation is current (version stamps)

**For Projects**:
- ✅ Reduced context-loading time (efficiency)
- ✅ Fewer AI hallucinations (explicit > implicit)
- ✅ Better knowledge preservation (structured decisions)
- ✅ Scalable documentation (works at 5 files or 500)

---

## The 7 Principles

### Principle 1: Structured Data Over Prose

**Philosophy**: AI parses tables and lists faster than extracting facts from paragraphs.

**Bad Example** (Prose):
```markdown
The project uses React version 18.2.0 for the frontend, along with TypeScript for type safety. The backend is built with Node.js version 20.x and uses Express as the web framework. For the database, we chose PostgreSQL version 15.x because it provides robust ACID guarantees and has excellent JSON support. We also use Redis for caching to improve performance.
```

**Good Example** (Structured):
```markdown
## Technology Stack

| Layer | Technology | Version | Purpose |
|-------|------------|---------|---------|
| Frontend | React | 18.2.0 | UI components and state management |
| Type System | TypeScript | 5.2.x | Static typing and IDE support |
| Backend | Node.js | 20.x | Runtime environment |
| Web Framework | Express | 4.18.x | HTTP server and routing |
| Database | PostgreSQL | 15.x | Primary data persistence (ACID, JSON) |
| Cache | Redis | 7.2.x | Session storage and performance |

**Decision Rationale**: See [ADR-001: Technology Stack Selection](./docs/decisions/001-tech-stack.md)
```

**Why This Works**:
- AI can extract version numbers without parsing prose
- Table format is scannable by both humans and AI
- Decision rationale linked (context without clutter)
- Clear separation of concerns (what vs why)

**When to Use**:
- Technology stacks
- Configuration options
- API endpoints
- Command reference
- File structures
- Status indicators
- Metrics and measurements

---

### Principle 2: Explicit Context

**Philosophy**: Never assume the reader (AI or human) knows background information.

**Bad Example** (Implicit):
```markdown
## Deployment

Use the standard process. Make sure to run migrations first.
```

**Good Example** (Explicit):
```markdown
## Deployment

**Prerequisites**:
- You must have production credentials configured (see [API_AUTHENTICATION.md](./API_AUTHENTICATION.md))
- Database backup created in last 24 hours (automated via cron)
- All tests passing on main branch (CI/CD checks)

**Process**:
1. Run database migrations: `npm run migrate:prod`
2. Build production assets: `npm run build`
3. Deploy to Render: `git push render main`
4. Verify deployment: `curl https://api.example.com/health`

**Rollback Procedure** (if deployment fails):
```bash
git revert HEAD
git push render main --force
npm run migrate:rollback:prod
```

**Expected Duration**: 5-10 minutes
**Monitoring**: Check [Render Dashboard](https://dashboard.render.com) for logs
```

**Why This Works**:
- No assumed knowledge ("standard process" undefined)
- Prerequisites explicit (AI knows what to check)
- Commands are copy-pasteable (no ambiguity)
- Rollback procedure documented (AI can help recover)
- Links to related docs (API_AUTHENTICATION.md)

**When to Use**:
- Deployment procedures
- Setup instructions
- API usage examples
- Troubleshooting guides
- Configuration steps

---

### Principle 3: Cause-Effect Relationships

**Philosophy**: Link decisions to outcomes. Document WHY, not just WHAT.

**Bad Example** (No Context):
```markdown
## API Rate Limiting

Rate limit: 100 requests per hour per IP address.
```

**Good Example** (Cause-Effect):
```markdown
## API Rate Limiting

**Current Limit**: 100 requests/hour per IP address

**Why This Limit**:
- **Problem**: Previous limit (1000/hour) led to abuse from scraper bots
- **Impact**: 3 service outages in October 2024 (CPU exhaustion)
- **Solution**: Reduced to 100/hour based on 95th percentile legitimate usage (avg: 42 req/hour)

**Monitoring**:
- Check rate limit violations: `grep "RATE_LIMIT_EXCEEDED" /var/log/api/*.log`
- Dashboard: [Grafana Rate Limit Panel](https://grafana.example.com/d/rate-limits)

**When to Adjust**:
- If legitimate users report 429 errors (Too Many Requests)
- If abuse continues, consider IP-based blocking (see [SECURITY.md](./SECURITY.md))

**Decision Record**: [ADR-012: API Rate Limiting Strategy](./docs/decisions/012-api-rate-limiting.md)
```

**Why This Works**:
- Historical context (WHY limit was chosen)
- Data-driven decision (95th percentile)
- Monitoring tools provided (how to detect issues)
- Future adjustment criteria (when to revisit)
- Link to full decision record (ADR)

**When to Use**:
- Configuration decisions
- Architecture choices
- Performance tuning
- Security policies
- Business rule documentation

---

### Principle 4: Machine-Readable Formats

**Philosophy**: Use consistent formats AI can parse programmatically.

**Required Machine-Readable Elements**:

1. **Dates**: ISO 8601 format (YYYY-MM-DD)
2. **Status Indicators**: ✅ (done), 🔄 (in progress), ⚪ (not started), ⚠️ (blocked)
3. **Versions**: Semantic versioning (MAJOR.MINOR.PATCH)
4. **Metadata Blocks**: Consistent key-value format
5. **Code Blocks**: Proper syntax highlighting

**Bad Example**:
```markdown
Updated last week. Current version is 2.1. Status: mostly done.
```

**Good Example**:
```markdown
**Last Updated**: 2025-11-14
**Version**: 2.1.0
**Status**: 🔄 In Progress (80% complete)
**Next Milestone**: 2.2.0 (target: 2025-12-01)
```

**Metadata Block Standard**:
```markdown
**Purpose**: [One-sentence description]
**Context Level**: [Main | Quick Reference | Deep Dive | Historical | Reference]
**Last Updated**: YYYY-MM-DD
**Status**: [Active | Draft | Deprecated | Archived]
**Template Version**: 1.5.1
```

**Why This Works**:
- AI can parse dates programmatically (check if stale)
- Status indicators are visual and parseable
- Version comparison possible (is 2.1.0 > 2.0.5?)
- Consistent format across all documentation

**When to Use**:
- All documentation headers
- Changelog entries
- Release notes
- Status reports
- Progress tracking

---

### Principle 5: Searchable Content

**Philosophy**: Use keywords, anchors, and consistent terminology.

**Techniques**:

1. **Anchor Links** for long documents:
```markdown
## Table of Contents
- [Installation](#installation)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)

## Installation
[content]

## Configuration
[content]
```

2. **Consistent Terminology**:
```markdown
# Good: Use same term throughout
"deployment" (not: deploy, deploying, pushed to production)
"API key" (not: API token, access key, authentication key)

# Document terminology
## Glossary
- **Deployment**: The process of pushing code to production servers
- **API Key**: Secret credential for API authentication (format: ak_[32 chars])
```

3. **Keywords** in headers:
```markdown
# Good: Specific, searchable
## PostgreSQL Database Connection Issues

# Bad: Vague, not searchable
## Problems
```

4. **Tags** for categorization:
```markdown
**Tags**: #database #troubleshooting #production

This allows: grep -r "#database" docs/
```

**Why This Works**:
- AI can search for specific keywords
- Humans can Ctrl+F effectively
- Anchors enable deep linking
- Consistent terms prevent confusion

---

### Principle 6: Version-Stamped Documentation

**Philosophy**: Track when information was accurate. Detect stale documentation.

**Required Version Information**:

1. **Document Version** (last updated date):
```markdown
**Last Updated**: 2025-11-14
```

2. **Template Version** (which template used):
```markdown
**Template Version**: 1.5.1
```

3. **Software Version** (what version documented):
```markdown
**Applies to**: v2.1.0 and later
**Deprecated in**: v3.0.0
```

**Example**:
```markdown
# Database Migration Guide

**Last Updated**: 2025-11-14
**Template Version**: 1.5.1
**Applies to**: PostgreSQL 15.x and later
**Status**: Active

[content]

---

## Version History

| Date | Version | Changes | Author |
|------|---------|---------|--------|
| 2025-11-14 | 1.2.0 | Added rollback procedures | Jimmy |
| 2025-10-01 | 1.1.0 | Updated for PostgreSQL 15 | Jimmy |
| 2025-08-15 | 1.0.0 | Initial documentation | Jimmy |
```

**Stale Documentation Detection**:
```bash
# Find docs not updated in 6 months
find docs/ -name "*.md" -mtime +180

# Grep for old dates in documentation
grep -r "Last Updated: 2024" docs/
```

**Why This Works**:
- AI knows if documentation is current
- Version mismatches detectable
- Historical changes tracked
- Audit trail for compliance

---

### Principle 7: Cross-Referenced Documentation

**Philosophy**: Link related documents. AI follows links to build context.

**Linking Patterns**:

1. **Parent-Child Relationships**:
```markdown
# CLAUDE.md (Child)
**Parent context**: [AGENTS.md](./AGENTS.md) - This is a summary of that document
```

2. **Sibling Documents**:
```markdown
# DEPLOYMENT.md
**Related docs**:
- [API_AUTHENTICATION.md](./API_AUTHENTICATION.md) - For API credentials
- [DATABASE.md](./docs/DATABASE.md) - For database setup
- [MONITORING.md](./docs/MONITORING.md) - For post-deployment checks
```

3. **Decision References**:
```markdown
**Decision Rationale**: See [ADR-005: Deployment Strategy](./docs/decisions/005-deployment-strategy.md)
```

4. **Master Navigation**:
```markdown
**Navigation**: See [DOCS-MAP.md](./DOCS-MAP.md) for all documentation
```

**Link Format Standards**:
```markdown
# Relative links (preferred for project-internal docs)
[AGENTS.md](./AGENTS.md)
[Setup Guide](./docs/guides/SETUP.md)

# Absolute URLs (for external references)
[PostgreSQL Docs](https://www.postgresql.org/docs/15/)
[Express API](https://expressjs.com/en/api.html)
```

**Why This Works**:
- AI can navigate documentation graph
- Humans follow logical flow
- No orphaned documents
- Context building is explicit

---

## Documentation Components

### 1. AI Navigation Header

**Purpose**: Tell AI when to read this file and how it fits in the hierarchy.

**Template**: See [doc-components/AI-NAVIGATION-HEADER.template](./doc-components/AI-NAVIGATION-HEADER.template)

**Structure**:
```markdown
<!-- AI NAVIGATION -->
**For AI Assistants**:
- **Read this when**: [Specific trigger condition]
- **Parent context**: [Link to parent document]
- **Related docs**: [Sibling/child documents]
- **Use for**: [Primary use case]
- **Don't use for**: [Anti-use cases]
- **Navigation**: See [DOCS-MAP.md](./DOCS-MAP.md)
```

**Key Elements**:

1. **Read this when** - Specific trigger:
   - ✅ Good: "User asks about deployment procedures"
   - ❌ Bad: "For deployment information"

2. **Parent context** - Where this fits:
   - ✅ Good: "[AGENTS.md](./AGENTS.md) - Main project guidelines"
   - ❌ Bad: "See main docs"

3. **Related docs** - Sibling documents:
   - ✅ Good: "[API_AUTH.md](./API_AUTH.md), [DATABASE.md](./docs/DATABASE.md)"
   - ❌ Bad: "Other relevant docs"

4. **Use for** - Primary use case:
   - ✅ Good: "Step-by-step deployment instructions"
   - ❌ Bad: "Deployment stuff"

5. **Don't use for** - Anti-use cases (critical!):
   - ✅ Good: "Architecture decisions (see docs/decisions/)"
   - ❌ Bad: [omitted]

**Example** (from dev-hunting):
```markdown
<!-- AI NAVIGATION -->
**For AI Assistants**:
- **Read this when**: User asks about bug hunting learning plan or weekly goals
- **Parent context**: [../AGENTS.md](../AGENTS.md) - Main project guidelines
- **Related docs**: [week-1/README.md](./week-1/README.md) - Current week's goals
- **Use for**: Understanding the 12-week learning roadmap for Phase 0
- **Don't use for**: Actual bug hunting (this is planning only)
- **Navigation**: See [../DOCS-MAP.md](../DOCS-MAP.md)
```

---

### 2. Machine-Readable Metadata

**Purpose**: Structured data AI can parse programmatically.

**Template**: See [doc-components/METADATA-BLOCK.template](./doc-components/METADATA-BLOCK.template)

**Structure**:
```markdown
**Purpose**: [One-sentence description]
**Context Level**: [Main | Quick Reference | Deep Dive | Historical | Reference]
**Last Updated**: YYYY-MM-DD
**Status**: [Active | Draft | Deprecated | Archived]
**Template Version**: 1.5.1
```

**Context Levels Explained**:

| Level | Description | Example Files | Detail Level |
|-------|-------------|---------------|--------------|
| **Main** | Core project guidelines | AGENTS.md | Complete (100%) |
| **Quick Reference** | Summaries and command lookups | CLAUDE.md | Summary (20%) |
| **Deep Dive** | Implementation details | docs/guides/* | Detailed (150%) |
| **Historical** | Past context and decisions | docs/decisions/* | Archival |
| **Reference** | Technical specs, API docs | docs/api/* | Specification |

**Example**:
```markdown
**Purpose**: Quick reference summary of AGENTS.md for fast lookups
**Context Level**: Quick Reference
**Last Updated**: 2025-11-14
**Status**: Active
**Template Version**: 1.5.1
```

---

### 3. Master Navigation (DOCS-MAP.md)

**Purpose**: Single source of truth for all project documentation.

**Template**: See [doc-components/DOCS-MAP.md.template](./doc-components/DOCS-MAP.md.template)

**When Required**:
- Projects with >5 documentation files
- Multi-service platforms
- Complex documentation hierarchies

**Structure**:
1. **How to Use This Map** (guide section)
2. **Root Documentation** (⚡ high priority)
3. **Strategic Documentation** (📋 planning)
4. **Implementation Guides** (🔧 execution)
5. **Architecture & Decisions** (🏛️ historical)
6. **Technical Reference** (📚 reference)
7. **Active Workspace** (🎯 current work)
8. **Navigation Shortcuts** (by context, audience, task)

**Example Entry**:
```markdown
## Root Documentation (⚡ High Priority)

| File | Purpose | Read When | Size |
|------|---------|-----------|------|
| [AGENTS.md](./AGENTS.md) | Main AI context | Starting any task | ~20KB |
| [CLAUDE.md](./CLAUDE.md) | Quick reference | Quick command lookup | ~2KB |
```

**Update Frequency**: Every time you add/remove/move documentation files.

---

### 4. Architecture Decision Records (ADRs)

**Purpose**: Document WHY decisions were made, not just WHAT.

**Template**: See [doc-components/ADR-TEMPLATE.md](./doc-components/ADR-TEMPLATE.md)

**Structure**:
1. **Context** - Why is this decision needed?
2. **Decision** - What did we choose?
3. **Consequences** - Positive, negative, neutral
4. **Alternatives Considered** - What else? Why rejected?
5. **Implementation Notes** - How to implement
6. **References** - Links to research/discussions

**Critical Section**: **Alternatives Considered**

Every ADR must document:
- At least 2 alternatives considered
- Explicit "Why Rejected" for each alternative
- Trade-offs honestly assessed

**Example** (abbreviated):
```markdown
# ADR 001: Dev VM Network Architecture

**Status**: Accepted
**Date**: 2025-11-12

## Context

Need to access dev VM from laptop. Two options:
1. VM has own Tailscale node (direct access)
2. ProxyJump through production-server host

## Decision

VM will have its own Tailscale node.

## Alternatives Considered

### Alternative 1: ProxyJump via production-server

**How it works**: `ssh -J production-server dev-vm`

**Pros**:
- One fewer Tailscale node (simpler network)
- VM doesn't need Tailscale installed

**Cons**:
- Requires production-server to be running (dependency)
- Extra hop (latency)
- More complex SSH config

**Why Rejected**: Creates dependency on production-server. Phase 1 will need direct access.

### Alternative 2: Do Nothing (Local VM)

**Why Rejected**: Laptop can't run VMs with adequate resources.
```

**File Naming**: `001-decision-name.md`, `002-next-decision.md` (sequential)

---

## File Types and Templates

### Core Documentation Files

| File | Purpose | Template | Required |
|------|---------|----------|----------|
| **AGENTS.md** | Main AI context | AGENTS.md.template | ✅ Yes |
| **CLAUDE.md** | Quick reference | CLAUDE.md.template | ✅ Yes |
| **DOCS-MAP.md** | Master navigation | DOCS-MAP.md.template | If >5 docs |
| **STATUS.md** | Project state | STATUS.md.template | Recommended |
| **NEXT-SESSION-START-HERE.md** | Session continuity | NEXT-SESSION-START-HERE.md.template | Recommended |
| **JIMMYS-WORKFLOW.md** | Validation system | (reference copy) | ✅ Yes |

### Documentation Directories

**Recommended Structure**:
```
project/
├── AGENTS.md (main context)
├── CLAUDE.md (quick reference)
├── DOCS-MAP.md (navigation)
├── STATUS.md (current state)
├── NEXT-SESSION-START-HERE.md (session context)
├── JIMMYS-WORKFLOW.md (validation)
├── README.md (public documentation)
│
└── docs/
    ├── plans/ (strategic planning)
    │   ├── ROADMAP.md
    │   └── BUSINESS-MODEL.md
    │
    ├── guides/ (implementation guides)
    │   ├── SETUP.md
    │   ├── DEPLOYMENT.md
    │   └── TESTING.md
    │
    ├── decisions/ (ADRs)
    │   ├── 001-tech-stack.md
    │   └── 002-deployment-strategy.md
    │
    ├── api/ (technical reference)
    │   └── API-REFERENCE.md
    │
    └── architecture/
        ├── ARCHITECTURE.md
        └── DATABASE-SCHEMA.md
```

---

## Best Practices

### 1. Start with AI Navigation

**Every documentation file should start with**:
1. Title (# heading)
2. AI Navigation Header
3. Metadata Block
4. Separator (---)
5. Content

**Example**:
```markdown
# Deployment Guide

<!-- AI NAVIGATION -->
**For AI Assistants**:
- **Read this when**: User asks about deployment procedures
- **Parent context**: [AGENTS.md](./AGENTS.md)
[...rest of header...]

**Purpose**: Step-by-step deployment procedures
**Context Level**: Deep Dive
**Last Updated**: 2025-11-14
**Status**: Active
**Template Version**: 1.5.1

---

## Deployment Process
[content]
```

---

### 2. Use Tables for Structured Data

**Whenever presenting**:
- Technology stacks
- Configuration options
- Command references
- File structures
- Comparisons
- Status indicators

**Use tables instead of prose.**

**Example**:
```markdown
## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `DATABASE_URL` | ✅ Yes | - | PostgreSQL connection string |
| `API_KEY` | ✅ Yes | - | Third-party API key |
| `PORT` | ⚠️ Optional | 3000 | Server port |
| `LOG_LEVEL` | ⚠️ Optional | info | Logging level (debug, info, warn, error) |
```

---

### 3. Provide Copy-Pasteable Commands

**Bad**:
```markdown
Run the migration command with the production flag.
```

**Good**:
```markdown
```bash
# Run production migrations
npm run migrate:prod

# Verify migration success
npm run migrate:status
```
```

---

### 4. Document Rollback Procedures

**For every risky operation (deployment, migration, config change)**:

```markdown
## Rollback Procedure

**If deployment fails**:
```bash
# 1. Revert code
git revert HEAD
git push origin main --force

# 2. Rollback database
npm run migrate:rollback:prod

# 3. Verify rollback
curl https://api.example.com/health
```

**Expected Recovery Time**: 5-10 minutes
```

---

### 5. Link Decisions to ADRs

**In implementation docs, reference WHY**:

```markdown
## Database Connection Pooling

**Current Configuration**:
- Pool size: 20 connections
- Idle timeout: 30 seconds
- Connection timeout: 5 seconds

**Why These Values**: See [ADR-008: Database Connection Pool Sizing](./docs/decisions/008-db-pool-sizing.md)
```

---

### 6. Update "Last Updated" Dates

**When modifying documentation**:
```markdown
# Before changes
**Last Updated**: 2025-10-01

# After changes
**Last Updated**: 2025-11-14
```

**Pro tip**: Add to your editor as a snippet.

---

### 7. Test with AI

**After writing documentation, validate**:

1. Ask AI: "When should you read [file-name].md?"
   - AI should reference AI Navigation Header

2. Ask AI: "Where is [topic] documented?"
   - AI should reference DOCS-MAP.md

3. Ask AI: "What are the deployment steps?"
   - AI should find and read correct guide

**If AI can't find it, improve your navigation headers.**

---

## Anti-Patterns

### ❌ Anti-Pattern 1: Vague Navigation

**Bad**:
```markdown
**Read this when**: For general information
```

**Why Bad**: "General information" is not a specific trigger.

**Good**:
```markdown
**Read this when**: User asks about database migration procedures or encounters migration errors
```

---

### ❌ Anti-Pattern 2: Missing Anti-Use Cases

**Bad**:
```markdown
<!-- AI NAVIGATION -->
**For AI Assistants**:
- **Read this when**: Deployment questions
- **Use for**: Deployment
```

**Why Bad**: No "Don't use for" section. AI may read this for architecture questions.

**Good**:
```markdown
**Use for**: Step-by-step deployment procedures
**Don't use for**: Architecture decisions (see docs/decisions/), API documentation (see docs/api/)
```

---

### ❌ Anti-Pattern 3: Prose-Heavy Documentation

**Bad**:
```markdown
We use several technologies. React is used for the frontend because it has a great ecosystem. The backend is Node.js which we chose for its performance and JavaScript compatibility.
```

**Why Bad**: AI must parse prose to extract facts.

**Good**: See Principle 1 (Structured Data Over Prose) - use tables.

---

### ❌ Anti-Pattern 4: No Rollback Procedures

**Bad**:
```markdown
## Deployment

1. Run migrations
2. Deploy code
3. Done!
```

**Why Bad**: What if deployment fails? No recovery plan.

**Good**: Include rollback procedures for every risky operation.

---

### ❌ Anti-Pattern 5: Orphan Documents

**Bad**: Create `docs/advanced-config.md` but never:
- Add to DOCS-MAP.md
- Link from parent documentation
- Add AI Navigation Header

**Why Bad**: AI (and humans) will never discover this document.

**Good**: Every document should be:
- Listed in DOCS-MAP.md
- Linked from at least one other document
- Have AI Navigation Header with parent context

---

### ❌ Anti-Pattern 6: Stale Documentation

**Bad**:
```markdown
**Last Updated**: 2023-05-15
[Content describing deprecated v1.0 API]
```

**Why Bad**: AI doesn't know this is outdated.

**Good**:
```markdown
**Last Updated**: 2023-05-15
**Status**: ⚠️ Deprecated - See [v2.0 API Docs](./API-V2.md)
**Deprecated in**: v2.0.0 (2024-10-01)
```

---

### ❌ Anti-Pattern 7: Marketing Language

**Bad**:
```markdown
Our world-class, cutting-edge deployment system leverages best-in-class technologies to deliver enterprise-grade reliability.
```

**Why Bad**: No factual information. Just buzzwords.

**Good**:
```markdown
## Deployment System

**Technology**: GitHub Actions + Render
**Deployment Time**: 5-10 minutes (typical)
**Rollback Time**: 2-3 minutes (automated)
**Uptime**: 99.9% (last 12 months)
```

---

## Validation Checklist

### Documentation Quality Checklist

Use this checklist when creating or updating documentation:

#### AI Navigation Header
- [ ] "Read this when" is specific (not generic)
- [ ] Parent context link exists and works
- [ ] Related docs listed (if applicable)
- [ ] Primary use case clear
- [ ] Anti-use cases specified (critical!)
- [ ] DOCS-MAP.md link present and correct

#### Metadata Block
- [ ] Purpose is one clear sentence
- [ ] Context level appropriate for content depth
- [ ] Date in ISO 8601 format (YYYY-MM-DD)
- [ ] Status reflects reality (Active/Draft/Deprecated/Archived)
- [ ] Template version matches project template version

#### Content Quality
- [ ] Uses structured data (tables, lists) over prose
- [ ] Commands are copy-pasteable (includes full command)
- [ ] Examples provided for complex concepts
- [ ] Cross-references working (no broken links)
- [ ] No marketing language ("world-class", "cutting-edge", "best-in-class")
- [ ] Objective and factual
- [ ] Rollback procedures for risky operations

#### DOCS-MAP.md (if project has >5 docs)
- [ ] All documentation files listed
- [ ] Categories make sense (⚡📋🔧🎯📚🏛️)
- [ ] No broken links (all files exist)
- [ ] "Last Updated" date is current
- [ ] Navigation shortcuts provided

#### ADRs (if used)
- [ ] Context explains WHY decision was needed
- [ ] Decision is specific and actionable
- [ ] At least 2 alternatives documented
- [ ] Each alternative has explicit "Why Rejected" section
- [ ] Consequences include positive AND negative
- [ ] Status at top matches status at bottom
- [ ] Date in ISO 8601 format

---

### Automated Validation

**Run audit script**:
```bash
templates/tools/audit-project.sh --full
```

**Check for broken links**:
```bash
grep -r "](\./" *.md docs/**/*.md | while read line; do
  file=$(echo "$line" | cut -d: -f1)
  link=$(echo "$line" | grep -o '](\..*\.md)' | sed 's/](\(.*\))/\1/')
  [ ! -f "$link" ] && echo "Broken link in $file: $link"
done
```

**Find unfilled placeholders**:
```bash
grep -r "\[FILL:" *.md docs/**/*.md
# Should return no results when complete
```

**Find stale documentation** (>6 months old):
```bash
find docs/ -name "*.md" -mtime +180
```

---

## Examples

### Example 1: dev-hunting Project

**Implementation**: Full AI-optimized documentation

**What They Have**:
- ✅ AI Navigation Headers in all core files (13 root files)
- ✅ Comprehensive DOCS-MAP.md indexing 40+ files
- ✅ Machine-readable metadata in AGENTS.md, CLAUDE.md, STATUS.md
- ✅ Architecture Decision Records (docs/decisions/)
- ✅ Clear parent/child relationships (CLAUDE.md → AGENTS.md)
- ✅ Status indicators throughout (✅🔄⚪⚠️)
- ✅ Explicit context levels (Main, Quick Reference, Deep Dive)

**Results**:
- AI navigates 40+ files accurately
- Loads correct context on first try
- Understands when NOT to read files (anti-use cases work)
- Session continuity excellent (NEXT-SESSION-START-HERE.md)

**Location**: `./your-project/`

**Key Files to Study**:
- AGENTS.md - Main AI context with comprehensive navigation
- DOCS-MAP.md - Master navigation with priorities
- docs/decisions/001-network-architecture.md - Excellent ADR example
- learning/LEARNING-CLAUDE.md - Subdomain context with parent reference

---

### Example 2: Minimal Project (5 Files)

**Implementation**: Lightweight documentation

**What to Include**:
- ✅ AI Navigation Header in AGENTS.md
- ✅ Metadata Block in AGENTS.md
- ✅ Quick reference (CLAUDE.md)
- ⚠️ Skip DOCS-MAP.md (only 5 files - not needed)
- ⚠️ Skip ADRs (no complex decisions yet)

**Files**:
```
project/
├── AGENTS.md (with AI Nav Header + Metadata)
├── CLAUDE.md (quick reference)
├── README.md (public docs)
├── JIMMYS-WORKFLOW.md (reference)
└── STATUS.md (project state)
```

**When to Upgrade**:
- If project grows to >5 documentation files → Add DOCS-MAP.md
- If making architecture decisions → Start using ADRs
- If documentation becomes complex → Add docs/ hierarchy

---

### Example 3: Multi-Service Platform

**Implementation**: Full documentation hierarchy

**Structure**:
```
platform/
├── DOCS-MAP.md (master navigation - ⚡ start here)
├── AGENTS.md (platform-wide guidelines)
├── CLAUDE.md (platform quick reference)
├── JIMMYS-WORKFLOW.md (validation system)
│
├── docs/
│   ├── guides/ (platform guides)
│   │   ├── SETUP.md
│   │   └── DEPLOYMENT.md
│   │
│   ├── decisions/ (platform-wide ADRs)
│   │   ├── 001-microservices-architecture.md
│   │   └── 002-shared-database-strategy.md
│   │
│   └── architecture/
│       ├── SYSTEM-ARCHITECTURE.md
│       └── INTER-SERVICE-COMMUNICATION.md
│
├── service-auth/
│   ├── AGENTS.md (auth-specific, references ../AGENTS.md)
│   ├── CLAUDE.md (auth quick reference)
│   ├── README.md (public API docs)
│   └── docs/
│       ├── AUTH-FLOW.md
│       └── DATABASE-SCHEMA.md
│
└── service-api/
    ├── AGENTS.md (api-specific, references ../AGENTS.md)
    ├── CLAUDE.md (api quick reference)
    ├── README.md (public API docs)
    └── docs/
        ├── ENDPOINTS.md
        └── RATE-LIMITING.md
```

**Key Patterns**:
1. **Root DOCS-MAP.md** indexes everything (master navigation)
2. **Service AGENTS.md** references root AGENTS.md (inheritance)
3. **Platform ADRs** in root docs/decisions/ (cross-service decisions)
4. **Service-specific docs** in service subdirectories

**AI Navigation Example** (service-auth/AGENTS.md):
```markdown
<!-- AI NAVIGATION -->
**For AI Assistants**:
- **Read this when**: User asks about authentication service specifically
- **Parent context**: [../AGENTS.md](../AGENTS.md) - Platform-wide guidelines (read first!)
- **Related docs**: [../docs/architecture/SYSTEM-ARCHITECTURE.md](../docs/architecture/SYSTEM-ARCHITECTURE.md)
- **Use for**: Auth service implementation details
- **Don't use for**: Other services (see ../service-*/AGENTS.md), Platform decisions (see ../docs/decisions/)
- **Navigation**: See [../DOCS-MAP.md](../DOCS-MAP.md)
```

---

## Integration with Jimmy's Workflow

Documentation updates follow **RED/GREEN/CHECKPOINT**:

### 🔴 RED: IMPLEMENT

**Create/update documentation**:
- Write content
- Add AI Navigation Header
- Fill metadata block
- Update DOCS-MAP.md (if file added/removed)
- Cross-reference related docs

**Documentation Checklist**:
- [ ] AI Navigation Header complete (all placeholders filled)
- [ ] Metadata block current
- [ ] Structured data used (tables, lists)
- [ ] Commands copy-pasteable
- [ ] Examples provided
- [ ] Rollback procedures for risky operations
- [ ] Cross-references working

---

### 🟢 GREEN: VALIDATE

**Validation Commands**:

```bash
# 1. Test AI navigation
# Ask AI: "When should you read [file-name].md?"
# Expected: AI references AI Navigation Header accurately

# 2. Test documentation discovery
# Ask AI: "Where is [topic] documented?"
# Expected: AI references DOCS-MAP.md and finds correct file

# 3. Check for broken links
grep -r "](\./" *.md docs/**/*.md | while read line; do
  file=$(echo "$line" | cut -d: -f1)
  link=$(echo "$line" | grep -o '](\..*\.md)' | sed 's/](\(.*\))/\1/')
  [ ! -f "$link" ] && echo "❌ Broken link in $file: $link"
done

# 4. Validate all placeholders filled
grep -r "\[FILL:" *.md docs/**/*.md
# Expected: No results

# 5. Run compliance audit
templates/tools/audit-project.sh --full
# Expected: Pass (or only optional warnings)

# 6. Test commands actually work
# Copy-paste commands from documentation
# Verify they execute without errors
```

**Pass Criteria**:
- [ ] AI correctly identifies when to read each file
- [ ] AI can find documentation via DOCS-MAP.md
- [ ] No broken internal links
- [ ] All [FILL: ...] placeholders replaced
- [ ] Commands execute successfully
- [ ] Audit passes (or only optional warnings)

---

### 🔵 CHECKPOINT: GATE

**Commit documentation**:
```bash
git add DOCS-MAP.md docs/ *.md
git commit -m "docs: Add [description of documentation changes]

- Added AI Navigation Headers to [files]
- Created DOCS-MAP.md for project navigation
- Documented [decision/process/feature]

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

git push origin main
```

**Document Rollback**:
```bash
# Note commit hash for rollback
git log -1
# Commit: abc123def456

# If documentation needs reverting:
git revert abc123def456
# Or:
git reset --hard HEAD~1
```

**Update DOCS-MAP.md metadata**:
```markdown
**Last Updated**: 2025-11-14  # ← Update this date
```

---

## Troubleshooting

### Issue 1: AI Not Reading Correct File

**Symptoms**:
- AI reads wrong documentation file
- AI reads multiple files unnecessarily
- AI says "I don't have documentation on that"

**Diagnosis**:
```markdown
1. Check AI Navigation Header:
   - Is "Read this when" specific enough?
   - Are anti-use cases specified?

2. Check DOCS-MAP.md:
   - Is file listed?
   - Is "Read When" clear?

3. Test directly:
   - Ask AI: "When should you read X.md?"
   - Expected: AI cites navigation header
```

**Solutions**:
- Make "Read this when" more specific
- Add anti-use cases to prevent misuse
- Ensure DOCS-MAP.md lists file correctly
- Add file to DOCS-MAP.md if missing

---

### Issue 2: Broken Links

**Symptoms**:
- Clicking links results in 404
- AI references documents that don't exist

**Diagnosis**:
```bash
# Find broken links
grep -r "](\./" *.md docs/**/*.md | while read line; do
  file=$(echo "$line" | cut -d: -f1)
  link=$(echo "$line" | grep -o '](\..*\.md)' | sed 's/](\(.*\))/\1/')
  [ ! -f "$link" ] && echo "Broken: $file → $link"
done
```

**Solutions**:
- Use relative paths consistently: `./docs/FILE.md` not `docs/FILE.md`
- Update links after moving files
- Validate links after every documentation change
- Use find/replace when reorganizing

---

### Issue 3: Stale Documentation

**Symptoms**:
- Documentation describes old version
- Commands don't work anymore
- AI provides outdated information

**Diagnosis**:
```bash
# Find docs not updated recently
find docs/ -name "*.md" -mtime +180  # >6 months

# Check for old dates
grep -r "Last Updated: 2024" *.md docs/**/*.md
```

**Solutions**:
- Review "Last Updated" dates quarterly
- Mark deprecated docs with `**Status**: ⚠️ Deprecated`
- Add "Applies to: v2.x and later" version stamps
- Archive truly obsolete documentation

---

### Issue 4: Audit Failing

**Symptoms**:
- `audit-project.sh` reports errors
- Check #8 (Documentation Quality) failing

**Diagnosis**:
```bash
templates/tools/audit-project.sh --full
# Read specific error messages
```

**Solutions**:
- **>5 docs but no DOCS-MAP.md**: Create DOCS-MAP.md
- **Missing AI Navigation Headers**: Add to core files (AGENTS.md, CLAUDE.md, major guides)
- **Unfilled placeholders**: Search and replace `[FILL:` patterns
- **Template version mismatch**: Run `templates/tools/check-version.sh`

---

## Summary

**Core Philosophy**: *Documentation is structured data for AI consumption, not just human reading.*

**7 Principles**:
1. ✅ Structured Data Over Prose
2. ✅ Explicit Context
3. ✅ Cause-Effect Relationships
4. ✅ Machine-Readable Formats
5. ✅ Searchable Content
6. ✅ Version-Stamped Documentation
7. ✅ Cross-Referenced Documentation

**Key Components**:
- AI Navigation Headers (when to read)
- Machine-Readable Metadata (version, status, context)
- DOCS-MAP.md (master navigation)
- ADRs (decision documentation)

**When to Apply**:
- ✅ Projects with >5 documentation files
- ✅ Multi-service platforms
- ✅ Long-lived projects (>3 months)
- ⚠️ Optional for simple scripts

**Validation**:
- Test with AI ("When should you read X?")
- Check for broken links
- Run `audit-project.sh --full`
- Verify commands work

**Templates Available**:
- [doc-components/AI-NAVIGATION-HEADER.template](./doc-components/AI-NAVIGATION-HEADER.template)
- [doc-components/DOCS-MAP.md.template](./doc-components/DOCS-MAP.md.template)
- [doc-components/ADR-TEMPLATE.md](./doc-components/ADR-TEMPLATE.md)
- [doc-components/METADATA-BLOCK.template](./doc-components/METADATA-BLOCK.template)

---

## Related Documentation

- [doc-components/README.md](./doc-components/README.md) - How to use documentation templates
- [AGENTS-TEMPLATE-GUIDE.md](./AGENTS-TEMPLATE-GUIDE.md) - Template usage guide
- [init-project.md](./init-project.md) - Project initialization (see Step 13.5)
- [tools/audit-project.sh](./tools/audit-project.sh) - Compliance auditing (Check #8)
- [JIMMYS-WORKFLOW.md](./JIMMYS-WORKFLOW.md) - Validation workflow (RED/GREEN/CHECKPOINT)

---

## Version History

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 1.5.1 | 2025-11-14 | Initial comprehensive documentation standards | Claude + Jimmy |

---

**Template Version**: 1.5.1
**Last Updated**: 2025-11-14
**Status**: Active

<!-- END OF DOCUMENTATION-STANDARDS.md -->
