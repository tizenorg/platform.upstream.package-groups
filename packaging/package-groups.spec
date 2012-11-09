Summary:	Tizen Package Groups
Name:		package-groups
Version:	100
Release:	1
License:	GPLv2
Group:		System/Base
URL:		http://www.tizen.org
Source:		%{name}-%{version}.tar.bz2
BuildRequires:	patterns-base
BuildRequires:	pattern-tools
BuildRequires:	python


%description
Tizen Package Groups

%prep
%setup -q

%build
mkdir -p input
for pp in base; do 
	cp %{_datadir}/package-groups/$i/*.yaml input
done

merge-patterns -a ${ARCH} -p input -o output
xsltproc /usr/share/package-groups/stylesheets/xsl/comps.xsl output/patterns.xml > output/group.xml


%install
install -d %{buildroot}/usr/share/package-groups
install -m 644 output/patterns.xml %{buildroot}/usr/share/package-groups
install -m 644 group.xml %{buildroot}/usr/share/package-groups

%files
%{_datadir}/package-groups/*.xml

