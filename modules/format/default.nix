{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;
  inherit (lib.generators) mkLuaInline;
in {
  config.vim = {
    formatter.conform-nvim = {
      enable = true;
      setupOpts = {
        formatters = with pkgs; {
          stylua.command = getExe stylua;
        };
        format_on_save = mkLuaInline "nil";
        format_after_save = mkLuaInline "nil";
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
