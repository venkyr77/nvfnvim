{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
in {
  config.vim = {
    theme = {
      enable = true;
      name = "catppuccin";
    };

    lsp.lspsaga.setupOpts.ui.kind =
      mkLuaInline
      # lua
      ''
        require("catppuccin.groups.integrations.lsp_saga").custom_kind()
      '';

    tabline.nvimBufferline.setupOpts.highlights =
      mkLuaInline
      # lua
      ''
        require("catppuccin.groups.integrations.bufferline").get()
      '';
  };
}
