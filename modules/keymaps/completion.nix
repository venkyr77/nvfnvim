{lib, ...}: {
  config.vim.autocomplete.nvim-cmp.setupOpts.mapping =
    lib.generators.mkLuaInline
    # lua
    ''
      {
        ["<Down>"] = require("cmp").mapping.select_next_item({ behavior = "select" }),
        ["<Up>"] = require("cmp").mapping.select_prev_item({ behavior = "select" }),
        ["<Tab>"] = require("cmp").mapping.confirm({ select = true }),
        ["<CR>"] = require("cmp").mapping.confirm({ select = false }),
        ["<C-Space>"] = require("cmp").mapping.complete({}),
        ["<C-b>"] = require("cmp").mapping.scroll_docs(-4),
        ["<C-f>"] = require("cmp").mapping.scroll_docs(4),
      }
    '';
}
