{
  imports = [ ./common.nix ];
  networking.hostName = "gesnix-hp-laptop";
  boot.kernelParams = [ "i915.enable_psr=0" ];
}
