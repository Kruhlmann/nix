{ pkgs, ... }: {
  networking.hostName = "gesnix";
  networking.networkmanager.enable = true;
  networking.networkmanager.unmanaged = [ "nat0" "nat1" ];
  networking.networkmanager.settings = {
    main = {
      dns = "none";
      systemd-resolved = "true";
    };
  };
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  networking.nameservers = [ "127.0.0.1" "172.31.0.2" "8.8.8.8" ];
  services.resolved = {
    enable = true;
    fallbackDns = [ "1.1.1.1" "8.8.8.8" ];
    dnsovertls = "false";
  };
  systemd.network.enable = true;
  systemd.network.networks.nat0 = {
    enable = true;
    matchConfig.Name = "nat0";
    networkConfig.Address = [ "172.31.0.1/24" "172.31.0.2/24" ];
    networkConfig.IPMasquerade = true;
    networkConfig.ConfigureWithoutCarrier = true;
    dns = [ "172.31.0.2" ];
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
  systemd.services.systemd-networkd.serviceConfig.ExecStartPost =
    "${pkgs.nftables}/bin/nft -f /etc/nftables-nat0.conf";
  networking.nftables.enable = true;
#  networking.nftables.ruleset = ''
#    flush ruleset
#
#    table inet filter {
#      chain input {
#        type filter hook input priority 0; policy drop;
#        ct state established,related accept
#        tcp dport {ssh} accept
#        iif lo accept
#        jump nat.input
#      }
#      chain nat.input {
#      }
#      chain forward {
#        type filter hook forward priority 0; policy drop;
#        ct state established,related accept
#        jump nat.forward
#      }
#      chain nat.forward {
#      }
#      chain output {
#        type filter hook output priority 0;
#      }
#    }
#  '';
  environment.etc."nftables-nat0.conf".text = ''
    #!/usr/sbin/nft -f

    flush chain inet filter nat.input
    flush chain inet filter nat.forward

    table inet filter {
      chain nat.input {
        iif nat0 accept
        iif nat1 accept
      }
      chain nat.forward {
        iif nat0 accept
      }
    }
  '';
}
