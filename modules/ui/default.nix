{
  config.vim = {
    notes.todo-comments.enable = true;
    notify.nvim-notify.enable = true;
    statusline.lualine = {
      enable = true;
      setupOpts.extensions = ["neo-tree"];
    };
    tabline.nvimBufferline.enable = true;
    ui = {
      borders.enable = true;
      illuminate.enable = true;
      noice = {
        enable = true;
        setupOpts.lsp.override."cmp.entry.get_documentation" = true;
      };
    };
    visuals = {
      indent-blankline.enable = true;
      rainbow-delimiters.enable = true;
    };
  };
}
