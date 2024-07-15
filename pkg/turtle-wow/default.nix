{ pkgs, ver ? "1171", addons ? [ ]
, winePrefix ? "~/.cache/turtle-wow/.wine-prefix", gameConfig ? { }
, accountConfigs ? { }, bindings ? { }, macros ? { } }:

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
    url = "https://turtle-eu.b-cdn.net/twmoa_${version}.zip";
    sha256 = "sha256-fJNiSRln7xsyv3P4B6NTudvF7wAVFSJdu2LEpPdqu3w=";
  };
  nativeBuildInputs = [ pkgs.unzip pkgs.copyDesktopItems ];
  buildInputs = [ pkgs.wineWowPackages.full pkgs.vulkan-loader ];
  dontBuild = true;
  installPhase = ''
      mkdir -p $out/share/turtle-wow $out/bin $out/share/icons/hicolor/256x256/apps/ $out/share/applications
      rm -f ./realmlist.wtf ./Config.wtf
      cp -r * $out/share/turtle-wow
      cp ${
        pkgs.copyPathToStore ./res/icon.png
      } $out/share/icons/hicolor/256x256/apps/turtle-wow.png
      cp -r ${desktop}/share/applications/* $out/share/applications
      ${
        pkgs.lib.concatMapStrings (addon: ''
          cp -r ${addon}/share/${addon.pname} $out/share/turtle-wow/Interface/AddOns/
        '') buildAddons
      }
      substituteAll ${./res/turtle-wow} $out/bin/turtle-wow
      echo "export WINE_STORE=${pkgs.wineWowPackages.full}" >>$out/bin/turtle-wow.env
      echo "export TURTLE_WOW_STORE=$out" >>$out/bin/turtle-wow.env
      echo "export WINEPREFIX=${winePrefix}" >>$out/bin/turtle-wow.env
      chmod +x $out/bin/turtle-wow
      printf 'set realmlist %s\nset patchlist %s\n' "${combinedConfig.realmList}" "${combinedConfig.patchlist}" >$out/share/turtle-wow/realmlist.wtf
      echo "${generatedWtfConfig}" >$out/share/turtle-wow/WTF/Config.wtf
      chmod 444 $out/share/turtle-wow/WTF/Config.wtf  
    ${
      pkgs.lib.concatStrings (pkgs.lib.mapAttrsToList
        (accountName: accountConfig:
          let upperAccountName = pkgs.lib.toUpper accountName;
          in ''
            mkdir -p $out/share/turtle-wow/WTF/Account/${upperAccountName}    
            cp ${
              generateAccountConfig accountName accountConfig
            } $out/share/turtle-wow/WTF/Account/${upperAccountName}/SavedVariables.lua    
            chmod 444 $out/share/turtle-wow/WTF/Account/${upperAccountName}/SavedVariables.lua  
          '') mappedAccountConfigs)
    }    
    ${
      pkgs.lib.concatStrings (pkgs.lib.mapAttrsToList
        (accountName: bindingConfig:
          let upperAccountName = pkgs.lib.toUpper accountName;
          in ''
            mkdir -p $out/share/turtle-wow/WTF/Account/${upperAccountName}    
            cp ${
              generateBindingsFile accountName bindingConfig
            } $out/share/turtle-wow/WTF/Account/${upperAccountName}/bindings-cache.wtf    
            chmod 444 $out/share/turtle-wow/WTF/Account/${upperAccountName}/bindings-cache.wtf  
          '') bindings)
    }    
    ${pkgs.lib.concatStrings (pkgs.lib.mapAttrsToList
      (accountName: accountMacros:
        let upperAccountName = pkgs.lib.toUpper accountName;
        in ''
                                      mkdir -p $out/share/turtle-wow/WTF/Account/${upperAccountName}
                                    echo "${
                                      generateMacroCache {
                                        macros = accountMacros.global;
                                        startId = 1;
                                      }
                                    }" > $out/share/turtle-wow/WTF/Account/${upperAccountName}/macros-cache.txt
          ${
            pkgs.lib.concatStringsSep "\n" (pkgs.lib.mapAttrsToList
              (serverName: serverMacros:
                pkgs.lib.concatStringsSep "\n" (pkgs.lib.mapAttrsToList
                  (characterName: characterMacros: ''
                    mkdir -p $out/share/turtle-wow/WTF/Account/${upperAccountName}/${serverName}/${characterName}  
                    echo "${
                      generateMacroCache {
                        macros = characterMacros;
                        startId = 10000;
                      }
                    }" > $out/share/turtle-wow/WTF/Account/${upperAccountName}/${serverName}/${characterName}/macros-cache.txt  
                  '') serverMacros)) accountMacros.servers)
          }  
        '') macros)}
      mv $out/share/turtle-wow/WTF $out/share/turtle-wow/WTF.original
      ln -s /tmp/turtle-wow $out/share/turtle-wow/WTF
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

#                  generateMacroCache {
#                    macros = serverMacros;
#                    startId = 10000;
#                  }
