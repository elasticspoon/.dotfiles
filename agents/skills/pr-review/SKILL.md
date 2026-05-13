---
name: pr-review
description: Reviews the current branch's PR using gh CLI. Identifies critical and medium issues (bugs, performance, security, correctness, risk). Outputs structured review to PR_REVIEW_claude.md. Use when asked to review a PR.
---

# PR Review

## Instructions

First, set thinking to maximum depth for thorough analysis:

```
Use the set_thinking tool to set level to "xhigh"
```

Use the `gh` CLI to access the PR corresponding to this branch.

## IMPORTANT: Read-Only Review

**DO NOT modify any files in the codebase under review.** This is a read-only review process. The ONLY file you should create or modify is the PR_REVIEW_claude.md file at the end of your review. All other files in the repository must remain unchanged.

## Context and Project Guidelines

Before reviewing the PR, search for and read any CLAUDE.md and AGENTS.md files in the codebase being reviewed. These files contain project-specific guidelines, conventions, and standards that MUST be followed:

- **CLAUDE.md**: Contains code style preferences, architecture patterns, testing guidelines, and project-specific workflows
- **AGENTS.md**: Contains agent-specific instructions and guidelines

Apply the guidelines from these files when reviewing the PR. Ensure changes conform to:

- Code style preferences (Ruby, JavaScript/TypeScript, RBS, etc.)
- Testing conventions and requirements
- Architecture patterns and best practices
- Project-specific workflows and standards
- Any other guidelines specified in these files

## Review Focus

Please analyze the changes in the PR and focus on identifying critical issues related to:

- Potential bugs or issues
- Performance
- Security
- Correctness
- Risk aversion:
  - Have feature flags been added around risky code?
  - Have metrics and logging been put into place to diagnose production issues?

If critical issues are found, list them using the following format for each issue:

### Issue Format

For each issue identified, provide:

1. **TLDR**: A one-line summary of the issue (e.g., "Race condition in user session handling")

2. **Explanation**: Describe the issue in plain language that any developer can understand. Avoid jargon where possible.

3. **Example**: Provide a concrete, simple example showing how the problem could occur in practice. Use realistic scenarios.

4. **Suggested Test**: Propose a unit test that would catch this issue by failing. Include:
   - The file path where the test should be added
   - A code snippet or pseudocode for the test
   - What the test asserts and why it would fail with the current code

5. **Simple Resolution** (optional): If there is a straightforward fix that can be described in 1-2 sentences, include it. Skip this for complex issues requiring significant discussion or design decisions.

Example issue entry:

````
### Issue: Null pointer exception on empty user list

**TLDR**: `process_users` crashes when given an empty array

**Explanation**: The function assumes the user list always has at least one element and accesses `users[0]` without checking. When an empty list is passed, this causes a crash.

**Example**: A merchant with a new store that has no customers yet clicks "Export Users". The system calls `process_users([])` which crashes because it tries to access the first element of an empty array.

**Suggested Test**:
- File: `test/services/user_processor_test.rb`
- Test:
  ```ruby
  test "process_users handles empty user list gracefully" do
    result = UserProcessor.process_users([])
    assert_equal [], result
  end
  ```
- This test would fail because the current code raises `IndexError` when accessing `users[0]` on an empty array.

**Simple Resolution**: Add an early return `return [] if users.empty?` at the start of the `process_users` method.
````

If no critical issues are found, look for medium issues:

- Maintainability
- Missing tests
- Consistency of test names with expectations
- General consistency of code

Use the same issue format (TLDR, Explanation, Example, Suggested Test) for medium issues as well.

## Check Existing Comments

After completing your initial review but before finalizing, use the `gh` CLI to fetch and review existing PR comments and review threads:

```bash
gh pr view --comments
gh api repos/{owner}/{repo}/pulls/{number}/comments --jq '.[] | "---\nauthor: \(.user.login)\npath: \(.path)\nbody: \(.body)\n"'
```

For each issue you've identified in your review:

1. Check if similar feedback has already been commented on the PR
2. If similar feedback exists, **read the full discussion thread** including all replies
3. **Re-evaluate your issue based on the discussion**:
   - If the author has provided a convincing justification, downgrade or remove the issue and note it as resolved (e.g., `✅ Resolved in discussion — [brief reason]`)
   - If a reviewer raised the concern and the author acknowledged it with a fix or action item, mark it as resolved
   - If the discussion is unresolved or the author's response doesn't fully address the concern, keep the issue but note the existing discussion and explain what remains unresolved
   - If a bot reviewer (e.g., binks) raised the concern but the code already handles it (false positive), call it out as a non-issue
4. Only mark issues as `⚠️ Already commented` if they are still unresolved after considering the discussion
5. This ensures the review adds value by building on the existing conversation rather than repeating it

## Pattern Consistency Check

For each substantive change in the PR (new classes, methods, services, GraphQL resolvers, etc.):

1. Search the codebase for similar constructs and existing patterns
2. Verify that the change follows existing patterns rather than introducing new ones
3. If the change introduces a new pattern when a similar existing pattern is available:
   - Flag this as an inconsistency
   - Identify the existing pattern (with file paths and examples)
   - Suggest how to refactor the code to use the existing pattern
4. Examples to check:
   - Service classes: Are they following the same structure as other services?
   - Error handling: Is it consistent with how errors are handled elsewhere?
   - Database queries: Are similar query patterns being reused?
   - GraphQL types/resolvers: Do they follow existing conventions?
   - Background jobs: Are they structured like other jobs?
   - Tests: Do they follow the same patterns as other tests?

Sign off with a checkbox emoji: ✅ (approved) or ⚠️ (issues found).

Keep your response concise. Only highlight critical and medium issues that must be addressed before merging. Skip detailed style or minor suggestions unless they impact performance, security, or correctness.

After completing your review, write your review to PR_REVIEW_claude.md.

## Finishing Up

After writing the review file, reset thinking back to normal:

```
Use the set_thinking tool to set level to "medium"
```
