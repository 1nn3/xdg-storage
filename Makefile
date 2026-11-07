prefix ?= ~/.local

bindir ?= $(prefix)/bin
libdir ?= $(prefix)/lib
mandir ?= $(prefix)/share/man
sharedir ?= $(prefix)/share/xdg-storage

all:

install:
	install -D xdg-rmdups.1 $(DESTDIR)$(mandir)/man1/xdg-rmdups.1
	install -D xdg-rmdups $(DESTDIR)$(bindir)/xdg-rmdups
	install -D xdg-storage.1 $(DESTDIR)$(mandir)/man1/xdg-storage.1
	install -D xdg-storage.5 $(DESTDIR)$(mandir)/man5/xdg-storage.5
	install -D xdg-storage $(DESTDIR)$(bindir)/xdg-storage
	install -D lsaudio $(DESTDIR)$(bindir)/lsaudio
	install -D lsimage $(DESTDIR)$(bindir)/lsimage
	install -D lstext $(DESTDIR)$(bindir)/lstext
	install -D lsvideo $(DESTDIR)$(bindir)/lsvideo
	install -D mv2sha256 $(DESTDIR)$(bindir)/mv2sha256
	install -D mv2sha256.1 $(DESTDIR)$(mandir)/mv2sha256.1
	install -D mv2md5 $(DESTDIR)$(bindir)/mv2md5
	install -D mv2md5.1 $(DESTDIR)$(mandir)/man1/mv2md5.1
	install -D rmbak $(DESTDIR)$(bindir)/rmbak
	install -D rmbak.1 $(DESTDIR)$(mandir)/man1/rmbak.1
	install -D a2audio $(DESTDIR)$(bindir)/a2audio
	install -D a2video $(DESTDIR)$(bindir)/a2video
	install -D video-is $(DESTDIR)$(bindir)/video-is
	install -D image-is $(DESTDIR)$(bindir)/image-is
	install -D rmbackups $(DESTDIR)$(bindir)/rmbackups

uninstall:
	-rm -f $(DESTDIR)$(bindir)/xdg-rmdups
	-rm -f $(DESTDIR)$(mandir)/man1/xdg-rmdups.1
	-rm -f $(DESTDIR)$(bindir)/xdg-storage
	-rm -f $(DESTDIR)$(mandir)/man1/xdg-storage.1
	-rm -f $(DESTDIR)$(mandir)/man5/xdg-storage.5
	-rm -f $(DESTDIR)$(bindir)/lsaudio
	-rm -f $(DESTDIR)$(bindir)/lsimage
	-rm -f $(DESTDIR)$(bindir)/lstexts
	-rm -f $(DESTDIR)$(bindir)/lsvideo
	-rm -f $(DESTDIR)$(bindir)/mv2sha256
	-rm -f $(DESTDIR)$(mandir)/man1/mv2sha256.1
	-rm -f $(DESTDIR)$(bindir)/mv2md5
	-rm -f $(DESTDIR)$(mandir)/man1/mv2md5.1
	-rm -f $(DESTDIR)$(bindir)/rmbak
	-rm -f $(DESTDIR)$(mandir)/man1/rmbak.1
	-rm -f $(DESTDIR)$(bindir)/a2audio
	-rm -f $(DESTDIR)$(bindir)/a2video
	-rm -f $(DESTDIR)$(bindir)/video-is
	-rm -f $(DESTDIR)$(bindir)/image-is
	-rm -f $(DESTDIR)$(bindir)/rmbackups

clean:

distclean: clean

.PHONY: all install clean distclean uninstall

