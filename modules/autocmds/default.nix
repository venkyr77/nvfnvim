{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
in {
  config.vim = {
    extraLuaFiles = [
      (builtins.path {path = ./config.lua;})
    ];

    autocmds = [
      {
        callback = mkLuaInline "require('modules.autocmds.config').indentscope_disable_callback";
        desc = "Disable indentscope for certain filetypes";
        event = ["FileType"];
      }
      {
        callback = mkLuaInline "require('modules.autocmds.config').try_lint_callback";
        desc = "Try lint on certain events";
        event = ["BufEnter" "BufWritePost" "InsertLeave"];
      }
      {
        callback = mkLuaInline "require('modules.autocmds.config').lsp_on_attach_callback";
        desc = "LSP on attach autocmd";
        event = ["LspAttach"];
      }
    ];
  };
}
