{ pkgs, lib, ... }: {
  imports = [
    ./ssh.nix
    ./xorg.nix
    ./fail2ban.nix
    ./pipewire.nix
  ];
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
    extraPortals = [
      pkgs.xdg-desktop-portal-termfilechooser
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      "org.freedesktop.impl.portal.Settings" = [ "darkman" ];
    };
  };
  environment.etc."xdg/xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    default_dir=$HOME
    env=TERMCMD='${pkgs.alacritty}/bin/alacritty -e'
    env=PATH='${
      lib.makeBinPath [
        pkgs.yazi
        pkgs.coreutils
      ]
    }:/run/current-system/sw/bin'
    open_mode=suggested
    save_mode=last
  '';

  services.udev.extraRules = ''
    SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
  '';
}
