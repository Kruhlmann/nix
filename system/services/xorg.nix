{ lib, ... }:
let
  fileExists = file: builtins.pathExists file;
  hasAmdGpu =
    fileExists "/sys/class/drm/card0/device/driver/module/drivers/pci:amdgpu";
in {
  services.xserver.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.desktopManager.xfce.noDesktop = true;
  services.xserver.desktopManager.xfce.enableXfwm = false;
  services.xserver.displayManager.defaultSession = "xfce+xmonad";
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.videoDrivers = lib.optionals hasAmdGpu [ "amdgpu" ];
}
