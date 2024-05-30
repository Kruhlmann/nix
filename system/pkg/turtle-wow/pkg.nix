{ pkgs, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "turtle-wow";
  version = "1171";
  src = pkgs.fetchurl {
    url = "https://turtle-eu.b-cdn.net/twmoa_${version}.zip";
    sha256 = "sha256-fJNiSRln7xsyv3P4B6NTudvF7wAVFSJdu2LEpPdqu3w=";
  };
  nativeBuildInputs = [ pkgs.unzip pkgs.copyDesktopItems ];
  buildInputs = [ pkgs.wineWowPackages.full pkgs.vulkan-loader ];
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/turtle-wow $out/bin
    cp -r * $out/share/turtle-wow
    echo "#!/usr/bin/env sh" > $out/bin/turtle-wow
    echo "WINEPREFIX="~/.wine-turtle-wow" WINEARCH=win32 wine $out/share/turtle-wow/WoW.exe" >> $out/bin/turtle-wow
    chmod +x $out/bin/turtle-wow
  '';
  desktopItems = [
    (pkgs.makeDesktopItem {
      name = "turtle-wow";
      exec = "turtle-wow";
      desktopName = "Play Turtle WoW";
      categories = [ "Game" ];
    })
  ];
  meta = with pkgs.lib; {
    description = "Turtle WoW - A private server for World of Warcraft";
    homepage = "https://turtle-wow.org";
    license = licenses.unfree;
    platforms = platforms.linux;
  };
}
