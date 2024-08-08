{ ... }: {
  services.xserver = {
    enable = true;
    desktopManager.xterm.enable = false;
    desktopManager.xfce.enable = true;
    desktopManager.xfce.noDesktop = true;
    desktopManager.xfce.enableXfwm = false;
    displayManager.sessionCommands = "xset r rate 300 50";
    windowManager.xmonad.enable = true;
    #videoDrivers = [ "amdgpu" ];
    deviceSection = ''
      Option "TearFree" "true"
    '';
    xkb.layout = "us";
    xkb.variant = "altgr-intl";
    xkb.options = "caps:escape";
  };
  services.displayManager.defaultSession = "xfce+xmonad";
}
