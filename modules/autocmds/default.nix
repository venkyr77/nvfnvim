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
            require("lint").try_lint()
          end
        '';
      desc = "Try lint on certain events";
      event = ["BufEnter" "BufWritePost" "InsertLeave"];
    }
  ];
}
