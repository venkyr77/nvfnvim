{
  imports = [
    ./completion.nix
    ./conform.nix
    ./gitsigns.nix
    ./lsp.nix
    ./neotree.nix
  ];

  config.vim = {
    binds.whichKey = {
      enable = true;
      register = {
        "<leader>c" = "conform (format)";
        "<leader>d" = "+[D]iagnostics";
        "<leader>g" = "+[G]o to(LSP)";
        "<leader>h" = "[H]unk(Gitsigns)";
      };
    };

    keymaps = [
      {
        action = "<cmd>nohlsearch<CR>";
        desc = "Clear highlights on search when pressing <Esc> in normal mode";
        key = "<Esc>";
        mode = "n";
        silent = true;
      }
    ];
  };
}
