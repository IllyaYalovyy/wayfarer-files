# Working in Wayfarer Files

Read README.md and CONTRIBUTING.md first, then only the relevant code and tests.
This fork accepts AI-assisted work under its own contribution policy.

- Preserve existing edits. Inspect Git status and `ktask --json current` before
  editing; never compete with a live ktask attempt for the worktree.
- Follow surrounding Rust style. Keep changes focused and documentation brief.
- Validate the real event, target, state change, and rendered result. Use
  disposable fixtures for file operations; never test destructive actions on
  user data. Follow TESTING.md where relevant and report evidence gaps honestly.
- Keep upstream history and notices. Inspect imported patches against current
  code; preserve original authorship when importing existing commits.
- For every new commit you create here, use Illya Yalovyy
  <1623643+IllyaYalovyy@users.noreply.github.com> as sole author. Never add
  Co-authored-by trailers or bypass Git hooks.
- Run scripts/check.sh for code changes. ktask owns commits during its attempts;
  do not start runners, publish releases, or push without task authorization.
