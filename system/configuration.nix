{ pkgs,  ... }: {
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./hardware.nix
    ./network.nix
    ./users.nix
    ./services/default.nix
    ./programs/default.nix
  ];
  system.stateVersion = "23.11";
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Europe/Copenhagen";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales =
    [ "en_US.UTF-8/UTF-8" "da_DK.UTF-8/UTF-8" "en_DK.UTF-8/UTF-8" ];
  sound.enable = true;
  security.rtkit.enable = true;
  security.sudo.extraConfig = ''
    %wheel ALL=(ALL) NOPASSWD: ALL
  '';
  virtualisation.docker.enable = true;
  fonts.packages = with pkgs; [
    terminus-nerdfont
    fira-code-nerdfont
    jetbrains-mono
  ];
  environment.systemPackages = with pkgs; [
    (pkgsi686Linux.alsaLib)
    (pkgsi686Linux.alsaPlugins)
    (pkgsi686Linux.gnutls)
    (pkgsi686Linux.gtk3)
    (pkgsi686Linux.libgcrypt)
    (pkgsi686Linux.libjpeg)
    (pkgsi686Linux.mpg123)
    (pkgsi686Linux.ncurses)
    (pkgsi686Linux.ocl-icd)
    (pkgsi686Linux.openal)
    (pkgsi686Linux.pulseaudio)
    (pkgsi686Linux.sqlite)
    (pkgsi686Linux.vulkan-loader)
    alsaLib
    alsaPlugins
    curl
    dig
    docker
    docker-compose
    dunst
    gcc
    giflib
    git
    gnumake
    gnutls
    gtk3
    home-manager
    htop
    jq
    killall
    lazygit
    less
    libgcrypt
    libgpgerror
    libjpeg
    libnotify
    libpng
    libva
    libxslt
    lm_sensors
    mpc-cli
    mpd
    mpg123
    ncmpcpp
    ncurses
    ocl-icd
    openal
    openldap
    openssl
    pavucontrol
    powershell
    python311
    qemu
    ruby
    rustc
    sqlite
    sudo
    tldr
    tmux
    unrar
    unzip
    v4l-utils
    vim
    virt-manager
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    wget
    wine-staging
    xorg.xauth
    xorg.xinit
    xwaylandvideobridge
  ];
}
