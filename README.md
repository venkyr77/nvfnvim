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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvfnvim = {
      url = "github:venkyr77/nvfnvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { nvfnvim, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      packages = builtins.listToAttrs (
        map (system: {
          name = system;
          value = {
            inherit (nvfnvim.packages.${system}) default;
          };
        }) systems
      );
    in
    {
      inherit packages;
    };
}
```

and then run using `nix run` by,

```sh
nix run --extra-experimental-features nix-command --extra-experimental-features flakes .
```
