{
  imports = [ ./common.nix ];
  networking.hostName = "gesnix-desktop";
  hardware.amdgpu.initrd.enable = true;
}
