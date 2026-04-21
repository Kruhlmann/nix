{ pkgs, ... }:
let
  punlock = pkgs.callPackage ../pkg/punlock/package.nix { };
  turtleWowConfig = import ./turtle-wow-config.nix { };
  turtleWow = pkgs.callPackage ../pkg/turtle-wow/default.nix turtleWowConfig;
in {
  imports =
    [ ./programs ./services ./files.nix ./gtk.nix ./session.nix ./xdg.nix ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ (self: super: { punlock = punlock; }) ];
  home.stateVersion = "23.11";
  home.username = "ges";
  home.homeDirectory = "/home/ges";
  programs.home-manager.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    alacritty
    arandr
    autorandr
    bat
    batsignal
    bitwarden-cli
    brightnessctl
    btop
    cabextract
    chromium
    conky
    dialog
    discord
    distrobox
    dunst
    entr
    eza
    fd
    feh
    fzf
    gamemode
    gh
    gimp
    gnupg
    graphviz
    gruvbox-dark-gtk
    htop
    imagemagickBig
    jdt-language-server
    jetbrains.idea-oss
    lazygit
    libreoffice-fresh
    luarocks
    lutris
    maim
    mpv
    mullvad-vpn
    nautilus
    nautilus-open-any-terminal
    networkmanagerapplet
    obs-cli
    obs-studio
    page
    papirus-icon-theme
    pass
    pavucontrol
    pciutils
    perf
    protonmail-desktop
    punlock
    rofi
    rustc
    rustup
    rusty-path-of-building
    sc-im
    sccache
    sushi
    teams-for-linux
    texliveFull
    thunderbird
    tigervnc
    tldr
    trayer
    tree
    turtleWow
    wireshark
    xcape
    xclip
    xcolor
    xdotool
    xorg.xkbcomp
    xorg.xmodmap
    xorg.xrandr
    zathura
    zenity
    zsh-autosuggestions
  ];
}
