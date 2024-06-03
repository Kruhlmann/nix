{ pkgs, ... }: {
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "auto";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "splash" ];
  boot.initrd.kernelModules = [ "kvm-intel" ];
  #boot.initrd.kernelModules = [ "amdgpu" "kvm-amd" "kvm-intel" ];
}
