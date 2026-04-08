{ pkgs }:
patch@{ name, kind, ... }:

let
  src = if kind == "zip" then
    pkgs.fetchzip {
      inherit (patch) url sha256;
      stripRoot = false;
    }
  else if kind == "file" then
    pkgs.fetchurl { inherit (patch) url sha256; }
  else
    throw "Unsupported patch kind: ${kind}";
in pkgs.stdenvNoCC.mkDerivation {
  pname = name;
  version = "1";

  inherit src;

  dontBuild = true;
  dontUnpack = kind == "file";

  installPhase = ''
    mkdir -p "$out/share/${name}"

    if [ -d "$src" ]; then
      find "$src" -type f -iname '*.mpq' -exec cp -t "$out/share/${name}" {} +
    else
      cp "$src" "$out/share/${name}/${builtins.baseNameOf patch.url}"
    fi
  '';

  meta = with pkgs.lib; {
    description = "${name} patch for Turtle WoW";
    homepage = patch.url or null;
    license = licenses.unfree;
    platforms = platforms.linux;
  };
}
