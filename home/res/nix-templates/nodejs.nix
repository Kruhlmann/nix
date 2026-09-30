{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  buildInputs = [
    pkgs.pnpm
    pkgs.nodejs
  ];
}
