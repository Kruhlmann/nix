{ config, pkgs, lib, ... }: {
  programs.hyprland.enable = true;
  programs.hyprland.enableNvidiaPatches = true;
  programs.hyprland.xwayland.enable = true;

  environment.sessionVariables = lib.mkMerge [{
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  }];

  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
}
