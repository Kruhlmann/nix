{ config, pkgs, lib, ... }: {
  imports = [ ./programs/alacritty ./programs/nvim ./services/gpg-agent ];
  home.stateVersion = "23.11";
  home.username = "ges";
  home.homeDirectory = "/home/ges";
  home.packages = with pkgs; [
    alacritty
    bitwarden-cli
    ckb-next
    dialog
    discord
    entr
    feh
    feh
    firefox
    fzf
    gimp
    gnome.nautilus
    lutris
    maim
    neovim
    networkmanager_dmenu
    networkmanagerapplet
    polybar
    rofi
    steam
    teams-for-linux
    texliveFull
    thefuck
    xcape
    xclip
    xorg.xkbcomp
    xorg.xmodmap
    xorg.xrandr
  ];
  xdg.dataHome = ~/.;
  xdg.configHome = ~/.config;

  home.file = {
    "${config.xdg.configHome}/nvim" = {
      source = res/nvim;
      recursive = true;
    };
    "${config.xdg.configHome}/git" = {
      source = res/git;
      recursive = true;
    };
    "${config.xdg.configHome}/polybar" = {
      source = res/polybar;
      recursive = true;
    };
    "${config.xdg.configHome}/rofi" = {
      source = res/rofi;
      recursive = true;
    };
    "${config.xdg.dataHome}/.local/bin" = {
      source = res/bin;
      recursive = true;
    };
    "${config.xdg.dataHome}/.ssh/config" = { source = res/ssh/config; };
  };
  home.sessionPath = [ "$HOME/.local/bin" ];

  xsession = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./res/xmonad/xmonad.hs;
      extraPackages = hp: [ hp.dbus hp.monad-logger ];
    };
  };

  programs.home-manager.enable = true;
}
