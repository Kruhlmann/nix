{ pkgs }:
mod@{ name, dlls, kind, ... }:

if kind == "builtin" then {
  pname = name;
  inherit dlls kind;
  outPath = null;
} else
  let
    src = if kind == "zip" then
      pkgs.fetchzip {
        inherit (mod) url sha256;
        stripRoot = false;
      }
    else if kind == "file" then
      pkgs.fetchurl { inherit (mod) url sha256; }
    else
      throw "Unsupported client mod kind: ${kind}";

    drv = pkgs.stdenvNoCC.mkDerivation {
      pname = name;
      version = "1";

      inherit src;

      dontBuild = true;
      dontUnpack = kind == "file";

      installPhase = ''
        mkdir -p "$out/share/${name}"

        if [ -d "$src" ]; then
          find "$src" -type f -iname '*.dll' -exec cp -t "$out/share/${name}" {} +
        else
          cp "$src" "$out/share/${name}/${builtins.baseNameOf mod.url}"
        fi
      '';

      meta = with pkgs.lib; {
        description = "${name} client mod for Turtle WoW";
        homepage = mod.url or null;
        license = licenses.unfree;
        platforms = platforms.linux;
      };
    };
  in {
    pname = name;
    inherit dlls kind;
    outPath = drv;
  }
