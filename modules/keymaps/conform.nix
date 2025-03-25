{
  config.vim.keymaps = [
    {
      action =
        #lua
        ''
          function()
            require("conform").format()
          end
        '';
      desc = "[f]ormat buffer or selection";
      key = "<leader>cf";
      lua = true;
      mode = ["n" "v"];
    }
  ];
}
