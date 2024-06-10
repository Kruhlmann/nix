{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "extra-certs";
  version = "1.0";
  src = ./.;
  buildPhase = "true";
  installPhase = ''
    mkdir -p $out/etc/ssl/certs
    cat $src/certs/*.cer > $out/etc/ssl/certs/extra.pem
  '';
  meta = {
    description = "Extra SSL certificates";
    license = pkgs.lib.licenses.mit;
  };
}
