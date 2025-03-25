{
  config.vim.tabline.nvimBufferline = {
    enable = true;
    setupOpts.options = {
      offsets = [
        {
          filetype = "neo-tree";
          text = "Explorer";
          highlight = "Directory";
          text_align = "center";
          separator = true;
        }
      ];
    };
  };
}
