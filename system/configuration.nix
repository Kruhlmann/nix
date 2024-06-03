{ pkgs, ... }:
let
  aux = import ./pkg/turtle-wow/addons/aux.nix { };
  big-wigs = import ./pkg/turtle-wow/addons/big-wigs.nix { };
  mcp = import ./pkg/turtle-wow/addons/mcp.nix { };
  mpowa = import ./pkg/turtle-wow/addons/mpowa.nix { };
  pfui = import ./pkg/turtle-wow/addons/pfui.nix { };
  pfquest = import ./pkg/turtle-wow/addons/pfquest.nix { };
  pfquest-turtle = import ./pkg/turtle-wow/addons/pfquest-turtle.nix { };
  shagu-bop = import ./pkg/turtle-wow/addons/shagu-bop.nix { };
  shagu-mount = import ./pkg/turtle-wow/addons/shagu-mount.nix { };
  wim = import ./pkg/turtle-wow/addons/wim.nix { };
  turtle-wow = import ./pkg/turtle-wow/default.nix {
    inherit pkgs;
    realmlist = "logon.turtle-wow.org";
    wine-prefix = "~/.cache/turtle-wow/.wine-prefix";
    config = {
      accountName = "ges";
      MusicVolume = "0.4";
      MasterVolume = "0.1";
      gxResolution = "2550x1440";
    };
    addons = [
      aux
      big-wigs
      mcp
      mpowa
      pfui
      pfquest
      pfquest-turtle
      shagu-bop
      shagu-mount
      wim
    ];
  };
in {
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./hardware.nix
    ./network.nix
    ./users.nix
    ./virtualization.nix
    ./services/default.nix
    ./programs/default.nix
  ];

  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };
  system.stateVersion = "23.11";
  nixpkgs.config.allowUnfree = true;
  console.keyMap = "us";
  time.timeZone = "Europe/Copenhagen";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales =
    [ "en_US.UTF-8/UTF-8" "da_DK.UTF-8/UTF-8" "en_DK.UTF-8/UTF-8" ];
  sound.enable = true;
  security.rtkit.enable = true;
  security.sudo.extraConfig = ''
    %wheel ALL=(ALL) NOPASSWD: ALL
  '';
  boot.extraModprobeConfig = "options kvm_intel nested=1";
  environment.etc."polkit-1/rules.d/90-fprintd.rules".text = ''
      polkit.addRule(function(action, subject) {
        if ((action.id == "net.reactivated.fprint.device.enroll" ||
             action.id == "net.reactivated.fprint.device.verify" ||
             action.id == "net.reactivated.fprint.device.identify") &&
            subject.isInGroup("wheel")) {
            return polkit.Result.YES;
        }
    });
  '';
  environment.etc."lib/onepin.so".source =
    "${pkgs.opensc}/lib/opensc-pkcs11.so";
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
    acpid
    alsaLib
    alsaPlugins
    ccid
    curl
    dash
    dig
    docker
    docker-compose
    dunst
    evtest
    file
    fprintd
    gcc
    giflib
    git
    git-lfs
    gnumake
    gnutls
    gtk3
    home-manager
    htop
    inetutils
    jq
    killall
    lazygit
    less
    libfprint
    libgcrypt
    libgpgerror
    libjpeg
    libnotify
    libpng
    libva
    libxslt
    lm_sensors
    lxappearance
    modem-manager-gui
    modemmanager
    mpc-cli
    mpd
    mpg123
    ncmpcpp
    ncurses
    ocl-icd
    openal
    openconnect
    openldap
    opensc
    openssl
    papirus-icon-theme
    pavucontrol
    pcsctools
    pinentry
    powershell
    python311
    qemu
    ruby
    rustc
    sqlite
    sudo
    tldr
    turtle-wow
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
    xorg.xev
    xorg.xinit
    xwaylandvideobridge
    zip
  ];
  #services.udev.packages = [ adaptrandr ];
}
