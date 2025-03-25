{pkgs, ...}: {
  config.vim = {
    autopairs.nvim-autopairs.enable = true;

    extraPlugins."autosave-nvim" = {
      package = pkgs.vimPlugins.auto-save-nvim;
      setup =
        # lua
        ''
          require('auto-save').setup({debounce_delay = 100})
        '';
    };

    filetree.neo-tree = {
      enable = true;
      setupOpts = {
        default_component_configs.indent.with_expanders = true;
        enable_cursor_hijack = true;
        filesystem = {
          filtered_items = {
            hide_dotfiles = false;
            never_show = [
              ".git"
            ];
          };
          follow_current_file = {
            enabled = true;
            leave_dirs_open = true;
          };
          group_empty_dirs = true;
          scan_mode = "deep";
        };
      };
    };

    git.gitsigns.enable = true;

    extraPlugins."guess-indent.nvim" = {
      package = pkgs.vimPlugins.guess-indent-nvim;
      setup =
        # lua
        ''
          require('guess-indent').setup()
        '';
    };

    extraPlugins."smartyank-nvim" = {
      package = pkgs.vimPlugins.smartyank-nvim;
      setup =
        # lua
        ''
          require('smartyank').setup({osc52 = {ssh_only = false}})
        '';
    };

    snippets.luasnip.enable = true;

    telescope.enable = true;

    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
    };

    treesitter.indent.enable = true;
  };
}
