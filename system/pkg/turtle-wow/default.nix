{ pkgs, addons ? [ ], realmlist ? "logon.turtle-wow.org"
, wine-prefix ? "~/.cache/turtle-wow/.wine-prefix", config ? { } }:

let
  buildAddon = import ./addons/default.nix { inherit pkgs; };
  buildAddons = map buildAddon addons;
  defaultConfig = {
    accountName = ""; # Default account name
    gxWindow = "1"; # Enables windowed mode
    gxMaximize = "1"; # Maximizes the window
    scriptMemory = "0"; # Amount of memory allocated for scripts
    gxCursor = "0"; # Disables hardware cursor
    hwDetect = "0"; # Disables hardware detection on startup
    gxColorBits = "24"; # Sets the color depth in bits
    gxDepthBits = "24"; # Sets the depth buffer depth in bits
    gxResolution = "1920x1080"; # Sets the screen resolution
    gxRefresh = "60"; # Sets the screen refresh rate in Hz
    gxMultisampleQuality =
      "0.000000"; # Sets the multisampling quality for anti-aliasing
    gxFixLag = "0"; # Disables lag fix
    fullAlpha = "1"; # Enables full alpha transparency
    lodDist = "100.000000"; # Level of detail distance
    SmallCull =
      "0.040000"; # Sets the distance at which small objects are culled
    DistCull =
      "500.000000"; # Sets the distance at which distant objects are culled
    trilinear = "1"; # Enables trilinear filtering
    frillDensity = "32"; # Density of environment frills like grass and bushes
    farclip = "477"; # Maximum view distance
    specular = "1"; # Enables specular highlights
    pixelShaders = "1"; # Enables pixel shaders
    particleDensity = "1.000000"; # Density of particle effects
    unitDrawDist =
      "300.000000"; # Distance at which units (NPCs, players) are drawn
    movie = "0"; # Disables intro movie
    readTOS = "1"; # Indicates that the Terms of Service have been read
    readEULA =
      "1"; # Indicates that the End User License Agreement has been read
    realmList = "logon.turtle-wow.org"; # Sets the realm list server address
    patchlist = "logon.turtle-wow.org"; # Sets the patch list server address
    M2UsePixelShaders = "1"; # Enables use of pixel shaders for models
    Gamma = "1.000000"; # Gamma correction level
    lastCharacterIndex = "1"; # Index of the last character used
    MusicVolume = "0.40000000596046"; # Volume level for music
    SoundVolume = "1"; # Volume level for sound effects
    MasterVolume = "1"; # Master volume level
    gameTip = "1"; # Enables game tips
    AmbienceVolume = "0.60000002384186"; # Volume level for ambient sounds
    uiScale = "1"; # Scale factor for the user interface
  };
  combinedConfig = pkgs.lib.recursiveUpdate defaultConfig config;
  generatedWtfConfig = import ./config.nix {
    inherit pkgs;
    settings = combinedConfig;
  };
in pkgs.stdenv.mkDerivation rec {
  pname = "turtle-wow";
  version = "1171";
  src = pkgs.fetchurl {
    url = "https://turtle-eu.b-cdn.net/twmoa_${version}.zip";
    sha256 = "sha256-fJNiSRln7xsyv3P4B6NTudvF7wAVFSJdu2LEpPdqu3w=";
  };
  icon = pkgs.fetchurl {
    url =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5kziZqFv4kii1P8K8MYnl3XkME-ZF2TWSf6T2uPWArDYLYDEn";
    sha256 = "sha256-0XdP81dd9InEAhdFkR5QfUIbcwn3zSKQJeCPURJUZh0=";
  };
  nativeBuildInputs = [ pkgs.unzip pkgs.copyDesktopItems ];
  buildInputs = [ pkgs.wineWowPackages.full pkgs.vulkan-loader ];
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/turtle-wow $out/bin $out/share/icons/hicolor/256x256/apps/ $out/share/applications
    cp -r * $out/share/turtle-wow
    cp ${icon} $out/share/icons/hicolor/256x256/apps/turtle-wow.png
    cp -r ${desktop}/share/applications/* $out/share/applications
    ${pkgs.lib.concatMapStrings (addon: ''
      cp -r ${addon}/share/${addon.pname} $out/share/turtle-wow/Interface/AddOns/
    '') buildAddons}
    echo "#!/usr/bin/env sh" >$out/bin/turtle-wow
    echo "mkdir -p ${wine-prefix}" >>$out/bin/turtle-wow
    echo "WINEPREFIX="${wine-prefix}" WINEARCH=win32 ${pkgs.wineWowPackages.full}/bin/wine $out/share/turtle-wow/WoW.exe" >>$out/bin/turtle-wow
    chmod +x $out/bin/turtle-wow
    printf 'set realmlist %s\nset patchlist %s\n' "${combinedConfig.realmList}" "${combinedConfig.patchlist}" >$out/share/turtle-wow/realmlist.wtf
    echo "${generatedWtfConfig}" > $out/share/turtle-wow/WTF/Config.wtf
  '';
  desktop = pkgs.makeDesktopItem {
    type = "Application";
    name = "turtle-wow";
    exec = "turtle-wow";
    icon = "turtle-wow";
    desktopName = "Play Turtle WoW";
    categories = [ "Game" ];
  };
  meta = with pkgs.lib; {
    description = "Turtle WoW - A private server for World of Warcraft";
    homepage = "https://turtle-wow.org";
    license = licenses.unfree;
    platforms = platforms.linux;
  };
}
