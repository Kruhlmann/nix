{ ... }: {
  programs.virt-manager.enable = true;
  programs.zsh.enable = true;
  programs.dconf.enable = true;
  programs.ssh.startAgent = true;
}
