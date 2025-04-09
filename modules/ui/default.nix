{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
in {
  config.vim = {
    notes.todo-comments.enable = true;
    statusline.lualine = {
      enable = true;
      setupOpts.extensions = [
        {
          sections = {
            lualine_a = mkLuaInline ''
              {
                function()
                  return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
                end,
              }
            '';
          };
          filetypes = ["snacks_picker_list" "snacks_picker_input"];
        }
      ];
    };
    tabline.nvimBufferline = {
      enable = true;
      setupOpts.options.offsets = [
        {
          filetype = "snacks_layout_box";
          text = "File Explorer";
          highlight = "Directory";
          separator = true;
        }
      ];
    };
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
