{
  config.vim = {
    keymaps = [
      {
        action = "<cmd>nohlsearch<CR>";
        desc = "Clear highlights on search when pressing <Esc> in normal mode";
        key = "<Esc>";
        mode = "n";
        silent = true;
      }
      {
        action = ":Neotree toggle<CR>";
        desc = "[N]eotree [t]oggle";
        key = "\\";
        mode = "n";
        silent = true;
      }
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
  };
}
