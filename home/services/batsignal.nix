{ pkgs, ... }: {
  systemd.user.services.batsignal = {
    Unit = {
      Description = "Battery warning notifications";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart =
        "${pkgs.batsignal}/bin/batsignal -b -w 20 -c 10 -d 5 -f 100 -p";
      Restart = "on-failure";
    };
    Install = { WantedBy = [ "graphical-session.target" ]; };
  };
}
