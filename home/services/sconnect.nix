{ pkgs, ... }:
let
  notify-connect =
    import ../../pkg/notify-connect/default.nix { inherit pkgs; };
in {
  systemd.user.services."sconnect-loop" = {
    #wantedBy = [ "default.target" ];
    Unit = { Description = "SConnect loop"; };
    Service = {
      Type = "simple";
      ExecStart = "${notify-connect}/bin/notify-connect";
      Restart = "always";
      RestartSec = "5s";
    };
  };
}
