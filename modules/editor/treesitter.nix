{pkgs, ...}: {
  config.vim.treesitter = {
    enable = true;
    grammars = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars;
    indent.enable = true;
  };
}
