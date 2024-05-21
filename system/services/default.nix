{ ... }: {
  imports = [ ./ssh.nix ./xorg.nix ./dnsmasq.nix ./fail2ban.nix ];
  services.ntp.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.upower.enable = true;
  services.pipewire.enable = true;
  services.pcscd.enable = true;
  services.fprintd.enable = true;
  services.acpid.enable = true;
}
