#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

# Build against the target distribution's libraries, never Fedora's binaries.
source /etc/os-release
if [[ "$VERSION_ID" != 24.04 || ( "$ID" != ubuntu && "$ID" != pop ) ]]; then
    echo 'Build this package on Pop!_OS/Ubuntu 24.04, or use the Debian build container.' >&2
    exit 1
fi
for tool in dpkg-deb dpkg-gencontrol dpkg-shlibdeps just; do
    command -v "$tool" >/dev/null
done
if [[ -n "$(git status --porcelain)" ]]; then
    echo 'Commit changes before packaging.' >&2
    exit 1
fi
version=$(python3 -c 'import tomllib; print(tomllib.load(open("Cargo.toml", "rb"))["package"]["version"])')
revision=$(git rev-parse --short=12 HEAD)
version="$version+wayfarer.$(date -u +%Y%m%d%H%M%S).g$revision"
architecture=$(dpkg --print-architecture)
mkdir -p target
stage=$(mktemp -d "$PWD/target/wayfarer-deb.XXXXXX")
trap 'rm -rf "$stage"' EXIT

just build-release --locked
just rootdir="$stage" install
install -Dm644 debian/copyright "$stage/usr/share/doc/cosmic-files/copyright"
install -Dm644 README.md "$stage/usr/share/doc/cosmic-files/README.md"
mkdir -p "$stage/DEBIAN"
dpkg-shlibdeps -O \
    -e"$stage/usr/bin/cosmic-files" \
    -e"$stage/usr/bin/cosmic-files-applet" \
    -e"$stage/usr/bin/cosmic-files-thumbnailer" > "$stage/substvars"
printf 'misc:Depends=\n' >> "$stage/substvars"
dpkg-gencontrol -pcosmic-files -v"$version" -P"$stage" -T"$stage/substvars"
rm "$stage/substvars"
output_dir=${DEB_OUTPUT_DIR:-"$PWD/target/deb"}
mkdir -p "$output_dir"
dpkg-deb --root-owner-group --build "$stage" "$output_dir/cosmic-files_${version}_${architecture}.deb"
