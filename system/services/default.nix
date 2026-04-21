{ pkgs, ... }: {
  imports = [ ./ssh.nix ./xorg.nix ./fail2ban.nix ./pipewire.nix ];
  services.ntp.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.upower.enable = true;
  services.pcscd.enable = true;
  services.fprintd.enable = true;
  services.acpid.enable = true;
  services.flatpak.enable = true;
  services.teamviewer.enable = true;
  services.avahi.enable = true;
  services.automatic-timezoned.enable = true;
  services.geoclue2.enable = true;
  services.geoclue2.geoProviderUrl = "https://api.beacondb.net/v1/geolocate";
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.Settings" = [ "darkman" ];
    };
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
  '';
}
