{
  config.vim = {
    diagnostics.nvim-lint = {
      enable = true;
      linters_by_ft = {
        zsh = ["shellcheck"];
      };
    };

    languages = {
      bash.extraDiagnostics.enable = true;
      lua.extraDiagnostics.enable = true;
      nix.extraDiagnostics.enable = true;
    };
  };
}
