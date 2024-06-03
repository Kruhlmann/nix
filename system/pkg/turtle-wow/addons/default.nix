{ pkgs }:
{ owner, repo, rev, sha256, name }:
  pkgs.stdenv.mkDerivation {
    pname = "${name}";
    version = rev;
    src = pkgs.fetchFromGitHub { inherit owner repo rev sha256; };
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/${name}
      cp -r $src/* $out/share/${name}
    '';
    meta = with pkgs.lib; {
      description = "${repo} addon for Turtle WoW";
      homepage = "https://github.com/${owner}/${repo}";
      license = licenses.mit;
      platforms = platforms.linux;
    };
  }
