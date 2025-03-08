{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
  };
  outputs =
    {
      nixpkgs,
      nvf,
      ...
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      makeNeovim =
        { system }:
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
        }).neovim;

      packages =
        systems
        |> map (system: {
          name = system;
          value = {
            default = makeNeovim { inherit system; };
          };
        })
        |> builtins.listToAttrs;
    in
    {
      inherit packages;
    };
}
