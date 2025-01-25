{ pkgs, ... }: {
  services.dnsmasq = {
    enable = true;
    # settings = { conf-file = "/etc/dnsmasq.d/*"; };
  };

  environment.etc."dnsmasq.d/lo.conf".text = ''
    all-servers
    bind-interfaces
    listen-address=172.31.0.2
    resolv-file=/run/NetworkManager/resolv.conf
    conf-dir=/run/dnsmasq/,*.conf
    server=/modi.nat0/172.31.0.1
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
    dhcp-host=set:gain,gateway,172.31.0.101
    dhcp-option=tag:gain,option:dns-server,172.31.0.1
    dhcp-option=tag:gain,option:domain-name,ad001.siemens.net
  '';

  systemd.services."dnsmasq@" = {
    description = "dnsmasq@i - A lightweight DHCP and caching DNS server";
    after = [ "network.target" ];
    before = [ "network-online.target" "nss-lookup.target" ];
    wants = [ "nss-lookup.target" ];
    serviceConfig = {
      BusName = "uk.org.thekelleys.dnsmasq.%i";
      ExecStartPre = [
        "${pkgs.coreutils}/bin/mkdir -m 755 -p /run/dnsmasq"
        "${pkgs.dnsmasq}/bin/dnsmasq --test --conf-file=/etc/dnsmasq.d/%i.cfg"
        "${pkgs.dnsmasq}/bin/dnsmasq --test"
      ];
      ExecStart =
        "${pkgs.dnsmasq}/bin/dnsmasq -k --enable-dbus=uk.org.thekelleys.dnsmasq.%i --user=dnsmasq --pid-file --conf-file=/etc/dnsmasq.d/%i.cfg";
      ExecReload = "/bin/kill -HUP $MAINPID";
      Restart = "on-failure";
      PrivateDevices = true;
      ProtectSystem = "full";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
