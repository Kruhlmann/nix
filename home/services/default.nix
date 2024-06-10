{ ... }: {
  imports = [ ./gpg-agent.nix ./autorandr.nix ./sconnect.nix ];
  services.lorri.enable = true;
}
