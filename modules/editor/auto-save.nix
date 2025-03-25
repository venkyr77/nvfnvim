{pkgs, ...}: {
  config.vim.extraPlugins."auto-save" = {
    package = pkgs.vimPlugins.auto-save-nvim;
    setup =
      # lua
      ''
        require("auto-save").setup({ debounce_delay = 100 })
      '';
  };
}
