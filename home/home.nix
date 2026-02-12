{ pkgs, ... }:
let
  punlock = pkgs.callPackage ../pkg/punlock/package.nix { };
in
{
  imports = [
    ./programs
    ./services
    ./files.nix
    ./gtk.nix
    ./session.nix
    ./xdg.nix
  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (self: super: { punlock = punlock; })
  ];
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
    chromium
    conky
    dialog
    direnv
    discord
    distrobox
    dunst
    entr
    eza
    fd
    feh
    firefox
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
    protonmail-desktop
    punlock
    rofi
    rustc
    rustup
    sc-im
    sccache
    sushi
    teams-for-linux
    texliveFull
    thunderbird
    perf
    tigervnc
    tldr
    trayer
    tree
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
