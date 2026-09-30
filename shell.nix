{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  buildInputs = [
    pkgs.checkmake
    pkgs.gnumake
    pkgs.home-manager
    pkgs.nixfmt-tree
    pkgs.opencode
    pkgs.ormolu
    pkgs.ruby
    pkgs.shellharden
  ];
}
