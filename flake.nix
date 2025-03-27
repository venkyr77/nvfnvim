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
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        flake-utils.follows = "flake-utils";
        systems.follows = "systems";
      };
    };
    systems.url = "github:nix-systems/default";
  };
  outputs = {
    flake-parts,
    nixpkgs,
    nvf,
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
            modules = [./modules];
          })
          .neovim;
      };
    };
}
