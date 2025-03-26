{pkgs, ...}: {
  config.vim.autocmds = [
    {
      callback = with pkgs;
        lib.generators.mkLuaInline
        # lua
        ''
          function()
            local ignore_filetypes = {
              "help",
              "neo-tree",
              "notify",
            }
            if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
              vim.b.miniindentscope_disable = true
            end
          end
        '';
      desc = "Disable indentscope for certain filetypes";
      event = ["FileType"];
    }
    {
      callback = with pkgs;
        lib.generators.mkLuaInline
        # lua
        ''
          function()
            require("lint").try_lint()
          end
        '';
      desc = "Try lint on certain events";
      event = ["BufEnter" "BufWritePost" "InsertLeave"];
    }
  ];
}
