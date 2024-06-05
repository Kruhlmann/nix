{ pkgs, ... }:
let
  wow = import ./pkg/turtle-wow/wow-types.nix { };
  servers = import ./pkg/turtle-wow/servers.nix { };
  addons = import ./pkg/turtle-wow/addons/default.nix { };
  turtle-wow = import ./pkg/turtle-wow/default.nix {
    inherit pkgs;
    ver = "1171";
    gameConfig = {
      MusicVolume = "0.4";
      MasterVolume = "0.1";
      gxResolution = "2560x1440";
      realmName = servers.turtleWow.realms.RP.Nordanaar;
      realmList = servers.turtleWow.realmList;
      patchlist = servers.turtleWow.patchlist;
      accountName = "ges";
      UnitNameOwn = wow.true;
      cameraPivot = wow.false;
      showGameTips = wow.false;
      cameraDistanceMaxFactor = "2";
      cameraCustomViewSmoothing = wow.true;
      cameraView = "3";
      cameraDistanceC = "50.000000";
      cameraPitchC = "10.000000";
      cameraYawC = "0.000000";
    };
    accountConfigs = { ges = { AUTO_QUEST_WATCH = wow.false; }; };
    bindings = {
      ges = {
        BUTTON3 = "MOVEANDSTEER";
        W = "MULTIACTIONBAR1BUTTON2";
        UP = "MOVEFORWARD";
        S = "MULTIACTIONBAR1BUTTON7";
        DOWN = "MOVEBACKWARD";
        A = "MULTIACTIONBAR1BUTTON6";
        LEFT = "TURNLEFT";
        D = "STRAFELEFT";
        RIGHT = "TURNRIGHT";
        SPACE = "JUMP";
        NUMPAD0 = "JUMP";
        X = "MULTIACTIONBAR1BUTTON10";
        Z = "MULTIACTIONBAR1BUTTON9";
        INSERT = "PITCHUP";
        DELETE = "PITCHDOWN";
        NUMPADDIVIDE = "TOGGLERUN";
        ENTER = "OPENCHAT";
        "/" = "OPENCHATSLASH";
        PAGEUP = "CHATPAGEUP";
        PAGEDOWN = "CHATPAGEDOWN";
        SHIFT-PAGEDOWN = "CHATBOTTOM";
        CTRL-PAGEUP = "COMBATLOGPAGEUP";
        CTRL-PAGEDOWN = "COMBATLOGPAGEDOWN";
        CTRL-SHIFT-PAGEDOWN = "COMBATLOGBOTTOM";
        R = "MULTIACTIONBAR1BUTTON4";
        SHIFT-R = "REPLY2";
        "1" = "ACTIONBUTTON1";
        "2" = "ACTIONBUTTON2";
        "3" = "ACTIONBUTTON3";
        "4" = "ACTIONBUTTON4";
        "5" = "ACTIONBUTTON5";
        ALT-1 = "SELFACTIONBUTTON1";
        ALT-2 = "SELFACTIONBUTTON2";
        ALT-3 = "SELFACTIONBUTTON3";
        ALT-4 = "SELFACTIONBUTTON4";
        ALT-5 = "SELFACTIONBUTTON5";
        ALT-6 = "SELFACTIONBUTTON6";
        ALT-7 = "SELFACTIONBUTTON7";
        ALT-8 = "SELFACTIONBUTTON8";
        ALT-9 = "SELFACTIONBUTTON9";
        ALT-0 = "SELFACTIONBUTTON10";
        ALT-- = "SELFACTIONBUTTON11";
        "ALT-=" = "SELFACTIONBUTTON12";
        CTRL-F1 = "SHAPESHIFTBUTTON1";
        CTRL-F2 = "SHAPESHIFTBUTTON2";
        CTRL-F3 = "SHAPESHIFTBUTTON3";
        CTRL-F4 = "SHAPESHIFTBUTTON4";
        CTRL-F5 = "SHAPESHIFTBUTTON5";
        CTRL-F6 = "SHAPESHIFTBUTTON6";
        CTRL-F7 = "SHAPESHIFTBUTTON7";
        CTRL-F8 = "SHAPESHIFTBUTTON8";
        CTRL-F9 = "SHAPESHIFTBUTTON9";
        CTRL-F10 = "SHAPESHIFTBUTTON10";
        CTRL-1 = "ACTIONBUTTON6";
        CTRL-2 = "ACTIONBUTTON7";
        CTRL-3 = "ACTIONBUTTON8";
        CTRL-4 = "ACTIONBUTTON9";
        CTRL-5 = "ACTIONBUTTON10";
        CTRL-6 = "BONUSACTIONBUTTON6";
        CTRL-7 = "BONUSACTIONBUTTON7";
        CTRL-8 = "BONUSACTIONBUTTON8";
        CTRL-9 = "BONUSACTIONBUTTON9";
        CTRL-0 = "BONUSACTIONBUTTON10";
        SHIFT-1 = "ACTIONPAGE1";
        SHIFT-2 = "ACTIONPAGE2";
        SHIFT-3 = "ACTIONPAGE3";
        SHIFT-4 = "ACTIONPAGE4";
        SHIFT-5 = "ACTIONPAGE5";
        SHIFT-6 = "ACTIONPAGE6";
        SHIFT-UP = "PREVIOUSACTIONPAGE";
        SHIFT-MOUSEWHEELUP = "PREVIOUSACTIONPAGE";
        SHIFT-DOWN = "NEXTACTIONPAGE";
        SHIFT-MOUSEWHEELDOWN = "NEXTACTIONPAGE";
        TAB = "TARGETNEARESTENEMY";
        SHIFT-TAB = "TARGETPREVIOUSENEMY";
        CTRL-TAB = "TARGETNEARESTFRIEND";
        CTRL-SHIFT-TAB = "TARGETPREVIOUSFRIEND";
        F1 = "TARGETSELF";
        SHIFT-F1 = "TARGETPET";
        F2 = "TARGETPARTYMEMBER1";
        F3 = "TARGETPARTYMEMBER2";
        F4 = "TARGETPARTYMEMBER3";
        F5 = "TARGETPARTYMEMBER4";
        SHIFT-F2 = "TARGETPARTYPET1";
        SHIFT-F3 = "TARGETPARTYPET2";
        SHIFT-F4 = "TARGETPARTYPET3";
        SHIFT-F5 = "TARGETPARTYPET4";
        G = "MULTIACTIONBAR1BUTTON8";
        F = "STRAFERIGHT";
        V = "MULTIACTIONBAR1BUTTON12";
        SHIFT-V = "FRIENDNAMEPLATES";
        CTRL-V = "MULTIACTIONBAR3BUTTON3";
        T = "MULTIACTIONBAR1BUTTON5";
        SHIFT-T = "PETATTACK";
        B = "MULTIACTIONBAR2BUTTON1";
        F12 = "TOGGLEBACKPACK";
        F8 = "TOGGLEBAG1";
        F9 = "TOGGLEAUTORUN";
        F10 = "TOGGLEBAG3";
        F11 = "TOGGLEBAG4";
        P = "TOGGLESPELLBOOK";
        SHIFT-I = "TOGGLEPETBOOK";
        SHIFT-P = "TOGGLECHARACTER3";
        SHIFT-SPACE = "TOGGLEWORLDSTATESCORES";
        SHIFT-M = "TOGGLEBATTLEFIELDMINIMAP";
        H = "TOGGLECHARACTER4";
        N = "TOGGLETALENTS";
        U = "TOGGLECHARACTER2";
        K = "TOGGLECHARACTER1";
        O = "TOGGLESOCIAL";
        L = "TOGGLEQUESTLOG";
        SHIFT-C = "TOGGLECOMBATLOG";
        ESCAPE = "TOGGLEGAMEMENU";
        M = "TOGGLEWORLDMAP";
        PRINTSCREEN = "SCREENSHOT";
        NUMPADPLUS = "MINIMAPZOOMIN";
        NUMPADMINUS = "MINIMAPZOOMOUT";
        CTRL-M = "TOGGLEMUSIC";
        CTRL-S = "MULTIACTIONBAR2BUTTON8";
        "CTRL-=" = "MASTERVOLUMEUP";
        CTRL-- = "MASTERVOLUMEDOWN";
        ALT-Z = "TOGGLEUI";
        MOUSEWHEELUP = "CAMERAZOOMIN";
        MOUSEWHEELDOWN = "CAMERAZOOMOUT";
        END = "NEXTVIEW";
        HOME = "PREVVIEW";
        CTRL-R = "MULTIACTIONBAR2BUTTON5";
        CTRL-Y = "TOGGLESTATS";
        CTRL-Q = "MULTIACTIONBAR2BUTTON2";
        CTRL-W = "MULTIACTIONBAR2BUTTON3";
        CTRL-E = "MULTIACTIONBAR2BUTTON4";
        CTRL-T = "MULTIACTIONBAR2BUTTON6";
        ALT-B = "TOGGLEPLAYERBOUNDS";
        ALT-P = "TOGGLEPERFORMANCEDISPLAY";
        ALT-O = "TOGGLEPERFORMANCEVALUES";
        CTRL-P = "RESETPERFORMANCEVALUES";
        BUTTON2 = "TURNORACTION";
        BUTTON1 = "CAMERAORSELECTORMOVE";
        CTRL-BUTTON1 = "CAMERAORSELECTORMOVESTICKY";
        BUTTON4 = "TOGGLEAUTORUN";
        SHIFT-Q = "ACTIONBUTTON11";
        SHIFT-W = "ACTIONBUTTON12";
        "[" = "TOGGLECHARACTER0";
        "]" = "OPENALLBAGS";
        Q = "MULTIACTIONBAR1BUTTON1";
        E = "MULTIACTIONBAR1BUTTON3";
        C = "MULTIACTIONBAR1BUTTON11";
        CTRL-A = "MULTIACTIONBAR2BUTTON7";
        CTRL-D = "MULTIACTIONBAR2BUTTON9";
        CTRL-F = "MULTIACTIONBAR2BUTTON10";
        CTRL-G = "MULTIACTIONBAR2BUTTON11";
        CTRL-Z = "MULTIACTIONBAR2BUTTON12";
        CTRL-X = "MULTIACTIONBAR3BUTTON1";
        CTRL-C = "MULTIACTIONBAR3BUTTON2";
        CTRL-B = "MULTIACTIONBAR3BUTTON4";
      };
    };
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
