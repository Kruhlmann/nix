# AGENTS.md

This file provides guidance for AI coding agents working in this repository.

## Project Overview

This is a personal NixOS system configuration for a single machine (`gesnix`, user `ges`). It declaratively manages both the NixOS system layer and the home-manager user environment using traditional `nix-channel` (no flakes).

## Repository Structure

```
.
├── Makefile              # Primary entrypoint
├── shell.nix             # Dev shell with linting/formatting tools
├── system/               # NixOS system config (copied to /etc/nixos/)
├── home/                 # home-manager config (symlinked to ~/.config/home-manager)
│   └── res/              # Static resource files deployed into ~/
├── pkg/                  # Custom Nix packages
└── scripts/              # Helper scripts
```

### `system/`

NixOS modules for the system layer. `configuration.nix` is the root, importing sub-modules:

- `boot.nix` — bootloader, kernel, NTFS
- `hardware.nix` — AMD GPU, Bluetooth, keyboard
- `network.nix` — NetworkManager, nftables, systemd-resolved with DoT
- `users.nix` — single user `ges`, experimental Nix features
- `virtualization.nix` — Docker, libvirtd/KVM, Waydroid
- `services/` — SSH, Xorg/XMonad, fail2ban, PipeWire, and many system services
- `programs/` — zsh, wireshark, nix-ld, virt-manager

### `home/`

home-manager modules for the user environment. `home.nix` is the root:

- `programs/` — Alacritty, Firefox, Neovim, Zsh
- `services/` — GPG agent, autorandr, darkman, xfce4-screensaver
- `files.nix` — deploys `res/` into `~/.config/` and `~/.local/bin/`
- `gtk.nix` — Gruvbox-Dark theme, Papirus icons
- `session.nix` — XMonad xsession, environment variables
- `res/` — static dotfiles, scripts, wallpapers, XMonad config

### `pkg/`

Custom packages shared between system and home layers:

- `extra-certs/` — bundles `.cer` files into system trust store
- `bedstead/` — Bedstead OTF font
- `punlock/` — Rust password unlocker utility
- `dfhack/` — DFHack for Dwarf Fortress (defined, not currently wired in)
- `turtle-wow/` — full Turtle WoW private server client (complex; addons, mods, macros, config generation)

## Development Workflow

### Enter the dev shell

```sh
nix-shell   # or: direnv allow (auto-activates via .envrc)
```

### Linting

```sh
make lint   # checks nixfmt, ormolu (Haskell), shellharden, checkmake
make fix    # auto-formats in place
```

### Applying changes

```sh
make install-system   # copies system/ and pkg/ to /etc/, runs nixos-rebuild switch
make install-user     # symlinks home/ and pkg/, runs home-manager switch
make install          # both of the above
```

## Conventions

- **One concern per file.** Each functional area (e.g. SSH, PipeWire, Alacritty) gets its own `.nix` file.
- **`default.nix` for grouping.** Directories like `services/` and `programs/` use a `default.nix` containing only `imports = [...]`.
- **Resources in `home/res/`.** Static config files, scripts, and assets live here and are deployed via `home.file` entries in `files.nix`, not inline in Nix expressions.
- **Custom packages via relative paths.** `pkg/` packages are called with `pkgs.callPackage` using relative paths — there is no overlay registry or flake input.
- **No flake.nix.** The repo uses `nix-channel`. Do not add a `flake.nix` unless explicitly requested.
- **`hardware-configuration.nix` is gitignored.** It must be generated locally with `nixos-generate-config`. Never commit it.
- **Formatting.** All `.nix` files must pass `nixfmt --check`. Haskell files (XMonad config) must pass `ormolu`. Shell scripts must pass `shellharden`.

## CI

GitHub Actions runs `make lint` on every push and pull request. Changes must pass linting before merging.

## Key Design Details

- **Single machine, single user.** Values for hostname, username, display resolution, GPU, and keyboard are hardcoded throughout. Do not abstract for multi-host support unless asked.
- **No flakes.** `stateVersion` is `"23.11"`; channel is `nixos-25.11`. This mismatch is intentional.
- **Gruvbox theme.** GTK, Alacritty, and Neovim all use Gruvbox Dark. Light/dark switching is handled by `darkman` via hook scripts in `files.nix`.
- **Window manager.** XFCE (no desktop manager, no XFWM) + XMonad. The session is `xfce+xmonad`, configured in `system/services/xorg.nix` and `home/session.nix`.
- **`pkg/` is shared.** Installed to both `/etc/pkg/` (system) and `~/.config/pkg/` (user) so both config layers reference it with the same relative path.
