// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import sitemap from '@astrojs/sitemap';

export default defineConfig({
	site: 'https://docs.ydun.io',
	integrations: [
		sitemap(),
		starlight({
			title: 'Ydun AI Workflow',
			description: 'Production-tested templates, principles, and patterns for AI-assisted development. AGENTS.md, Jimmy\'s Workflow, multi-agent coordination, prompt engineering.',
			social: [
				{
					icon: 'github',
					label: 'GitHub',
					href: 'https://github.com/ydun-code-library/Ydun_ai_workflow',
				},
			],
			head: [
				// JSON-LD: Organization
				{
					tag: 'script',
					attrs: { type: 'application/ld+json' },
					content: JSON.stringify({
						'@context': 'https://schema.org',
						'@type': 'Organization',
						name: 'Ydun.io',
						url: 'https://ydun.io',
						description: 'Applied R&D consultancy specializing in decentralised architecture, local-first design, and AI workflows.',
						knowsAbout: [
							'AI-assisted development',
							'Multi-agent AI coordination',
							'Prompt engineering',
							'Local-first architecture',
							'Cardano blockchain development',
							'Rust development',
							'Tauri applications',
						],
					}),
				},
				// JSON-LD: WebSite
				{
					tag: 'script',
					attrs: { type: 'application/ld+json' },
					content: JSON.stringify({
						'@context': 'https://schema.org',
						'@type': 'WebSite',
						name: 'Ydun AI Workflow',
						url: 'https://docs.ydun.io',
						description: 'Production-tested templates, principles, and patterns for AI-assisted development.',
					}),
				},
				// Open Graph
				{
					tag: 'meta',
					attrs: { property: 'og:type', content: 'website' },
				},
				{
					tag: 'meta',
					attrs: { property: 'og:site_name', content: 'Ydun AI Workflow' },
				},
			],
			editLink: {
				baseUrl: 'https://github.com/ydun-code-library/Ydun_ai_workflow/edit/main/docs/',
			},
			lastUpdated: true,
			sidebar: [
				{
					label: 'Getting Started',
					items: [
						{ label: 'Overview', slug: 'getting-started' },
						{ label: 'Installation', slug: 'getting-started/installation' },
						{ label: 'Philosophy', slug: 'getting-started/philosophy' },
					],
				},
				{
					label: 'Templates',
					items: [
						{ label: 'Overview', slug: 'templates' },
						{ label: 'AGENTS.md', slug: 'templates/agents-md' },
						{ label: 'CLAUDE.md', slug: 'templates/claude-md' },
						{ label: 'Session Continuity', slug: 'templates/session-continuity' },
						{ label: 'Initializing a Project', slug: 'templates/initializing-a-project' },
					],
				},
				{
					label: 'Workflow',
					items: [
						{ label: 'Overview', slug: 'workflow' },
						{ label: "Jimmy's Workflow v2.1", slug: 'workflow/jimmys-workflow' },
						{ label: '11 Core Principles', slug: 'workflow/11-principles' },
						{ label: 'Documentation Standards', slug: 'workflow/documentation-standards' },
					],
				},
				{
					label: 'Prompts',
					items: [
						{ label: 'Overview', slug: 'prompts' },
						{ label: 'Audit Framework', slug: 'prompts/audit-framework' },
						{ label: 'CAP Methodology', slug: 'prompts/cap-methodology' },
						{ label: 'Prompt Testing', slug: 'prompts/prompt-testing' },
					],
				},
				{
					label: 'Guides',
					items: [
						{ label: 'Overview', slug: 'guides' },
						{ label: 'Evolution (v1-v4)', slug: 'guides/evolution' },
						{ label: 'Multi-Agent Setup', slug: 'guides/multi-agent-setup' },
						{ label: 'Writing Role Cards', slug: 'guides/role-cards' },
						{ label: 'Handoff Protocol', slug: 'guides/handoff-protocol' },
					],
				},
				{
					label: 'Tech-Specific',
					items: [
						{ label: 'Overview', slug: 'tech' },
						{ label: 'Cardano / Aiken', slug: 'tech/cardano' },
						{ label: 'Solidity', slug: 'tech/solidity' },
					],
				},
				{
					label: 'Research',
					items: [
						{ label: 'Overview', slug: 'research' },
						{ label: 'Haiku 4.5 Findings', slug: 'research/haiku-findings' },
						{ label: 'Orchestrator Pattern', slug: 'research/orchestrator-pattern' },
					],
				},
			],
		}),
	],
});
