{
  config.vim = {
    binds.whichKey = {
      enable = true;
      register = {
        "<leader>d" = "+[D]iagnostics";
        "<leader>g" = "+[G]o to(LSP)";
        "<leader>h" = "[H]unk(Gitsigns)";
      };
    };

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
