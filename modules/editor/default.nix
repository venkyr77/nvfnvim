{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
in {
  imports = [
    ./auto-save.nix
    ./fzf-lua.nix
    ./guess-indent.nix
    ./neo-tree.nix
    ./smartyank.nix
    ./telescope.nix
    ./treesitter.nix
  ];

  config.vim = {
    autopairs.nvim-autopairs.enable = true;
    diagnostics = {
      enable = true;
      config.virtual_text.format =
        mkLuaInline
        # lua
        ''
          function(diagnostic)
            return string.format("%s (%s)", diagnostic.message, diagnostic.source)
          end
        '';
    };
    git.gitsigns.enable = true;
    snippets.luasnip.enable = true;
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
    };
  };
}
