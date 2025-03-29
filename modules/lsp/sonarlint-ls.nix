{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;
  inherit (lib.nvim.lua) toLuaObject;

  plugin = pkgs.vimUtils.buildVimPlugin {
    name = "sonarlint.nvim";
    src = pkgs.fetchFromGitLab {
      owner = "schrieveslaach";
      repo = "sonarlint.nvim";
      rev = "main";
      hash = "sha256-x/Z3+lF8+TaLkWOKEOdy04h9emXzP1JgX3t0EhzC4bo=";
    };
  };

  setupOpts = {
    server = {
      cmd = with pkgs; [
        "${getExe sonarlint-ls}"
        "-stdio"
        "-analyzers"
        "${sonarlint-ls}/share/plugins/sonarjava.jar"
      ];
    };
    filetypes = ["java"];
  };
in {
  config.vim.extraPlugins.sonarlint-ls = {
    # https://gitlab.com/schrieveslaach/sonarlint.nvim/-/issues/2
    after = ["lsp-setup"];
    package = plugin;
    setup =
      # lua
      ''
        require("sonarlint").setup(${toLuaObject setupOpts})
      '';
  };
}
