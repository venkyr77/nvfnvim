{
  config.vim = {
    languages = {
      bash = {
        enable = true;
        extraDiagnostics.enable = true;
        format.enable = true;
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
        format.enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };

      nix = {
        enable = true;
        extraDiagnostics.enable = true;
        format.enable = true;
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
        extraDiagnostics.enable = true;
        format.enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };
    };

    lsp = {
      lspsaga.enable = true;
    };
  };
}
