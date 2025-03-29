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
    {
      callback =
        mkLuaInline
        # lua
        ''
          function(event)
            local bufnr = event.buf
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
            end
          end
        '';
      desc = "LSP on attach autocmd";
      event = ["LspAttach"];
    }
  ];
}
