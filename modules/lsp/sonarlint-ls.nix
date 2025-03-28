{pkgs, ...}: {
  config.vim = {
    extraPackages = [pkgs.sonarlint-ls];

    extraPlugins.sonarlint-ls = {
      after = ["lsp-setup"];

      package = pkgs.vimUtils.buildVimPlugin {
        name = "sonarlint.nvim";
        src = pkgs.fetchFromGitLab {
          owner = "schrieveslaach";
          repo = "sonarlint.nvim";
          rev = "main";
          hash = "sha256-x/Z3+lF8+TaLkWOKEOdy04h9emXzP1JgX3t0EhzC4bo=";
        };
      };

      setup = with pkgs;
      # lua
        ''
          require("sonarlint").setup({
            server = {
              cmd = {
                vim.fn.fnamemodify("${lib.getExe sonarlint-ls}", ":p"),
                "-stdio",
                "-analyzers",
                vim.fn.fnamemodify("${sonarlint-ls}/share/plugins/sonarjava.jar", ":p"),
              },
            },
            filetypes = { "java" },
          })
        '';
    };
  };
}
