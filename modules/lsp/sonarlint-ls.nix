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
      hash = "sha256-EOAdSvugcDEDuBuFv/HL35HXWvB/V97UtOJqdRuU7ak=";
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
