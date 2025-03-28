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
    pluginRC.nvim-dap-ui =
      entryAfter ["nvim-dap"]
      # lua
      ''
        dap.listeners.after.event_initialized["dapui_config"] = function()
          require("neo-tree").close_all()
          require("dapui").open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          require("dapui").close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          require("dapui").close()
        end
      '';
  };
}
