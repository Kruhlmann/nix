{ ... }: {
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.desktopManager.xfce.noDesktop = true;
  services.xserver.desktopManager.xfce.enableXfwm = false;
  services.xserver.displayManager.defaultSession = "xfce+xmonad";
  services.xserver.windowManager.xmonad.enable = true;
}
