{pkgs, ...}: {
  config.vim = {
    extraPackages = with pkgs; [
      luajitPackages.luacheck
      markdownlint-cli2
      shellcheck
      statix
    ];

    diagnostics.nvim-lint = {
      enable = true;
      linters_by_ft = {
        lua = ["luacheck"];
        markdown = ["markdownlint-cli2"];
        nix = ["statix"];
        sh = ["shellcheck"];
        zsh = ["shellcheck"];
      };
    };
  };
}
