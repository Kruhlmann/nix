{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell { buildInputs = [ pkgs.nodePackages.pnpm pkgs.nodejs ]; }
