{ config, ... }: {
  xdg = {
    enable = true;
    dataHome = "${config.home.homeDirectory}/.local/share";
    configHome = "${config.home.homeDirectory}/.config";
    cacheHome = "${config.home.homeDirectory}/.cache";
    stateHome = "${config.home.homeDirectory}/.local/state";
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.pwmt.zathura-ps.desktop";
        "application/x-pdf" = "org.pwmt.zathura-ps.desktop";
        "image/jpeg" = "feh.desktop";
        "image/png" = "feh.desktop";
        "image/svg+xml" = "firefox.desktop";
        "image/webp" = "feh.desktop";
        "image/x-icon" = "feh.desktop";
        "image/x-xcf" = "gimp.desktop";
        "image/x-xpixmap" = "feh.desktop";
        "image/x-xwindowdump" = "feh.desktop";
        "image/x-ms-bmp" = "feh.desktop";
        "image/x-portable-anymap" = "feh.desktop";
        "video/mp4" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop";
        "video/x-msvideo" = "mpv.desktop";
        "video/x-flv" = "mpv.desktop";
        "video/webm" = "mpv.desktop";
        "video/quicktime" = "mpv.desktop";
        "video/x-ms-wmv" = "mpv.desktop";
        "video/x-ms-asf" = "mpv.desktop";
        "inode/directory" = "org.gnome.Nautilus.desktop";
        "text/html" = "firefox.desktop";
        "text/markdown" = "nvim.desktop";
        "text/plain" = "nvim.desktop";
      };
    };
  };
}
