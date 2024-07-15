{ pkgs, settings, ... }:
let
  generateConfigWtf = settings:
    pkgs.lib.concatStringsSep "\n"
    (map (key: ''SET ${key} "${settings.${key}}"'')
      (builtins.attrNames settings));
in generateConfigWtf settings
