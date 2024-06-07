{ pkgs, ... }: {
  systemd.user.services.autorandr-loop = {
    Unit = { Description = "AutoRandR loop"; };
    Service = {
      Type = "simple";
      ExecStart =
        "${pkgs.bash}/bin/bash -c 'while true; do ${pkgs.autorandr}/bin/autorandr -c; sleep 3; done'";
      Restart = "always";
      RestartSec = "3s";
    };
  };
}
