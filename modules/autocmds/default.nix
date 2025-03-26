{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
in {
  config.vim.autocmds = [
    {
      callback =
        mkLuaInline
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
      callback =
        mkLuaInline
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
