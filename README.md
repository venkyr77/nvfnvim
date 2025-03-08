# nvfnvim
Modular, configurable, reproducible and easy to use personal Neovim configuration in Nix using [nvf](https://github.com/NotAShelf/nvf)

## Run using `nix run`

```sh
nix run --extra-experimental-features nix-command --extra-experimental-features flakes --extra-experimental-features pipe-operators github:venkyr77/nvfnvim
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

      packages =
        systems
        |> map (system: {
          name = system;
          value = {
            default = nvfnvim.packages.${system}.default;
          };
        })
        |> builtins.listToAttrs;
    in
    {
      inherit packages;
    };
}
```

and then run using `nix run` by,

```sh
nix run --extra-experimental-features nix-command --extra-experimental-features flakes --extra-experimental-features pipe-operators .
```
