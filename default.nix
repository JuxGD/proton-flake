{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

{
  cachyos-proton = pkgs.callPackage ./cachyos-proton.nix { };
  ge-proton = pkgs.callPackage ./ge-proton.nix { };
  dw-proton = pkgs.callPackage ./dw-proton.nix { };
}