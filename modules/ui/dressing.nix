{
  config.vim = {
    extraPlugins."dressing" = {
      package = "dressing-nvim";
      setup =
        # lua
        ''
          require("dressing").setup({ select = { backend = { "fzf_lua" } } })
        '';
    };
  };
}
