{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.easyalign;
in {
  config = mkIf (cfg.enable) {
    vim.startPlugins = [
      "easyalign"
    ];

    vim.nnoremap = {
      "<leader>aa" = "<cmd> EasyAlign";
      "<leader>al" = "<cmd> LiveEasyAlign";
    };
  };
}
