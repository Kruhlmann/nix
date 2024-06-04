{ pkgs, ... }:
let
  wow = import ./pkg/turtle-wow/wow-types.nix { };
  servers = import ./pkg/turtle-wow/servers.nix { };
  addons = import ./pkg/turtle-wow/addons.nix { };
  turtle-wow = import ./pkg/turtle-wow/default.nix {
    inherit pkgs;
    ver = "1171";
    gameConfig = {
      MusicVolume = "0.4";
      MasterVolume = "0.1";
      realmName = servers.turtleWow.realms.RP.Nordanaar;
      realmList = servers.turtleWow.realmList;
      patchlist = servers.turtleWow.patchlist;
      accountName = "ges";
      UnitNameOwn = wow.true;
      cameraPivot = wow.false;
      showGameTips = wow.false;
      cameraDistanceMaxFactor = "2";
    };
    accountConfigs = { ges = { AUTO_QUEST_WATCH = wow.false; }; };
    addons = [
      addons.balakethelock.twthreat
      addons.berranzan.modifiedpowerauras-continued
      addons.doorknob6.pfui-turtle
      addons.firenahzku.vgattackbar
      addons.hosq.bigwigs
      addons.isitlove.outfitter
      addons.jsb.gatherer
      addons.kakysha.honorspy
      addons.kxseven.vanillaratingbuster
      addons.lexiebean.atlasloot
      addons.mrrosh.healcomm
      addons.mrrosh.mcp
      addons.road-block.classicsnowfall
      addons.shagu.pfquest
      addons.shagu.pfquest-turtle
      addons.shagu.pfui
      addons.shagu.shagudps
      addons.shirsig.aux-addon-vanilla
      addons.shirsig.aux_merchant_prices
      addons.shirsig.unitscan
      addons.shirsig.wim
      addons.satan666.trinketmenu-fix
      addons.opcow.buffreminder
      addons.danieladolfsson.clevermacro
      addons.tercioo.details-damage-meter
      addons.wow-vanilla-addons.accountant
      addons.wow-vanilla-addons.postal
      addons.yogo1212.healbot-classic
      addons.fiskehatt.saysapped
      addons.proxicide.macroextender
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
    gcr
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
    pinentry-curses
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
