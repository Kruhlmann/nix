{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell { buildInputs = [ pkgs.hello pkgs.nixfmt pkgs.bashInteractive ]; }
