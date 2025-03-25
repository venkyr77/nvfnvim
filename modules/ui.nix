{
  config.vim = {
    mini.indentscope.enable = true;

    notes.todo-comments.enable = true;

    notify.nvim-notify.enable = true;

    statusline.lualine.enable = true;

    tabline.nvimBufferline = {
      enable = true;
      setupOpts.options = {
        offsets = [
          {
            filetype = "neo-tree";
            text = "Explorer";
            highlight = "Directory";
            text_align = "center";
            separator = true;
          }
        ];
      };
    };

    ui = {
      borders.plugins.which-key.enable = true;

      illuminate = {
        enable = true;
        setupOpts.filetypes_denylist = [
          "help"
          "neo-tree"
          "notify"
        ];
      };

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
