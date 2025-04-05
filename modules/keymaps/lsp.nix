{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
  inherit (import ../../helpers) mkActionBindingToBuffer mkFnBindingToBuffer;
in {
  config.vim = {
    autocmds = [
      {
        callback =
          mkLuaInline
          # lua
          ''
            function(event)
              ${mkActionBindingToBuffer "<leader>gd" ":Lspsaga goto_definition<CR>" "[d]efinition / declaration"}
              ${mkActionBindingToBuffer "<leader>gi" ":Lspsaga finder imp<CR>" "[i]mplementations"}
              ${mkActionBindingToBuffer "<leader>gr" ":Lspsaga finder ref<CR>" "[r]eferences"}
              ${mkActionBindingToBuffer "<leader>gt" ":Lspsaga finder tyd<CR>" "[t]ype definitions"}
              ${mkFnBindingToBuffer "<leader>la" "vim.lsp.buf.code_action" "code [a]ction"}
              ${mkFnBindingToBuffer "<leader>ldn"
              # lua
              ''
                function()
                  vim.diagnostic.jump({ count = 1, float = false })
                end
              ''
              "[n]ext"}
              ${mkFnBindingToBuffer "<leader>ldp"
              # lua
              ''
                function()
                  vim.diagnostic.jump({ count = -1, float = false })
                end
              ''
              "[p]rev"}
              ${mkFnBindingToBuffer "<leader>lh" "vim.lsp.buf.hover" "[h]over doc"}
              ${mkFnBindingToBuffer "<leader>lr" "vim.lsp.buf.rename" "[r]ename"}
            end
          '';
        desc = "LSP on attach set keymaps autocmd";
        event = ["LspAttach"];
      }
    ];
    lsp = {
      mappings = {
        addWorkspaceFolder = null;
        codeAction = null;
        documentHighlight = null;
        format = null;
        goToDeclaration = null;
        goToDefinition = null;
        goToType = null;
        hover = null;
        listDocumentSymbols = null;
        listImplementations = null;
        listReferences = null;
        listWorkspaceFolders = null;
        listWorkspaceSymbols = null;
        nextDiagnostic = null;
        openDiagnosticFloat = null;
        previousDiagnostic = null;
        removeWorkspaceFolder = null;
        signatureHelp = null;
        renameSymbol = null;
        toggleFormatOnSave = null;
      };
      lspsaga.setupOpts.finder.keys = {
        quit = ["q" "<Esc>"];
        toggle_or_open = ["o" "<CR>"];
      };
    };
  };
}
