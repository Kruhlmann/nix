{ pkgs, ... }: {
  boot.kernel.sysctl."net.ipv4.ip_forward" = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "auto";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "splash" "i915.enable_psr=0" ];
}
