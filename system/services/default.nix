{ ... }: {
  imports = [ ./ssh.nix ./xorg.nix ./fail2ban.nix ./pipewire.nix ];
  services.ntp.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.upower.enable = true;
  services.pcscd.enable = true;
  services.fprintd.enable = true;
  services.acpid.enable = true;
  services.flatpak.enable = true;
  services.geoclue2.enable = true;
  xdg.portal.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
  '';
}
