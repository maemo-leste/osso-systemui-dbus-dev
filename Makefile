# This file is part of osso-systemui-dbus-dev
#
# Copyright (C) 2005-2006 Nokia Corporation.  All rights reserved.
#
# Author: David Weinehall <david.weinehall@nokia.com>

INSTALL_DIR := install -d
INSTALL_DATA := install -o root -g root -m 644
INSTALL_DOC := cp -r

DOXYGEN := doxygen

PCDIR := $(DESTDIR)/usr/lib/pkgconfig
INCLUDEDIR := $(DESTDIR)/usr/include/systemui
DOCUMENTATION := $(DESTDIR)/usr/share/doc/osso-systemui-dbus-dev

TOPDIR := $(shell /bin/pwd)
INCDIR := $(TOPDIR)/include/systemui
DOCDIR := $(TOPDIR)/doc

PCFILE  := osso-systemui-dbus.pc
INCLUDE_FILES := \
	$(INCDIR)/dbus-names.h \
	$(INCDIR)/actingdead-dbus-names.h \
	$(INCDIR)/alarm_dialog-dbus-names.h

.PHONY: doc
doc:
	-mkdir $(DOCDIR)
	@$(DOXYGEN) 2> $(TOPDIR)/doc/warnings > /dev/null

clean:
	@if [ x"$(DOCDIR)" != x"" ]; then	\
		rm -rf $(DOCDIR)/*;		\
	fi

.PHONY: install
install: doc
	$(INSTALL_DIR) $(PCDIR) $(INCLUDEDIR) $(DOCUMENTATION)
	$(INSTALL_DATA) $(PCFILE) $(PCDIR)
	$(INSTALL_DATA) $(INCLUDE_FILES) $(INCLUDEDIR)
	$(INSTALL_DOC) $(DOCDIR)/html $(DOCUMENTATION)

.PHONY: distclean
distclean: clean
