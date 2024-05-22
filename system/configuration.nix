{ pkgs, ... }:
let adaptrandr = import ./pkg/adaptrandr/pkg.nix { inherit pkgs; };
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
    adaptrandr
    alsaLib
    alsaPlugins
    curl
    dash
    dig
    docker
    docker-compose
    dunst
    fprintd
    libfprint
    gcc
    giflib
    git
    git-lfs
    gnumake
    gnutls
    gtk3
    home-manager
    htop
    jq
    killall
    lazygit
    evtest
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
    modemmanager
    modem-manager-gui
    opensc
    pcsctools
    ccid
    pinentry
    mpd
    mpg123
    ncmpcpp
    ncurses
    ocl-icd
    openal
    openconnect
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
    xorg.xev
    xwaylandvideobridge
  ];
  #services.udev.packages = [ adaptrandr ];
}
