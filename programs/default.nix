{ config, pkgs, ... }: {
  imports = [
    ./hyprland.nix
    ./zsh.nix
  ];
}
