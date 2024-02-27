{ config, pkgs, ... }: {
  users.users.ges = {
    isNormalUser = true;
    description = "Andreas Krühlmann";
    extraGroups = [ "audio" "wheel" "docker" "libvirt" "networkmanager" ];
    shell = pkgs.zsh;
  };
  nix.settings.trusted-users = [ "ges" ];
}
