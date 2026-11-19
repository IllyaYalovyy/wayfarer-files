# Wayfarer Files

An independent file manager for COSMIC, derived from
[COSMIC Files](https://github.com/pop-os/cosmic-files). We focus on practical
usability improvements, reliable file operations, and reproducible evidence.

**Early development:** the project name is provisional. Executables, application
IDs, configuration, and installation recipes still use upstream names. Do not
install this checkout over your system file manager. Independent identity and
side-by-side installation are prerequisites for a preview release.

## Development

```sh
git clone https://github.com/IllyaYalovyy/wayfarer-files.git
cd wayfarer-files
cargo build --locked
./scripts/check.sh
```

Use the pinned Rust toolchain. Linux builds need a C/C++ toolchain, pkg-config,
Clang, GLib/GIO and xkbcommon development packages. Validate GUI behavior with
disposable files and a separate test session; builds alone do not establish it.

Contributions are welcome regardless of authoring tools. Read
[CONTRIBUTING.md](CONTRIBUTING.md) for the quality bar and
[DEVELOPMENT.md](DEVELOPMENT.md) for checks and ktask setup.
Report this fork's problems in [our issue tracker](https://github.com/IllyaYalovyy/wayfarer-files/issues).

## Upstream and license

Maintained independently by Illya Yalovyy; not a System76 product. Upstream history,
copyright notices, and the [GPL-3.0-only license](LICENSE) are retained. Useful
upstream fixes remain welcome after review and validation. Upstream authors are
not responsible for this fork or its support.
