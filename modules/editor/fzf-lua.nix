{pkgs, ...}: {
  config.vim = {
    extraPackages = with pkgs; [
      fzf
    ];
    fzf-lua.enable = true;
  };
}
