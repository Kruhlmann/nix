{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell { buildInputs = [ pkgs.nixfmt-classic pkgs.gnumake ]; }
