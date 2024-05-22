{ pkgs, ... }: {
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.onBoot = "start";
  virtualisation.libvirtd.onShutdown = "shutdown";
  virtualisation.libvirtd.allowedBridges = [ "virbr0" "nat0" "nat1" ];
  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;
}
