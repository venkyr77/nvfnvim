{pkgs, ...}: {
  config.vim = {
    extraPackages = with pkgs; [
      luajitPackages.luacheck
    ];

    diagnostics.nvim-lint = {
      enable = true;
      linters_by_ft = {
        lua = ["luacheck"];
        zsh = ["shellcheck"];
      };
    };

    languages = {
      bash.extraDiagnostics.enable = true;
      nix.extraDiagnostics.enable = true;
    };
  };
}
