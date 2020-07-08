# This is free and unencumbered software released into the public domain.

PACKAGE      := conreality
VERSION      := $(shell cat VERSION)
VERSION_MAJOR = $(word 1,$(subst ., ,$(VERSION)))
VERSION_MINOR = $(word 2,$(subst ., ,$(VERSION)))
VERSION_PATCH = $(word 3,$(subst ., ,$(VERSION)))

builddir      = build

prefix        = /usr/local
exec_prefix   = $(prefix)
libdir        = $(exec_prefix)/lib
includedir    = $(prefix)/include
datarootdir   = $(prefix)/share
mandir        = $(datarootdir)/man
man7dir       = $(mandir)/man7

ZIG          ?= zig
PANDOC        = pandoc
YAMLLINT      = yamllint

SOURCES      := VERSION build.zig $(wildcard src/*.zig src/*/*.zig src/*/*/*.zig)

# The default target:

default: all

.PHONY: default

# Rules for compilation:

$(builddir):
	mkdir -p $(builddir)

$(builddir)/$(PACKAGE).pc: $(builddir)

$(builddir)/lib$(PACKAGE).a: $(SOURCES)
	$(ZIG) build static
	@touch $@

$(builddir)/lib$(PACKAGE).so.$(VERSION): $(SOURCES)
	$(ZIG) build shared
	@touch $@

$(builddir)/lib$(PACKAGE).$(VERSION).dylib: $(SOURCES)
	$(ZIG) build shared
	@touch $@

$(builddir)/lib$(PACKAGE).dll: $(SOURCES)
	$(ZIG) build shared
	@touch $@

all: static shared pkgconfig

static:
	$(ZIG) build static

shared:
	$(ZIG) build shared

pkgconfig: $(builddir)/$(PACKAGE).pc

include etc/pkgconfig/rules.mk

.PHONY: all static shared pkgconfig

# Rules for verification:

test: check

check: all

.PHONY: test check

# Rules for installation:

install: installdirs install-headers install-static install-shared install-pkgconfig install-manpages

install-headers:
	@[ -f c/Makefile ] && $(MAKE) -w -C c install || true
	@[ -f cpp/Makefile ] && $(MAKE) -w -C cpp install || true

install-static: $(builddir)/lib$(PACKAGE).a installdirs
	install -c -m 0644 $< $(DESTDIR)$(libdir)

install-shared: installdirs
	[ -f $(builddir)/lib$(PACKAGE).so.$(VERSION) ] && install -c -m 0644 $(builddir)/lib$(PACKAGE).so.$(VERSION) $(DESTDIR)$(libdir) || true
	[ -f $(builddir)/lib$(PACKAGE).$(VERSION).dylib ] && install -c -m 0644 $(builddir)/lib$(PACKAGE).$(VERSION).dylib $(DESTDIR)$(libdir) || true
	[ -f $(builddir)/lib$(PACKAGE).dll ] && install -c -m 0644 $(builddir)/lib$(PACKAGE).dll $(DESTDIR)$(libdir) || true
	[ -f $(builddir)/lib$(PACKAGE).lib ] && install -c -m 0644 $(builddir)/lib$(PACKAGE).lib $(DESTDIR)$(libdir) || true
	[ -f $(builddir)/lib$(PACKAGE).pdb ] && install -c -m 0644 $(builddir)/lib$(PACKAGE).pdb $(DESTDIR)$(libdir) || true

install-pkgconfig: $(builddir)/$(PACKAGE).pc installdirs
	install -c -m 0644 $< $(DESTDIR)$(libdir)/pkgconfig

install-manpages: doc/man/man7/$(PACKAGE).7 installdirs
	install -c -m 0644 $< $(DESTDIR)$(man7dir)

installdirs:
	install -d $(DESTDIR)$(libdir)
	install -d $(DESTDIR)$(libdir)/pkgconfig
	install -d $(DESTDIR)$(man7dir)

installcheck:

.PHONY: install install-headers install-static install-shared install-pkgconfig install-manpages installdirs installcheck

# Rules for uninstallation:

uninstall: uninstall-headers uninstall-static uninstall-shared uninstall-pkgconfig uninstall-manpages

uninstall-headers:
	@[ -f c/Makefile ] && $(MAKE) -w -C c uninstall || true
	@[ -f cpp/Makefile ] && $(MAKE) -w -C cpp uninstall || true

uninstall-static:
	-rm -f $(DESTDIR)$(libdir)/lib$(PACKAGE).a

uninstall-shared:
	-rm -f $(DESTDIR)$(libdir)/lib$(PACKAGE).*

uninstall-pkgconfig:
	-rm -f $(DESTDIR)$(libdir)/pkgconfig/$(PACKAGE).pc

uninstall-manpages:
	-rm -f $(DESTDIR)$(man7dir)/$(PACKAGE).7

.PHONY: uninstall uninstall-headers uninstall-static uninstall-shared uninstall-pkgconfig uninstall-manpages

# Rules for distribution:

dist:

.PHONY: dist

# Rules for development:

manpages: doc/man/man7/$(PACKAGE).7

doc/man/man7/$(PACKAGE).7: doc/man/man7/$(PACKAGE).7.md VERSION
	sed -e "s:@VERSION@:$(VERSION):;" < $< | $(PANDOC) -s -t man -o $@

lint: lint-yaml lint-zig

lint-yaml:
	@find etc -name '*.yaml' | sort | xargs $(YAMLLINT) -c etc/yamllint.yaml

lint-zig:
	@find src -name '*.zig' | sort | xargs $(ZIG) fmt --check

clean:
	@rm -Rf $(builddir) build dist zig-cache *~

distclean: clean

mostlyclean: clean

maintainer-clean: clean

.PHONY: manpages lint lint-yaml lint-zig clean distclean mostlyclean maintainer-clean

.SECONDARY:
.SUFFIXES:
