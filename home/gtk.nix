{ pkgs, ... }: {
  gtk = {
    enable = true;
    cursorTheme = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 12;
    };
    font = {
      name = "FiraCode Nerd Font Mono";
      package = pkgs.nerd-fonts.fira-code;
      size = 12;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };
  };
}
