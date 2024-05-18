{ ... }: {
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    font = {
      size = 11.0;
      normal = {
        family = "FiraCode Nerd Font Mono";
        style = "Regular";
      };
      bold = {
        family = "FiraCode Nerd Font Mono";
        style = "Bold";
      };
      italic = {
        family = "FiraCode Nerd Font Mono";
        style = "Italic";
      };
    };
  };

}
