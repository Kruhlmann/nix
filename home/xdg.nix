{ config, ... }: {
  xdg = {
    enable = true;
    dataHome = "${config.home.homeDirectory}/.local/share";
    configHome = "${config.home.homeDirectory}/.config";
    cacheHome = "${config.home.homeDirectory}/.cache";
    stateHome = "${config.home.homeDirectory}/.local/state";
  };
}
