{ pkgs, ... }: {
  virtualisation.docker.enable = true;
  virtualisation.docker.liveRestore = false;
  virtualisation.docker.autoPrune.enable = true;
  virtualisation.waydroid.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.onBoot = "start";
  virtualisation.libvirtd.onShutdown = "shutdown";
  virtualisation.libvirtd.allowedBridges = [ "virbr0" "nat0" "nat1" ];
  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;
  virtualisation.libvirtd.qemu.runAsRoot = true;
  virtualisation.libvirtd.qemu.swtpm.enable = true;
  systemd.services.docker.environment = {
    HTTP_PROXY = "http://localhost:8888";
    HTTPS_PROXY = "http://localhost:8888";
    NO_PROXY = "localhost,127.0.0.1";
  };
}
