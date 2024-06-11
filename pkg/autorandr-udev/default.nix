{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "autorandr-udev";
  version = "1.0";
  src = ./.;
  buildPhase = "true";
  installPhase = ''
    mkdir -p $out/bin
    cp autorandr-udev $out/bin/autorandr-udev
    chmod +x $out/bin/autorandr-udev 
  '';
  meta = {
    description = "Auto execute autorandr -c";
    license = pkgs.lib.licenses.mit;
  };
}
