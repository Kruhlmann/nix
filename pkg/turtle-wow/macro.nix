{ pkgs, macros, ... }:
let
  generateMacros = macros:
    pkgs.lib.concatStringsSep "\n"
    (map (m: "MACRO ${m.name} ${m.icon} ${m.body}") macros.ges);
in generateMacros macros
