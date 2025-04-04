{
  imports = [
    ./dressing.nix
    ./noice.nix
  ];

  config.vim = {
    mini.indentscope.enable = true;
    notes.todo-comments.enable = true;
    notify.nvim-notify.enable = true;
    statusline.lualine.enable = true;
    tabline.nvimBufferline.enable = true;
    ui = {
      borders.enable = true;
      illuminate.enable = true;
    };
    visuals = {
      indent-blankline.enable = true;
      rainbow-delimiters.enable = true;
    };
  };
}
