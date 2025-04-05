{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
in {
  config.vim = {
    autocmds = [
      {
        callback =
          mkLuaInline
          # lua
          ''
            function()
              require("lint").try_lint()
            end
          '';
        desc = "Try lint on certain events";
        event = ["BufEnter" "BufWritePost" "InsertLeave"];
      }
    ];

    diagnostics = {
      enable = true;
      config.virtual_text.format =
        mkLuaInline
        # lua
        ''
          function(diagnostic)
            return string.format("%s (%s)", diagnostic.message, diagnostic.source)
          end
        '';
      nvim-lint = {
        enable = true;
        linters_by_ft = {
          zsh = ["shellcheck"];
        };
      };
    };

    languages = {
      bash.extraDiagnostics.enable = true;
      lua.extraDiagnostics.enable = true;
      markdown.extraDiagnostics.enable = true;
      nix.extraDiagnostics.enable = true;
    };
  };
}
