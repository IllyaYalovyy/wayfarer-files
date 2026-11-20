#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

command -v rpmbuild >/dev/null
command -v just >/dev/null
version=$(python3 -c 'import tomllib; print(tomllib.load(open("Cargo.toml", "rb"))["package"]["version"])')
revision=$(git rev-parse --short=12 HEAD)
if [[ -n "$(git status --porcelain)" ]]; then
    echo "Commit changes before packaging so the RPM identifies reproducible source." >&2
    exit 1
fi
installed_version=$(rpm -q --qf '%{VERSION}' cosmic-files 2>/dev/null || true)
release_base=1
if [[ "$installed_version" == "$version" ]]; then
    release_base=$(rpm -q --qf '%{RELEASE}' cosmic-files)
    release_base=${release_base%%.wayfarer.*}
    release_base=${release_base%%.fc*}
fi
release="${release_base}.wayfarer.$(date -u +%Y%m%d%H%M%S).g${revision}"
build_root="$PWD/target/rpm"
mkdir -p "$PWD/target"
payload=$(mktemp -d "$PWD/target/wayfarer-payload.XXXXXX")
trap 'rm -rf "$payload"' EXIT

just build-release --locked
just rootdir="$payload" install
install -Dm644 LICENSE "$payload/usr/share/licenses/cosmic-files/LICENSE"
install -Dm644 README.md "$payload/usr/share/doc/cosmic-files/README.md"
mkdir -p "$build_root"
rpmbuild -bb packaging/cosmic-files.spec \
    --define "_topdir $build_root" \
    --define "upstream_version $version" \
    --define "wayfarer_release $release" \
    --define "payload $payload"
