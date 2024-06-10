{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "dnsmasq_dbus";
  version = "1.0";
  src = ./.;
  buildPhase = "true";
  installPhase = ''
    mkdir -p $out/etc/dbus-1/system.d
    cp dnsmasq.conf $out/etc/dbus-1/system.d/dnsmasq.conf
  '';
  meta = {
    description = "Configuration for dnsmasq dbus";
    license = pkgs.lib.licenses.mit;
  };
}
