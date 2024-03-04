{ pkgs, ... }: {
  users.users.ges = {
    createHome = true;
    isNormalUser = true;
    description = "Andreas Krühlmann";
    extraGroups =
      [ "audio" "wheel" "docker" "libvirtd" "qemu-libvirtd" "networkmanager" ];
    shell = pkgs.zsh;
  };
  nix.settings.trusted-users = [ "ges" ];
}
