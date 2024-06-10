{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "notify-connect";
  version = "1.0";
  src = ./.;
  buildPhase = "true";
  installPhase = ''
    mkdir -p $out/bin/
    cp notify-connect $out/bin/notify-connect
    chmod +x $out/bin/notify-connect
  '';
  buildInputs = [ pkgs.curl ];
  meta = {
    description = "Connection state notifier";
    license = pkgs.lib.licenses.mit;
  };
}
