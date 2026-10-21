{ ... }: {
  imports = [
    ./files.nix
    ./gtk.nix
    ./packages.nix
    ./programs
    ./services
    ./session.nix
    ./xdg.nix
  ];
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "23.11";
  home.username = "ges";
  home.homeDirectory = "/home/ges";
  programs.home-manager.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
