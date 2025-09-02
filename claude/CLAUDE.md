# Development Partnership

We build production code together. I handle implementation details while you
guide architecture and catch complexity early.

## Core Workflow: Research → Plan → Implement → Validate

**Start every feature with:** "Let me research the codebase and create a plan
before implementing."

1. **Research** - Understand existing patterns and architecture
2. **Plan** - Propose approach and verify with you
3. **Implement** - Build with tests and error handling
4. **Validate** - ALWAYS run formatters, linters, and tests after implementation

## Architecture Principles

**This is always a feature branch:**

- Delete old code completely - no deprecation needed
- No versioned names (processV2, handleNew, ClientOld)
- No migration code unless explicitly requested
- No "removed code" comments - just delete it

**Prefer explicit over implicit:**

- Clear function names over clever abstractions
- Obvious data flow over hidden magic
- Direct dependencies over service locators

## Maximize Efficiency

**Parallel operations:** Run multiple searches, reads, and greps in single messages
**Multiple agents:** Split complex tasks - one for tests, one for implementation
**Batch similar work:** Group related file edits together
**Read the docs**: use the context7 MCP to read the docs for any framework / language methods

## Ruby Development Standards

### Required Patterns

- **Early returns** to reduce nesting - flat code is readable code
- prefer few longer methods over many short methods
- prefer to create attr_readers / writers to avoid using instance variables directly

## Problem Solving

**When stuck:** Stop. The simple solution is usually correct.

**When uncertain:** "Let me ultrathink about this architecture."

**When choosing:** "I see approach A (simple) vs B (flexible). Which do you prefer?"

Your redirects prevent over-engineering. When uncertain about implementation,
stop and ask for guidance.

## Testing Strategy

**Match testing approach to code complexity:**

- Complex business logic: Write tests first (TDD)
- Simple CRUD operations: Write code first, then tests
- Hot paths: Add benchmarks after implementation

**Always keep security in mind:** Validate all inputs, use crypto/rand for
randomness, use prepared SQL statements.

**Performance rule:** Measure before optimizing. No guessing.

**Testing Structure**: do not use ad hoc testing strategies, if the language
has a testing framework use that instead. Do not create new files for tests
unless they don't fit existing files.

## Project Specific Guidelines

- Rails projects will include a Gemfile with the Rails gem in the root directory.
  If a project is a Rails project take into account Rails specific configs from
  ~/.claude/RAILS.md

## Progress Tracking

- **TodoWrite** for task management
- **Clear naming** in all code

Focus on maintainable solutions over clever abstractions.
