{ pkgs, ... }: {
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.onBoot = "start";
  virtualisation.libvirtd.onShutdown = "shutdown";
  virtualisation.libvirtd.allowedBridges = [ "virbr0" "nat0" "nat1" ];
  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;
  virtualisation.libvirtd.qemu.runAsRoot = true;
  virtualisation.libvirtd.qemu.swtpm.enable = true;
  virtualisation.libvirtd.qemu.ovmf.enable = true;
  virtualisation.libvirtd.qemu.ovmf.packages = [(pkgs.OVMF.override {
    secureBoot = true;
    tpmSupport = true;
  }).fd];
}
