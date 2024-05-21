{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "dnsmasq_dbus";
  version = "1.0";
  unpackPhase = "true";
  installPhase = ''
    mkdir -p $out/etc/dbus-1/system.d
    cat <<EOF >$out/etc/dbus-1/system.d/dnsmasq.conf
<!DOCTYPE busconfig PUBLIC
 "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>
  <policy user="root">
    <allow own="uk.org.thekelleys.dnsmasq.nat0"/>
    <allow send_destination="uk.org.thekelleys.dnsmasq.nat0"/>
  </policy>
  <policy context="default">
    <deny own="uk.org.thekelleys.dnsmasq.nat0"/>
    <deny send_destination="uk.org.thekelleys.dnsmasq.nat0"/>
  </policy>
</busconfig>
EOF
  '';

  meta = {
    description = "dnsmasq dbus configuration";
    license = pkgs.lib.licenses.mit;
  };
}
