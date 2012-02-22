Summary:	Tizen Package Groups
Name:		package-groups
Version:	1
Release:	1
License:	GPLv2
Group:		System/Base
URL:		http://www.tizen.org
Source:		%{name}-%{version}.tar.bz2
BuildArch:	noarch
BuildRequires:  libxslt
BuildRequires: python-yaml
BuildRequires: python-lxml


%description
Tizen Package Groups

%prep
%setup -q

%build
make 

%install
%make_install


%files
/usr/share/package-groups/*xml

