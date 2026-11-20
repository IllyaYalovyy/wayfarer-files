%global debug_package %{nil}
%global _build_id_links none

Name:           cosmic-files
Version:        %{upstream_version}
Release:        %{wayfarer_release}%{?dist}
Summary:        Wayfarer Files, a drop-in COSMIC Files fork
License:        GPL-3.0-only
URL:            https://github.com/IllyaYalovyy/wayfarer-files
Vendor:         Wayfarer Files
Requires:       cosmic-icon-theme >= %{version}
Requires:       gvfs
Requires:       gvfs-fuse
Requires:       xdg-utils

%description
Independent COSMIC Files fork with the original application and configuration
identifiers. Includes the file manager, desktop applet, and thumbnailer.
The COSMIC portal and application-embedded file choosers are not replaced.

%install
mkdir -p "%{buildroot}"
cp -a "%{payload}/." "%{buildroot}/"

%files
%license %{_licensedir}/cosmic-files/LICENSE
%doc %{_docdir}/cosmic-files/README.md
%{_bindir}/cosmic-files
%{_bindir}/cosmic-files-applet
%{_bindir}/cosmic-files-thumbnailer
%{_datadir}/applications/com.system76.CosmicFiles.desktop
%{_datadir}/metainfo/com.system76.CosmicFiles.metainfo.xml
%{_datadir}/thumbnailers/com.system76.CosmicFiles.thumbnailer
%{_datadir}/icons/hicolor/*/apps/com.system76.CosmicFiles.svg
