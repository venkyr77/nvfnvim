local M = {}

M.indentscope_disable_callback = function()
  local ignore_filetypes = {
    "help",
    'neo-tree',
    'notify',
  }
  if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
    vim.b.miniindentscope_disable = true
  end
end

M.try_lint_callback = function()
  require('lint').try_lint()
end

M.lsp_on_attach_callback = function(event)
  local buffer = event.buf
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buffer }), { bufnr = buffer })
  end
end

return M
