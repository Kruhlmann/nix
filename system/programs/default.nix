{ config, pkgs, ... }: { imports = [ ./hyprland.nix ./zsh.nix ]; programs.zsh.enable = true; }
