{ pkgs, ... }: {
  networking.hostName = "gesnix";
  networking.networkmanager.enable = true;
  networking.networkmanager.unmanaged = [ "nat0" "nat1" ];
  networking.networkmanager.settings.main = {
    dns = "none";
    systemd-resolved = "false";
  };
  networking.firewall.enable = true;
  networking.firewall.allowedUDPPorts = [ 61820 ];
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  networking.wireguard.interfaces.wg0 = {
      ips = [ "10.13.13.2/24" ];
      listenPort = 61820;
      privateKeyFile = "/home/ges/.cache/punlock/tmp/pass/wg0.key";
      peers = [{
        publicKey = "gm0ndVBukhLM2lCBKtUwLnGCC/xoEJjGKbDpZOV0DXA=";
        allowedIPs = [ "0.0.0.0/0" ];
        endpoint = "188.177.19.193:61820";
        persistentKeepalive = 25;
      }];
  };
  services.resolved = {
    enable = true;
    fallbackDns = [ "8.8.8.8" ];
    dnsovertls = "false";
    llmnr = "false";
    extraConfig = ''
      Cache=no-negative
      DNS=172.31.0.2
    '';
  };
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
  networking.nftables.enable = true;
  systemd.network.wait-online.enable = false;
  systemd.services.docker.serviceConfig.PartOf = "nftables.service";
  systemd.services.docker.serviceConfig.ExecStartPost =
    "${pkgs.nftables}/bin/nft -f /etc/systemd/nftables.d/docker.conf";
  systemd.services.systemd-networkd.serviceConfig.PartOf = "nftables.service";
  systemd.services.systemd-networkd.serviceConfig.ExecStartPost =
    "${pkgs.nftables}/bin/nft -f /etc/systemd/nftables.d/nat0.conf";
  environment.etc."systemd/nftables.d/nat0.conf".text = ''
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
  environment.etc."systemd/nftables.d/docker.conf".text = ''
    #!/usr/sbin/nft -f

    flush chain inet filter docker.input
    flush chain inet filter docker.forward

    table inet filter {
      chain docker.input {
        iif docker0 accept
      }
      chain docker.forward {
        iif docker0 accept
      }
    }
  '';
  networking.nftables.ruleset = ''
    #!/usr/sbin/nft -f

    flush ruleset

    table inet filter {
      chain input {
        type filter hook input priority filter
        policy drop
        
        ct state invalid drop comment "early drop of invalid connections"
        ct state {established, related} accept comment "allow tracked connections"
        
        iif lo accept comment "allow from loopback"
        jump docker.input comment "jump to docker managed input chain"
        jump nat.input comment "jump to systemd-networkd managed input chain"
        
        ip protocol icmp accept comment "allow icmp"
        meta l4proto ipv6-icmp accept comment "allow icmp v6"
        tcp dport ssh accept comment "allow sshd"
        pkttype host limit rate 5/second counter reject with icmpx type admin-prohibited
        counter
      }
      chain docker.input{
      }
      chain nat.input{
      }
      chain forward {
        type filter hook forward priority filter
        policy drop
        
        ct state {established, related} accept
        jump docker.forward
        jump nat.forward
      }
      chain docker.forward{
      }
      chain nat.forward{
      }
      chain output {
        type filter hook output priority filter
      }
    }
  '';
}
