# God Prompt Methodology, Part 2: The Composable Agentic Prompt (CAP) Workflow for Enterprise-Scale LLM Development

---

## Plain English Introduction

**What problem does this solve?**

In Part 1, we learned about "God Prompts" - single, massive instruction sets that tell an AI how to complete complex tasks. But here's the catch: as these prompts grow to thousands of lines, they become a nightmare to maintain. It's like having a 500-page instruction manual written as one continuous document - finding and fixing problems becomes nearly impossible.

This document (Part 2) solves that problem by showing you how to break that massive prompt into smaller, manageable pieces (like chapters in a book) that you can develop, test, and improve separately - then automatically combine them into the final "God Prompt" when you're ready to use it.

**The key insight: "Develop in pieces, deploy as one"**

Think of it like building with LEGO blocks:
- Each block (component) is designed and tested individually
- Different team members can work on different blocks simultaneously  
- You can swap out old blocks for improved versions without rebuilding everything
- When ready, you snap them together into the final structure

**Real-world example:**

Instead of one 5000-line file that everyone's afraid to touch, you have:
- A "security checking" component (200 lines) owned by the security team
- A "performance analysis" component (150 lines) owned by the platform team  
- A "documentation checker" component (100 lines) owned by the docs team
- A simple script that combines them into the final prompt

**Why is this revolutionary?**

It brings professional software engineering practices to prompt development - version control, testing, team collaboration - while keeping the simplicity of the single-prompt approach.

> 💡 **Want to understand how this works in practice?** Feed this entire document to your favorite LLM and ask: "Walk me through setting up a CAP workflow for my team" or "Show me how to convert my existing monolithic prompt to components" or "What does the testing process look like for a prompt component?" The AI can provide personalized guidance based on your specific situation.

---

## Executive Summary

This document extends the Monolithic Agentic Prompt (MAP) methodology introduced in Part 1. While the MAP approach successfully reduces external application complexity, it introduces the risk of creating a large, unmaintainable prompt monolith. This report details the **Composable Agentic Prompt (CAP) workflow**, a systematic, software-engineering-driven approach for managing this internal complexity. 

The CAP workflow applies principles of **Separation of Concerns (SoC)** and **Test-Driven Development (TDD)** to prompt engineering, enabling teams to develop modular, testable prompt components that are then compiled into a final, highly optimized MAP for deployment. This transforms prompt engineering from an art into a scalable, collaborative, and maintainable discipline.

**Key Innovation**: Develop in modules, deploy as a monolith.

## 1. The Monolith Paradox: The Challenge of Success

The "God Prompt" or MAP methodology simplifies LLM application architecture by consolidating logic into a single, comprehensive prompt, eliminating brittle orchestration code. However, as these prompts grow to thousands of lines to handle complex tasks, they begin to mirror the challenges of legacy monolithic software:

### Current Pain Points

| Challenge | Impact | Example |
|-----------|--------|---------|
| **Low Maintainability** | 5000-line prompt files become cognitive overload | Finding a bug in phase 7 requires understanding phases 1-6 |
| **Collaboration Friction** | Version control conflicts when multiple developers edit | Two teams modifying different lenses cause merge conflicts |
| **Lack of Reusability** | Core logic duplicated across projects | Audit log spec copied to 10 different prompts, each slightly different |
| **Brittle Testing** | Any change requires full end-to-end testing | Fixing a typo in security lens requires 5-minute full test run |
| **Hidden Dependencies** | Phase interactions aren't explicit | Architecture lens assumes security lens populates certain fields |

### The Hidden Cost Multiplier

```python
# The true cost of a monolithic prompt over time
maintenance_cost = (
    initial_development_time * 
    (1 + change_frequency * debugging_difficulty * team_size)
)

# Without proper structure, this grows exponentially
```

## 2. The Solution: The Composable Agentic Prompt (CAP) Workflow

The CAP workflow resolves the monolith paradox by introducing a critical distinction:

> **Develop in modules, deploy as a monolith**

It treats individual prompt components as version-controlled source code and the final God Prompt as a compiled artifact.

### 2.1. Principle 1: Separation of Concerns (SoC)

The prompt is decomposed into a **Prompt Library** of logical, self-contained, version-controlled components:

```
prompt_library/
├── common/
│   ├── role_definitions/
│   │   ├── auditor_role_v1.md
│   │   └── researcher_role_v2.md
│   ├── state_management/
│   │   ├── accumulator_spec_v1.md
│   │   └── audit_log_spec_v2.md
│   └── utilities/
│       ├── deduplication_logic_v1.md
│       └── severity_matrix_v3.md
├── lenses/
│   ├── security/
│   │   ├── security_lens_v1.2.md
│   │   ├── security_lens_v1.2.test.json
│   │   └── CHANGELOG.md
│   ├── architecture/
│   │   ├── architecture_lens_v2.0.md
│   │   └── architecture_lens_v2.0.test.json
│   └── performance/
│       ├── performance_lens_v1.0.md
│       └── performance_lens_v1.0.test.json
├── outputs/
│   ├── markdown_report_v2.md
│   └── json_audit_log_v3.md
└── blueprints/
    ├── codebase_audit_v5.blueprint
    └── security_scan_v2.blueprint
```

#### Component Interface Contracts

Each component declares its dependencies and outputs:

```markdown
<!-- security_lens_v1.2.md -->
---
requires: 
  - state.accumulator.findings[]
  - state.file_index{}
provides:
  - security_findings[]
  - vulnerability_count
version: 1.2
tested_with: claude-3-opus
---

### SECURITY_ANALYSIS_LENS

Input expectations:
- accumulator.file_index must be populated
- Each file must have 'path' and 'content' fields

Processing logic:
[Detailed security analysis instructions...]

Output guarantees:
- Appends findings to accumulator.findings[]
- Each finding has: {type, severity, file, line, evidence}
```

### 2.2. Principle 2: Test-Driven Development (TDD)

Each prompt component is developed against a formal test suite:

#### The TDD Cycle for Prompts

```python
# security_lens_test.py
def test_sql_injection_detection():
    # RED: Write the test first
    test_input = {
        "code": "query = 'SELECT * FROM users WHERE id=' + user_input",
        "file": "user.py",
        "line": 45
    }
    
    expected_output = {
        "finding": {
            "type": "sql_injection",
            "severity": "CRITICAL",
            "file": "user.py",
            "line": 45,
            "evidence": "string_concatenation_with_user_input",
            "cwe": "CWE-89"
        }
    }
    
    # GREEN: Run the component in isolation
    result = run_lens_isolated("security_lens_v1.2.md", test_input)
    
    # Assert the output matches expectations
    assert result["finding"]["type"] == expected_output["finding"]["type"]
    assert result["finding"]["severity"] == "CRITICAL"
    
    # REFACTOR: Improve the lens instructions for clarity
```

#### Component Testing Infrastructure

```python
class PromptComponentTester:
    def __init__(self, llm_client):
        self.llm = llm_client
    
    def test_component(self, component_path, test_cases):
        """Test a single prompt component in isolation"""
        component = load_component(component_path)
        
        for test_case in test_cases:
            # Create minimal prompt with just this component
            test_prompt = f"""
            {component.content}
            
            Input: {json.dumps(test_case.input)}
            
            Provide output in this exact format:
            {json.dumps(test_case.expected_schema)}
            """
            
            result = self.llm.complete(test_prompt)
            assert validate_output(result, test_case.expected)
```

### 2.3. Principle 3: KISS (Keep It Simple, Stupid)

The CAP workflow avoids complex frameworks:

- Each component is a **simple markdown file**
- The compiler is a **straightforward concatenation script**
- Testing uses **basic assertions**
- No complex dependency injection frameworks

## 3. The 4-Step CAP Development Workflow

### Step 1: Architect the Prompt Library

Define clear boundaries and interfaces:

```yaml
# prompt_architecture.yaml
components:
  core:
    - name: role_definition
      version: 1.0
      immutable: true  # Rarely changes
  
  lenses:
    - name: security_lens
      version: 1.2
      owner: security_team
      dependencies: [accumulator_spec]
    
    - name: performance_lens
      version: 1.0
      owner: platform_team
      dependencies: [accumulator_spec, metrics_spec]
  
  outputs:
    - name: audit_report
      version: 2.0
      dependencies: [all_lenses]
```

### Step 2: Develop Components with TDD

```python
# Development workflow for a new lens
class LensDevelopment:
    def develop_new_lens(self, lens_name):
        # 1. Write test cases first
        test_cases = self.define_test_cases(lens_name)
        
        # 2. Create minimal lens that passes tests
        lens_content = self.write_minimal_lens(test_cases)
        
        # 3. Test in isolation
        for test in test_cases:
            result = self.test_isolated(lens_content, test)
            assert result.passes()
        
        # 4. Integration test with other components
        full_prompt = self.assemble_with_dependencies(lens_content)
        integration_result = self.test_integrated(full_prompt)
        
        # 5. Version and commit
        self.commit_component(lens_name, lens_content, test_cases)
```

### Step 3: Assemble with the "Prompt Compiler"

The **Weaver** - a prompt compilation system:

```python
# prompt_compiler.py
import json
import hashlib
from datetime import datetime

class PromptWeaver:
    def __init__(self, library_path="./prompt_library"):
        self.library = library_path
        self.cache = {}
    
    def weave_prompt(self, blueprint_file):
        """
        Compile a blueprint into a final MAP
        """
        blueprint = self.load_blueprint(blueprint_file)
        components = []
        
        # Phase 1: Load and validate components
        for component_ref in blueprint['components']:
            component = self.load_component(component_ref)
            self.validate_interface(component)
            components.append(component)
        
        # Phase 2: Apply optimizations
        if blueprint.get('optimize', True):
            components = self.apply_strategic_minification(components)
        
        # Phase 3: Assemble with metadata
        final_prompt = self.assemble(components, blueprint)
        
        # Phase 4: Generate audit manifest
        manifest = self.generate_manifest(components, final_prompt)
        
        return final_prompt, manifest
    
    def apply_strategic_minification(self, components):
        """
        Minify data structures while preserving instruction clarity
        """
        optimized = []
        for component in components:
            if component.type == 'data_structure':
                # Aggressive minification for data
                component.content = self.minify_json(component.content)
            elif component.type == 'instruction':
                # Preserve readability for instructions
                pass
            optimized.append(component)
        return optimized
    
    def generate_manifest(self, components, final_prompt):
        """
        Create a manifest for debugging and auditing
        """
        return {
            "timestamp": datetime.now().isoformat(),
            "components": [
                {
                    "name": c.name,
                    "version": c.version,
                    "hash": hashlib.md5(c.content.encode()).hexdigest(),
                    "tokens": self.count_tokens(c.content)
                }
                for c in components
            ],
            "total_tokens": self.count_tokens(final_prompt),
            "optimization_savings": self.calculate_savings(components),
            "test_coverage": self.get_test_coverage(components)
        }
```

#### Blueprint Specification

```yaml
# codebase_audit_v5.blueprint
name: "Codebase Audit MAP"
version: "5.0"
target_model: "claude-3-opus"
optimize: true

components:
  # Core setup
  - ref: "common/role_definitions/auditor_role_v1"
  - ref: "common/state_management/accumulator_spec_v1"
  
  # Analysis lenses (order matters)
  - ref: "lenses/security/security_lens_v1.2"
  - ref: "lenses/architecture/architecture_lens_v2.0"
  - ref: "lenses/performance/performance_lens_v1.0"
  - ref: "lenses/testing/test_quality_lens_v1.5"
  
  # Synthesis
  - ref: "common/utilities/deduplication_logic_v1"
  
  # Output formats
  - ref: "outputs/markdown_report_v2"
  - ref: "outputs/json_audit_log_v3"

configuration:
  strategic_minification:
    data_structures: true
    instructions: false
  
  token_budget:
    max_input: 15000
    target_output: 8000
```

### Step 4: Integration Test the Final Artifact

```python
class IntegrationTester:
    def test_assembled_prompt(self, compiled_prompt, test_repository):
        """
        End-to-end test of the compiled MAP
        """
        # 1. Execute the full audit
        result = self.llm.complete(
            compiled_prompt + "\n\nRepository:\n" + test_repository
        )
        
        # 2. Validate structural integrity
        assert self.has_all_phases(result.audit_log)
        assert self.accumulator_consistency(result.audit_log)
        
        # 3. Check inter-lens communication
        assert self.data_flows_correctly(result.audit_log)
        
        # 4. Verify deduplication worked
        assert self.no_duplicate_findings(result.findings)
        
        # 5. Performance benchmarks
        assert result.execution_time < 300  # seconds
        assert result.token_count < 200000
```

## 4. Enhanced Methodology & Advanced Considerations

### 4.1. The "Prompt Architect" Role

The CAP workflow creates a new engineering discipline:

#### Prompt Architect Responsibilities

| Area | Responsibilities | Skills Required |
|------|-----------------|----------------|
| **Design** | Define component interfaces, state schemas | Systems thinking, API design |
| **Development** | Write core components, review contributions | Technical writing, LLM expertise |
| **Testing** | Design test strategies, coverage requirements | QA mindset, automation |
| **Operations** | Monitor performance, optimize token usage | Analytics, cost optimization |
| **Governance** | Version control, deprecation policies | DevOps, change management |

#### Team Structure Example

```
Prompt Engineering Team
├── Prompt Architect (Lead)
├── Component Developers (per domain)
│   ├── Security Lens Owner
│   ├── Performance Lens Owner
│   └── Testing Lens Owner
├── Prompt QA Engineer
└── Prompt Operations Engineer
```

### 4.2. Nuanced Cost-Benefit Analysis

#### Blended Model Strategy vs MAP

| Scenario | Multi-Agent (Blended) | MAP (Single Model) | Winner |
|----------|----------------------|-------------------|---------|
| Simple data extraction + complex analysis | $0.50 (Haiku) + $2.00 (Opus) = $2.50 | $3.00 (Opus for all) | Blended |
| Complex multi-phase reasoning | $5.00 (5x Opus with overhead) | $3.00 (1x Opus) | MAP |
| Real-time streaming needs | Can stream intermediate results | Single long wait | Blended |
| Debugging failed runs | Complex distributed logs | Single audit log | MAP |

#### The True Cost Equation

```python
def calculate_total_cost(approach, project_scale):
    if approach == "MAP":
        return (
            higher_per_run_cost * run_count +
            lower_development_cost +
            minimal_maintenance_cost +
            fast_debugging_cost
        )
    else:  # Multi-agent
        return (
            lower_per_run_cost * run_count +
            high_development_cost +
            high_maintenance_cost +
            slow_debugging_cost * debug_frequency
        )
    
    # MAP wins at scale and complexity
```

### 4.3. Strategic Minification as a Compilation Step

The Weaver performs intelligent optimization:

```python
class StrategicMinifier:
    def minify_component(self, component):
        """
        Apply different strategies based on component type
        """
        strategies = {
            'data_structure': self.aggressive_minify,
            'instruction': self.preserve_readability,
            'example': self.moderate_minify,
            'output_spec': self.selective_minify
        }
        
        return strategies[component.type](component.content)
    
    def aggressive_minify(self, content):
        # Remove all whitespace from JSON/YAML
        return json.dumps(json.loads(content), separators=(',', ':'))
    
    def preserve_readability(self, content):
        # Keep instructions fully readable
        return content
    
    def selective_minify(self, content):
        # Minify data parts, keep descriptions
        lines = content.split('\n')
        result = []
        for line in lines:
            if line.strip().startswith('{') or line.strip().startswith('['):
                result.append(self.aggressive_minify(line))
            else:
                result.append(line)
        return '\n'.join(result)
```

### 4.4. Advanced Testing Patterns

#### Regression Testing

```python
class PromptRegressionTester:
    def __init__(self):
        self.golden_outputs = self.load_golden_outputs()
    
    def test_backwards_compatibility(self, new_component, old_component):
        """
        Ensure new versions don't break existing behavior
        """
        for test_case in self.golden_outputs:
            old_result = self.run_component(old_component, test_case.input)
            new_result = self.run_component(new_component, test_case.input)
            
            # New version should produce compatible output
            assert self.outputs_compatible(old_result, new_result)
```

#### Property-Based Testing

```python
from hypothesis import strategies as st, given

class PropertyBasedPromptTester:
    @given(st.text(min_size=100, max_size=10000))
    def test_lens_always_produces_valid_json(self, input_code):
        """
        Regardless of input, lens should produce valid JSON
        """
        result = self.run_lens(self.security_lens, input_code)
        assert self.is_valid_json(result)
        assert 'findings' in result
        assert isinstance(result['findings'], list)
```

### 4.5. Version Control and Dependency Management

```python
class PromptDependencyManager:
    def check_compatibility(self, blueprint):
        """
        Ensure all components are compatible
        """
        dependency_graph = self.build_dependency_graph(blueprint)
        
        for component in dependency_graph:
            for dependency in component.dependencies:
                if not self.versions_compatible(component, dependency):
                    raise IncompatibleVersionError(
                        f"{component.name} v{component.version} "
                        f"incompatible with {dependency.name} v{dependency.version}"
                    )
    
    def suggest_upgrades(self, blueprint):
        """
        Suggest component updates for better performance
        """
        suggestions = []
        for component in blueprint.components:
            latest = self.get_latest_version(component.name)
            if latest.version > component.version:
                if latest.has_performance_improvements:
                    suggestions.append({
                        'component': component.name,
                        'current': component.version,
                        'suggested': latest.version,
                        'improvement': latest.improvement_description
                    })
        return suggestions
```

## 5. Implementation Roadmap

### Phase 1: Foundation (Weeks 1-2)
- Set up prompt library structure
- Define component interfaces
- Create first 2-3 core components
- Build basic Weaver script

### Phase 2: Migration (Weeks 3-4)
- Decompose existing monolithic prompts
- Create test suites for each component
- Validate components work in isolation

### Phase 3: Optimization (Weeks 5-6)
- Implement strategic minification
- Add performance benchmarking
- Optimize token usage

### Phase 4: Scale (Weeks 7-8)
- Train team on CAP workflow
- Establish governance processes
- Deploy to production

## 6. Case Study: Migrating a 5000-Line Audit Prompt

### Before: Monolithic Chaos
```python
# Single 5000-line file
god_prompt_v1.md  # No one remembers what changed between versions
```

### After: Organized Component Library
```
prompt_library/
├── components/     # 47 tested, versioned components
├── tests/          # 147 test cases
├── blueprints/     # 3 different audit configurations
└── compiled/       # Generated MAPs ready for deployment
```

### Results
- **Development Speed**: 3x faster for new features
- **Bug Resolution**: 10x faster with component isolation
- **Team Productivity**: 5 developers working in parallel
- **Token Efficiency**: 25% reduction through smart minification
- **Test Coverage**: 95% of components have tests
- **Deployment Confidence**: 99.9% reliability

## 7. Common Pitfalls and Solutions

| Pitfall | Impact | Solution |
|---------|--------|----------|
| Over-componentization | Too many tiny files | Minimum component size of 50 lines |
| Circular dependencies | Components require each other | Strict layering architecture |
| Version proliferation | Too many versions to track | Semantic versioning + deprecation policy |
| Test brittleness | Tests break with minor changes | Focus on behavior, not exact text |
| Component coupling | Hidden dependencies | Explicit interface contracts |

## 8. Future Directions

### Emerging Patterns

1. **Prompt Inheritance**: Components extending base components
2. **Conditional Compilation**: Different MAPs for different models
3. **Dynamic Assembly**: Runtime blueprint selection based on input
4. **Prompt Caching**: Reusing compiled prompts with cache keys
5. **A/B Testing**: Running multiple prompt versions in parallel

### Tooling Ecosystem

```python
# Future prompt engineering toolkit
class PromptEngineeringIDE:
    features = [
        "Syntax highlighting for prompt components",
        "Interactive component testing",
        "Visual dependency graphs",
        "Token usage profiler",
        "Automated regression testing",
        "Component marketplace"
    ]
```

## Conclusion: Prompt Engineering as a Software Discipline

The God Prompt (MAP) methodology offers a radically simpler architecture for complex LLM applications. The Composable Agentic Prompt (CAP) workflow provides the engineering discipline required to make it scalable, maintainable, and enterprise-ready.

By treating prompts as source code—with libraries, tests, versioning, and a build process—we move beyond ad-hoc prompt editing. This combined methodology allows organizations to harness the full power of frontier models by managing complexity where it belongs: in a structured, test-driven, and collaborative development workflow that produces a simple, reliable, and auditable monolithic artifact.

The transformation is complete:

| Aspect | Traditional Prompt Engineering | CAP Workflow |
|--------|--------------------------------|--------------|
| Development | Ad-hoc text editing | Component-based development |
| Testing | Manual verification | Automated test suites |
| Collaboration | Difficult merging | Parallel development |
| Maintenance | Full prompt changes | Surgical component updates |
| Deployment | Copy-paste | Compiled artifacts |
| Debugging | Guesswork | Audit log + component tests |

**The future of LLM applications isn't more complex orchestration—it's better prompt engineering.**

---

## Appendix A: Reference Implementation

### Complete Weaver Script

```python
#!/usr/bin/env python3
"""
prompt_weaver.py - Reference implementation of the CAP workflow compiler
"""

import argparse
import json
import yaml
from pathlib import Path
from datetime import datetime
import hashlib

class PromptWeaver:
    def __init__(self, library_path="./prompt_library"):
        self.library_path = Path(library_path)
        self.component_cache = {}
        
    def compile_blueprint(self, blueprint_path, output_path=None):
        """Main entry point for compilation"""
        # Load blueprint
        with open(blueprint_path) as f:
            blueprint = yaml.safe_load(f)
        
        # Load and validate components
        components = self.load_components(blueprint['components'])
        
        # Apply optimizations
        if blueprint.get('optimize', True):
            components = self.optimize_components(components)
        
        # Assemble final prompt
        final_prompt = self.assemble_prompt(components, blueprint)
        
        # Generate manifest
        manifest = self.generate_manifest(components, blueprint, final_prompt)
        
        # Save outputs
        if output_path:
            self.save_outputs(output_path, final_prompt, manifest)
        
        return final_prompt, manifest
    
    def load_components(self, component_refs):
        """Load components from library"""
        components = []
        for ref in component_refs:
            path = self.library_path / f"{ref['ref']}.md"
            with open(path) as f:
                content = f.read()
            
            # Parse frontmatter
            metadata, body = self.parse_frontmatter(content)
            
            components.append({
                'ref': ref['ref'],
                'metadata': metadata,
                'content': body,
                'type': ref.get('type', 'instruction')
            })
        
        return components
    
    def optimize_components(self, components):
        """Apply strategic minification"""
        optimized = []
        for component in components:
            if component['type'] == 'data_structure':
                component['content'] = self.minify_data(component['content'])
            optimized.append(component)
        return optimized
    
    def assemble_prompt(self, components, blueprint):
        """Concatenate components into final prompt"""
        sections = []
        
        # Add header
        sections.append(f"# {blueprint['name']} v{blueprint['version']}")
        sections.append(f"# Compiled: {datetime.now().isoformat()}")
        sections.append("")
        
        # Add components
        for component in components:
            sections.append(f"## Component: {component['ref']}")
            sections.append(component['content'])
            sections.append("")
        
        return "\n".join(sections)
    
    def generate_manifest(self, components, blueprint, final_prompt):
        """Create compilation manifest"""
        return {
            'blueprint': blueprint['name'],
            'version': blueprint['version'],
            'compiled_at': datetime.now().isoformat(),
            'components': [
                {
                    'ref': c['ref'],
                    'version': c['metadata'].get('version'),
                    'hash': hashlib.md5(c['content'].encode()).hexdigest(),
                    'type': c['type']
                }
                for c in components
            ],
            'total_size': len(final_prompt),
            'estimated_tokens': len(final_prompt) // 4  # Rough estimate
        }
    
    def save_outputs(self, output_path, prompt, manifest):
        """Save compiled prompt and manifest"""
        output_path = Path(output_path)
        
        # Save prompt
        prompt_file = output_path / "compiled_prompt.md"
        with open(prompt_file, 'w') as f:
            f.write(prompt)
        
        # Save manifest
        manifest_file = output_path / "manifest.json"
        with open(manifest_file, 'w') as f:
            json.dump(manifest, f, indent=2)
        
        print(f"✅ Compiled prompt saved to {prompt_file}")
        print(f"📋 Manifest saved to {manifest_file}")
    
    @staticmethod
    def parse_frontmatter(content):
        """Extract YAML frontmatter from markdown"""
        lines = content.split('\n')
        if lines[0] == '---':
            end_idx = lines[1:].index('---') + 1
            frontmatter = '\n'.join(lines[1:end_idx])
            body = '\n'.join(lines[end_idx + 1:])
            return yaml.safe_load(frontmatter), body
        return {}, content
    
    @staticmethod
    def minify_data(content):
        """Aggressively minify data structures"""
        # This is a simplified example
        # Real implementation would parse and minify JSON/YAML blocks
        import re
        
        def minify_json_block(match):
            try:
                data = json.loads(match.group(1))
                return '```json\n' + json.dumps(data, separators=(',', ':')) + '\n```'
            except:
                return match.group(0)
        
        # Find and minify JSON blocks
        content = re.sub(r'```json\n(.*?)\n```', minify_json_block, content, flags=re.DOTALL)
        return content


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Compile prompt blueprints into MAPs")
    parser.add_argument('blueprint', help="Path to blueprint file")
    parser.add_argument('-o', '--output', help="Output directory", default="./compiled")
    parser.add_argument('-l', '--library', help="Prompt library path", default="./prompt_library")
    
    args = parser.parse_args()
    
    weaver = PromptWeaver(library_path=args.library)
    weaver.compile_blueprint(args.blueprint, args.output)
```

## Appendix B: Sample Component Test Suite

```python
# test_security_lens.py
import pytest
import json
from prompt_tester import ComponentTester

class TestSecurityLens:
    def setup_method(self):
        self.tester = ComponentTester()
        self.lens_path = "lenses/security/security_lens_v1.2.md"
    
    def test_detects_sql_injection(self):
        """Test that SQL injection is properly detected"""
        test_input = {
            "code": "query = 'SELECT * FROM users WHERE id=' + request.params.id",
            "file": "api.py",
            "line": 42
        }
        
        result = self.tester.run_component(self.lens_path, test_input)
        
        assert result['finding']['type'] == 'sql_injection'
        assert result['finding']['severity'] == 'CRITICAL'
        assert 'CWE-89' in result['finding']['cwe']
    
    def test_ignores_safe_parameterized_queries(self):
        """Test that safe queries aren't flagged"""
        test_input = {
            "code": "cursor.execute('SELECT * FROM users WHERE id=?', (user_id,))",
            "file": "db.py",
            "line": 10
        }
        
        result = self.tester.run_component(self.lens_path, test_input)
        
        assert 'finding' not in result or result['finding'] is None
    
    def test_handles_malformed_input_gracefully(self):
        """Test error handling for bad input"""
        test_input = {"malformed": "data"}
        
        result = self.tester.run_component(self.lens_path, test_input)
        
        assert 'error' in result
        assert result['error']['handled'] == True
```

---

*This document represents the evolution of prompt engineering from art to engineering discipline. Version 1.0, November 2024.*