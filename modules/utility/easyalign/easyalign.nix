{
  config,
  lib,
  ...
}:
with lib;
with builtins; {
  options.vim.utility.easyalign = {
    enable = mkEnableOption "Enable easy alignment";
  };
}
