{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "siemens-certs";
  version = "1.0";
  src = ./.;
  buildPhase = "true";
  installPhase = ''
    mkdir -p $out/etc/ssl/certs
    cat $src/certs/*.cer > $out/etc/ssl/certs/siemens.pem
  '';
  meta = {
    description = "Siemens SSL certificates";
    license = pkgs.lib.licenses.mit;
  };
}
