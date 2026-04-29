{ pkgs, ... }:
let
  mac-style-src = pkgs.fetchFromGitHub {
    owner = "SergioRibera";
    repo = "s4rchiso-plymouth-theme";
    rev = "bc585b7f42af415fe40bece8192d9828039e6e20";
    sha256 = "sha256-yOvZ4F5ERPfnSlI/Scf9UwzvoRwGMqZlrHkBIB3Dm/w=";
  };
  mac-style-load = pkgs.callPackage mac-style-src { };
in
{
  boot.kernel.sysctl."net.ipv4.ip_forward" = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "auto";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
    "splash"
    "i915.enable_psr=0"
  ];
  boot.supportedFilesystems = [ "ntfs" ];
  boot.plymouth = {
    enable = true;
    theme = "mac-style";
    themePackages = [ mac-style-load ];
  };
}
