{
  config.vim = {
    languages = {
      bash = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };

      html = {
        enable = true;
        treesitter.enable = true;
      };

      lua = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };

      markdown = {
        enable = true;
        extensions.render-markdown-nvim.enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };

      nix = {
        enable = true;
        lsp = {
          enable = true;
          server = "nixd";
        };
        treesitter.enable = true;
      };

      terraform = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };

      ts = {
        enable = true;
        extensions.ts-error-translator.enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };
    };

    lsp = {
      lspkind.enable = true;
      lspsaga = {
        enable = true;
        setupOpts.finder.methods.tyd = "textDocument/typeDefinition";
      };
      null-ls.enable = false;
    };
  };
}
