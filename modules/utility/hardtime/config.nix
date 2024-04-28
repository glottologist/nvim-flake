{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.utility.hardtime;
in {
  config = mkIf (cfg.enable) {
    vim.startPlugins = [
      "hardtime"
    ];
    vim.nnoremap = {
      "<leader>uh" = "<cmd> Hardtime toggle<CR>";
    };
    vim.luaConfigRC.hardtime = ''
      require("hardtime").setup()
    '';
  };
}
