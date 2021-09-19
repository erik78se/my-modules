Name:           my-modules
Version:        1
Release:        %{?_pkgrel}%{?dist}
Summary:        Lmod modules

Group:          Utilities
BuildArch:      noarch
License:        GPL
URL:            https://github.com/erik78se/my-modules.git
Source0:	modules.tar.gz

%description
A package with Lmod modules.

%prep
echo "Prep"
%setup -q -n modules
echo "setup"

%build
echo "Build"

%install
echo "install"
rm -rf $RPM_BUILD_ROOT

install -m 0755 -d $RPM_BUILD_ROOT/usr/share/modulefiles/
cp -r * $RPM_BUILD_ROOT/usr/share/modulefiles/


%clean
rm -rf $RPM_BUILD_ROOT

%files
/usr/share/modulefiles/*


%changelog
* Sun Sep 19 2021 Erik Lönroth  1.0.0
  - Initial rpm release
