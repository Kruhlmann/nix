{ pkgs, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "turtle-wow";
  version = "1171";
  src = pkgs.fetchurl {
    url = "https://turtle-eu.b-cdn.net/twmoa_${version}.zip";
    sha256 = "sha256-fJNiSRln7xsyv3P4B6NTudvF7wAVFSJdu2LEpPdqu3w=";
  };
  icon = pkgs.fetchurl {
    url =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5kziZqFv4kii1P8K8MYnl3XkME-ZF2TWSf6T2uPWArDYLYDEn";
    sha256 = "sha256-0XdP81dd9InEAhdFkR5QfUIbcwn3zSKQJeCPURJUZh0=";
  };
  nativeBuildInputs = [ pkgs.unzip pkgs.copyDesktopItems pkgs.gtk3 ];
  buildInputs = [ pkgs.wineWowPackages.full pkgs.vulkan-loader ];
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/turtle-wow $out/bin $out/share/icons/hicolor/256x256/apps/ $out/share/applications
    cp -r * $out/share/turtle-wow
    cp ${icon} $out/share/icons/hicolor/256x256/apps/turtle-wow.png
    cp -r ${desktop}/share/applications/* $out/share/applications
    echo "#!/usr/bin/env sh" > $out/bin/turtle-wow
    echo "WINEPREFIX="~/.wine-turtle-wow" WINEARCH=win32 wine $out/share/turtle-wow/WoW.exe" >> $out/bin/turtle-wow
    chmod +x $out/bin/turtle-wow
  '';
  desktop = pkgs.makeDesktopItem {
    type = "Application";
    name = "turtle-wow";
    exec = "turtle-wow";
    icon = "turtle-wow";
    desktopName = "Play Turtle WoW";
    categories = [ "Game" ];
  };
  meta = with pkgs.lib; {
    description = "Turtle WoW - A private server for World of Warcraft";
    homepage = "https://turtle-wow.org";
    license = licenses.unfree;
    platforms = platforms.linux;
  };
}
