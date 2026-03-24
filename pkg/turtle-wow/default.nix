{ pkgs, ver ? "1180", addons ? [ ]
, winePrefix ? "~/.cache/turtle-wow/.wine-prefix", gameConfig ? { }
, accountConfigs ? { }, bindings ? { }, macros ? { }, mods ? [ ], }:
let
  buildAddon = import ./addons/build.nix { inherit pkgs; };
  buildAddons = map buildAddon addons;

  buildMod = import ./client-mods/build.nix { inherit pkgs; };
  builtMods = map buildMod mods;
  dllList = pkgs.lib.concatMap (mod: mod.dlls) builtMods;

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
  version = ver;

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
      "$out/share/turtle-wow" \
      "$out/bin" \
      "$out/share/icons/hicolor/256x256/apps" \
      "$out/share/applications"

    rm -f ./realmlist.wtf ./Config.wtf
    cp -r ./* "$out/share/turtle-wow/"

    cp ${pkgs.copyPathToStore ./res/icon.png} \
      "$out/share/icons/hicolor/256x256/apps/turtle-wow.png"

    cp -r ${desktop}/share/applications/* "$out/share/applications/"

    ${pkgs.lib.concatMapStrings (addon: ''
      cp -r "${addon}/share/${addon.pname}" \
        "$out/share/turtle-wow/Interface/AddOns/"
    '') buildAddons}

    ${pkgs.lib.concatMapStrings (mod:
      if mod.builtin then
        ""
      else
        pkgs.lib.concatMapStrings (dll: ''
          if [ ! -f "${mod.outPath}/share/${mod.pname}/${dll}" ]; then
            echo "Missing DLL ${dll} in mod ${mod.pname}" >&2
            exit 1
          fi
          cp "${mod.outPath}/share/${mod.pname}/${dll}" \
            "$out/share/turtle-wow/${dll}"
        '') mod.dlls) builtMods}

    printf '%s\n' ${pkgs.lib.escapeShellArgs dllList} \
      > "$out/share/turtle-wow/dlls.txt"

    substituteAll ${./res/turtle-wow} "$out/bin/turtle-wow"
    chmod +x "$out/bin/turtle-wow"

    printf '%s\n' \
      "export WINE_STORE=${pkgs.wineWowPackages.full}" \
      "export TURTLE_WOW_STORE=$out" \
      "export WINEPREFIX=${winePrefix}" \
      "export TURTLE_WOW_VERSION=${version}" \
      "export RSYNC=${pkgs.rsync}/bin/rsync" \
      "export COREUTILS=${pkgs.coreutils}/bin" \
      "export FINDUTILS=${pkgs.findutils}/bin" \
      > "$out/share/turtle-wow/turtle-wow.env"

    printf 'set realmlist %s\nset patchlist %s\n' \
      "${combinedConfig.realmList}" \
      "${combinedConfig.patchlist}" \
      > "$out/share/turtle-wow/realmlist.wtf"

    mkdir -p "$out/share/turtle-wow/WTF"
    cp ${pkgs.writeText "Config.wtf" generatedWtfConfig} \
      "$out/share/turtle-wow/WTF/Config.wtf"

    ${pkgs.lib.concatStrings (pkgs.lib.mapAttrsToList
      (accountName: accountConfig:
        let upperAccountName = pkgs.lib.toUpper accountName;
        in ''
          mkdir -p "$out/share/turtle-wow/WTF/Account/${upperAccountName}"
          cp ${generateAccountConfig accountName accountConfig} \
            "$out/share/turtle-wow/WTF/Account/${upperAccountName}/SavedVariables.lua"
        '') mappedAccountConfigs)}

    ${pkgs.lib.concatStrings (pkgs.lib.mapAttrsToList
      (accountName: bindingConfig:
        let upperAccountName = pkgs.lib.toUpper accountName;
        in ''
          mkdir -p "$out/share/turtle-wow/WTF/Account/${upperAccountName}"
          cp ${generateBindingsFile accountName bindingConfig} \
            "$out/share/turtle-wow/WTF/Account/${upperAccountName}/bindings-cache.wtf"
        '') bindings)}

    ${pkgs.lib.concatStrings (pkgs.lib.mapAttrsToList
      (accountName: accountMacros:
        let
          upperAccountName = pkgs.lib.toUpper accountName;
          globalMacroFile = pkgs.writeText "macros-cache.txt"
            (generateMacroCache {
              macros = accountMacros.global;
              startId = 1;
            });
        in ''
          mkdir -p "$out/share/turtle-wow/WTF/Account/${upperAccountName}"
          cp ${globalMacroFile} \
            "$out/share/turtle-wow/WTF/Account/${upperAccountName}/macros-cache.txt"

          ${pkgs.lib.concatStringsSep "\n" (pkgs.lib.mapAttrsToList
            (serverName: serverMacros:
              pkgs.lib.concatStringsSep "\n" (pkgs.lib.mapAttrsToList
                (characterName: characterMacros:
                  let
                    charMacroFile = pkgs.writeText "macros-cache.txt"
                      (generateMacroCache {
                        macros = characterMacros;
                        startId = 10000;
                      });
                  in ''
                    mkdir -p "$out/share/turtle-wow/WTF/Account/${upperAccountName}/${serverName}/${characterName}"
                    cp ${charMacroFile} \
                      "$out/share/turtle-wow/WTF/Account/${upperAccountName}/${serverName}/${characterName}/macros-cache.txt"
                  '') serverMacros)) accountMacros.servers)}
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
    homepage = "https://turtlecraft.gg";
    license = licenses.unfree;
    platforms = platforms.linux;
  };
}
