{ pkgs, settings, useDoubleQuotes, ... }:
let
  generateConfigWtf = settings:
    let quote = if useDoubleQuotes then ''\"'' else ''"'';
    in pkgs.lib.concatStringsSep "\n"
    (map (key: "SET ${key} ${quote}${settings.${key}}${quote}")
      (builtins.attrNames settings));
in generateConfigWtf settings
