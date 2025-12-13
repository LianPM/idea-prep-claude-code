# Skill Template

Use this template when creating `.claude/skills/{skill-name}/SKILL.md` files.

## SKILL.md Structure

```yaml
---
name: {skill-name}
description: >
  {What this skill does}. Use when {triggers/conditions}.
  {Optional: additional context about when to use it}.
---

# {Skill Name}

{Brief intro paragraph explaining the skill's purpose.}

## When to Use

This skill activates when:
- {trigger condition 1}
- {trigger condition 2}
- {trigger condition 3}

## Instructions

{Step-by-step guidance for Claude when this skill is active.}

### Step 1: {First Action}
{Details}

### Step 2: {Second Action}
{Details}

## Reference

{Key information, rules, or patterns to follow.}

### {Category 1}
- {item}
- {item}

### {Category 2}
- {item}
- {item}

## Examples

### Example: {Scenario Name}
{Show how to use the skill in practice}

## Constraints

- {Rule 1}
- {Rule 2}
```

## Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Lowercase, hyphens, max 64 chars |
| `description` | Yes | Max 1024 chars. Include WHAT it does + WHEN to use it |
| `allowed-tools` | No | Comma-separated tool names to restrict access |

## Description Best Practices

**Bad** (too vague):
```yaml
description: Helps with compliance
```

**Good** (specific + triggers):
```yaml
description: >
  Enforces HIPAA compliance rules for PHI handling, data anonymization,
  and audit logging. Use when working with patient data, medical records,
  or any code that processes protected health information.
```

## Directory Structure Options

### Simple Skill (single file)
```
my-skill/
└── SKILL.md
```

### Multi-file Skill
```
my-skill/
├── SKILL.md              # Main skill file (required)
├── reference.md          # Detailed documentation
├── examples.md           # Usage examples
├── checklists/
│   └── validation.md     # Validation checklists
└── scripts/
    └── helper.py         # Utility scripts
```

Reference additional files from SKILL.md:
```markdown
For detailed rules, see [reference.md](reference.md).
For examples, see [examples.md](examples.md).
```

Claude loads these files only when needed (progressive disclosure).

## Example: Domain-Specific Skill

```yaml
---
name: hipaa-enforcer
description: >
  Enforces HIPAA compliance for healthcare applications. Use when writing
  code that handles PHI (Protected Health Information), patient records,
  medical data, or healthcare APIs. Validates data handling, logging, and
  access controls.
---

# HIPAA Enforcer

Ensures all code handling Protected Health Information (PHI) complies with
HIPAA Security Rule requirements.

## When to Use

This skill activates when:
- Writing code that processes patient data
- Implementing healthcare APIs or integrations
- Creating logging or audit systems for medical applications
- Reviewing code for PHI handling

## Instructions

### Step 1: Identify PHI
Before writing code, identify what data qualifies as PHI:
- Patient names, addresses, dates (birth, admission, discharge)
- Medical record numbers, health plan IDs
- Diagnosis codes, treatment information
- Any data that could identify a patient

### Step 2: Apply Safeguards
Ensure all PHI handling includes:
- Encryption at rest and in transit (AES-256, TLS 1.2+)
- Access controls and authentication
- Audit logging for all access
- Minimum necessary data principle

### Step 3: Validate Logging
Check that logs:
- Never contain raw PHI
- Include user ID, timestamp, action, resource
- Are immutable and tamper-evident
- Retain for required period (6 years)

## Reference

### PHI Categories (18 Identifiers)
1. Names
2. Geographic data smaller than state
3. Dates (except year) related to individual
4. Phone numbers
5. Fax numbers
6. Email addresses
7. Social Security numbers
8. Medical record numbers
9. Health plan beneficiary numbers
10. Account numbers
11. Certificate/license numbers
12. Vehicle identifiers
13. Device identifiers
14. Web URLs
15. IP addresses
16. Biometric identifiers
17. Full-face photographs
18. Any unique identifying code

### Required Safeguards
- Administrative: policies, training, risk assessment
- Physical: facility access, workstation security
- Technical: access control, audit controls, encryption

## Constraints

- NEVER log raw PHI to console or files
- ALWAYS encrypt PHI at rest and in transit
- ALWAYS implement audit trails for PHI access
- NEVER store PHI in environment variables or config files
```

## Example: Read-Only Skill with Tool Restrictions

```yaml
---
name: code-reviewer
description: >
  Reviews code for quality, security, and best practices. Use when
  reviewing pull requests, auditing code, or checking for issues.
  Read-only analysis without making changes.
allowed-tools: Read, Grep, Glob
---

# Code Reviewer

Provides read-only code review and analysis.

## When to Use

This skill activates when:
- User asks to review code or a PR
- User wants security or quality analysis
- User asks "what's wrong with this code"

## Instructions

1. Use `Glob` to find relevant files
2. Use `Read` to examine code
3. Use `Grep` to search for patterns
4. Provide detailed feedback without making changes

## Review Checklist

### Code Quality
- [ ] Clear naming conventions
- [ ] Appropriate abstraction levels
- [ ] No code duplication
- [ ] Proper error handling

### Security
- [ ] No hardcoded secrets
- [ ] Input validation present
- [ ] SQL injection prevention
- [ ] XSS prevention

### Performance
- [ ] No N+1 queries
- [ ] Appropriate caching
- [ ] Efficient algorithms
```
