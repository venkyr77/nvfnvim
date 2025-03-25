{pkgs, ...}: {
  config.vim.extraPlugins."guess-indent" = {
    package = pkgs.vimPlugins.guess-indent-nvim;
    setup =
      # lua
      ''
        require('guess-indent').setup()
      '';
  };
}
