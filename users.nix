{ config, pkgs, ... }: {
  users.users.ges = {
    isNormalUser = true;
    description = "Andreas Krühlmann";
    extraGroups = [ "wheel" "docker" "libvirt" "networkmanager" ];
  };
  nix.settings.trusted-users = [ "ges" ];
}
