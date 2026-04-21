{ ... }: {
  imports =
    [ ./gpg-agent.nix ./autorandr.nix ./xfce4-screensaver.nix ./darkman.nix ];
  services.lorri.enable = true;
  systemd.user.startServices = "suggest";
}
