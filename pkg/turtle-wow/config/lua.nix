{ pkgs, settings, ... }:
let
  generateConfigLua = settings:
    pkgs.lib.concatStringsSep "\n"
    (map (key: "${key} = ${settings.${key}}") (builtins.attrNames settings));
in generateConfigLua settings
