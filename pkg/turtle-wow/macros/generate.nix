{ pkgs, ... }:
let
  generateMacroCache = { macros, startId ? 1 }:
    let
      indexedMacros =
        builtins.map (i: (builtins.elemAt macros i // { index = i + startId; }))
        (pkgs.lib.range 0 (builtins.length macros - 1));

      formatMacro = macro: ''
        MACRO ${toString macro.index} \"${macro.name}\" \"${macro.icon}\"
        ${macro.body}
        END
      '';
    in pkgs.lib.concatStringsSep "" (map formatMacro indexedMacros);

in generateMacroCache
