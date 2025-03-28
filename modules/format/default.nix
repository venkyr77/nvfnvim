{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;
  inherit (lib.generators) mkLuaInline;
in {
  config.vim.formatter.conform-nvim = {
    enable = true;
    setupOpts = {
      formatters = with pkgs; let
        getDenoFormatterForExt = ext: {
          command = getExe deno;
          args = [
            "fmt"
            "-"
            "--ext"
            ext
          ];
        };
      in {
        alejandra.command = getExe alejandra;
        denofmt_md = getDenoFormatterForExt "md";
        nixfmt-rfc-style.command = getExe nixfmt-rfc-style;
        prettierd.command = getExe prettierd;
        shfmt.command = getExe shfmt;
        stylua = {
          command = getExe stylua;
          append_args = [
            "--indent-type"
            "Spaces"
            "--indent-width"
            "2"
            "--quote-style"
            "ForceSingle"
            "--sort-requires"
          ];
        };
      };
      format_on_save = mkLuaInline "nil";
      format_after_save = mkLuaInline "nil";
      formatters_by_ft = {
        java.lsp_format = "prefer";
        lua = ["stylua"];
        markdown = ["denofmt_md"];
        nix = ["alejandra"];
        sh = ["shfmt"];
        typescript = ["prettierd"];
        zsh = ["shfmt"];
      };
    };
  };
}
