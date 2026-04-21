{ ... }: {
  services.darkman = {
    enable = true;

    settings = {
      usegeoclue = true;
      dbusserver = true;
      portal = true;
    };
  };
}
