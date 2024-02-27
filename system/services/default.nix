{ config, pkgs, ... }: {
  imports = [ ./ssh.nix ./pipewire.nix ];
  services.ntp.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.upower.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  #services.xserver.videoDrivers = [ "nvidia" "amdgpu" ];
  services.xserver.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.desktopManager.xfce.noDesktop = true;
  services.xserver.desktopManager.xfce.enableXfwm = false;
  services.xserver.displayManager.defaultSession = "xfce+xmonad";
  services.xserver.windowManager.xmonad.enable = true;
}
