---
name: commit
description: Generates a world-class Git commit message for staged changes. Analyzes staged diff, infers type/scope/why, and writes the result to /tmp/<branch-name>-commit. Prompts the user for missing context if needed.
---

# Commit Message Generator

## Instructions

### Step 1: Gather Staged Changes

Run the following to collect context:

```bash
git diff --cached
git diff --cached --stat
git status
```

If nothing is staged, tell the user: "No staged changes found. Please stage your changes with `git add` first." and stop.

### Step 2: Analyze the Diff

From the diff, extract:

1. **Type** — choose one: `feat` / `fix` / `docs` / `style` / `refactor` / `perf` / `test` / `build` / `ci` / `chore` / `revert`
2. **Scope** — the area of the codebase affected (e.g., `models`, `controllers`, `api`, `checkout`, `jobs`, `migrations`, `tests`). Use the most specific applicable scope.
3. **Subject** — imperative mood, capitalized, under 50 chars, no trailing period. Answers: "If applied, this commit will **\_**"
4. **Why / context** — the motivation, business reason, or problem being solved. Not just what changed, but why.
5. **Side effects** — migrations, breaking changes, dependent changes, performance implications.
6. **Issue references** — any ticket/issue numbers referenced in branch name, diff comments, or filenames.

### Step 3: Assess Confidence — The "Why" is Mandatory

The body of a commit message must explain **why** the change was made — the motivation, problem being solved, or decision driving it. A description of _what_ the code does is not sufficient; that can be read from the diff.

Ask yourself: _Would a developer reading this in 6 months understand why this change existed, not just what it did?_

**Always ask the user for the "why" unless** the motivation is unambiguously obvious from the diff itself (e.g., a typo fix, a version bump, or a failing test being corrected with a clear root cause in the code). When in doubt, ask.

Prompt the user:

> "To write a useful commit message I need to understand the motivation behind this change, not just what it does. Could you explain:
>
> - What problem does this solve, or what need does it address?
> - Why now — was something broken, requested, or decided?
> - Any trade-offs, risks, or alternatives you considered?"

Do not proceed to Step 4 until you have a clear answer to "why".

### Step 4: Generate the Commit Message

Use this structure:

```
<type>(<scope>): <subject>

<body — wrapped at 72 chars, explains why/context/side effects>

<footer — issue refs, breaking changes, co-authors>
```

**Rules:**

- Subject line: `type(scope): subject` — total under 50 chars, imperative, capitalized, no period
- Blank line between subject and body
- Body: wrap at 72 chars; explain _why_, not just _what_; use bullets or short paragraphs
- Footer: `Fixes #123`, `BREAKING CHANGE: ...`
- **Never** include `Co-authored-by` lines
- Links: use explicit markdown reference-style — place `[text][n]` inline and list `[n]: <url>` definitions at the bottom of the body or footer, never inline URLs
- Atomic: one logical change per commit — if the diff spans multiple concerns, note it

**Example output:**

```
fix(models): prevent duplicate emails with unique validation

Adds app-level uniqueness check to complement the DB constraint and
avoid race conditions during concurrent sign-ups. Includes tests for
concurrent email registration scenarios.

Fixes #123
```

### Step 5: Strip Redundant "What"

Before validating, scrub the message for any line whose information can be recovered by reading the diff. The commit message must not restate the mechanical contents of the patch.

**Remove** lines like:

- "Adds files `X` and `Y`"
- "Adds method `Z` to class `C`"
- "Renames `foo` to `bar`" (with no reason)
- "Deletes the unused `Baz` module" (with no reason)
- "Bumps dependency from 1.2.0 to 1.3.0" (unless the _reason_ for the bump is included)
- Bullet lists that enumerate changed files, methods, or symbols

**Keep** "what" only when it is inseparable from the "why". Good examples:

- "Rename `process` to `enqueue` so the name reflects that work is deferred, not executed inline."
- "Extract `BillingClient` from `Order` because the billing path now needs to be mocked independently in tests."
- "Drop the `legacy_*` columns; the backfill completed last week and nothing still reads them."

Rule of thumb: if a sentence describes a change that `git diff` already shows, and removing it leaves the motivation intact, delete it.

### Step 6: Validate

After generating, self-validate:

- [ ] Subject ≤ 50 chars
- [ ] Imperative mood ("add", not "adds" or "added")
- [ ] Capitalized subject, no trailing period
- [ ] Body explains _why_ (motivation/problem), not just _what_ (implementation) — if the body could be replaced by reading the diff, it's not good enough
- [ ] No redundant "what": no bullets or sentences that merely enumerate added/removed files, methods, or symbols (see Step 5)
- [ ] Body wrapped at 72 chars
- [ ] Footer has issue refs if applicable
- [ ] Atomic — covers one logical change

### Step 7: Write Output

First, get the current branch name:

```bash
git rev-parse --abbrev-ref HEAD
```

Write the raw commit message (plain text, no markdown) to `/tmp/<branch-name>-commit`. The file should contain only the commit message itself — subject, blank line, body, blank line, footer — exactly as it would appear in a git commit editor.

Copy the file path to the clipboard:

```bash
echo -n '/tmp/<branch-name>-commit' | pbcopy
```

Output the full commit message to the user, then tell them:

> "Commit message written to `/tmp/<branch-name>-commit` (path copied to clipboard). To use it: `git commit -F /tmp/<branch-name>-commit`"
