{
  config.vim = {
    notes.todo-comments.enable = true;
    statusline.lualine = {
      enable = true;
      setupOpts.extensions = ["neo-tree"];
    };
    tabline.nvimBufferline.enable = true;
    ui = {
      borders.enable = true;
      noice = {
        enable = true;
        setupOpts.lsp.override."cmp.entry.get_documentation" = true;
      };
    };
    visuals = {
      rainbow-delimiters.enable = true;
    };
  };
}
