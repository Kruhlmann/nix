{ pkgs, ... }:
pkgs.stdenv.mkDerivation {
  name = "adaptrandr";
  version = "1.0";
  src = ./.;
  buildInputs = [ pkgs.udev ];
  buildPhase = "true";
  installPhase = ''
    mkdir -p $out/bin
    install -m755 adaptrandr $out/bin
    mkdir -p $out/lib/udev/rules.d
    install -m644 99-adaptrandr.rules $out/lib/udev/rules.d
  '';
  meta = {
    description = "Adapter screen randr";
    license = pkgs.lib.licenses.mit;
  };
}
