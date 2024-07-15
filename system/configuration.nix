{ pkgs, ... }:
let
  turtle-wow-config = import ./turtle-wow.nix { };
  turtle-wow = import ../pkg/turtle-wow/default.nix {
    inherit pkgs;
    ver = turtle-wow-config.ver;
    gameConfig = turtle-wow-config.gameConfig;
    accountConfigs = turtle-wow-config.accountConfigs;
    addons = turtle-wow-config.addons;
    bindings = turtle-wow-config.bindings;
    macros = turtle-wow-config.macros;
  };
  extra-certs = import ../pkg/extra-certs/default.nix { inherit pkgs; };
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
  security.pki.certificateFiles = [ "${extra-certs}/etc/ssl/certs/extra.pem" ];
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
  environment.sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];
  fonts.packages = with pkgs; [
    terminus-nerdfont
    fira-code-nerdfont
    jetbrains-mono
  ];
  environment.systemPackages = with pkgs; [
    (pkgsi686Linux.alsaLib)
    (pkgsi686Linux.alsaPlugins)
    (pkgsi686Linux.gnutls)
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
    evtest
    file
    fprintd
    gcc
    gcr
    giflib
    git
    git-lfs
    gnumake
    gnutls
    home-manager
    inetutils
    jq
    killall
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
    mesa
    libGL
    libGLU
    modem-manager-gui
    modemmanager
    mpg123
    ncurses
    ocl-icd
    openal
    openconnect
    openldap
    opensc
    openssl
    pcsctools
    pinentry
    pinentry-curses
    python311
    qemu
    extra-certs
    sqlite
    steam
    sudo
    turtle-wow
    tmux
    unrar
    unzip
    v4l-utils
    virt-manager
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    wget
    wine-staging
    xorg.xauth
    xorg.xev
    xorg.xinit
    zip
  ];
}
