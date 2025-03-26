{pkgs, ...}: {
  config.vim = {
    extraPackages = with pkgs; [
      sonarlint-ls
    ];

    extraPlugins.sonarlint-ls = {
      after = [
        "nvim-lspconfig"
        "lspconfig"
      ];

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
                "${lib.getExe sonarlint-ls}",
                "-stdio",
                "-analyzers",
                "${sonarlint-ls}/share/plugins/sonarjava.jar"
              },
            },
            filetypes = { "java" },
          })
        '';
    };
  };
}
