{ ... }: {
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    font = {
      size = 10.0;
      normal = {
        family = "FiraCode Nerd Font Mono";
        style = "Regular";
      };
      bold = {
        family = "FiraCode Nerd Font Mono";
        style = "Bold";
      };
    };
  };

}
