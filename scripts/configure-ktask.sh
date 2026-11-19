#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

ktask_args=(--json --project "$PWD" --actor-kind ai --actor codex)
ktask "${ktask_args[@]}" init --check-command './scripts/check.sh' --check-timeout-ms 3600000 --check-before-task on
delivery_version=$(ktask "${ktask_args[@]}" delivery | python3 -c 'import json,sys; print(json.load(sys.stdin)["data"]["delivery"]["version"])')
ktask "${ktask_args[@]}" delivery --mode local --remote origin --base main --if-version "$delivery_version"
lens_version=$(ktask "${ktask_args[@]}" lens list | python3 -c 'import json,sys; print(next((x["version"] for x in json.load(sys.stdin)["data"]["lenses"] if x["name"] == "correctness"), 0))')
ktask "${ktask_args[@]}" lens save correctness --scope project --if-version "$lens_version" \
    --description 'Behavior, data safety, and reproducible evidence.' \
    --instructions 'Read CONTRIBUTING.md and the relevant TESTING.md cases. Independently inspect the final diff against the goal and criteria. Trace the real event and action target, state, persistence, and UI. Challenge evidence and report missing coverage without claiming unperformed tests passed. For file operations examine overwrite, cancellation, partial failure, metadata, symlinks, and source preservation as relevant. Report concrete defects with evidence; keep findings proportional to the change.'
current_lenses=$(ktask "${ktask_args[@]}" lens list | python3 -c 'import json,sys; print(",".join(json.load(sys.stdin)["data"]["defaults"]))')
ktask "${ktask_args[@]}" lens defaults --set correctness simplicity --if-current "$current_lenses"
ktask "${ktask_args[@]}" profile effective
ktask "${ktask_args[@]}" checks
