{ ... }: {
  networking.hostName = "gesnix";
  networking.networkmanager.enable = true;
  networking.networkmanager.settings.main = { systemd-resolved = "true"; };
  networking.extraHosts = ''
    127.0.0.1 redis
  '';
  networking.nameservers = [ "1.1.1.1" ];
  networking.firewall.enable = true;
  networking.firewall.trustedInterfaces = [ "virbr0" "virbr80" "virbr81" ];
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
    settings.Resolve = {
      LLMNR = "false";
      FallbackDNS = [ "1.1.1.1" ];
      DNSSEC = "allow-downgrade";
      DNSOverTLS = "opportunistic";
    };
  };
  systemd.network.enable = true;
  networking.nftables.enable = true;
  systemd.network.wait-online.enable = false;
}
