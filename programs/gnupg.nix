{ config, pkgs, lib, ... }: {
  programs.gnupg.enable = true;
  programs.gnupg.enableSSHSupport = true;
}
