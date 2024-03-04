{ config, ... }: {
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "auto";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "amdgpu" "nvidia" "kvm-amd" "kvm-intel" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
}
