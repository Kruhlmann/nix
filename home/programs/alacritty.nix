{ config, pkgs, ... }:
let
  alacrittyThemes = pkgs.alacritty-theme;
in
{
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    general.import = [ "${config.home.homeDirectory}/.config/alacritty/theme.toml" ];
    font = {
      size = 11.0;
      normal = {
        family = "JetBrainsMono";
        style = "Regular";
      };
      bold = {
        family = "JetBrainsMono";
        style = "Bold";
      };
    };
  };

  home.file.".config/alacritty/themes/light.toml".text = ''
    [general]
    import = [ "${alacrittyThemes}/share/alacritty-theme/gruvbox_light.toml" ]
  '';

  home.file.".config/alacritty/themes/dark.toml".text = ''
    [general]
    import = [ "${alacrittyThemes}/share/alacritty-theme/gruvbox_dark.toml" ]
  '';
}
