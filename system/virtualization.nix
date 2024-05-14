{ pkgs, ... }: {
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.onBoot = "start";
  virtualisation.libvirtd.onShutdown = "shutdown";
  virtualisation.libvirtd.allowedBridges = [ "virbr0" "nat0" "nat1" ];
  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;
  virtualisation.libvirtd.virtualMachines = {
    mlinux = {
      memory = 4096;
      vcpu = 2;
      disks = [{
        file = "/var/lib/libvirt/images/mlinux.qcow2";
        format = "qcow2";
      }];
      networkInterfaces = [
      { model = "virtio";
        macAddress = "52:54:00:4b:88:ad";
        bridge = "nat0"; }
      { model = "virtio";
        macAddress = "52:54:00:1e:51:6d";
        bridge = "nat1";
      }];
      boot = { dev = "hd"; };
      cpu = { mode = "host-passthrough"; };
      graphics = { type = "spice"; listen = "127.0.0.1"; };
      video = { model = "qxl"; };
      extraConfig = ''
        <clock offset="utc">
          <timer name="rtc" tickpolicy="catchup"/>
          <timer name="pit" tickpolicy="delay"/>
          <timer name="hpet" present="no"/>
        </clock>
        <features>
          <acpi/>
          <apic/>
          <vmport state="off"/>
        </features>
        <pm>
          <suspend-to-mem enabled="no"/>
          <suspend-to-disk enabled="no"/>
        </pm>
      '';
    };
  };
}
