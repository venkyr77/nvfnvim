{
  imports = [
    ./completion.nix
    ./conform.nix
    ./gitsigns.nix
    ./lsp.nix
    ./picker.nix
  ];

  config.vim = {
    binds.whichKey = {
      enable = true;
      register = {
        "<leader>c" = "+[c]onform(format)";
        "<leader>d" = "+[d]ap";
        "<leader>f" = "+[f]ind(snacks)";
        "<leader>g" = "+[g]o to(lsp)";
        "<leader>h" = "+[h]unk(gitsigns)";
        "<leader>l" = "+[l]sp";
        "<leader>ld" = "+[d]iagnostics";
        "<leader>t" = "+[t]oggle";
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
