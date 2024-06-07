{ ... }: {
  imports = [ ./gpg-agent.nix ./autorandr.nix ];
  services.lorri.enable = true;
}
