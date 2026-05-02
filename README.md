# JuxGD's Proton Flake

Based on imaviso's [dwproton-flake](https://github.com/imaviso/dwproton-flake), this is a bit of an expansion including as many Proton packages as I can think of. Use these packages in `programs.steam.extraCompatPackages`.

Also shoutout [loplxl/GD-Low-Linux-Latency](https://github.com/loplxl/GD-Low-Linux-Latency)

## Features

- Automatically tracks the latest releases of different Proton versions:
  - [CachyOS Proton](https://github.com/CachyOS/proton-cachyos)
  - [DW-Proton](https://dawn.wine/dawn-winery/dwproton)
  - [GE Proton](https://github.com/GloriousEggroll/proton-ge-custom)
- Daily GitHub Actions workflow to check for updates
- Simple flake-based installation

## Usage

### NixOS

Add the flake to your inputs and add the package to `programs.steam.extraCompatPackages`:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    proton.url = "github:CachyOS/proton-flake"
  };

  outputs = { self, nixpkgs, dw-proton, cachyos-proton, ... }: {
    nixosConfigurations.yourhostname = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({ pkgs, ... }: {
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
