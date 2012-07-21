Summary:	Tizen Package Groups
Name:		package-groups
Version:	0.13
Release:	1
License:	GPLv2
Group:		System/Base
URL:		http://www.tizen.org
Source:		%{name}-%{version}.tar.bz2


%package tools
Summary:    Package Group Tools
Group:		System/Base
Requires:  libxslt
Requires: python-yaml
Requires: python-lxml

%description tools
Tools for managing package groups and patterns.


%description
Tizen Package Groups

%prep
%setup -q

%build
make 

%install
%make_install


%files
/usr/share/package-groups/patterns/*.yaml


%files tools
/usr/bin/merge-patterns
/usr/share/package-groups/stylesheets/*.xsl
