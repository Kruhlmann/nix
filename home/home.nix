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
    cabextract
    ckb-next
    conky
    dart-sass
    davinci-resolve
    dialog
    direnv
    discord
    dunst
    dwarf-fortress
    dwarf-fortress-packages.dwarf-therapist
    dwarf-fortress-packages.legends-browser
    dwarf-fortress-packages.themes.gemset
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
    mpc-cli
    mpd
    mpv
    nautilus
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
    page
    papirus-icon-theme
    pavucontrol
    powershell
    protonmail-bridge
    rofi
    ruff-lsp
    rustc
    rustup
    sc-im
    sccache
    steam
    steam-run
    steamcmd
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
