{pkgs, ...}: {
  config.vim = {
    extraPackages = [pkgs.ripgrep];
    keymaps = [
      # Explorer
      {
        action =
          #lua
          ''
            function() Snacks.explorer() end
          '';
        desc = "[t]oggle [e]xplorer";
        key = "\\";
        lua = true;
        mode = "n";
        silent = true;
      }

      # Find
      {
        action =
          #lua
          ''
            function() Snacks.picker.files() end
          '';
        desc = "[f]iles";
        key = "<leader>ff";
        lua = true;
        mode = ["n"];
      }
      {
        action =
          #lua
          ''
            function() Snacks.picker.grep() end
          '';
        desc = "[g]rep files";
        key = "<leader>fg";
        lua = true;
        mode = ["n"];
      }
      {
        action =
          #lua
          ''
            function() Snacks.picker.grep({ hidden = true, ignored = true }) end
          '';
        desc = "[G]rep all(hidden and ignored) files";
        key = "<leader>fG";
        lua = true;
        mode = ["n"];
      }
    ];
  };
}
