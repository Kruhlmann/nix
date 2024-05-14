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
  '';
  networking.networkmanager = {
    enable = true;
    useGlobalDns = true;
  };
  networking.nftables.enable = true;
  networking.nftables.rules = ''
    flush ruleset

    table inet filter {
      chain input {
        type filter hook input priority 0; policy drop;
        ct state established,related accept
        tcp dport {ssh} accept
        # BEGIN Experimental
        iif docker0 accept
        # END Experimental
        iif lo accept
        jump nat.input
      }
      chain nat.input {
      }
      chain forward {
        type filter hook forward priority 0; policy drop;
        ct state established,related accept
        jump nat.forward
      }
      chain nat.forward {
      }
      chain output {
        type filter hook output priority 0;
      }
    }
  '';
  environment.etc."dbus-1/system.d/dnsmasq-dbus.conf".text = ''
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
  '';
}
