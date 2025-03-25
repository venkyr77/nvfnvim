{
  imports = [
    ./auto-save.nix
    ./colorscheme.nix
    ./guess-indent.nix
    ./neo-tree.nix
    ./smartyank.nix
  ];

  config.vim = {
    autopairs.nvim-autopairs.enable = true;
    git.gitsigns.enable = true;
    snippets.luasnip.enable = true;
    telescope.enable = true;
    treesitter.indent.enable = true;
  };
}
