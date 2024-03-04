{ ... }: {
  networking.hostName = "gesnix";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
  systemd.network.enable = true;
  systemd.network.networks."nat0" = {
    enable = true;
    matchConfig = "nat0";
    networkConfig = {
      Address = [ "172.31.0.1/24" "172.31.0.2/24" ];
      IPMasquerade = true;
      ConfigureWithoutCarrier = true;
    };
  };
  systemd.network.netdevs."nat0" = {
    enable = true;
    netdevConfig = {
      Name = "nat0";
      Kind = "bridge";
    };
  };
  systemd.network.networks."nat1" = {
    enable = true;
    matchConfig = "nat1";
    networkConfig = {
      Address = [ "172.31.1.2/24" ];
      ConfigureWithoutCarrier = true;
    };
  };
  systemd.network.netdevs."nat1" = {
    enable = true;
    netdevConfig = {
      Name = "nat1";
      Kind = "bridge";
    };
  };
}
