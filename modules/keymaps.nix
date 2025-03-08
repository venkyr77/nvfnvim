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
    ];
  };
}
