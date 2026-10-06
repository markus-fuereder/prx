PREFIX ?= $(shell test -d /opt/homebrew && echo /opt/homebrew || echo /usr/local)

install:
	install -m 755 prx $(PREFIX)/bin/prx
	install -d $(PREFIX)/share/man/man1
	install -m 644 prx.1 $(PREFIX)/share/man/man1/prx.1

uninstall:
	rm -f $(PREFIX)/bin/prx $(PREFIX)/share/man/man1/prx.1

test:
	./prx --selftest

.PHONY: install uninstall test
