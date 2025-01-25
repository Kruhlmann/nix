{ pkgs, ... }: {
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ intel-compute-runtime ];
  };
  hardware.bluetooth.enable = true;
  hardware.ckb-next.enable = true;
}
