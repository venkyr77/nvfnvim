{lib, ...}: let
  inherit (lib.nvim.dag) entryAfter;
in {
  config.vim = {
    debugger.nvim-dap = {
      enable = true;
      ui = {
        autoStart = false;
        enable = true;
      };
    };
    languages = {
      go.dap.enable = true;
    };
    pluginRC.nvim-dap-ui =
      entryAfter ["nvim-dap"]
      # lua
      ''
        dap.listeners.after.event_initialized["dapui_config"] = function()
          local explorer = Snacks.picker.get({ source = "explorer" })[1]
          if explorer ~= nil then
            explorer:close()
          end
          require("dapui").open()
        end
      '';
  };
}
