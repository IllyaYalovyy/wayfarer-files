# Contributing

Human-written, AI-assisted, and AI-generated contributions meet the same bar.
Authoring tools neither qualify nor disqualify a contribution. Contributors own
their changes, must understand them, and must be able to address review findings.

- Define the user problem and observable acceptance criteria before coding.
- Keep changes focused and consistent with surrounding code. Preserve attribution
  and only contribute material compatible with the project's license.
- Provide a regression test for a behavior change where feasible, including a
  meaningful failure or boundary case. Explain any testing gap.
- Record the exact revision, commands, enabled features, environment, results,
  and known limitations. Evidence must exercise the claimed behavior; a mock,
  screenshot, or successful build proves only what it actually tests.
- For UI changes, include before/after images and exercise the actual interaction,
  selection target, keyboard path, and affected windows or dialogs.
- For file mutations, use disposable fixtures and verify contents and metadata,
  cancellation, collisions, partial failure, and source preservation as relevant.
- Performance claims need comparable before/after measurements.

Run `./scripts/check.sh` and the affected cases in [TESTING.md](TESTING.md).
Documentation-only changes need link/content review rather than application tests.
Keep evidence concise and remove secrets and personal paths from shared artifacts.

An independent reviewer must examine the final diff and challenge its evidence.
Automated review helps, but a named human maintainer owns merge and release
decisions. Unresolved correctness or data-loss risks block release. Do not weaken
tests or acceptance criteria merely to obtain a pass. Record untested cases as
untested; a polished report is not a substitute for verification.
