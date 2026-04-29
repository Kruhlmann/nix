{ pkgs, config, ... }: {
  home.file."${config.xdg.configHome}/nvim" = {
    source = res/nvim;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/git" = {
    source = res/git;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/rofi" = {
    source = res/rofi;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/stickers" = {
    source = res/stickers;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/stack" = {
    source = res/stack;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/conky" = {
    source = res/conky;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/dunst" = {
    source = res/dunst;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/zsh" = {
    source = res/zsh;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/libvirt" = {
    source = res/libvirt;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/nix-templates" = {
    source = res/nix-templates;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/etc" = {
    source = res/etc;
    recursive = true;
  };
  home.file."${config.xdg.dataHome}/dark-mode.d/alacritty".source =
    pkgs.writeShellScript "" ''
      ${pkgs.coreutils}/bin/ln -sfn "${config.home.homeDirectory}/.config/alacritty/themes/dark.toml" "${config.home.homeDirectory}/.config/alacritty/theme.toml"
    '';
  home.file."${config.xdg.dataHome}/light-mode.d/alacritty".source =
    pkgs.writeShellScript "" ''
      ${pkgs.coreutils}/bin/ln -sfn "${config.home.homeDirectory}/.config/alacritty/themes/light.toml" "${config.home.homeDirectory}/.config/alacritty/theme.toml"
    '';
  home.file."${config.xdg.dataHome}/dark-mode.d/nvim".source =
    pkgs.writeShellScript "" ''
      ${pkgs.coreutils}/bin/printf 'vim.o.background = "dark"\n' >"${config.home.homeDirectory}/.config/nvim/lua/theme.lua"
    '';
  home.file."${config.xdg.dataHome}/light-mode.d/nvim".source =
    pkgs.writeShellScript "" ''
      ${pkgs.coreutils}/bin/printf 'vim.o.background = "light"\n' >"${config.home.homeDirectory}/.config/nvim/lua/theme.lua"
    '';
  home.file."${config.xdg.dataHome}/dark-mode.d/wallpaper".source =
    pkgs.writeShellScript "" ''
      ${pkgs.feh}/bin/feh --bg-scale "${config.home.homeDirectory}/img/lib/wallpaper/bg_dark.png"
    '';
  home.file."${config.xdg.dataHome}/light-mode.d/wallpaper".source =
    pkgs.writeShellScript "" ''
      ${pkgs.feh}/bin/feh --bg-scale "${config.home.homeDirectory}/img/lib/wallpaper/bg_light.png"
    '';
  home.file."${config.xdg.dataHome}/dark-mode.d/gtk".source =
    pkgs.writeShellScript "" ''
      ${pkgs.xfce.xfconf}/bin/xfconf-query -c xsettings -p /Net/ThemeName -s "Gruvbox-Dark"
      ${pkgs.xfce.xfconf}/bin/xfconf-query -c xsettings -p /Net/IconThemeName -s "Papirus-Dark"
      GSETTINGS_SCHEMA_DIR=${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas \
        ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme "Gruvbox-Dark"
      GSETTINGS_SCHEMA_DIR=${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas \
        ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
      GSETTINGS_SCHEMA_DIR=${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas \
        ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
    '';
  home.file."${config.xdg.dataHome}/light-mode.d/gtk".source =
    pkgs.writeShellScript "" ''
      ${pkgs.xfce.xfconf}/bin/xfconf-query -c xsettings -p /Net/ThemeName -s "Gruvbox-Light"
      ${pkgs.xfce.xfconf}/bin/xfconf-query -c xsettings -p /Net/IconThemeName -s "Papirus-Light"
      GSETTINGS_SCHEMA_DIR=${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas \
        ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme "Gruvbox-Light"
      GSETTINGS_SCHEMA_DIR=${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas \
        ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface icon-theme "Papirus-Light"
      GSETTINGS_SCHEMA_DIR=${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas \
        ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
    '';
  home.file.".local/bin" = {
    source = res/bin;
    recursive = true;
  };
  home.file.".ssh" = {
    source = res/ssh;
    recursive = true;
  };
  home.file."img/lib" = {
    source = res/img;
    recursive = true;
  };
}
