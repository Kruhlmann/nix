{ pkgs }:
mod@{ name, dlls, builtin ? false, ... }:

if builtin then {
  pname = name;
  inherit dlls builtin;
  outPath = null;
} else
  let
    drv = pkgs.stdenv.mkDerivation {
      pname = name;
      version = "1";

      src = pkgs.fetchzip {
        inherit (mod) url sha256;
        stripRoot = false;
      };

      dontBuild = true;

      installPhase = ''
        mkdir -p "$out/share/${name}"
        cp -r "$src"/* "$out/share/${name}/"
      '';

      meta = with pkgs.lib; {
        description = "${name} client mod for Turtle WoW";
        homepage = mod.url;
        license = licenses.unfree;
        platforms = platforms.linux;
      };
    };
  in {
    pname = name;
    inherit dlls builtin;
    outPath = drv;
  }
