{ pkgs, ... }:
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
        format.enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };

      nix = {
        enable = true;
        extraDiagnostics.enable = false;
        format = {
          enable = true;
          package = pkgs.nixfmt-rfc-style;
          type = "nixfmt";
        };
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
        goToDeclaration = "<leader>gD";
        goToDefinition = "<leader>gd";
        goToType = "<leader>gt";
        listImplementations = "<leader>gi";
        listReferences = "<leader>gr";
        nextDiagnostic = "<leader>dn";
        previousDiagnostic = "<leader>dp";
      };
      trouble.enable = true;
    };
  };
}
