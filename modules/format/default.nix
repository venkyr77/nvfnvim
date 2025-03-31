{
  config.vim = {
    formatter.conform-nvim = {
      enable = true;
      setupOpts = {
        format_on_save = null;
        format_after_save = null;
        formatters_by_ft = {
          zsh = ["shfmt"];
        };
      };
    };
    languages = {
      bash.format.enable = true;
      lua.format.enable = true;
      markdown.format.enable = true;
      nix.format.enable = true;
      ts.format.enable = true;
    };
  };
}
