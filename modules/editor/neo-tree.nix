{
  config.vim.filetree.neo-tree = {
    enable = true;
    setupOpts = {
      default_component_configs.indent.with_expanders = true;
      enable_cursor_hijack = true;
      filesystem = {
        filtered_items = {
          hide_dotfiles = false;
          never_show = [
            ".git"
          ];
        };
        follow_current_file = {
          enabled = true;
          leave_dirs_open = true;
        };
        group_empty_dirs = true;
        scan_mode = "deep";
      };
    };
  };
}
