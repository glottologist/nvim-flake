{
  config,
  lib,
  ...
}:
with lib;
with builtins; {
  options.vim.utility.keylog = {
    enable = mkEnableOption "A Neovim plugin to help generate keystroke heatmaps";
  };
}
