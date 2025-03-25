{pkgs, ...}: {
  config.vim.formatter.conform-nvim = with pkgs; {
    enable = true;
    setupOpts = {
      formatters = let
        getDenoFormatterForExt = ext: {
          command = lib.getExe deno;
          args = [
            "fmt"
            "-"
            "--ext"
            ext
          ];
        };
      in {
        alejandra.command = lib.getExe alejandra;
        denofmt_md = getDenoFormatterForExt "md";
        nixfmt-rfc-style.command = lib.getExe nixfmt-rfc-style;
        prettierd.command = lib.getExe prettierd;
        shfmt.command = lib.getExe shfmt;
        stylua.command = lib.getExe stylua;
      };
      format_on_save = lib.generators.mkLuaInline "nil";
      format_after_save = lib.generators.mkLuaInline "nil";
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
