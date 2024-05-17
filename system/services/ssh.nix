{ ... }: {
  services.openssh = {
    settings.LogLevel = "VERBOSE";
    enable = true;
    extraConfig = ''
      Include /etc/ssh/sshd_config.d/*.conf

      Port 22
      LogLevel INFO
      PermitRootLogin no
      MaxAuthTries 3
      PasswordAuthentication no
      ChallengeResponseAuthentication no
      UsePAM yes
      AllowAgentForwarding yes
      AllowTcpForwarding yes
      X11UseLocalhost yes
      X11Forwarding yes
      X11UseLocalhost no
      PermitTTY yes
      PrintMotd no
      PermitUserEnvironment yes
      PermitTunnel yes
      Subsystem	sftp	/usr/lib/openssh/sftp-server
      AllowUsers ges
      Ciphers aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com
    '';
  };
}
