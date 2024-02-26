{ config, pkgs, ... }: {
  imports = [
    ./ssh.nix
  ];
  services.ntp.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.upower.enable = true;
  services.xserver.videoDrivers = [ "nvidia" "amdgpu" ];
}
