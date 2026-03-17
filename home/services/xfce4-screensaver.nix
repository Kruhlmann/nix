{ pkgs, ... }: {
  systemd.user.services.xfce4-screensaver = {
    Unit = {
      Description = "Xfce4 Screensaver";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.xfce.xfce4-screensaver}/bin/xfce4-screensaver";
      Restart = "on-failure";
    };
    Install = { WantedBy = [ "graphical-session.target" ]; };
  };
}
