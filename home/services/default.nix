{ ... }: {
  imports = [
    ./autorandr.nix
    ./batsignal.nix
    ./caffeine.nix
    ./darkman.nix
    ./gpg-agent.nix
    ./xfce4-screensaver.nix
  ];
  services.lorri.enable = true;
  services.copyq.enable = true;
  systemd.user.startServices = "suggest";
}
