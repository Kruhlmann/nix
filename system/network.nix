{ config, pkgs, ... }: {
  networking.hostName = "gesnix";
  networking.networkmanager.enable = true;
#  networking.networkmanager.customizeConfig = ''
#    dns=dnsmasq
#  '';
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
#  networking.useNetworkd = true;

#  networking.networkd.netdevs.nat0 = {
#    name = "nat0";
#    kind = "bridge";
#  };
#  networking.networkd.netdevs.nat1 = {
#    name = "nat1";
#    kind = "bridge";
#  };
#  networking.networkd.links.nat0.networkConfig = {
#    Address = [ "172.31.0.1/24" "172.31.0.2/24" ];
#    IPMasquerade = true;
#    ConfigureWithoutCarrier = true;
#  };
#  networking.networkd.links.nat1.networkConfig = {
#    Address = [ "172.31.1.2/24" ];
#    ConfigureWithoutCarrier = true;
#  };
}
