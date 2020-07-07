prefix        = /usr/local
exec_prefix   = $(prefix)
libdir        = $(exec_prefix)/lib
includedir    = $(prefix)/include
datarootdir   = $(prefix)/share
mandir        = $(datarootdir)/man
man7dir       = $(mandir)/man7

PACKAGE      := conreality
VERSION      := $(shell cat VERSION)
VERSION_MAJOR = $(word 1,$(subst ., ,$(VERSION)))
VERSION_MINOR = $(word 2,$(subst ., ,$(VERSION)))
VERSION_PATCH = $(word 3,$(subst ., ,$(VERSION)))

PANDOC        = pandoc

# The default target:

default: all

# Rules for compilation:

all:

# Rules for verification:

test: check

check:

# Rules for installation:

installdirs:
	install -d $(DESTDIR)$(libdir)
	install -d $(DESTDIR)$(man7dir)

install: installdirs
	install -c -m 0644 doc/man/man7/$(PACKAGE).7 $(DESTDIR)$(man7dir)
	@$(MAKE) -C c install
	@$(MAKE) -C cpp install

installcheck:

# Rules for uninstallation:

uninstall:
	-rm -f $(DESTDIR)$(man7dir)/$(PACKAGE).7
	@$(MAKE) -C c uninstall
	@$(MAKE) -C cpp uninstall

# Rules for distribution:

dist:

# Rules for development:

man: doc/man/man7/conreality.7

doc/man/man7/conreality.7: doc/man/man7/conreality.7.md VERSION
	sed -e "s:@VERSION@:$(VERSION):;" < $< | $(PANDOC) -s -t man -o $@

clean:
	@rm -Rf build dist zig-cache *~

distclean: clean

mostlyclean: clean

maintainer-clean: clean

.PHONY: default all
.PHONY: test check installdirs install installcheck uninstall
.PHONY: clean distclean mostlyclean maintainer-clean
.SECONDARY:
.SUFFIXES:
