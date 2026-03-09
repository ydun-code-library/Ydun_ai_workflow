# AI-Driven SEO Best Practices

**Version**: 1.0.0
**Status**: Active
**Last Updated**: 2026-01-22
**Parent Context**: Web Development, Marketing

<!-- AI NAVIGATION -->
**For AI Assistants**:
- **Read this when**: User asks about SEO, LLM optimization, AI search visibility, structured data, or llms.txt
- **Parent context**: Web development projects, marketing optimization
- **Related docs**: [DOCUMENTATION-STANDARDS.md](./DOCUMENTATION-STANDARDS.md)
- **Use for**: Implementing modern SEO that optimizes for both traditional search and AI/LLM discovery
- **Don't use for**: Content strategy, copywriting, paid advertising
- **Navigation**: Comprehensive reference guide with implementation templates

---

## Table of Contents

1. [Introduction](#introduction)
2. [The Shift: Traditional SEO vs AI Search](#the-shift-traditional-seo-vs-ai-search)
3. [Core Strategies](#core-strategies)
4. [Implementation Guide](#implementation-guide)
5. [File Templates](#file-templates)
6. [Structured Data (JSON-LD)](#structured-data-json-ld)
7. [Technical Requirements](#technical-requirements)
8. [Validation Checklist](#validation-checklist)
9. [Integration with Jimmy's Workflow](#integration-with-jimmys-workflow)
10. [Sources and Further Reading](#sources-and-further-reading)

---

## Introduction

### Why AI-Driven SEO?

Traditional SEO optimizes for search engine crawlers that index keywords and backlinks. In 2026, a significant portion of discovery happens through:

- **AI Assistants**: ChatGPT, Claude, Perplexity answering questions directly
- **AI Overviews**: Google's AI-generated summaries at top of search results
- **LLM-Powered Search**: Bing Copilot, Perplexity, and others that synthesize answers

**Key Insight**: LLMs don't match keywords—they interpret meaning. Structure and clarity matter more than keyword density.

### What This Guide Covers

| Aspect | Traditional SEO | AI-Driven SEO |
|--------|----------------|---------------|
| **Discovery** | Googlebot crawling | GPTBot, ClaudeBot, PerplexityBot |
| **Ranking Factor** | Backlinks, keywords | Clarity, structure, recency |
| **Content Format** | Long-form for dwell time | Direct answers, structured data |
| **Technical** | robots.txt, sitemap | + llms.txt, JSON-LD schemas |
| **Success Metric** | Rankings, traffic | AI citations, visibility |

---

## The Shift: Traditional SEO vs AI Search

### Key Differences

**Traditional SEO Assumptions (Still Valid)**:
- Crawlability and indexation matter
- Site speed affects rankings
- Mobile-first is essential
- Secure (HTTPS) is required

**New AI Search Realities**:
1. **Weak Correlation**: Backlinks and organic traffic have weak correlation with AI citations
2. **Recency Matters**: AI systems discover and cite new content in days, not weeks
3. **Structure Over Keywords**: LLMs parse semantic structure, not keyword density
4. **External Validation**: Third-party mentions matter more than owned content
5. **Direct Answers Win**: Content that directly answers questions gets cited

### What LLMs Look For

| Factor | Importance | Why |
|--------|------------|-----|
| **Entity Clarity** | Critical | AI must understand who you are, what you do, whom you serve |
| **Semantic Structure** | High | Clean heading hierarchy (H1→H2→H3), tables, lists |
| **Freshness** | High | Recent content preferred; keep `lastmod` dates current |
| **Machine-Readability** | High | JSON-LD, schema markup, static HTML |
| **Direct Answers** | High | FAQ blocks, definition lists, summary paragraphs |
| **Depth & Clarity** | Medium | Substantive explanations over surface-level content |

---

## Core Strategies

### Strategy 1: Entity Clarity

Make it crystal clear who you are and what you do:

```html
<!-- Bad: Vague -->
<meta name="description" content="We help businesses grow">

<!-- Good: Entity-clear -->
<meta name="description" content="Ydun – Applied R&D consultancy specializing in decentralised architecture, local-first design, and AI workflows. Founded by James Barclay in Sweden.">
```

**Implementation**:
- Use Organization and Person schemas
- Include `knowsAbout` arrays with expertise areas
- Link to authoritative profiles (LinkedIn, GitHub)

### Strategy 2: Structured Content

Organize content for machine parsing:

**Heading Hierarchy**:
```
H1: Main Topic (one per page)
├── H2: Major Section
│   ├── H3: Subsection
│   └── H3: Subsection
├── H2: Major Section
│   └── H3: Subsection
```

**Direct Answer Pattern**:
```html
<h2>What is Local-First Design?</h2>
<p><strong>Local-first design</strong> is an architecture pattern where
data lives on the user's device first, with cloud sync as optional.
This provides offline capability, faster performance, and user data ownership.</p>
```

### Strategy 3: Machine-Readable Technical Foundation

| Requirement | Implementation |
|-------------|----------------|
| **Rendering** | SSR, SSG, or ISR (not client-side JS only) |
| **Response Time** | <200ms server response |
| **Load Time** | <1s for critical content |
| **Structured Data** | JSON-LD in `<head>` |
| **Sitemap** | XML with `lastmod` dates |
| **llms.txt** | AI-specific content guide |

### Strategy 4: Freshness Signals

AI systems strongly prefer recent content:

- Update `lastmod` in sitemap.xml when content changes
- Include visible "Last Updated" dates on pages
- Refresh evergreen content quarterly
- Add new content regularly

### Strategy 5: External Validation

LLMs weigh third-party mentions heavily:

- Get mentioned on authoritative sites
- Contribute to open source (GitHub visibility)
- Publish on platforms LLMs cite: YouTube, Reddit, Stack Overflow
- Earn genuine backlinks from reputable sources

---

## Implementation Guide

### Phase 1: Foundation (Day 1)

**Files to Create**:

```
/
├── robots.txt          # Allow AI crawlers
├── sitemap.xml         # URL index with lastmod
├── llms.txt            # AI-specific content guide
└── [pages with JSON-LD structured data]
```

**Steps**:
1. Create `robots.txt` allowing AI crawlers
2. Create `sitemap.xml` with current dates
3. Create `llms.txt` with curated content
4. Add JSON-LD to all pages

### Phase 2: Structured Data (Day 2-3)

**Priority Order**:
1. Organization schema (homepage)
2. Person schema (about/team pages)
3. WebSite schema (homepage)
4. Article/TechArticle schemas (blog posts)
5. FAQPage schema (FAQ sections)
6. HowTo schema (tutorials)

### Phase 3: Content Optimization (Ongoing)

- Audit existing content for direct-answer opportunities
- Add FAQ sections to key pages
- Create glossary/definition content
- Ensure heading hierarchy is clean
- Add summary paragraphs at top of long content

---

## File Templates

### robots.txt Template

```
# [Site Name] - robots.txt
# Allow all crawlers including AI/LLM crawlers

User-agent: *
Allow: /

# AI Crawlers - explicitly allowed
User-agent: GPTBot
Allow: /

User-agent: ChatGPT-User
Allow: /

User-agent: Google-Extended
Allow: /

User-agent: Anthropic-AI
Allow: /

User-agent: ClaudeBot
Allow: /

User-agent: PerplexityBot
Allow: /

User-agent: Cohere-AI
Allow: /

# Sitemap location
Sitemap: https://www.example.com/sitemap.xml
```

### sitemap.xml Template

```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://www.example.com/</loc>
    <lastmod>2026-01-22</lastmod>
    <changefreq>monthly</changefreq>
    <priority>1.0</priority>
  </url>
  <url>
    <loc>https://www.example.com/about</loc>
    <lastmod>2026-01-22</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
  </url>
  <!-- Add all public pages -->
</urlset>
```

### llms.txt Template

```markdown
# [Company/Site Name]

> [One-sentence description of who you are and what you do]

## About [Company/Site Name]

[2-3 sentence expanded description]

### [Key Topic 1 - e.g., "Services" or "Focus Areas"]

- **[Item 1]**: [One-line description]
- **[Item 2]**: [One-line description]
- **[Item 3]**: [One-line description]

## Key Pages

- [Home](https://www.example.com/): [Brief description]
- [About](https://www.example.com/about): [Brief description]
- [Services](https://www.example.com/services): [Brief description]

## About the Founder/Team

[Brief bio with key credentials and expertise]

### Technical Stack / Expertise

| Domain | Technologies/Skills |
|--------|---------------------|
| [Domain 1] | [Skills/technologies] |
| [Domain 2] | [Skills/technologies] |

## Contact

- Email: [email]
- LinkedIn: [url]
- Website: [url]
```

---

## Structured Data (JSON-LD)

### Organization Schema

```json
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "[Company Name]",
  "url": "https://www.example.com",
  "logo": "https://www.example.com/logo.png",
  "description": "[Detailed description of the organization]",
  "founder": {
    "@type": "Person",
    "name": "[Founder Name]",
    "url": "https://www.example.com/about",
    "sameAs": "https://www.linkedin.com/in/[profile]/"
  },
  "email": "[email]",
  "areaServed": "[Geographic area or 'Global']",
  "knowsAbout": [
    "[Expertise Area 1]",
    "[Expertise Area 2]",
    "[Expertise Area 3]"
  ]
}
```

### Person Schema

```json
{
  "@context": "https://schema.org",
  "@type": "Person",
  "name": "[Full Name]",
  "url": "https://www.example.com/about",
  "image": "https://www.example.com/photo.jpg",
  "jobTitle": "[Title]",
  "worksFor": {
    "@type": "Organization",
    "name": "[Company]",
    "url": "https://www.example.com"
  },
  "description": "[Professional bio]",
  "knowsAbout": [
    "[Skill 1]",
    "[Skill 2]",
    "[Skill 3]"
  ],
  "sameAs": [
    "https://www.linkedin.com/in/[profile]/",
    "https://github.com/[username]",
    "https://twitter.com/[handle]"
  ],
  "email": "[email]",
  "address": {
    "@type": "PostalAddress",
    "addressCountry": "[Country]"
  }
}
```

### WebSite Schema

```json
{
  "@context": "https://schema.org",
  "@type": "WebSite",
  "name": "[Site Name]",
  "url": "https://www.example.com",
  "description": "[Site tagline or description]",
  "potentialAction": {
    "@type": "SearchAction",
    "target": "https://www.example.com/search?q={search_term_string}",
    "query-input": "required name=search_term_string"
  }
}
```

### FAQPage Schema

```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "[Question 1]",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "[Answer 1]"
      }
    },
    {
      "@type": "Question",
      "name": "[Question 2]",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "[Answer 2]"
      }
    }
  ]
}
```

### Adding to HTML

```html
<head>
  <!-- Other head elements -->

  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "Organization",
    "name": "Example Corp",
    ...
  }
  </script>

  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "WebSite",
    ...
  }
  </script>
</head>
```

---

## Technical Requirements

### Server-Side Rendering

Most AI crawlers fetch but do not execute JavaScript:

| Rendering Method | AI Crawler Compatible |
|------------------|----------------------|
| Static HTML | ✅ Best |
| SSG (Static Site Generation) | ✅ Excellent |
| SSR (Server-Side Rendering) | ✅ Good |
| ISR (Incremental Static Regen) | ✅ Good |
| Client-Side JS Only | ❌ Poor |

**Recommendation**: Use static HTML, SSG, or SSR. Avoid SPAs that require JavaScript execution for content.

### Performance Targets

| Metric | Target | Why |
|--------|--------|-----|
| Server Response | <200ms | LLM crawlers have tight retrieval windows |
| Page Load | <1s | Sites <1s get 3x more crawler requests |
| Core Web Vitals | Pass | Google factors these into AI Overviews |
| Mobile-Friendly | Required | Most AI citations come from mobile queries |

### Meta Tags Checklist

```html
<!-- Essential -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="[150-160 chars, entity-clear]">
<title>[Primary Keyword] – [Brand] | [Secondary Info]</title>

<!-- Open Graph (Social/AI) -->
<meta property="og:title" content="[Title]">
<meta property="og:description" content="[Description]">
<meta property="og:type" content="website">
<meta property="og:url" content="[Canonical URL]">
<meta property="og:image" content="[Image URL]">

<!-- Twitter Card -->
<meta name="twitter:card" content="summary">
<meta name="twitter:title" content="[Title]">
<meta name="twitter:description" content="[Description]">

<!-- Canonical -->
<link rel="canonical" href="[Canonical URL]">
```

---

## Validation Checklist

### Pre-Launch Checklist

**Files**:
- [ ] `robots.txt` exists and allows AI crawlers
- [ ] `sitemap.xml` exists with current `lastmod` dates
- [ ] `llms.txt` exists with curated content
- [ ] All pages have JSON-LD structured data

**Technical**:
- [ ] Server response <200ms
- [ ] Pages load <1s
- [ ] Content renders without JavaScript (test: disable JS in browser)
- [ ] Mobile-responsive design
- [ ] HTTPS enabled

**Content**:
- [ ] Clear heading hierarchy (H1→H2→H3)
- [ ] Entity-clear meta descriptions
- [ ] Direct answer paragraphs for key questions
- [ ] `knowsAbout` arrays in Organization/Person schemas
- [ ] FAQ sections where relevant

**Validation Tools**:
- [ ] [Google Rich Results Test](https://search.google.com/test/rich-results) - Test structured data
- [ ] [Schema.org Validator](https://validator.schema.org/) - Validate JSON-LD
- [ ] [PageSpeed Insights](https://pagespeed.web.dev/) - Performance check
- [ ] [Mobile-Friendly Test](https://search.google.com/test/mobile-friendly) - Mobile check

### Post-Launch Monitoring

**Monthly Tasks**:
- [ ] Update `lastmod` dates in sitemap when content changes
- [ ] Review AI search appearance (search your brand in ChatGPT, Perplexity)
- [ ] Check for new AI crawler user agents to allow
- [ ] Refresh evergreen content

**Quarterly Tasks**:
- [ ] Audit structured data for accuracy
- [ ] Review and update llms.txt
- [ ] Check external mentions and citations
- [ ] Update knowsAbout arrays if expertise expands

---

## Integration with Jimmy's Workflow

### PRE-FLIGHT Phase

Before implementing AI-driven SEO:

1. **Audit Current State**:
   - Does robots.txt exist? What does it allow/block?
   - Is there a sitemap.xml? Are dates current?
   - What structured data exists (if any)?
   - How does content render (JS required or static)?

2. **Gather Requirements**:
   - What entities need representation? (Organization, Person, Products)
   - What pages are most important for AI discovery?
   - What expertise areas should be highlighted?

3. **Check Dependencies**:
   - Hosting platform (static, SSR, serverless?)
   - Current meta tag implementation
   - Existing SEO work to preserve

### IMPLEMENT Phase

Execute in order:

```
1. Create/update robots.txt (5 min)
2. Create/update sitemap.xml (10 min)
3. Create llms.txt (30 min)
4. Add JSON-LD to homepage (30 min)
5. Add JSON-LD to key pages (15 min each)
6. Add Open Graph/Twitter meta tags (15 min)
7. Optimize meta descriptions (5 min per page)
```

**Commit Pattern**:
```bash
git commit -m "feat: Add AI-driven SEO optimization

- robots.txt allowing AI crawlers
- sitemap.xml with lastmod dates
- llms.txt for LLM discovery
- JSON-LD structured data (Organization, Person, WebSite)
- Open Graph and Twitter Card meta tags
- Enhanced meta descriptions
"
```

### VALIDATE Phase

1. **Test Structured Data**:
   ```bash
   # Open in browser
   https://search.google.com/test/rich-results?url=[YOUR_URL]
   ```

2. **Verify Files Accessible**:
   ```bash
   curl -I https://www.example.com/robots.txt
   curl -I https://www.example.com/sitemap.xml
   curl -I https://www.example.com/llms.txt
   ```

3. **Test Without JavaScript**:
   - Open DevTools → Settings → Disable JavaScript
   - Verify all content is visible

4. **Check Performance**:
   ```bash
   # Lighthouse CLI or PageSpeed Insights
   lighthouse https://www.example.com --only-categories=performance,seo
   ```

### CHECKPOINT Phase

**Confidence Levels**:

| Level | Criteria |
|-------|----------|
| **High** | All files created, structured data validates, performance passes |
| **Medium** | Files created, minor validation warnings, performance acceptable |
| **Low** | Missing files, validation errors, performance issues |

**Documentation**:
- Update STATUS.md with SEO implementation details
- Note any platform-specific configurations (Vercel, Netlify, etc.)
- Document any deferred items for future sessions

---

## Sources and Further Reading

### Primary Research (2026)

- [LLM SEO in 2026: 8 Strategies to Boost AI Search Visibility](https://seoprofy.com/blog/llm-seo/)
- [How Vercel's adapting SEO for LLMs and AI search](https://vercel.com/blog/how-were-adapting-seo-for-llms-and-ai-search)
- [State of AI Search Optimization 2026](https://www.growth-memo.com/p/state-of-ai-search-optimization-2026)
- [What Is llms.txt? How the New AI Standard Works](https://www.semrush.com/blog/llms-txt/)

### Official Documentation

- [Schema.org](https://schema.org/) - Structured data vocabulary
- [Google Search Central](https://developers.google.com/search) - SEO documentation
- [llmstxt.org](https://llmstxt.org/) - llms.txt specification

### Key Statistics (2026)

- Pages with comprehensive schema markup are cited up to **40% more** in LLM responses
- Sites with <1s load times receive **3x more** crawler requests
- AI systems discover and cite new content in **days**, not weeks
- YouTube and Reddit are consistently in the **top 3 most cited domains** across LLMs

---

## Changelog

### v1.0.0 (2026-01-22)
- Initial release
- Core strategies and implementation guide
- File templates (robots.txt, sitemap.xml, llms.txt)
- JSON-LD schema templates
- Integration with Jimmy's Workflow
- Validation checklist

---

**This document is maintained as part of Jimmy's Templates.**

**Last Updated**: 2026-01-22
**Template Version**: 1.0.0
