---
alwaysApply: true
---

## Writing

- Write plain, concise English. Use short sentences, active voice, and consistent terms.

## Code style

- Avoid comments that repeat the code. Explain non-obvious decisions and constraints only if needed.
- Test observable behavior and meaningful failure cases. Avoid tests that repeat implementation logic or only verify mock setup.
- Add defensive checks at trust boundaries or for realistic failure modes. Within trusted code, rely on established invariants. Avoid redundant validation, speculative fallbacks, and error handling that hides bugs.
- For Go, follow https://google.github.io/styleguide/go/guide.

## Git

- Commit with `git commit --gpg-sign --signoff`.
- Use a subject-only commit message, except for the required Signed-off-by trailer.

## PR

- Give PRs a descriptive title and leave the description empty.
- Always open a PR as draft.
