{ pkgs, ... }: {
  systemd.user.services.caffeine-ng = {
    Unit = {
      Description = "Caffeine-ng tray icon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.caffeine-ng}/bin/caffeine";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
