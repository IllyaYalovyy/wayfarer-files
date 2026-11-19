#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

cargo fmt --all -- --check
cargo test --locked --package cosmic-files --no-default-features
cargo test --locked --package cosmic-files
cargo test --locked --package cosmic-files --all-features
cargo check --locked --workspace --all-targets --all-features
