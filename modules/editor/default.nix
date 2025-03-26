{
  imports = [
    ./auto-save.nix
    ./colorscheme.nix
    ./guess-indent.nix
    ./neo-tree.nix
    ./smartyank.nix
    ./telescope.nix
    ./treesitter.nix
  ];

  config.vim = {
    autopairs.nvim-autopairs.enable = true;
    git.gitsigns.enable = true;
    snippets.luasnip.enable = true;
  };
}
