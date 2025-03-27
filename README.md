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

## Run as a standalone flake with custom modules

You can also just import the
[modules](https://github.com/venkyr77/nvfnvim/tree/main/modules) and add your
own modules

A standlone flake that uses modules from
[nvfnvim/modules](https://github.com/venkyr77/nvfnvim/tree/main/modules) and
allows for addition of more modules

```nix
{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nvf = {
      url = "github:notashelf/nvf";
      inputs = {
        flake-parts.follows = "flake-parts";
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
    nvfnvim = {
      flake = false;
      url = "github:venkyr77/nvfnvim";
    };
    systems.url = "github:nix-systems/default";
  };

  outputs = {
    flake-parts,
    nixpkgs,
    nvf,
    nvfnvim,
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
        packages.default =
          (nvf.lib.neovimConfiguration {
            pkgs = nixpkgs.legacyPackages.${system};
            modules = [
              "${nvfnvim}/modules" # modules from https://github.com/venkyr77/nvfnvim/tree/main/modules

              # include your modules
              # ./mymodule

              # or just
              {
                config.vim = {
                  # any option from https://notashelf.github.io/nvf/options.html
                  # for ex
                  dashboard.alpha.enable = true;
                };
              }
            ];
          })
          .neovim;
      };
    };
}
```

and then run using `nix run` by,

```sh
nix run --extra-experimental-features nix-command --extra-experimental-features flakes .
```
