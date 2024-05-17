{ ... }: {
  imports = [ ./ssh.nix ./xorg.nix ./dnsmasq.nix ./fail2ban.nix ];
  services.ntp.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.upower.enable = true;
  services.pipewire.enable = true;
  services.pcscd.enable = true;
  services.fprintd.enable = true;
  #environment.etc."X11/xorg.conf.d/20-intel.conf/".text = ''
  #  Section "Module"
  #      Load "dri3"
  #  EndSection
  #
  #    Section "Device"
  #        Identifier  "Intel Graphics"
  #       Driver      "intel"
  #        Option      "DRI"   "3"
  #    EndSection
  #  '';
}
