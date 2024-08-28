{ pkgs, ... }: {
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
        intel-compute-runtime
    ];
  };
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.ckb-next.enable = true;
}
