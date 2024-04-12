{
  config,
  lib,
  ...
}:
with lib;
with builtins; {
  options.vim.utility.eyeliner = {
    enable = mkEnableOption "Enable quick jumps";
  };
}
