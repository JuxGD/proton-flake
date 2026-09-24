# JuxGD's Proton Package for Nix

Based on imaviso's [dwproton-flake](https://github.com/imaviso/dwproton-flake), this is a bit of an expansion including other useful Proton packages, including `dw-proton`, as well as support for non-flake based config. Use these packages in `programs.steam.extraCompatPackages`.

Also shoutout [loplxl/GD-Low-Linux-Latency](https://github.com/loplxl/GD-Low-Linux-Latency), that's basically the reason this repo exists.

## Features

- Automatically tracks the latest releases of different Proton versions:

  - [CachyOS Proton](https://github.com/CachyOS/proton-cachyos)
  - [DW-Proton](https://dawn.wine/dawn-winery/dwproton)
  - [GE Proton](https://github.com/GloriousEggroll/proton-ge-custom)

- Daily GitHub Actions workflow to check for updates
- Simple flake-based installation

## Usage

### NixOS

### Flake-based config

Add the flake to your inputs and add the package to `programs.steam.extraCompatPackages`:

```nix
# only flake.nix example

{
  # ...
  
  inputs = {

    # ...

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    proton.url = "github:JuxGD/proton-flake"

    # ...
  };

  outputs = { self, nixpkgs, proton, ... }:
  
  # ...
  
  {
    nixosConfigurations.yourhostname = nixpkgs.lib.nixosSystem { # replace `yourhostname` with your hostname ofc
      # ...

      system = "x86_64-linux";
      modules = [

        # ...

        ({ config, lib, pkgs, ... }: {
          programs.steam = {
            enable = true;
            extraCompatPackages = [
              proton.packages.${pkgs.stdenv.hostPlatform.system}.cachyos-proton # for cachyos proton
              proton.packages.${pkgs.stdenv.hostPlatform.system}.dw-proton # for dawnwine proton
              proton.packages.${pkgs.stdenv.hostPlatform.system}.ge-proton # for glorious eggroll proton
            ];
          };
        })
      ];
    };
  };
}
```

### Without flakes

Haven't tried this pls tell me if it works lol

```nix
# configuration.nix

{ config, lib, pkgs, ... }: let

# ...

  proton = import (builtins.fetchGit {
    url = "https://github.com/JuxGD/proton-nix";
  })

# ...

in

{
  # ...

  programs.steam.extraCompatPackages = [
    proton.cachyos-proton
    proton.ge-proton
    proton.dw-proton

    # ...
  
  ];

  # ...

}
```

## Development

```bash
# Enter development shell
nix develop

# Build the package
nix build
```

## Updates

This flake automatically checks for new releases daily and creates pull requests when updates are available.

## License

This packaging is provided under the MIT license. The included Proton packages may contain proprietary components.
