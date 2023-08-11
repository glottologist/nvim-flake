{
  config,
  lib,
  ...
}:
with lib;
with builtins; {
  options.vim.easyalign = {
    enable = mkEnableOption "Enable easy alignment";
  };
}
