# nvfnvim

Modular, configurable, reproducible and easy to use personal Neovim
configuration in Nix using [nvf](https://github.com/NotAShelf/nvf)

## Run using `nix run`

```sh
nix run --extra-experimental-features nix-command --extra-experimental-features flakes github:venkyr77/nvfnvim
```

## Run as a standalone flake

A simple standalone flake that makes this package as default

```nix
{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nvfnvim = {
      url = "github:venkyr77/nvfnvim";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = {
    nvfnvim,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = {system, ...}: {
        packages = {inherit (nvfnvim.packages.${system}) default;};
      };
    };
}
```

and then run using `nix run` by,

```sh
nix run --extra-experimental-features nix-command --extra-experimental-features flakes .
```
