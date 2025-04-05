{
  imports = [
    ./jdtls.nix
    ./sonarlint-ls.nix
  ];

  config.vim = {
    languages = {
      bash = {
        enable = true;
        lsp.enable = true;
      };

      html.enable = true;

      lua = {
        enable = true;
        lsp.enable = true;
      };

      markdown = {
        enable = true;
        extensions.render-markdown-nvim.enable = true;
        lsp.enable = true;
      };

      nix = {
        enable = true;
        lsp = {
          enable = true;
          server = "nixd";
        };
      };

      terraform = {
        enable = true;
        lsp.enable = true;
      };

      ts = {
        enable = true;
        extensions.ts-error-translator.enable = true;
        lsp.enable = true;
      };
    };

    lsp = {
      formatOnSave = false;
      inlayHints.enable = true;
      lspkind.enable = true;
      lspsaga = {
        enable = true;
        setupOpts.finder.methods.tyd = "textDocument/typeDefinition";
      };
    };
  };
}
