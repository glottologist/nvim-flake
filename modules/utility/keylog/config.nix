{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.utility.keylog;
in {
  config = mkIf (cfg.enable) {
    vim.startPlugins = [
      "keylog-nvim"
    ];
    vim.nnoremap = {
      "<leader>uks" = "<cmd> Keylog start<CR>";
      "<leader>ukp" = "<cmd> Keylog stop<CR>";
    };
    vim.luaConfigRC.hardtime = ''
      require("keylog").setup()
    '';
  };
}
