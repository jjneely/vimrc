# Alacritty terminfo setup

Why this file exists: getting Alacritty to render **24-bit color** and **styled
underlines** (colored undercurls, e.g. spell squiggles) depends on the terminal
advertising the right capabilities through its `terminfo` entry. When that entry
is missing or wrong, programs silently degrade: truecolor washes out, and
undercurls fall back to a plain underline in the text color. This is the runbook
for wiring it up correctly on a fresh machine.

## The reasoning

Programs like Neovim decide what escape sequences to emit by looking up the
current `$TERM` in the terminfo database. Two capabilities matter here:

- `RGB` / direct color: enables 24-bit truecolor output.
- `Smulx` (styled underline) and `Setulc` (underline color): enable undercurl
  and colored underlines. With `Smulx` present, Neovim supplies the underline
  color itself, so `Setulc` is not strictly required.

The trap: the generic `xterm-256color` entry does **not** carry `Smulx`, so if
you force `TERM=xterm-256color` (a common workaround when the `alacritty` entry
is missing) you lose colored undercurls even though Alacritty itself supports
them. The fix is always the same idea: make the `alacritty` terminfo entry
resolvable, then set `TERM = "alacritty"`.

GUI front-ends (Neovide) ignore terminfo and draw natively, which is why they
show the squiggle even when the terminal path is broken. That mismatch is the
tell that this is a terminfo problem, not an application bug.

## Verify current state

```sh
infocmp -x alacritty >/dev/null 2>&1 && echo "entry present" || echo "MISSING"
infocmp -x alacritty | grep -o 'Smulx=[^,]*'   # non-empty means undercurl works
```

If the entry is present and `Smulx` shows up, you are done. Otherwise follow the
section for your OS.

## macOS

The system terminfo database ships an ancient ncurses (6.0) that predates the
`alacritty` entry, and the Alacritty `.app` (Homebrew *cask* or manual install)
does not run `tic`, so nothing installs the entry for you.

Preferred path, if Homebrew `ncurses` is installed: its modern database already
contains `alacritty`. Compile it into your private `~/.terminfo` so every
program finds it, no download required:

```sh
/opt/homebrew/opt/ncurses/bin/infocmp -x alacritty        | tic -x -o ~/.terminfo -
/opt/homebrew/opt/ncurses/bin/infocmp -x alacritty-direct | tic -x -o ~/.terminfo -
```

Fallback, if you do not have Homebrew `ncurses`: pull the source entry and
compile it.

```sh
curl -fsSL -o /tmp/alacritty.info \
  https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info
tic -xe alacritty,alacritty-direct /tmp/alacritty.info
```

## Linux

Most current distros ship ncurses 6.3+ which already includes `alacritty` and
`alacritty-direct` in the system database, so `infocmp -x alacritty` just works.
If it does not:

- Install the distro package that provides the entry. On many distros the
  `alacritty` package installs the terminfo; some also ship a dedicated
  `alacritty-terminfo` package. Check with `pacman -Ql alacritty | grep terminfo`
  (Arch), `dpkg -L alacritty | grep terminfo` (Debian/Ubuntu), or
  `rpm -ql alacritty | grep terminfo` (Fedora).
- If no package covers it, compile from source into your user database:

```sh
curl -fsSL -o /tmp/alacritty.info \
  https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info
tic -xe alacritty,alacritty-direct /tmp/alacritty.info
```

`tic` writes to `~/.terminfo` by default (or `/etc/terminfo` / `/usr/share/terminfo`
when run as root). User scope is enough and needs no privileges.

## FreeBSD

The `x11/alacritty` port/package installs the terminfo entry as part of its
packing list, so a package-managed install of Alacritty usually leaves
`infocmp -x alacritty` working. If you built Alacritty outside of ports, or the
entry is absent, compile it manually with the base-system `tic`:

```sh
fetch -o /tmp/alacritty.info \
  https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info
tic -xe alacritty,alacritty-direct /tmp/alacritty.info
```

This installs into `~/.terminfo`. For a system-wide entry run it as root, which
targets `/usr/share/misc/terminfo`.

## Point Alacritty at the entry

Once `alacritty` resolves, set it in `alacritty.toml`:

```toml
[env]
TERM = "alacritty"
```

Relaunch Alacritty (a full restart, not a live config reload) so newly spawned
shells inherit the new `TERM`.

## tmux notes

Inside tmux the outer `$TERM` becomes whatever `default-terminal` is set to, so
the same capabilities have to be re-established at the tmux layer:

```
set -g  default-terminal "tmux-256color"
set -as terminal-features ",*:RGB"       # forward 24-bit color
set -as terminal-features ",*:usstyle"   # forward styled/colored underlines
```

`tmux-256color` carries `Smulx`, and `usstyle` is what tells tmux to pass the
underline-style and color escapes through to the outer terminal. Without
`usstyle`, colored undercurls are dropped (or mangled) between Neovim and
Alacritty even when both ends support them. After editing, run `tmux kill-server`
so running panes pick up the change; sourcing the config is not enough for
programs that already started.

## Confirming the whole chain

In a fresh Alacritty window (and again inside a fresh tmux session), open a file
that triggers spell highlighting and check for a colored squiggle. Or inspect
what Neovim emits directly:

```sh
echo $TERM                              # alacritty  (or tmux-256color inside tmux)
infocmp -x "$TERM" | grep -o 'Smulx=[^,]*'   # non-empty
```
