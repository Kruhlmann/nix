{ config, lib, pkgs, ... }:

{
  services.dnsmasq.enable = true;
  services.dnsmasq.extraConfig = ''
    conf-dir=/etc/dnsmasq.d/,*.conf
  '';

  environment.etc."dnsmasq.d/nat0.cfg".text = ''
    all-servers
    bind-interfaces
    listen-address=172.31.0.1
    resolv-file=/run/NetworkManager/resolv.conf
    dhcp-range=172.31.0.10,172.31.0.99,12h
    dhcp-option=option:dns-server,172.31.0.2
    domain=modi.nat0,172.31.0.0/24
    local=/modi.nat0/
    dhcp-host=set:gain,md3zcf1c,172.31.0.100
    dhcp-host=set:gain,gateway,172.31.0.101
    dhcp-option=tag:gain,option:dns-server,172.31.0.1
    dhcp-option=tag:gain,option:domain-name,ad001.siemens.net
  '';

  environment.etc."dnsmasq.d/lo.conf".text = ''
    all-servers
    bind-interfaces
    listen-address=127.0.0.1,172.31.0.2,172.17.0.1
    resolv-file=/run/NetworkManager/resolv.conf
    conf-dir=/run/dnsmasq/,*.conf
    server=/modi.nat0/172.31.0.1
  '';
}
