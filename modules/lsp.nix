{pkgs, ...}: {
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
      mappings = {
        goToDeclaration = null;
        goToDefinition = null;
        goToType = null;
        listImplementations = null;
        listReferences = null;
        nextDiagnostic = "<leader>dn";
        previousDiagnostic = "<leader>dp";
      };
      lspsaga = {
        enable = true;
        setupOpts.finder.keys = {
          quit = ["q" "<Esc>"];
          toggle_or_open = ["o" "<CR>"];
        };
      };
    };
  };
}
