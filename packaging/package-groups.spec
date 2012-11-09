Summary:	Tizen Package Groups
Name:		package-groups
Version:	100
Release:	1
License:	GPLv2
Group:		System/Base
URL:		http://www.tizen.org
Source:		%{name}-%{version}.tar.bz2
BuildRequires:	patterns-base


%description
Tizen Package Groups

%prep
%setup -q

%build
#

%install
install -d %{buildroot}%{_datadir}/package-groups/patterns
for pp in base; do 
	cp %{_datadir}/package-groups/$i/*.yaml %{buildroot}%{_datadir}/package-groups/patterns
done

%files
%{_datadir}/package-groups/patterns/*.yaml

