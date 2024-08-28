{ config, home, ... }: {
  xsession = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./res/xmonad/xmonad.hs;
      extraPackages = hp: [ hp.dbus hp.monad-logger ];
    };
  };
  home.sessionPath = [ "$HOME/.local/bin" "$HOME/.cargo/bin" ];
  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "page";
    MANPAGER = "page -t man";
    SHELL = "/run/current-system/sw/bin/zsh";
  };
}
