{ config, ... }: {
  home.file = {
    "${config.xdg.configHome}/nvim" = {
      source = res/nvim;
      recursive = true;
    };
    "${config.xdg.configHome}/git" = {
      source = res/git;
      recursive = true;
    };
    "${config.xdg.configHome}/rofi" = {
      source = res/rofi;
      recursive = true;
    };
    "${config.xdg.configHome}/stickers" = {
      source = res/stickers;
      recursive = true;
    };
    "${config.xdg.configHome}/stack" = {
      source = res/stack;
      recursive = true;
    };
    "${config.xdg.configHome}/conky" = {
      source = res/conky;
      recursive = true;
    };
    "${config.xdg.configHome}/dunst" = {
      source = res/dunst;
      recursive = true;
    };
    "${config.xdg.configHome}/zsh" = {
      source = res/zsh;
      recursive = true;
    };
    "${config.xdg.configHome}/libvirt" = {
      source = res/libvirt;
      recursive = true;
    };
    "${config.xdg.configHome}/etc" = {
      source = res/etc;
      recursive = true;
    };
    "${config.xdg.dataHome}/.local/bin" = {
      source = res/bin;
      recursive = true;
    };
    "${config.xdg.dataHome}/.ssh" = {
      source = res/ssh;
      recursive = true;
    };
    "${config.xdg.dataHome}/img/lib" = {
      source = res/img;
      recursive = true;
    };
  };
}
