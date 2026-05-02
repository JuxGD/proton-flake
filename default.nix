{ pkgs ? import <nixpkgs> { } }:

{
  dw-proton = pkgs.callPackage ./dw-proton.nix {};
  ge-proton = pkgs.callPackage ./ge-proton.nix {};
  cachyos-proton = pkgs.callPackage ./cachyos-proton.nix {};
}