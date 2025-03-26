{
  config.vim.telescope = {
    enable = true;
    setupOpts.defaults = {
      path_display = ["tail"];
      layout_config = {
        height = 0.95;
        width = 0.95;
        horizontal.prompt_position = "bottom";
      };
    };
  };
}
