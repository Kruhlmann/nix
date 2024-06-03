{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  pname = "turtle-wow-pfui";
  version = "a45c9f3dbe63a74bba9df698a25329b2d9f50c19";
  src = pkgs.fetchFromGitHub {
    owner = "shagu";
    repo = "pfUI";
    rev = "a45c9f3dbe63a74bba9df698a25329b2d9f50c19";
    sha256 = "sha256-z73sqT6B8Ixhgx9Dc+VOtNpCLChZ+A2t00j0PiUnFi8=";
  };
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/turtle-wow/Interface/Addons/pfUI
    cp -r * $out/share/turtle-wow/Interface/Addons/pfUI 
    ln -s $out/share/turtle-wow/Interface/Addons/pfUI /etc/turtle-wow/Interface/Addons/pfUI || true
  '';
  meta = with pkgs.lib; {
    description = "pfUI for turtle wow";
    homepage = "https://github.com/shagu/pfUI/";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
