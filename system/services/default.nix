{ pkgs, ... }:
let
  dnsmasq-dbus-config =
    import ../../pkg/dnsmasq-dbus/default.nix { inherit pkgs; };
  autorandr-udev =
    import ../../pkg/autorandr-udev/default.nix { inherit pkgs; };
in {
  imports = [ ./ssh.nix ./xorg.nix ./dnsmasq.nix ./fail2ban.nix ];
  services.ntp.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.upower.enable = true;
  services.pipewire.enable = true;
  services.pcscd.enable = true;
  services.fprintd.enable = true;
  services.acpid.enable = true;

  services.dbus.packages = [ dnsmasq-dbus-config ];
  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="drm", ENV{HOTPLUG}=="1", RUN+="${autorandr-udev}/bin/autorandr-udev"
  '';
}
