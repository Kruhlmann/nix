{ lib, ... }:
let
  fileExists = file: builtins.pathExists file;
  hasAmdGpu =
    fileExists "/sys/class/drm/card0/device/driver/module/drivers/pci:amdgpu";
in {
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "auto";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "kvm-intel" "kvm-amd" ]
    ++ lib.optionals hasAmdGpu [ "amdgpu" ];
}
