{ pkgs ? import <nixpkgs> { }, }:

pkgs.mkShell {
  buildInputs = [
    pkgs.checkmake
    pkgs.gnumake
    pkgs.home-manager
    pkgs.nixfmt-classic
    pkgs.opencode
    pkgs.ormolu
    pkgs.ruby
    pkgs.shellharden
  ];
}
