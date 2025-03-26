{
  config.vim.keymaps = [
    {
      action =
        #lua
        ''
          function()
            require("conform").format()
          end
        '';
      desc = "[b]uffer(or selection)";
      key = "<leader>cb";
      lua = true;
      mode = ["n" "v"];
    }
    {
      action =
        #lua
        ''
          -- https://github.com/stevearc/conform.nvim/issues/92#issuecomment-2069915330
          function()
            local hunks = require("gitsigns").get_hunks()
            local format = require("conform").format
            for i = #hunks, 1, -1 do
              local hunk = hunks[i]
              if hunk ~= nil and hunk.type ~= "delete" then
                local start = hunk.added.start
                local last = start + hunk.added.count
                -- nvim_buf_get_lines uses zero-based indexing -> subtract from last
                local last_hunk_line = vim.api.nvim_buf_get_lines(0, last - 2, last - 1, true)[1]
                local range = { start = { start, 0 }, ["end"] = { last - 1, last_hunk_line:len() } }
                format({ range = range })
              end
            end
          end
        '';
      desc = "[m]odifications";
      key = "<leader>cm";
      lua = true;
      mode = ["n"];
    }
  ];
}
