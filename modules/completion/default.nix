{lib, ...}: {
  config.vim.autocomplete.nvim-cmp = {
    enable = true;
    setupOpts.completion.completeopt = "menu,menuone,noselect";
    sources = lib.mkForce {
      buffer = "[Buffer]";
      luasnip = "[LuaSnip]";
      nvim_lsp = "[LSP]";
      path = "[Path]";
    };
  };
}
