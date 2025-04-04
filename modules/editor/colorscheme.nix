{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
in {
  config.vim = {
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
    };

    tabline.nvimBufferline.setupOpts.highlights =
      mkLuaInline
      # lua
      ''
        require("catppuccin.groups.integrations.bufferline").get()
      '';
  };
}
