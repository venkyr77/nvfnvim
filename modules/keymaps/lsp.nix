{
  config,
  lib,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
  inherit (import ../../helpers) mkFnBindingToBuffer;
in {
  config.vim = {
    autocmds = [
      {
        callback =
          mkLuaInline
          # lua
          ''
            function(event)
              local bufnr = event.buf

              ${mkFnBindingToBuffer "<leader>gd"
              # lua
              ''
                function() Snacks.picker.lsp_definitions() end
              ''
              "[d]efinitions"}
              ${mkFnBindingToBuffer "<leader>gD"
              # lua
              ''
                function() Snacks.picker.lsp_declarations() end
              ''
              "[d]eclarations"}
              ${mkFnBindingToBuffer "<leader>gi"
              # lua
              ''
                function() Snacks.picker.lsp_implementations() end
              ''
              "[i]mplementations"}
              ${mkFnBindingToBuffer "<leader>gr"
              # lua
              ''
                function() Snacks.picker.lsp_references() end
              ''
              "[r]eferences"}
              ${mkFnBindingToBuffer "<leader>gt"
              # lua
              ''
                function() Snacks.picker.lsp_type_definitions() end
              ''
              "[t]ype definitions"}
              ${mkFnBindingToBuffer "<leader>la" "vim.lsp.buf.code_action" "code [a]ction"}
              ${mkFnBindingToBuffer "<leader>lda"
              # lua
              ''
                function()
                  vim.b.current_min_severity = vim.diagnostic.severity.HINT
                  vim.diagnostic.config({
                    virtual_lines = vim.tbl_deep_extend(
                      "force",
                      vim.diagnostic.config()["virtual_lines"],
                      { severity = { min = vim.b.current_min_severity } }
                    ),
                  })
                end
              ''
              "[a]ll"}
              ${mkFnBindingToBuffer "<leader>lde"
              # lua
              ''
                function()
                  vim.b.current_min_severity = vim.diagnostic.severity.ERROR
                  vim.diagnostic.config({
                    virtual_lines = vim.tbl_deep_extend(
                      "force",
                      vim.diagnostic.config()["virtual_lines"],
                      { severity = { min = vim.b.current_min_severity } }
                    ),
                  })
                end
              ''
              "[e]rrors only"}
              ${mkFnBindingToBuffer "<leader>ldn"
              # lua
              ''
                function()
                  if not vim.b.current_min_severity then
                    vim.b.current_min_severity = vim.diagnostic.severity.HINT
                  end
                  vim.diagnostic.jump({
                    count = 1,
                    float = false,
                    severity = { min = vim.b.current_min_severity },
                  })
                end
              ''
              "[n]ext"}
              ${mkFnBindingToBuffer "<leader>ldp"
              # lua
              ''
                function()
                  if not vim.b.current_min_severity then
                    vim.b.current_min_severity = vim.diagnostic.severity.HINT
                  end
                  vim.diagnostic.jump({
                    count = -1,
                    float = false,
                    severity = { min = vim.b.current_min_severity },
                  })
                end
              ''
              "[p]rev"}
              ${mkFnBindingToBuffer "<leader>ldt"
              # lua
              ''
                function()
                  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
                end
              ''
              "[t]oggle"}
              ${mkFnBindingToBuffer "<leader>lh" "vim.lsp.buf.hover" "[h]over doc"}
              ${mkFnBindingToBuffer "<leader>lr" "vim.lsp.buf.rename" "[r]ename"}
            end
          '';
        desc = "LSP on attach set keymaps autocmd";
        event = ["LspAttach"];
      }
    ];
    lsp.mappings = builtins.mapAttrs (_: _: null) config.vim.lsp.mappings;
  };
}
