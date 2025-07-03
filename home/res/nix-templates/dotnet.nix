{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  packages = [ pkgs.dotnet-sdk pkgs.omnisharp-roslyn ];

  shellHook = ''
    echo ".NET SDK Version: $(dotnet --version)"
  '';
}
