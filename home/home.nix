{ config, pkgs, ... }: {
  imports = [ ./programs ./services ];
  home.stateVersion = "23.11";
  home.username = "ges";
  home.homeDirectory = "/home/ges";
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    alacritty
    arandr
    autorandr
    bitwarden-cli
    cabextract
    ckb-next
    dart-sass
    dialog
    direnv
    discord
    dunst
    entr
    fd
    feh
    firefox
    fzf
    gamemode
    gimp
    gnome.nautilus
    gnome.sushi
    gnome.zenity
    graphviz
    i3lock-color
    imagemagickBig
    libreoffice-fresh
    lutris
    maim
    mangohud
    mpv
    nautilus-open-any-terminal
    networkmanagerapplet
    obs-cli
    obs-studio
    obs-studio-plugins.advanced-scene-switcher
    obs-studio-plugins.input-overlay
    obs-studio-plugins.obs-backgroundremoval
    obs-studio-plugins.obs-command-source
    obs-studio-plugins.obs-mute-filter
    obs-studio-plugins.obs-pipewire-audio-capture
    obs-studio-plugins.obs-source-clone
    obs-studio-plugins.obs-source-switcher
    obs-studio-plugins.obs-text-pthread
    obs-studio-plugins.obs-transition-table
    obs-studio-plugins.obs-vertical-canvas
    opam
    page
    gnupg
    postgresql
    protonmail-bridge
    rofi
    rustup
    steam
    steam-run
    steamPackages.steamcmd
    teams-for-linux
    texliveFull
    thefuck
    thunderbird
    trayer
    tree
    xcape
    xclip
    xdotool
    xorg.xkbcomp
    xorg.xmodmap
    xorg.xrandr
    zathura
    pavucontrol
    powershell
    papirus-icon-theme
    htop
    mpc-cli
    tldr
    mpd
    lazygit
    zsh-autosuggestions
  ];
  gtk.enable = true;
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
    "${config.xdg.configHome}/dunst" = {
      source = res/dunst;
      recursive = true;
    };
    "${config.xdg.configHome}/zsh" = {
      source = res/zsh;
      recursive = true;
    };
    "${config.xdg.configHome}/gtk-3.0" = {
      source = res/gtk-3.0;
      recursive = true;
    };
    "${config.xdg.dataHome}/.local/bin" = {
      source = res/bin;
      recursive = true;
    };
    "${config.xdg.dataHome}/.ssh/config" = { source = res/ssh/config; };
    "img/lib" = {
      source = res/img;
      recursive = true;
    };
  };
  home.sessionPath = [ "$HOME/.local/bin" "$HOME/.cargo/bin" ];
  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "page";
    MANPAGER = "page -t man";
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
