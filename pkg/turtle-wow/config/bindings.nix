{ pkgs, bindings, ... }:
let
  generateBindingsConfig = bindings:
    pkgs.lib.concatStringsSep "\n"
    (map (key: "bind ${key} ${bindings.${key}}") (builtins.attrNames bindings));
in generateBindingsConfig bindings
