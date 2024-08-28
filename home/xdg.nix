{ config, pkgs, ... }: {
  xdg = {
    dataHome = ~/.;
    configHome = ~/.config;
    desktopEntries.dwarf-fortress = {
      name = "Dwarf Fortress";
      exec = "${config.xdg.dataHome}/.nix-profile/bin/dwarf-fortress";
      icon = "${config.xdg.dataHome}/img/lib/df-logo.png";
    };
  };
}
