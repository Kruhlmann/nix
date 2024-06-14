{ pkgs, ... }: {
  systemd.user.services."autorandr-loop" = {
    #wantedBy = [ "default.target" ];
    Unit = { Description = "AutoRandR loop"; };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.autorandr}/bin/autorandr -c";
      Restart = "always";
      RestartSec = "3s";
    };
  };
}
