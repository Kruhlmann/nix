{ ... }: {
  services.fail2ban = {
    enable = true;
    jails = {
      sshd = {
        enable = true;
        port = "ssh";
        filter = "sshd";
        logpath = "/var/log/auth.log";
        maxRetry = 3;
        findTime = 600;
        bantime = 3600;
      };
    };
  };
}
