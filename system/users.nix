{ pkgs, ... }: {
  users.users.ges = {
    createHome = true;
    isNormalUser = true;
    description = "Andreas Krühlmann";
    extraGroups = [
      "audio"
      "wheel"
      "docker"
      "libvirtd"
      "qemu-libvirtd"
      "networkmanager"
      "wireshark"
      "kvm"
      "flatpak"
    ];
    shell = pkgs.zsh;
  };
  nix.settings.trusted-users = [ "ges" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
