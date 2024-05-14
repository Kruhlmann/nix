{ ... }: {
  networking.hostName = "gesnix";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  systemd.network.enable = true;
  systemd.network.networks.nat0 = {
    enable = true;
    matchConfig.Name = "nat0";
    networkConfig.Address = [ "172.31.0.1/24" "172.31.0.2/24" ];
    networkConfig.IPMasquerade = true;
    networkConfig.ConfigureWithoutCarrier = true;
  };
  systemd.network.netdevs.nat0 = {
    enable = true;
    netdevConfig.Name = "nat0";
    netdevConfig.Kind = "bridge";
  };
  systemd.network.networks.nat1 = {
    enable = true;
    matchConfig.Name = "nat1";
    networkConfig.Address = [ "172.31.1.2/24" ];
    networkConfig.ConfigureWithoutCarrier = true;
  };
  systemd.network.netdevs.nat1 = {
    enable = true;
    netdevConfig.Name = "nat1";
    netdevConfig.Kind = "bridge";
  };
  systemd.network.wait-online.enable = false;
  networking.resolvconf = {
    enable = true;
    package = pkgs.openresolv;
  };
  environment.etc."resolv.conf".text = ''
    nameserver 127.0.0.1
    nameserver 8.8.8.8
    nameserver 8.8.4.4
    search your.domain
  '';
  networking.networkmanager = {
    enable = true;
    useGlobalDns = true;
  };
}
