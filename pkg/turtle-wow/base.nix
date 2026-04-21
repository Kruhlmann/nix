{ pkgs, ver ? "1180" }:
pkgs.stdenv.mkDerivation rec {
  pname = "turtle-wow-base";
  version = ver;

  src = pkgs.fetchurl {
    url = "https://eudl.turtlecraft.gg/twmoa_${version}.zip";
    hash = "sha256-ghZDSjAdrWVPJk43ARzAB5NJ956FJZy1p1iJWTzWdok=";
  };

  nativeBuildInputs = [ pkgs.unzip ];
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/share/turtle-wow-base"
    cp -r ./* "$out/share/turtle-wow-base/"
    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "Turtle WoW base client files";
    homepage = "https://turtlecraft.gg";
    license = licenses.unfree;
    platforms = platforms.linux;
  };
}
