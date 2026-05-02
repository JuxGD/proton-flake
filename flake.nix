{
  description = "Flake containing several Proton versions";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:

  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in
  {
    packages.${system} = {
      cachyos-proton = pkgs.callPackage ./cachyos-proton.nix {};
      ge-proton = pkgs.callPackage ./ge-proton.nix {};
      dw-proton = pkgs.callPackage ./dw-proton.nix {};
      default = self.packages.${system}.cachyos-proton;
    };
  };
}
