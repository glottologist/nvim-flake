{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.zenmode;
in {
  config = mkIf (cfg.enable) {
    vim.startPlugins = [
      "zenmode"
    ];

    vim.nnoremap = {
      "<leader>zt" = "<cmd> ZenMode<CR>";
    };
  };
}
