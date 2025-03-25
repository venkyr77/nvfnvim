{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    nixpkgs,
    nvf,
    ...
  }: let
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    makeNeovim = {system}:
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./modules/options.nix
          ./modules/keymaps.nix
          ./modules/editor.nix
          ./modules/ui.nix
          ./modules/lsp.nix
          ./modules/completion.nix
        ];
      })
      .neovim;

    packages = builtins.listToAttrs (
      map (system: {
        name = system;
        value = {
          default = makeNeovim {inherit system;};
        };
      })
      systems
    );
  in {
    inherit packages;
  };
}
