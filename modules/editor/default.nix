{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
in {
  config.vim = {
    autopairs.nvim-autopairs.enable = true;
    git.gitsigns.enable = true;
    lazy.plugins = {
      "auto-save.nvim" = {
        package = pkgs.vimPlugins.auto-save-nvim;
        setupModule = "auto-save";
        setupOpts.debounce_delay = 100;
      };
      "guess-indent.nvim" = {
        package = pkgs.vimPlugins.guess-indent-nvim;
        setupModule = "guess-indent";
      };
      "smartyank.nvim" = {
        package = pkgs.vimPlugins.smartyank-nvim;
        setupModule = "smartyank";
        setupOpts.osc52.ssh_only = false;
      };
    };
    notes.todo-comments.enable = true;
    snippets.luasnip.enable = true;
    statusline.lualine = {
      enable = true;
      setupOpts.extensions = [
        {
          sections.lualine_a =
            mkLuaInline
            # lua
            ''
              {
                function()
                  return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
                end,
              }
            '';
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
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
    };
    treesitter = {
      enable = true;
      grammars = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars;
      indent.enable = true;
    };
    ui = {
      borders.enable = true;
      noice = {
        enable = true;
        setupOpts.lsp.override."cmp.entry.get_documentation" = true;
      };
    };
    utility.snacks-nvim = {
      enable = true;
      setupOpts = {
        explorer.enabled = true;
        indent = {
          enable = true;
          scope.enabled = false;
        };
        notifier.enabled = true;
        picker = {
          enabled = true;
          sources = let
            generalOpts = {
              layout.fullscreen = true;
            };
          in {
            explorer = {
              hidden = true;
              win = {
                input.keys."<Esc>" = "";
                list.keys."<Esc>" = "";
              };
            };
            files = generalOpts;
            grep = generalOpts;
          };
          ui_select = true;
        };
        words.enabled = true;
      };
    };
    visuals.rainbow-delimiters.enable = true;
  };
}
