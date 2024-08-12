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
    batsignal
    bitwarden-cli
    brightnessctl
    btop
    cabextract
    ckb-next
    conky
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
    gnupg
    graphviz
    htop
    i3lock-color
    imagemagickBig
    lazygit
    libreoffice-fresh
    lutris
    maim
    mangohud
    mpc-cli
    mpd
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
    obs-studio-plugins.obs-source-clone
    obs-studio-plugins.obs-source-switcher
    obs-studio-plugins.obs-text-pthread
    obs-studio-plugins.obs-transition-table
    obs-studio-plugins.obs-vertical-canvas
    opam
    page
    papirus-icon-theme
    pavucontrol
    postgresql
    powershell
    protonmail-bridge
    rofi
    ruff-lsp
    rustup
    sc-im
    sccache
    steam
    steam-run
    steamPackages.steamcmd
    teams-for-linux
    texliveFull
    thefuck
    thunderbird
    tldr
    trayer
    tree
    wireshark
    xcape
    xclip
    xdotool
    xorg.xkbcomp
    xorg.xmodmap
    xorg.xrandr
    zathura
    zed-editor
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
    "${config.xdg.configHome}/conky" = {
      source = res/conky;
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
    "${config.xdg.configHome}/libvirt" = {
      source = res/libvirt;
      recursive = true;
    };
    "${config.xdg.configHome}/gtk-3.0" = {
      source = res/gtk-3.0;
      recursive = true;
    };
    "${config.xdg.configHome}/etc" = {
      source = res/etc;
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
