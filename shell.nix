{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = [ pkgs.nixfmt-classic pkgs.home-manager pkgs.gnumake ];
}
