# ex: set tabstop=4 noexpandtab: 
VERSION = $(shell cat VERSION)
NAME=package-groups
TAGVER = $(shell cat VERSION | sed -e "s/\([0-9\.]*\).*/\1/")
DESTDIR=
ARCH=i586

ifeq ($(VERSION), $(TAGVER))
        TAG = $(TAGVER)
else
        TAG = "HEAD"
endif

all:

install:
	install -d ${DESTDIR}/usr/bin
	install -m 755 scripts/merge-patterns.py ${DESTDIR}/usr/bin/merge-patterns
	install -d ${DESTDIR}/usr/share/package-groups
	install -d ${DESTDIR}/usr/share/package-groups/stylesheets
	install -d ${DESTDIR}/usr/share/package-groups/patterns
	install -m 644 patterns/*yaml ${DESTDIR}/usr/share/package-groups/patterns
	install -m 644 xsl/comps.xsl ${DESTDIR}/usr/share/package-groups/stylesheets

tag:
	git tag -a $(VERSION) -m "$(VERSION)"
	git push --tags

changelog:
	python ./scripts/gitlog2changelog.py

repackage: dist
	osc branch -c Tizen:Base $(NAME)
	rm home\:*\:branches\:Tizen:Base/$(NAME)/*tar.bz2
	cp $(NAME)-$(VERSION).tar.bz2 home\:*\:branches\:Tizen:Base/$(NAME)

	

dist-bz2:
	git archive --format=tar --prefix=$(NAME)-$(VERSION)/ $(TAG) | \
		bzip2  > $(NAME)-$(VERSION).tar.bz2

dist-gz:
	git archive --format=tar --prefix=$(NAME)-$(VERSION)/ $(TAG) | \
		gzip  > $(NAME)-$(VERSION).tar.gz

dist: dist-bz2

clean:
	rm -rf patterns.xml INDEX.xml group.xml *.xml
