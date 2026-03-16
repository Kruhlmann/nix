{ ... }: {
  programs.virt-manager.enable = true;
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  programs.dconf.enable = true;
  programs.wireshark.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
