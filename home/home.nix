{ pkgs, ... }: {
  imports =
    [ ./programs ./services ./files.nix ./gtk.nix ./session.nix ./xdg.nix ];
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "23.11";
  home.username = "ges";
  home.homeDirectory = "/home/ges";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    alacritty
    arandr
    autorandr
    bat
    batsignal
    bitwarden-cli
    brightnessctl
    btop
    ckb-next
    conky
    dialog
    direnv
    discord
    dunst
    entr
    eza
    fd
    feh
    firefox
    fzf
    gamemode
    gimp
    gnupg
    graphviz
    htop
    i3lock-color
    imagemagickBig
    lazygit
    libreoffice-fresh
    lutris
    maim
    mpv
    nautilus
    nautilus-open-any-terminal
    networkmanagerapplet
    obs-cli
    obs-studio
    page
    papirus-icon-theme
    pavucontrol
    protonmail-bridge
    rofi
    ruff-lsp
    rustc
    rustup
    sc-im
    sccache
    steam
    sushi
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
    zenity
    zsh-autosuggestions
  ];
}
