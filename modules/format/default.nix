{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;
in {
  config.vim = {
    formatter.conform-nvim = {
      enable = true;
      setupOpts = {
        formatters = with pkgs; {
          stylua.command = getExe stylua;
        };
        format_on_save = null;
        format_after_save = null;
        formatters_by_ft = {
          lua = ["stylua"];
          zsh = ["shfmt"];
        };
      };
    };
    languages = {
      bash.format.enable = true;
      markdown.format.enable = true;
      nix.format.enable = true;
      ts.format.enable = true;
    };
  };
}
