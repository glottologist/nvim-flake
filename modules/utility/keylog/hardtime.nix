{
  config,
  lib,
  ...
}:
with lib;
with builtins; {
  options.vim.utility.hardtime = {
    enable = mkEnableOption "A Neovim plugin helping you establish good command workflow and habit";
  };
}
