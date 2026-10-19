```text
 _ __    _ __  __  __
| '_ \  | '__| \ \/ /
| |_) | | |     >  <
| .__/  |_|    /_/\_\
|_|
```

A terminal UI for GitHub pull requests across several repositories and
authors.

prx shows the open, merged and closed PRs of the repositories in your config
in one table: CI state, reviewers and their review state, head branch, title,
and the next action for each PR. It groups stacked PRs under their root and
can act on the selected PR:

- merge a single PR,
- land a whole native GitHub stack in one go,
- link a plain stack into a native one,
- update an out-of-date chain bottom-up,
- re-run failed or canceled CI.

`--plain` and `--json` print the table once and exit, for scripts and AI
agents.

## Requirements

- Python 3.9 or later (standard library only)
- [`gh`](https://cli.github.com/), installed and authenticated
- Optional: the [`gh-stack`](https://github.com/github/gh-stack) extension,
  to link and land stacks
- Optional: a [Nerd Font](https://www.nerdfonts.com/) for the icons; without
  one, set `nerd_font: false` for plain text

## Install

```sh
make test      # run the selftest
make install   # prx to $PREFIX/bin, prx.1 to $PREFIX/share/man/man1
```

`PREFIX` defaults to `/opt/homebrew` if it exists, else `/usr/local`.
`make uninstall` removes both files.

## Configure

Copy the example config and list your repositories and authors:

```sh
mkdir -p ~/.config/prx
cp prx.example.yaml ~/.config/prx/prx.yaml
```

```yaml
repos:
  - name: backend
    url: https://github.com/acme/backend
authors:
  - name: robin
    tag: robin-gh-login
    me: true
```

The other keys and the icon names are in `prx.example.yaml` and `prx(1)`.
Settings can also be changed in the TUI with `,`.

## Use

```sh
prx                          # interactive TUI
prx --plain --state open     # print open PRs and exit
prx --json --all             # all authors, as JSON
```

In the TUI, `?` lists the keys. `man prx` has the full reference: columns,
actions, keys, merging, and the cache.

## Contributing

[GLOSSARY.md](GLOSSARY.md) defines the words prx uses (sync, refresh, stack,
land, and others). Use them as defined in code, UI text, and the manpage.
Run `make test` before `make install`.
