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
  home.file."${config.home.homeDirectory}/.local/share/xsessions/xfce.desktop".text = ''
    [Desktop Entry]
    Name=XFCE
    Exec=startxfce4
    Type=Application
  '';

  home.file."${config.home.homeDirectory}/.local/share/xsessions/xmonad.desktop".text = ''
    [Desktop Entry]
    Name=Xmonad
    Exec=${config.home.homeDirectory}/.xsession
    Type=Application
  '';

  home.file."${config.home.homeDirectory}/.local/share/xsessions/xfce-xmonad.desktop".text = ''
    [Desktop Entry]
    Name=XFCE+Xmonad
    Exec=${config.home.homeDirectory}/.xsession
    Type=Application
  '';
}
