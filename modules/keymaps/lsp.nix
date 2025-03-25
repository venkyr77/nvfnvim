{
  config.vim = {
    keymaps = [
      {
        action = ":Lspsaga goto_definition<CR>";
        desc = "[d]efinitions";
        key = "<leader>gd";
        mode = "n";
      }
      {
        action = ":Lspsaga finder imp<CR>";
        desc = "[i]mplementations";
        key = "<leader>gi";
        mode = "n";
      }
      {
        action = ":Lspsaga finder ref<CR>";
        desc = "[r]eferences";
        key = "<leader>gr";
        mode = "n";
      }
      {
        action = ":Lspsaga finder tyd<CR>";
        desc = "[t]ype definitions";
        key = "<leader>gt";
        mode = "n";
      }
    ];
    lsp = {
      mappings = {
        format = null;
        goToDeclaration = null;
        goToDefinition = null;
        goToType = null;
        listImplementations = null;
        listReferences = null;
        nextDiagnostic = "<leader>dn";
        previousDiagnostic = "<leader>dp";
      };
      lspsaga.setupOpts.finder.keys = {
        quit = ["q" "<Esc>"];
        toggle_or_open = ["o" "<CR>"];
      };
    };
  };
}
