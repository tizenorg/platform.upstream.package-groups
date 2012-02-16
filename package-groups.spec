Summary:	Tizen Package Groups
Name:		package-groups
Version:	0.22
Release:	1
License:	GPLv2
Group:		System/Base
URL:		http://www.meego.com
Source:		%{name}-%{version}.tar.bz2
BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root
BuildArch:	noarch
BuildRequires:  libxslt


%description
MeeGo Package Groups

%prep
%setup -q

%build
make 

%install
rm -rf %{buildroot}
%make_install

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root,-)
/usr/share/package-groups/*xml

