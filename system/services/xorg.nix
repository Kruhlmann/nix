{ ... }: {
  #services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver = {
    enable = true;
    desktopManager.xterm.enable = false;
    desktopManager.xfce.enable = true;
    desktopManager.xfce.noDesktop = true;
    desktopManager.xfce.enableXfwm = false;
    displayManager.defaultSession = "xfce+xmonad";
    displayManager.sessionCommands = ''
      xset r rate 300 50
    '';
    windowManager.xmonad.enable = true;
    layout = "us";
    xkbVariant = "altgr-intl";
  };
}
