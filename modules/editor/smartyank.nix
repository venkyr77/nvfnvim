{pkgs, ...}: {
  config.vim.extraPlugins."smartyank" = {
    package = pkgs.vimPlugins.smartyank-nvim;
    setup =
      # lua
      ''
        require("smartyank").setup({ osc52 = { ssh_only = false } })
      '';
  };
}
