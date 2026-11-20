# Fedora drop-in package

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
