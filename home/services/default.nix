{ ... }: {
  imports = [ ./gpg-agent.nix ];
  services.lorri.enable = true;
}
