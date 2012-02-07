Summary:	MeeGo Package Groups
Name:		package-groups
Version:	0.70
Release:	1
License:	GPLv2
Group:		System/Base
URL:		http://www.meego.com
Source:		%{name}-%{version}.tar.bz2
BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root
BuildRequires:  libxslt


%description
MeeGo Package Groups

%prep
%setup -q

%build
%ifarch %{arm}
make ARCH=arm
%else
make ARCH=i586
%endif

%install
%make_install

%clean
rm -rf %{buildroot}

%files
/usr/share/package-groups/*xml

