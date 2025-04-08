{
  imports = [
    ./auto-save.nix
    ./guess-indent.nix
    ./neo-tree.nix
    ./smartyank.nix
    ./treesitter.nix
  ];

  config.vim = {
    autopairs.nvim-autopairs.enable = true;
    git.gitsigns.enable = true;
    snippets.luasnip.enable = true;
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
    };
    utility.snacks-nvim = {
      enable = true;
      setupOpts = {
        indent = {
          enable = true;
          scope.enabled = false;
        };
        notifier.enabled = true;
        picker = {
          enabled = true;
          layout.fullscreen = true;
          ui_select = true;
        };
        words.enabled = true;
      };
    };
  };
}
