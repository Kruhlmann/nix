{ pkgs, ... }:
{
  boot.kernelParams = [
    "splash"
    "i915.enable_psr=0"
  ];
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = true;
    "vm.dirty_background_ratio" = 2;
    "vm.dirty_ratio" = 8;
    "vm.dirty_expire_centisecs" = 2000;
    "vm.dirty_writeback_centisecs" = 200;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
