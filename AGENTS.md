# prx

Single-file Python TUI (`prx`), with `prx.1` manpage and `prx.example.yaml`.

## Terms

Use the words in [GLOSSARY.md](GLOSSARY.md) (sync, full sync, delta sync,
refresh, restore, cache, watermark, covered-since) exactly as defined there —
in code, comments, UI text, and the manpage.

## After any change

Always run `make install` — it installs `prx` to `$PREFIX/bin` and the manpage
to `$PREFIX/share/man/man1`. A change that is not installed is not shipped.

Run `make test` (`./prx --selftest`) before installing.
