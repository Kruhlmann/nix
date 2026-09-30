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
        "application/gzip" = [ "org.gnome.FileRoller.desktop" ];
        "application/json" = [ "nvim.desktop" ];
        "application/msword" = [ "writer.desktop" ];
        "application/ogg" = [ "mpv.desktop" ];
        "application/pdf" = [ "org.pwmt.zathura-ps.desktop" ];
        "application/rtf" = [ "writer.desktop" ];
        "application/vnd.ms-excel" = [ "calc.desktop" ];
        "application/vnd.ms-excel.sheet.macroenabled.12" = [ "calc.desktop" ];
        "application/vnd.ms-powerpoint" = [ "impress.desktop" ];
        "application/vnd.ms-powerpoint.presentation.macroenabled.12" =
          [ "impress.desktop" ];
        "application/vnd.ms-word.document.macroenabled.12" =
          [ "writer.desktop" ];
        "application/vnd.oasis.opendocument.presentation" =
          [ "impress.desktop" ];
        "application/vnd.oasis.opendocument.presentation-template" =
          [ "impress.desktop" ];
        "application/vnd.oasis.opendocument.spreadsheet" = [ "calc.desktop" ];
        "application/vnd.oasis.opendocument.spreadsheet-template" =
          [ "calc.desktop" ];
        "application/vnd.oasis.opendocument.text" = [ "writer.desktop" ];
        "application/vnd.oasis.opendocument.text-template" =
          [ "writer.desktop" ];
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" =
          [ "impress.desktop" ];
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" =
          [ "calc.desktop" ];
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" =
          [ "writer.desktop" ];
        "application/vnd.rar" = [ "org.gnome.FileRoller.desktop" ];
        "application/x-7z-compressed" = [ "org.gnome.FileRoller.desktop" ];
        "application/x-bzip2" = [ "org.gnome.FileRoller.desktop" ];
        "application/x-extension-htm" = [ "firefox.desktop" ];
        "application/x-extension-html" = [ "firefox.desktop" ];
        "application/x-extension-shtml" = [ "firefox.desktop" ];
        "application/x-extension-xht" = [ "firefox.desktop" ];
        "application/x-extension-xhtml" = [ "firefox.desktop" ];
        "application/x-gzip" = [ "org.gnome.FileRoller.desktop" ];
        "application/x-pdf" = [ "org.pwmt.zathura-ps.desktop" ];
        "application/x-rar" = [ "org.gnome.FileRoller.desktop" ];
        "application/x-tar" = [ "org.gnome.FileRoller.desktop" ];
        "application/x-xz" = [ "org.gnome.FileRoller.desktop" ];
        "application/x-zstd-compressed-tar" =
          [ "org.gnome.FileRoller.desktop" ];
        "application/xhtml+xml" = [ "firefox.desktop" ];
        "application/xml" = [ "nvim.desktop" ];
        "application/zip" = [ "org.gnome.FileRoller.desktop" ];
        "application/zstd" = [ "org.gnome.FileRoller.desktop" ];

        "audio/aac" = [ "mpv.desktop" ];
        "audio/flac" = [ "mpv.desktop" ];
        "audio/mp4" = [ "mpv.desktop" ];
        "audio/mpeg" = [ "mpv.desktop" ];
        "audio/ogg" = [ "mpv.desktop" ];
        "audio/x-wav" = [ "mpv.desktop" ];

        "image/avif" = [ "feh.desktop" ];
        "image/gif" = [ "feh.desktop" ];
        "image/heic" = [ "feh.desktop" ];
        "image/heif" = [ "feh.desktop" ];
        "image/jpeg" = [ "feh.desktop" ];
        "image/png" = [ "feh.desktop" ];
        "image/svg+xml" = [ "firefox.desktop" ];
        "image/tiff" = [ "feh.desktop" ];
        "image/webp" = [ "feh.desktop" ];
        "image/x-icon" = [ "feh.desktop" ];
        "image/x-ms-bmp" = [ "feh.desktop" ];
        "image/x-portable-anymap" = [ "feh.desktop" ];
        "image/x-xcf" = [ "gimp.desktop" ];
        "image/x-xpixmap" = [ "feh.desktop" ];
        "image/x-xwindowdump" = [ "feh.desktop" ];

        "inode/directory" = [ "org.gnome.Nautilus.desktop" ];

        "text/csv" = [ "nvim.desktop" ];
        "text/html" = [ "firefox.desktop" ];
        "text/markdown" = [ "nvim.desktop" ];
        "text/plain" = [ "nvim.desktop" ];
        "text/x-python" = [ "nvim.desktop" ];
        "text/x-rust" = [ "nvim.desktop" ];
        "text/x-shellscript" = [ "nvim.desktop" ];
        "text/xml" = [ "nvim.desktop" ];

        "video/mp4" = [ "mpv.desktop" ];
        "video/mpeg" = [ "mpv.desktop" ];
        "video/ogg" = [ "mpv.desktop" ];
        "video/quicktime" = [ "mpv.desktop" ];
        "video/webm" = [ "mpv.desktop" ];
        "video/x-flv" = [ "mpv.desktop" ];
        "video/x-matroska" = [ "mpv.desktop" ];
        "video/x-ms-asf" = [ "mpv.desktop" ];
        "video/x-ms-wmv" = [ "mpv.desktop" ];
        "video/x-msvideo" = [ "mpv.desktop" ];

        "x-scheme-handler/chrome" = [ "firefox.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
      };
    };
  };
}
