{ config, pkgs, ... }: {
  imports = [
    ./programs
    ./services
  ];
  home.stateVersion = "23.11";
  home.username = "ges";
  home.homeDirectory = "/home/ges";
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    alacritty
    bitwarden-cli
    ckb-next
    dialog
    direnv
    discord
    dune_3
    entr
    fd
    feh
    feh
    firefox
    fzf
    gimp
    gnome.nautilus
    imagemagickBig
    lutris
    maim
    networkmanager_dmenu
    networkmanagerapplet
    polybar
    postgresql
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
    "${config.xdg.configHome}/stickers" = {
      source = res/stickers;
      recursive = true;
    };
    "${config.xdg.configHome}/stack" = {
      source = res/stack;
      recursive = true;
    };
    "${config.xdg.dataHome}/.local/bin" = {
      source = res/bin;
      recursive = true;
    };
    "${config.xdg.dataHome}/.ssh/config" = { source = res/ssh/config; };
  };
  home.sessionPath = [ "$HOME/.local/bin" ];
  home.sessionVariables = {
    EDITOR = "nvim";
    SHELL = "/run/current-system/sw/bin/zsh";
  };
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
