{ pkgs, ... }: {
  boot.initrd.verbose = true;
  boot.consoleLogLevel = 7;
  boot.kernelParams = [
    "splash"
    "systemd.show_status=1"
    "rd.systemd.show_status=1"
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
