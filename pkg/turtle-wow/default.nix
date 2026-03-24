{ pkgs, ver ? "1180", addons ? [ ]
, winePrefix ? "~/.cache/turtle-wow/.wine-prefix", gameConfig ? { }
, accountConfigs ? { }, bindings ? { }, macros ? { }, }:
let
  buildAddon = import ./addons/build.nix { inherit pkgs; };
  buildAddons = map buildAddon addons;
  defaultConfig = import ./config/preset/game.nix { };
  combinedConfig = pkgs.lib.recursiveUpdate defaultConfig gameConfig;
  generatedWtfConfig = import ./config/wtf.nix {
    inherit pkgs;
    settings = combinedConfig;
  };
  defaultAccountConfig = import ./config/preset/account.nix { };
  mappedAccountConfigs = pkgs.lib.mapAttrs (accountName: accountConfig:
    pkgs.lib.recursiveUpdate defaultAccountConfig accountConfig) accountConfigs;
  generateAccountConfig = accountName: accountConfig:
    pkgs.writeText "SavedVariables.lua" (import ./config/lua.nix {
      inherit pkgs;
      settings = accountConfig;
    });

  generateBindingsFile = accountName: bindingConfig:
    pkgs.writeText "bindings-cache.wtf" (import ./config/bindings.nix {
      inherit pkgs;
      bindings = bindingConfig;
    });

  generateMacroCache = import ./macros/generate.nix { inherit pkgs; };
in pkgs.stdenv.mkDerivation rec {
  pname = "turtle-wow";
  version = "${ver}";

  src = pkgs.fetchurl {
    url = "https://eudl.turtlecraft.gg/twmoa_${version}.zip";
    hash = "sha256-ghZDSjAdrWVPJk43ARzAB5NJ956FJZy1p1iJWTzWdok=";
  };

  nativeBuildInputs = [ pkgs.unzip pkgs.copyDesktopItems pkgs.makeWrapper ];

  buildInputs = [ pkgs.wineWowPackages.full pkgs.vulkan-loader ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p \
      $out/share/turtle-wow \
      $out/bin \
      $out/share/icons/hicolor/256x256/apps \
      $out/share/applications

    rm -f ./realmlist.wtf ./Config.wtf
    cp -r ./* $out/share/turtle-wow/

    cp ${pkgs.copyPathToStore ./res/icon.png} \
      $out/share/icons/hicolor/256x256/apps/turtle-wow.png

    cp -r ${desktop}/share/applications/* $out/share/applications/

    ${pkgs.lib.concatMapStrings (addon: ''
      cp -r ${addon}/share/${addon.pname} \
        $out/share/turtle-wow/Interface/AddOns/
    '') buildAddons}

    substituteAll ${./res/turtle-wow} $out/bin/turtle-wow

    cat > $out/bin/turtle-wow.env <<EOF
    export WINE_STORE=${pkgs.wineWowPackages.full}
    export TURTLE_WOW_STORE=$out
    export WINEPREFIX=${winePrefix}
    export TURTLE_WOW_VERSION=${version}
    export RSYNC=${pkgs.rsync}/bin/rsync
    export COREUTILS=${pkgs.coreutils}/bin
    export FINDUTILS=${pkgs.findutils}/bin
    EOF

    chmod +x $out/bin/turtle-wow

    printf 'set realmlist %s\nset patchlist %s\n' \
      "${combinedConfig.realmList}" \
      "${combinedConfig.patchlist}" \
      > $out/share/turtle-wow/realmlist.wtf

    mkdir -p $out/share/turtle-wow/WTF
    echo "${generatedWtfConfig}" > $out/share/turtle-wow/WTF/Config.wtf

    ${pkgs.lib.concatStrings (pkgs.lib.mapAttrsToList
      (accountName: accountConfig:
        let upperAccountName = pkgs.lib.toUpper accountName;
        in ''
          mkdir -p $out/share/turtle-wow/WTF/Account/${upperAccountName}
          cp ${generateAccountConfig accountName accountConfig} \
            $out/share/turtle-wow/WTF/Account/${upperAccountName}/SavedVariables.lua
        '') mappedAccountConfigs)}

    ${pkgs.lib.concatStrings (pkgs.lib.mapAttrsToList
      (accountName: bindingConfig:
        let upperAccountName = pkgs.lib.toUpper accountName;
        in ''
          mkdir -p $out/share/turtle-wow/WTF/Account/${upperAccountName}
          cp ${generateBindingsFile accountName bindingConfig} \
            $out/share/turtle-wow/WTF/Account/${upperAccountName}/bindings-cache.wtf
        '') bindings)}

    ${pkgs.lib.concatStrings (pkgs.lib.mapAttrsToList
      (accountName: accountMacros:
        let upperAccountName = pkgs.lib.toUpper accountName;
        in ''
                    mkdir -p $out/share/turtle-wow/WTF/Account/${upperAccountName}
                    cat > $out/share/turtle-wow/WTF/Account/${upperAccountName}/macros-cache.txt <<'EOF'
          ${generateMacroCache {
            macros = accountMacros.global;
            startId = 1;
          }}
          EOF
                    ${
                      pkgs.lib.concatStringsSep "\n" (pkgs.lib.mapAttrsToList
                        (serverName: serverMacros:
                          pkgs.lib.concatStringsSep "\n"
                          (pkgs.lib.mapAttrsToList
                            (characterName: characterMacros: ''
                                                  mkdir -p $out/share/turtle-wow/WTF/Account/${upperAccountName}/${serverName}/${characterName}
                                                  cat > $out/share/turtle-wow/WTF/Account/${upperAccountName}/${serverName}/${characterName}/macros-cache.txt <<'EOF'
                              ${generateMacroCache {
                                macros = characterMacros;
                                startId = 10000;
                              }}
                              EOF
                            '') serverMacros)) accountMacros.servers)
                    }
        '') macros)}

    runHook postInstall
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
