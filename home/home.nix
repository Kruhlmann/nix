{ pkgs, ... }: 
let
  punlock = pkgs.callPackage ../pkg/punlock/package.nix {};
in {
  imports =
    [ ./programs ./services ./files.nix ./gtk.nix ./session.nix ./xdg.nix ];
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
    ckb-next
    conky
    dialog
    punlock
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
    gimp
    gnupg
    graphviz
    gruvbox-dark-gtk
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
    pass
    pavucontrol
    pciutils
    protonmail-desktop
    gh
    luarocks
    mullvad-vpn
    jdt-language-server
    rofi
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
