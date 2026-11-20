# Development

`scripts/check.sh` is shared by local checks, CI, and ktask. It checks formatting,
tests the main package with minimal, default, and all features, and checks all
workspace targets with all features. GUI and filesystem integration evidence
remains task-specific; see CONTRIBUTING.md and TESTING.md.

## ktask

From this checkout, with ktask installed:

```sh
./scripts/configure-ktask.sh
ktask --json checks
ktask --json profile effective
ktask --json list
```

Setup inherits your model defaults, enables baseline checks, and uses local-only
delivery. It does not start a runner or change global defaults. New code tasks
receive independent correctness/evidence and simplicity reviews. Task evidence
belongs in `KTASK_ARTIFACT_DIR`; do not put large logs in Git.

## Upstream

Keep `origin` pointing to this project and `upstream` to
`https://github.com/pop-os/cosmic-files.git`. Review changes before importing them;
do not rewrite published history. Record the original issue/PR and commit for
imported work. There is no automatic upstream merge or deployment.

Keep COSMIC's installation and configuration identifiers. Build a drop-in package
with `scripts/package-rpm.sh`; see packaging/README.md for install and rollback.
Verify compatibility with existing settings before daily-use releases. Distinct
side-by-side installation is deferred. Portal and application-embedded chooser
builds remain separate integration work.
