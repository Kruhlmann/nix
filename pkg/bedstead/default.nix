{ pkgs, ... }:

pkgs.stdenvNoCC.mkDerivation rec {
  pname = "bedstead";
  version = "3.261";

  src = pkgs.fetchzip {
    url = "https://bjh21.me.uk/bedstead/bedstead-${version}.zip";
    hash = "sha256-1HGWdTMtlLQIGH8tSjpuPQVM+z2S09PXFkL65H3cG1g=";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/opentype
    cp bedstead-${version}/*.otf $out/share/fonts/opentype/

    runHook postInstall
  '';
}
