{ pkgs, ... }:
let
  extra-certs = import ../pkg/extra-certs/default.nix { inherit pkgs; };
  bedstead = pkgs.callPackage ../pkg/bedstead/default.nix { };
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
  nixpkgs.overlays = [
    (final: prev: {
      ckb-next = prev.ckb-next.overrideAttrs (old: {
        cmakeFlags = (old.cmakeFlags or [ ]) ++ [ "-DUSE_DBUS_MENU=0" ];
      });
    })
  ];

  programs.kdeconnect.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };
  system.stateVersion = "23.11";
  nixpkgs.config.allowUnfree = true;
  console.keyMap = "us";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales =
    [ "en_US.UTF-8/UTF-8" "da_DK.UTF-8/UTF-8" "en_DK.UTF-8/UTF-8" ];
  security.pam.services.xfce4-screensaver.enable = true;
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
  environment.etc."share/icons/hicolor/256x256/apps/virt-manager.png".source =
    "${pkgs.virt-manager}/share/icons/hicolor/256x256/apps/virt-manager.png";
  environment.sessionVariables = {
    LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];
    GSETTINGS_SCHEMA_DIR =
      "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
  };
  fonts.packages = with pkgs; [
    bedstead
    nerd-fonts.terminess-ttf
    nerd-fonts.fira-code
    jetbrains-mono
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "JetBrainsMono" ];
      serif = [ "JetBrainsMono" ];
      sansSerif = [ "JetBrainsMono" ];
    };
  };
  environment.systemPackages = with pkgs; [
    (pkgsi686Linux.alsa-lib)
    (pkgsi686Linux.alsa-plugins)
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
    alsa-lib
    alsa-plugins
    ccid
    curl
    dash
    dig
    docker
    evtest
    extra-certs
    file
    fprintd
    glib
    gsettings-desktop-schemas
    gcc
    gcr
    giflib
    git
    git-lfs
    gnumake
    gnutls
    dotnetCorePackages.runtime_8_0-bin
    dotnetCorePackages.runtime_9_0-bin
    dotnetCorePackages.runtime_10_0-bin
    home-manager
    inetutils
    jq
    killall
    less
    libGL
    libGLU
    libfprint
    libgcrypt
    libgpg-error
    libjpeg
    libnotify
    libpng
    libva
    libxslt
    lm_sensors
    lxappearance
    man-pages
    mesa
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
    pcsc-tools
    pinentry-gnome3
    pinentry-curses
    python311
    qemu
    sqlite
    sudo
    tmux
    unrar
    unzip
    v4l-utils
    virt-manager
    virt-viewer
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
