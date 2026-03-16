{ ... }: {
  networking.hostName = "gesnix";
  networking.networkmanager.enable = true;
  networking.networkmanager.settings.main = { systemd-resolved = "true"; };
  networking.extraHosts = ''
    127.0.0.1 redis
  '';
  networking.nameservers = [ "1.1.1.1" ];
  networking.firewall.enable = true;
  networking.firewall.trustedInterfaces = [ "virbr0" "virbr80" ];
  networking.firewall.checkReversePath = "loose";
  networking.firewall.allowedUDPPorts = [ 61820 ];
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  networking.firewall.allowedTCPPortRanges = [{
    from = 1714;
    to = 1764;
  }];
  networking.firewall.allowedUDPPortRanges = [{
    from = 1714;
    to = 1764;
  }];
  services.resolved = {
    enable = true;
    fallbackDns = [ "1.1.1.1" ];
    dnssec = "allow-downgrade";
    dnsovertls = "opportunistic";
    llmnr = "false";
    extraConfig = ''
      [Resolve]
      DNS=1.1.1.1
      FallbackDNS=8.8.8.8
    '';
  };
  systemd.network.enable = true;
  networking.nftables.enable = true;
  systemd.network.wait-online.enable = false;
}
