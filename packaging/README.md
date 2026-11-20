# Drop-in packages

## Fedora RPM

Requires Fedora's `rpm-build`, `just`, and the development dependencies in the
root README. From a clean, committed checkout, run `./scripts/package-rpm.sh`.
The RPM is written under `target/rpm/RPMS/`. It builds all three executables with
their normal features and keeps package name `cosmic-files`. Its release suffix
identifies Wayfarer, a UTC build time, and the source commit. This is a local
package recipe, not a Fedora distribution build or a signed public release.

Before switching, download the currently installed Fedora package for rollback:

```sh
mkdir -p target/rollback
dnf download --destdir target/rollback "$(rpm -q cosmic-files)"
sudo dnf install ./target/rpm/RPMS/x86_64/cosmic-files-*.rpm
```

Use the exact RPM path if multiple builds exist. Close Files and log out/in after
installing or rolling back so the desktop applet also uses the selected build.
Rollback using the saved Fedora RPM:

```sh
sudo dnf downgrade ./target/rollback/cosmic-files-*.rpm
```

Alternatively, `sudo dnf distro-sync cosmic-files` selects the enabled
repositories' version. No version lock is installed; newer Fedora packages can
replace this build. Configuration is reused, not deleted on rollback. Back it up
before testing changes that alter its format.

Validate payload/dependencies and a DNF transaction before installation. Daily-use
validation includes launch, existing settings/bookmarks, file operations on
scratch data, desktop icons, and rollback. The package does not replace chooser
code embedded in the COSMIC portal or other applications.

## Pop!_OS 24.04 DEB

On Pop!_OS/Ubuntu 24.04, install `build-essential git rustup python3 dpkg-dev
debhelper libclang-dev libglib2.0-dev libxkbcommon-dev pkg-config`, install the
repository Rust toolchain and `just` 1.59.0 (`cargo install just --locked
--version 1.59.0`), then run
`./scripts/package-deb.sh` from a clean checkout. It builds against the target
system and derives library dependencies with `dpkg-shlibdeps`.

On Fedora, use a separate source copy and container build directory:

```sh
podman build -t wayfarer-deb -f packaging/debian.Containerfile packaging
git clone --no-hardlinks . target/deb-source
mkdir -p target/deb
podman run --rm -e CARGO_BUILD_JOBS=4 -v "$PWD/target/deb-source:/src:Z" \
  -v wayfarer-deb-build:/build -v wayfarer-deb-cargo:/root/.cargo \
  -v "$PWD/target/deb:/out:Z" wayfarer-deb
```

Do not package Fedora executables as a DEB. Save the installed Pop!_OS package
before switching (`apt download cosmic-files=<installed-version>`). Install with
`sudo apt install ./cosmic-files_<version>_<arch>.deb`; rollback with
`sudo apt install --allow-downgrades ./<saved-pop-package>.deb`. No pin is added.
Build architecture follows the build environment; test installation in a Pop!_OS
session before recommending daily use. Source builds are unsigned local packages.
